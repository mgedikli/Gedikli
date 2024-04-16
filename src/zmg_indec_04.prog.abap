*&---------------------------------------------------------------------*
*& Report ZMG_INDEC_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_indec_04.

PARAMETERS: p_1 RADIOBUTTON GROUP bnm,
            p_2 RADIOBUTTON GROUP bnm,
            p_3 RADIOBUTTON GROUP bnm.

START-OF-SELECTION.

  IF p_1 = abap_true.
    SELECT * FROM scarr INTO TABLE @DATA(gt_scarr).

    LOOP AT gt_scarr INTO DATA(gs_scarr).
      WRITE: gs_scarr-carrid, gs_scarr-carrname,
             gs_scarr-currcode, gs_scarr-url.
    ENDLOOP.

  ELSEIF p_2 = abap_true.

    SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

    LOOP AT gt_spfli INTO DATA(gs_spfli).
      WRITE: gs_spfli-carrid, gs_spfli-connid, gs_spfli-cityfrom.
    ENDLOOP.

  ELSE.

    SELECT * FROM sflight INTO TABLE @DATA(gt_sflight).

    LOOP AT gt_sflight INTO DATA(gs_sflight).
      WRITE: gs_sflight-carrid, gs_sflight-connid, gs_sflight-fldate.
    ENDLOOP.
  ENDIF.
