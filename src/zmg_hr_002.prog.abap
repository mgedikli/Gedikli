*&---------------------------------------------------------------------*
*& Report ZMG_HR_002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_hr_002.

PARAMETERS: p_ubegin TYPE sy-datum OBLIGATORY,
            p_u_ende TYPE sy-datum OBLIGATORY,
            p_id     TYPE zcm_de_id OBLIGATORY.

DATA: go_urlaub            TYPE REF TO zmg_urlaubsanspruch_2,
      gv_mitarbeiter_check,
      gv_jahr_1            TYPE char4,
      gv_jahr_2            TYPE char4,
      gv_urlaub_plan_1     TYPE int1,
      gv_urlaub_plan_2     TYPE int1,
      gv_urlaub_ok_1       TYPE c LENGTH 1,
      gv_urlaub_ok_2       TYPE c LENGTH 1,
      gv_answer.

START-OF-SELECTION.

  CREATE OBJECT go_urlaub.

  IF p_ubegin > p_u_ende.
    MESSAGE 'Das Beginndatum des Urlaubs darf nicht nach dem Enddatum des Urlaubs liegen.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_ubegin < sy-datum.
    MESSAGE 'Das Beginndatum des Urlaubs darf nicht bevor dem heutigen Datum liegen.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  go_urlaub->id_check(
    EXPORTING
      iv_id                = p_id
    IMPORTING
      ev_mitarbeiter_check = gv_mitarbeiter_check ).

  IF gv_mitarbeiter_check = abap_false.
    MESSAGE 'Für die eingegebene ID wurde kein Mitarbeiter gefunden.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  go_urlaub->urlaub_check(
    EXPORTING
      iv_id                     = p_id
      iv_urlaub_beginn          = p_ubegin
      iv_urlaub_ende            = p_u_ende
    IMPORTING
      ev_jahr_1                 = gv_jahr_1
      ev_jahr_2                 = gv_jahr_2
      ev_urlaub_plan_1          = gv_urlaub_plan_1
      ev_urlaub_plan_2          = gv_urlaub_plan_2
      ev_urlaub_ok_1            = gv_urlaub_ok_1
      ev_urlaub_ok_2            = gv_urlaub_ok_2
    EXCEPTIONS
      null_werktage                  = 1
      unzureichender_urlaubsanspruch = 2
      doppelte_urlaubsplanung        = 3
      OTHERS                         = 4 ).

  IF sy-subrc = 1.
    MESSAGE 'Im eingegebenen Datumsbereich liegen keine Werktage vor.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ELSEIF sy-subrc = 2.
    MESSAGE 'Der Urlaubsanspruch reicht nicht aus.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ELSEIF sy-subrc = 3.
    MESSAGE 'Doppelte Urlaubsplanungsproblem.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  "Liegen zwischen den beiden eingegebenen Daten Werktage?
  "Hat Mitarbeiter ausreichend Urlaubsanspruch?
  "Gibt es doppelte Urlaubsplanungsfehler?

  IF p_ubegin(4) NE p_u_ende(4).

    "Wenn die eingegebenen Daten zu unterschiedlichen Jahren gehören.
    IF ( gv_urlaub_ok_1 IS INITIAL AND gv_urlaub_ok_2 IS NOT INITIAL ) OR
       ( gv_urlaub_ok_1 IS NOT INITIAL AND gv_urlaub_ok_2 IS INITIAL ).

      "Entweder das Startjahr oder das Endjahr ist für Urlaub geeignet.
      "Lassen Sie uns den Benutzer fragen: stimmt er der teilweise Dateneingabe zu?
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          text_question  = 'Genehmigen Sie die teilweise Dateneingabe?'
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

      "Der Benutzer hat die teilweise Dateneingabe bestätigt.
      "Fügen wir der Tabelle den Urlaub im Start- oder Endjahr hinzu.
      IF gv_answer = 1.
        IF gv_urlaub_ok_1 IS NOT INITIAL.

          go_urlaub->urlaub_add(
            EXPORTING
              iv_id            =  p_id
              iv_jahr          =  gv_jahr_1
              iv_urlaub_beginn =  p_ubegin
              iv_urlaub_ende   =  p_ubegin(4) && '1231'
              iv_urlaub_plan   =  gv_urlaub_plan_1 ).

        ENDIF.

        IF gv_urlaub_ok_2 IS NOT INITIAL.

          go_urlaub->urlaub_add(
            EXPORTING
              iv_id            =  p_id
              iv_jahr          =  gv_jahr_2
              iv_urlaub_beginn =  p_u_ende(4) && '0101'
              iv_urlaub_ende   =  p_u_ende
              iv_urlaub_plan   =  gv_urlaub_plan_2 ).
        ENDIF.
      ENDIF.
    ELSEIF gv_urlaub_ok_1 IS NOT INITIAL AND gv_urlaub_ok_2 IS NOT INITIAL.

      go_urlaub->urlaub_add(
        EXPORTING
          iv_id            =  p_id
          iv_jahr          =  gv_jahr_1
          iv_urlaub_beginn =  p_ubegin
          iv_urlaub_ende   =  p_ubegin(4) && '1231'
          iv_urlaub_plan   =  gv_urlaub_plan_1 ).

      go_urlaub->urlaub_add(
        EXPORTING
          iv_id            =  p_id
          iv_jahr          =  gv_jahr_2
          iv_urlaub_beginn =  p_u_ende(4) && '0101'
          iv_urlaub_ende   =  p_u_ende
          iv_urlaub_plan   =  gv_urlaub_plan_2 ).

    ENDIF.
  ELSE.
    "Beide eingegebenen Daten gehören zum selben Jahr.
    IF gv_urlaub_ok_1 IS NOT INITIAL.
      go_urlaub->urlaub_add(
        EXPORTING
          iv_id            =  p_id
          iv_jahr          =  gv_jahr_1
          iv_urlaub_beginn =  p_ubegin
          iv_urlaub_ende   =  p_u_ende
          iv_urlaub_plan   =  gv_urlaub_plan_1 ).
    ENDIF.
  ENDIF.
