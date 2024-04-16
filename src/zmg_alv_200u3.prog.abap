*&---------------------------------------------------------------------*
*& Report ZMG_ALV_200U3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_alv_200u3.
*Alıştırma-3:Yeni bir rapor oluşturun. Select-Options komutu kullanarak kullanıcıdan “AGENCYNUM” alın.
*(Bu kolonu STRAVELAG database tablosu içinde bulabilirsiniz).Gelen veriye göre ilk alıştırmada oluşturduğunuz ve
*içinde kayıt oluşturduğunuz database tablosundan ilgili satırları okuyun ve oluşan internal tablonun ALV’sini alın.
*(İkinci fonksiyon kombinasyonunu kullanarak). Programınızı Perform komutu kullanarak yazın.
*
*S.200-Übung-3:Erstellen Sie einen neuen Bericht. Verwenden Sie das Select-Options-Kommando, um vom Benutzer "AGENCYNUM" zu erhalten.
*(Diese Spalte finden Sie in der Tabelle der STRAVELAG-Datenbank).Lesen Sie entsprechende Zeilen aus der Datenbanktabelle,
*die Sie im ersten Übung erstellt und Datensätze eingefügt haben, und nehmen Sie das ALV der resultierenden internen Tabelle
*(unter Verwendung der zweiten Funktionskombination). Schreiben Sie Ihr Programm unter Verwendung des Perform-Befehls.

DATA: gt_stravelag TYPE TABLE OF zmg_stravelag_2,
      gs_stravelag TYPE zmg_stravelag_2,
      gt_fieldcat  TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: so_agnum FOR gs_stravelag-agencynum.
SELECTION-SCREEN END OF BLOCK a1.

PERFORM select_data.
PERFORM fcat.
PERFORM layout.
PERFORM show_alv.
*
FORM select_data.
  SELECT * FROM zmg_stravelag_2 INTO TABLE gt_stravelag WHERE agencynum in so_agnum.
ENDFORM.

FORM fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
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
  gs_layout-zebra       = abap_true.
  gs_layout-cwidth_opt  = abap_true.
  gs_layout-sel_mode    = 'A'.
ENDFORM.

FORM show_alv .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fieldcat
    TABLES
      t_outtab           = gt_stravelag
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.
