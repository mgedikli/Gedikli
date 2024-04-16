*&---------------------------------------------------------------------*
*& Report ZMG_ALV_200U2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_alv_200u2.
*Alıştırma – 2: Yeni bir rapor oluşturun. Select-Options komutu kullanarak kullanıcıdan “AGENCYNUM”alın.
*(Bu kolonu STRAVELAG database tablosu içinde bulabilirsiniz). Gelen veriye göre ilk alıştırmada oluşturduğunuz
*ve içinde kayıt oluşturduğunuz database tablosundan ilgili satırları okuyun ve oluşan internal tablonun ALV’sini alın.
*(Birinci fonksiyon kombinasyonunu kullanarak). Programınızı Perform komutu kullanarak yazın.
*
*S.200-Übung-2: Erstellen Sie einen neuen Bericht.Verwenden Sie das Select-Options-Kommando, um die "AGENCYNUM" vom Benutzer zu erhalten.
*(Sie finden diese Spalte in der STRAVELAG-Datenbanktabelle). Lesen Sie die entsprechenden Zeilen aus der Datenbanktabelle,
*die Sie im ersten Übung erstellt haben und in der Sie Datensätze gespeichert haben, basierend auf den empfangenen Daten,
*und erhalten Sie das ALV dieser internen Tabelle.(Verwenden Sie die erste Funktionskombination).Schreiben Sie Ihr Programm mit dem Perform-Kommando.


TYPES: BEGIN OF gty_table,
         box.
         INCLUDE STRUCTURE zmg_stravelag_2.
TYPES: END OF gty_table.

DATA: gs_stravelag TYPE zmg_stravelag_2,
      gt_fieldcat  TYPE slis_t_fieldcat_alv,
      gs_layout    TYPE slis_layout_alv,
      gt_stravelag TYPE TABLE OF gty_table.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: so_agnum FOR gs_stravelag-agencynum.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.

FORM select_data.
  SELECT * FROM zmg_stravelag_2 INTO CORRESPONDING FIELDS OF TABLE gt_stravelag WHERE agencynum IN so_agnum.
ENDFORM.

FORM fcat.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZMG_STRAVELAG_2'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.

FORM layout.
  gs_layout-zebra             = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname     = 'BOX'.
ENDFORM.

FORM show_alv.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
    TABLES
      t_outtab           = gt_stravelag
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.
