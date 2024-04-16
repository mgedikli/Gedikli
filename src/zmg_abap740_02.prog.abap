*&---------------------------------------------------------------------*
*& Report ZMG_ABAP740_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_abap740_02.
*ABAP740 Read Table mit Field Value
*In unserem Besitz ist keine Indexnummer, aber es gibt Werte (Value) für einige Zellen in der zu lesenden Zeile!
*zB. agencynum = '00000061' name = 'Fly High'.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE @DATA(gt_table).

  "vor Abap 7.40 :
  READ TABLE gt_table INTO DATA(gs_table) WITH KEY agencynum = '00000061' name = 'Fly High'.
  IF sy-subrc IS INITIAL.
    WRITE: gs_table-agencynum.
  ENDIF.

  "nach Abap 7.40 :
  TRY.
      DATA(gs_str) = gt_table[ agencynum = '00000061' name = 'Fly High' ].
    CATCH cx_sy_itab_line_not_found.
      MESSAGE 'Zeile nicht gefunden' TYPE 'I'.
      EXIT.
  ENDTRY.

  WRITE: gs_str-city.
