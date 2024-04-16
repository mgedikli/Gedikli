*&---------------------------------------------------------------------*
*& Report ZMG_ALV_200U7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_alv_200u7.
*Alıştırma – 7: Yeni bir rapor oluşturun ve STRAVELAG tablosunun sadece AGENCYNUM, NAME, CITY, COUNTRY,
*TELEPHONE ve URL kolonlarını çekerek bir internal tablo içine kaydedin. Internal tablonun ALV’sini
*görüntüleyebilmek için, manuel olarak Field Catalog internal tablosu oluşturun ve ALV’yi ekranda gösterin.
*
*S.200-Übung-7: Erstellen Sie einen neuen Bericht und speichern Sie die Spalten AGENCYNUM, NAME, CITY, COUNTRY,
*TELEPHONE und URL der Tabelle STRAVELAG in einer internen Tabelle. Erstellen Sie manuell eine Field Catalog interne Tabelle,
*um die ALV der internen Tabelle anzeigen zu können, und zeigen Sie die ALV auf dem Bildschirm an.

TYPES: BEGIN OF gty_table,
         agencynum TYPE s_agncynum,
         name      TYPE s_agncynam,
         city      TYPE city,
         country   TYPE s_country,
         telephone TYPE s_phoneno,
         url       TYPE s_url,
       END OF gty_table.

DATA: gt_table     TYPE TABLE OF gty_table,
      gs_structure TYPE gty_table,
      gt_fieldcat  TYPE lvc_t_fcat,
      gs_fieldcat  TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.

FORM select_data .
  SELECT * FROM zmg_stravelag_2 INTO CORRESPONDING FIELDS OF TABLE gt_table.
ENDFORM.

FORM fcat.
  gs_fieldcat-fieldname = 'AGENCYNUM'.
  gs_fieldcat-scrtext_m = 'Nummer des Reiseunternehmens'.
  gs_fieldcat-key       = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'NAME'.
  gs_fieldcat-scrtext_m = 'Name des Reiseunternehmens'.
*gs_fieldcat-key       = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'CITY'.
  gs_fieldcat-scrtext_m = 'STADT'.
*gs_fieldcat-key       = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'COUNTRY'.
  gs_fieldcat-scrtext_m = 'LAND'.
*gs_fieldcat-key       = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'TELEPHONE'.
  gs_fieldcat-scrtext_m = 'GSM'.
*gs_fieldcat-key       = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'URL'.
  gs_fieldcat-scrtext_m = 'Webadresse'.
*  gs_fieldcat-key       = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

ENDFORM.

FORM layout.
  gs_layout-zebra       = abap_true.
  gs_layout-cwidth_opt  = abap_true.
  gs_layout-sel_mode    = 'A'.
ENDFORM.

FORM show_alv.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fieldcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.
