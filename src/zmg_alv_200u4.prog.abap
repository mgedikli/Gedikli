*&---------------------------------------------------------------------*
*& Report ZMG_ALV_200U4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_alv_200u4.
*Alıştırma – 4: İkinci veya üçüncü alıştırmada gösterdiğiniz ALV için yeni bir PF_Status ve User Command oluşturun.
*“Geri butonunu düzenleyin”. Ayrıca 3 adet buton oluşturun.
*Birinci butona basıldığında ALV’de bulunan satir sayısını kullanıcıya bilgi mesajı olarak verin.
*İkinci butona basıldığında seyahat acentelerinin bulunduğu şehirlerin toplam sayısını kullanıcıya bilgi mesajı olarak verin.
*(Bazı seyahat şirketleri ayni şehirde bulunuyor.)Üçüncü butona basıldığında seçili satirin bilgilerini popup ALV olarak ekrana getirin.
*(Kullanıcının tek bir satir seçtiğini kabul ediyoruz.)
*
*S.200-Übung-4:Erstellen Sie ein neues PF-Status und ein Benutzerkommando für das ALV, das Sie im zweiten oder dritten Übung gezeigt haben.
*Bearbeiten Sie die "Zurück"-Schaltfläche. Erstellen Sie auch drei Schaltflächen.
*Wenn die erste Schaltfläche gedrückt wird, geben Sie dem Benutzer als Informationsmeldung die Anzahl der Zeilen im ALV an.
*Wenn die zweite Schaltfläche gedrückt wird, geben Sie dem Benutzer als Informationsmeldung die Gesamtanzahl der Städte an,
*in denen Reisebüros ansässig sind. (Einige Reiseunternehmen befinden sich möglicherweise in derselben Stadt.)
*Wenn die dritte Schaltfläche gedrückt wird, zeigen Sie die Informationen der ausgewählten Zeile als Popup-ALV auf dem Bildschirm an.
*(Wir gehen davon aus, dass der Benutzer nur eine Zeile auswählt.)

DATA: gt_stravelag         TYPE TABLE OF zmg_stravelag_2,
      gs_stravelag         TYPE zmg_stravelag_2,
      gt_ausgewaelte_zeile TYPE TABLE OF zmg_stravelag_2,
      gt_fieldcat          TYPE lvc_t_fcat,
      gt_fieldcat_slis     TYPE slis_t_fieldcat_alv,
      gs_layout            TYPE lvc_s_layo,
      gv_anzahl_zeilen     TYPE n LENGTH 3,
      gv_msg               TYPE c LENGTH 80,
      gv_zaehler           TYPE n LENGTH 3,
      gv_stadt             TYPE city.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: so_agnum FOR gs_stravelag-agencynum.
SELECTION-SCREEN END OF BLOCK a1.

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
      i_callback_pf_status_set = 'STATUS_04'
      i_callback_user_command  = 'UC_U4'
    TABLES
      t_outtab                 = gt_stravelag
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.

FORM status_04 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_04'.
ENDFORM.

FORM uc_u4 USING lv_ucomm     TYPE sy-ucomm
                 ls_selfield  TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'LINE'.
      DESCRIBE TABLE gt_stravelag LINES gv_anzahl_zeilen.
      SHIFT gv_anzahl_zeilen LEFT DELETING LEADING '0'.
      CONCATENATE TEXT-002 gv_anzahl_zeilen INTO gv_msg SEPARATED BY space.

      MESSAGE gv_msg TYPE 'I'.

    WHEN 'STADT'.
      SORT gt_stravelag BY city.
      LOOP AT gt_stravelag INTO gs_stravelag.
        IF sy-tabix > 1 AND gs_stravelag-city = gv_stadt.
          CONTINUE.
        ENDIF.
        gv_stadt = gs_stravelag-city.
        gv_zaehler = gv_zaehler + 1.
      ENDLOOP.

      SHIFT gv_zaehler LEFT DELETING LEADING '0'.
      CONCATENATE TEXT-003 gv_zaehler INTO gv_msg SEPARATED BY space.

      MESSAGE gv_msg TYPE 'I'.

    WHEN 'POPUP'.
      READ TABLE gt_stravelag INTO gs_stravelag INDEX ls_selfield-tabindex.
      IF sy-subrc IS INITIAL.
        APPEND gs_stravelag TO gt_ausgewaelte_zeile.
      ENDIF.

      CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
        EXPORTING
          i_structure_name       = 'ZMG_STRAVELAG_2'
          i_bypassing_buffer     = abap_true
        CHANGING
          ct_fieldcat            = gt_fieldcat_slis
        EXCEPTIONS
          inconsistent_interface = 1
          program_error          = 2
          OTHERS                 = 3.

      IF sy-subrc IS NOT INITIAL.
        LEAVE PROGRAM.
      ENDIF.

      CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
        EXPORTING
          i_title               = TEXT-004
          i_screen_start_column = 5
          i_screen_start_line   = 5
          i_screen_end_column   = 165
          i_screen_end_line     = 8
          i_tabname             = 'GT_AUSGEWAELTE_ZEILE'
          it_fieldcat           = gt_fieldcat_slis
          i_callback_program    = sy-repid
        TABLES
          t_outtab              = gt_ausgewaelte_zeile
        EXCEPTIONS
          program_error         = 1
          OTHERS                = 2.
      IF sy-subrc IS NOT INITIAL.
        LEAVE PROGRAM.
      ENDIF.

      CLEAR: gt_ausgewaelte_zeile.

  ENDCASE.
ENDFORM.
