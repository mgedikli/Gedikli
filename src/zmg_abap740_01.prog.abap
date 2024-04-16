*&---------------------------------------------------------------------*
*& Report ZMG_ABAP740_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_abap740_01.
*Abap740-Read Table: ABAP-7.40'la gelen yenilikler_Read Table 1

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE @DATA(gt_table).

  "vor Abap 7.40:
  READ TABLE gt_table INTO DATA(gs_table) INDEX 10.
  IF sy-subrc IS INITIAL.
    WRITE: gs_table-agencynum.
  ENDIF.

  "nach Abap 7.40:
  "DATA(gs_str) = gt_table[ 5 ].
  "Problem:Wenn die mit der Indexnummer angegebene Zeile nicht in der internen Tabelle vorhanden ist,
  "wird ein DUMP-Bericht generiert; um dies zu verhindern, wird das 'TRY-CATCH'-Statement verwendet!
  TRY.
      DATA(gs_str) = gt_table[ 6 ].
    CATCH cx_sy_itab_line_not_found.
      MESSAGE 'Die eingegebene INDEXNUMMER wurde nicht gefunden.' TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.
  WRITE: gs_table-agencynum.

  DESCRIBE TABLE gt_table LINES DATA(gv_no_lines).  "740 sonrasi 2.Cözüm : 'TRY-CATCH' kullanmadan

  IF gv_no_lines >= 7.            "2.Cözüm
    DATA(gs_str_2) = gt_table[ 7 ].
    WRITE: gs_table-agencynum.
  ENDIF.

  BREAK-POINT.
