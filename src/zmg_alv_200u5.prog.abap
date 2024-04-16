*&---------------------------------------------------------------------*
*& Report ZMG_ALV_200U5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_alv_200u5.
*Alıştırma – 5: İkinci veya üçüncü alıştırmada gösterdiğiniz ALV’nin URL kolonunu HOTSPOT haline getirin.
*Üzerine tıklandığında kullanıcıdan yeni bir URL alsın. Alınan değer ile db tablosunu güncelleyin ve ALV’yi yeniden oluşturun.
*
*S.200-Übung - 5: Machen Sie die URL-Spalte des ALV, die Sie im zweiten oder dritten Übung gezeigt haben, zu einem HOTSPOT.
*Wenn darauf geklickt wird, soll der Benutzer eine neue URL eingeben.
*Aktualisieren Sie die Datenbanktabelle mit dem erhaltenen Wert und erstellen Sie den ALV erneut.

DATA: gt_stravelag TYPE TABLE OF zmg_stravelag_2,
      gs_stravelag TYPE zmg_stravelag_2,
      gt_fieldcat  TYPE lvc_t_fcat,
      gs_fieldcat  TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo,
      gv_url       TYPE s_url,
      gv_answer.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: so_agnum FOR gs_stravelag-agencynum.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.
  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.

FORM select_data.
  SELECT * FROM zmg_stravelag_2 INTO TABLE gt_stravelag WHERE agencynum IN so_agnum.
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

  LOOP AT gt_fieldcat INTO gs_fieldcat.
    CASE gs_fieldcat-fieldname.
      WHEN 'URL'.
        gs_fieldcat-hotspot = abap_true.
        MODIFY gt_fieldcat FROM gs_fieldcat TRANSPORTING hotspot WHERE fieldname = gs_fieldcat-fieldname.
    ENDCASE.
  ENDLOOP.

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
      i_callback_program       = sy-repid
      is_layout_lvc            = gs_layout
      it_fieldcat_lvc          = gt_fieldcat
      i_callback_pf_status_set = 'STATUS_05'
      i_callback_user_command  = 'UC_U5'
    TABLES
      t_outtab                 = gt_stravelag
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.

FORM status_05 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_UBUNG5'.
ENDFORM.

FORM uc_u5 USING lv_ucomm     TYPE sy-ucomm
                 ls_selfield  TYPE slis_selfield.
  CASE lv_ucomm.
    WHEN '&IC1'.
      IF ls_selfield-fieldname = 'URL'.
        CALL FUNCTION 'ZMG_POPUP_GET_NEW_URL_1'
          IMPORTING
            ev_url    = gv_url
            ev_answer = gv_answer.

        IF gv_answer IS INITIAL. "IF gv_answer = 0.
          IF gv_url IS NOT INITIAL.

            SELECT SINGLE * FROM zmg_stravelag_2 INTO gs_stravelag WHERE url = ls_selfield-value. "Modify satiri ile birlikte kullan.
************
            gs_stravelag-alte_url = gs_stravelag-url.  "Ü6
            gs_stravelag-url = gv_url.                 "Ü5 SELECT SINGLE)
            MODIFY zmg_stravelag_2 FROM gs_stravelag.  "Ü5
************
          ENDIF.
        ENDIF.
        PERFORM select_data.
        PERFORM show_alv.
      ENDIF.
  ENDCASE.
ENDFORM.

*Übung-6:Fügen Sie der Tabelle "STRAVELAG" eine neue Spalte mit dem Namen "ALTE_URL" hinzu.
*Verwenden Sie erneut die Datenbanktabelle STRAVELAG, um die ALV auf dem Bildschirm anzuzeigen.
*Wenn die URL-Zelle mithilfe der Taste aktualisiert wird,
*speichern Sie die alte URL-Daten in der Zelle "ALTE_URL" der Datenbanktabelle und erstellen Sie die ALV erneut.

*Alıştırma-6:STRAVELAG db tablosuna “ESKI_URL” isminde yeni bir kolon ekleyin.
*STRAVELAG database tablosunu kullanarak ALV’yi ekranda gösterin.
*yeni buton yardımıyla URL hücresi güncellendiğinde,
*eski URL verisini db tablosunun “ESKI_URL” hücresine kaydedin ve ALV’yi yeniden oluşturun.

*            UPDATE zmg_stravelag_2 SET url = gv_url                "Modify satirina alternatif
*                                   WHERE url = ls_selfield-value.
