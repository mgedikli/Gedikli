*&---------------------------------------------------------------------*
*& Report ZMG_HR_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_hr_001.

PARAMETERS: p_ustart TYPE sy-datum OBLIGATORY,
            p_u_ende TYPE sy-datum OBLIGATORY,
            p_id     TYPE zcm_de_id OBLIGATORY.

DATA: go_urlaub            TYPE REF TO zmg_urlaubsanspruch,
      gv_mitarbeiter_check,
      gv_urlaub_ok_1,
      gv_urlaub_ok_2,
      gv_jahr_1(4),
      gv_jahr_2(4),
      gv_urlaub_alte_1     TYPE int1,
      gv_urlaub_alte_2     TYPE int1,
      gv_answer.

START-OF-SELECTION.

  IF p_ustart > p_u_ende.
    MESSAGE 'Das Beginndatum des Urlaubs darf nicht nach dem Enddatum des Urlaubs liegen.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_ustart < sy-datum.
    MESSAGE 'Das Beginndatum des Urlaubs darf nicht bevor dem heutigen Datum liegen.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  CREATE OBJECT go_urlaub.

  go_urlaub->id_check(
    EXPORTING
      iv_id                =  p_id
    IMPORTING
      ev_mitarbeiter_check =  gv_mitarbeiter_check ).

  IF gv_mitarbeiter_check IS NOT INITIAL.

    go_urlaub->urlaub_check(
      EXPORTING
        iv_id                          = p_id
        iv_urlaub_start                = p_ustart
        iv_urlaub_ende                 = p_u_ende
      IMPORTING
        ev_jahr_1                      = gv_jahr_1
        ev_jahr_2                      = gv_jahr_2
        ev_alte_urlaub_1               = gv_urlaub_alte_1
        ev_alte_urlaub_2               = gv_urlaub_alte_2
        ev_urlaub_ok_1                 = gv_urlaub_ok_1
        ev_urlaub_ok_2                 = gv_urlaub_ok_2
      EXCEPTIONS
        unzureichender_urlaubsanspruch = 1
        null_werktage                  = 2
        doppelte_registrierung         = 3
        OTHERS                         = 4 ).

    IF sy-subrc = 1.
      MESSAGE 'unzureichender Urlaubsanspruch.' TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.
    ELSEIF sy-subrc = 2.
      MESSAGE 'null Werktage.' TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.
    ELSEIF sy-subrc = 3.
      MESSAGE 'doppelte Registrierung.' TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.
    ENDIF.

    IF p_ustart(4) NE p_u_ende(4).
      "Beginn und Ende des Urlaubs liegen in unterschiedlichen Jahren.
      IF ( gv_urlaub_ok_1 IS INITIAL AND gv_urlaub_ok_2 IS NOT INITIAL ) OR
         ( gv_urlaub_ok_1 IS NOT INITIAL AND gv_urlaub_ok_2 IS INITIAL ).

        "Entweder das Startjahr oder das Endjahr ist für Urlaubsanträge verfügbar.
        "Fragen wir den Benutzer: Stimmt er der teilweisen Dateneingabe zu?
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            text_question  = 'Stimmen Sie der teilweisen Dateneingabe zu?'
            text_button_1  = 'Ja'(001)
            text_button_2  = 'Nein'(002)
          IMPORTING
            answer         = gv_answer
          EXCEPTIONS
            text_not_found = 1
            OTHERS         = 2.

        IF sy-subrc IS NOT INITIAL.
          EXIT.
        ENDIF.

        "Der Benutzer hat der teilweisen Dateneingabe zugestimmt.
        "Fügen wie den Urlaub füe das Start- oder Endjahr der Tabellehinzu.
        IF gv_answer = 1.
          IF gv_urlaub_ok_1 IS NOT INITIAL.
            go_urlaub->urlaub_add(
              EXPORTING
                iv_id           = p_id
                iv_jahr         = gv_jahr_1
                iv_urlaub_start = p_ustart
                iv_urlaub_ende  = p_ustart(4) && '1231'
                iv_urlaub_alte  = gv_urlaub_alte_1 ).
          ENDIF.

          IF gv_urlaub_ok_2 IS NOT INITIAL.
            go_urlaub->urlaub_add(
              EXPORTING
                iv_id           =  p_id
                iv_jahr         =  gv_jahr_2
                iv_urlaub_start =  p_u_ende(4) && '0101'
                iv_urlaub_ende  =  p_u_ende
                iv_urlaub_alte  =  gv_urlaub_alte_2 ).
          ENDIF.
        ENDIF.

        "Das Startjahr und das laufende Jahr sind für Urlaub geeignet.
        "Fügen wir beides hinzu.
      ELSEIF gv_urlaub_ok_1 IS NOT INITIAL AND gv_urlaub_ok_2 IS NOT INITIAL.
        go_urlaub->urlaub_add(
            EXPORTING
              iv_id           = p_id
              iv_jahr         = gv_jahr_1
              iv_urlaub_start = p_ustart
              iv_urlaub_ende  = p_ustart(4) && '1231'
              iv_urlaub_alte  = gv_urlaub_alte_1 ).

        go_urlaub->urlaub_add(
          EXPORTING
            iv_id           =  p_id
            iv_jahr         =  gv_jahr_2
            iv_urlaub_start =  p_u_ende(4) && '0101'
            iv_urlaub_ende  =  p_u_ende
            iv_urlaub_alte  =  gv_urlaub_alte_2 ).
      ENDIF.
    ELSE.
      "Beginn und Ende des Urlaubs liegen im selben Jahr.
      IF gv_urlaub_ok_1 IS NOT INITIAL.
        go_urlaub->urlaub_add(
          EXPORTING
            iv_id           =  p_id
            iv_jahr         =  gv_jahr_1
            iv_urlaub_start =  p_ustart
            iv_urlaub_ende  =  p_u_ende
            iv_urlaub_alte  =  gv_urlaub_alte_1 ).
      ENDIF.
    ENDIF.
  ENDIF.
