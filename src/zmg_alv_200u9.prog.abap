*&---------------------------------------------------------------------*
*& Report ZMG_ALV_200U9
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_alv_200u9.
*Alıştırma-9:Yeni bir database tablosu oluşturun. (Örneğin ZCM_SCARR) Satir yapısı SCARR database tablosu ile tamamen ayni olsun.
*Daha sonra yeni bir rapor oluşturun ve SCARR tablosundaki bütün bilgileri okuyup oluşturduğunuz yeni database tablosu içine kaydedin.
*Oluşturduğunuz ve içini doldurduğunuz tablodaki bütün satırları okuyup ALV’sini gösterin.
*SE41 işlem kodu yardımıyla SAP’ye ait PF_Status objesinin kopyasını oluşturun ve ALV fonksiyonu içerisinde kullanın.
*Kopya PF-Status içinde yeni bir buton oluşturun ve basıldığında kullanıcıdan birer adet CARRID, CARRNAME,CURRCODE ve URL alsın.
*Alınan veriyi kullanarak database tablosuna yeni bir satir ekleyin ve ALV’yi yenileyin.
*
*Übung-9:Erstellen Sie eine neue Datenbanktabelle.(Zum Beispiel ZCM_SCARR)Die Zeilenstruktur soll genau wie die SCARR-Datenbanktabelle sein.
*Erstellen Sie dann einen neuen Bericht und lesen Sie alle Informationen aus der SCARR-Tabelle aus und speichern Sie sie in der von Ihnen erstellten neuen Datenbanktabelle.
*Zeigen Sie alle Zeilen in der erstellten und gefüllten Tabelle im ALV an.
*Erstellen Sie mit der Transaktion SE41 eine Kopie des PF-Status-Objekts von SAP und verwenden Sie es in der ALV-Funktion.
*Erstellen Sie in der kopierten PF-Status-Instanz eine neue Schaltfläche, die beim Klicken vom Benutzer je eine CARRID, CARRNAME, CURRCODE und URL erhält.
*Fügen Sie eine neue Zeile zur Datenbanktabelle basierend auf den erhaltenen Daten hinzu und aktualisieren Sie den ALV.

DATA: gt_scarr    TYPE TABLE OF scarr,
      gs_scarr    TYPE scarr,
      gt_scarr_01 TYPE TABLE OF zmg_scarr,
      gs_scarr_01 TYPE zmg_scarr,
      gt_fieldcat TYPE lvc_t_fcat,
      gs_fieldcat TYPE lvc_s_fcat,
      gs_layout   TYPE lvc_s_layo,
      gv_carrid   TYPE s_carr_id,
      gv_carname  TYPE s_carrname,
      gv_currcode TYPE s_currcode,
      gv_url      TYPE s_carrurl.

START-OF-SELECTION.

  PERFORM select.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.

FORM select.
  SELECT * FROM scarr INTO TABLE gt_scarr.
  LOOP AT gt_scarr INTO gs_scarr.
    MODIFY zmg_scarr FROM gs_scarr.
  ENDLOOP.
  SELECT * FROM zmg_scarr INTO TABLE gt_scarr_01.
ENDFORM.

FORM fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZMG_SCARR'
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
  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.
ENDFORM.

FORM show_alv.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'MG_PF_STATUS'
      i_callback_user_command  = 'MG_USER_COMMAND'
      is_layout_lvc            = gs_layout
      it_fieldcat_lvc          = gt_fieldcat
    TABLES
      t_outtab                 = gt_scarr_01
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.

FORM mg_pf_status USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_U9'.
ENDFORM.

FORM mg_user_command USING lv_ucomm TYPE sy-ucomm
                    ls_selfield TYPE slis_selfield.
  CASE lv_ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'ADD'.

      CALL FUNCTION 'ZMG_NEW_ZEILE'
        IMPORTING
          ev_carrid   = gv_carrid
          ev_carrname = gv_carname
          ev_currcode = gv_currcode
          ev_url      = gv_url.

      gs_scarr_01-carrid    = gv_carrid.
      gs_scarr_01-carrname  = gv_carname.
      gs_scarr_01-currcode  = gv_currcode.
      gs_scarr_01-url       = gv_url.

      APPEND gs_scarr_01 TO gt_scarr_01.
      INSERT zmg_scarr FROM gs_scarr_01.

      PERFORM show_alv.
  ENDCASE.

ENDFORM.
