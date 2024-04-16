*&---------------------------------------------------------------------*
*& Report ZMG_ABAP740_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_abap740_03.
*ABAP740 Read Table- Ermitteln des SY-TABIX_Werts, wenn der Lesevorgang erfolgreich ist.(okuma basarili ise sy-tabix bulma)

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE @DATA(gt_table).

  "vor 7.40 :
  READ TABLE gt_table INTO DATA(gs_str) WITH KEY agencynum = '00000061' name = 'Fly High'.
  IF sy-subrc IS INITIAL.
    BREAK-POINT.
  ENDIF.

  "nach 7.40 :
  DATA(gv_index) = line_index( gt_table[ agencynum = '00000061' name = 'Fly High' ] ).
  BREAK-POINT.
