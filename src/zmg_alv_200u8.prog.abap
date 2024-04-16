*&---------------------------------------------------------------------*
*& Report ZMG_ALV_200U8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_alv_200u8.
*Alıştırma – 8: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CARRID alın. Alınan CARRID ile SCARR
*tablosunu okuyun ve oluşan internal tablonun ALV’sini gösterin. ALV’deki CARRID kolonu HOTSPOT
*olsun. Tıklandığında mevcut ALV’den çıkmadan SPFLI tablosunda ayni CARRID verisine sahip satırların
*ALV’si gösterilsin. (Küçük pencere şeklinde.) Bu ALV’nin de CARRID kolonu HOTSPOT olsun.
*Tıklandığında mevcut ALV’den çıkmadan SFLIGHT tablosunda ayni CARRID verisine sahip satırların
*ALV’si gösterilsin.
*
*S.200-Übung-8:Erstellen Sie einen neuen Bericht und fordern Sie den Benutzer auf, 1 CARRID zu geben.
*Lesen Sie die SCARR-Tabelle mit dem erhaltenen CARRID und zeigen Sie das ALV der entstandenen internen Tabelle an.
*Die CARRID-Spalte im ALV soll ein HOTSPOT sein. Wenn darauf geklickt wird,
*soll das ALV der Zeilen in der SPFLI-Tabelle angezeigt werden, die denselben CARRID-Datensatz haben,
*ohne das aktuelle ALV zu verlassen. Dieses ALV soll auch eine HOTSPOT-Spalte für CARRID haben. Wenn darauf geklickt wird,
*sollen die Zeilen im SFLIGHT-Datensatz angezeigt werden, die denselben CARRID-Datensatz haben, ohne das aktuelle ALV zu verlassen.

DATA: gt_scarr        TYPE TABLE OF scarr,
      gt_spfli        TYPE TABLE OF spfli,
      gt_sflight      TYPE TABLE OF sflight,
      gt_fcat_scarr   TYPE lvc_t_fcat,
      gt_fcat_spfli   TYPE lvc_t_fcat,
      gt_fcat_sflight TYPE lvc_t_fcat,
      gs_fcat_scarr   TYPE lvc_s_fcat,
      gs_fcat_spfli   TYPE lvc_s_fcat,
      gs_fcat_sflight TYPE lvc_s_fcat,
      gs_layout       TYPE lvc_s_layo.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.

FORM select_data.
  SELECT * FROM scarr INTO TABLE gt_scarr.
ENDFORM.

FORM fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SCARR'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_scarr
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

**********HOTSPOT SCARR
  LOOP AT gt_fcat_scarr INTO gs_fcat_scarr.
    CASE gs_fcat_scarr-fieldname.
      WHEN 'CARRID'.
        gs_fcat_scarr-hotspot  = abap_true.
        MODIFY gt_fcat_scarr FROM gs_fcat_scarr TRANSPORTING hotspot WHERE fieldname = gs_fcat_scarr-fieldname.
*      WHEN .
*      WHEN OTHERS.
    ENDCASE.
  ENDLOOP.

*********FCAT SPFLI
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SPFLI'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_spfli
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

***********HOTSPOT SPFLI
*  LOOP AT gt_fcat_spfli INTO gs_fcat_spfli.
*    CASE gs_fcat_scarr-fieldname.
*      WHEN 'CARRID'.
*        gs_fcat_spfli-hotspot  = abap_true.
*        MODIFY gt_fcat_spfli FROM gs_fcat_spfli TRANSPORTING hotspot WHERE fieldname = gs_fcat_spfli-fieldname.
**      WHEN .
**      WHEN OTHERS.
*    ENDCASE.
*  ENDLOOP.

********FCAT SFLIGHT
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_sflight
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

***********HOTSPOT SFLIGHT
*  LOOP AT gt_fcat_sflight INTO gs_fcat_sflight.
*    CASE gs_fcat_sflight-fieldname.
*      WHEN 'CARRID'.
*        gs_fcat_sflight-hotspot  = abap_true.
*        MODIFY gt_fcat_sflight FROM gs_fcat_sflight TRANSPORTING hotspot WHERE fieldname = gs_fcat_sflight-fieldname.
**      WHEN .
**      WHEN OTHERS.
*    ENDCASE.
*  ENDLOOP.

ENDFORM.
*
FORM layout.
  gs_layout-zebra       = abap_true.
  gs_layout-cwidth_opt  = abap_true.
  gs_layout-sel_mode    = 'A'.
ENDFORM.
*
FORM show_alv.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program      = sy-repid
      i_callback_user_command = 'UC_SCARR'
      is_layout_lvc           = gs_layout
      it_fieldcat_lvc         = gt_fcat_scarr
    TABLES
      t_outtab                = gt_scarr
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.
*
FORM uc_scarr USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.
  CASE lv_ucomm.
    WHEN '&IC1'.
      IF ls_selfield-fieldname = 'CARRID'.
        SELECT * FROM spfli INTO TABLE gt_spfli WHERE carrid = ls_selfield-value.

**********ALV SPFLI
        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
          EXPORTING
            i_callback_program      = sy-repid
            i_callback_user_command = 'UC_SPFLI'
            is_layout_lvc           = gs_layout
            it_fieldcat_lvc         = gt_fcat_spfli
            i_screen_start_column   = 4
            i_screen_start_line     = 10
            i_screen_end_column     = 140
            i_screen_end_line       = 20
          TABLES
            t_outtab                = gt_spfli
          EXCEPTIONS
            program_error           = 1
            OTHERS                  = 2.

        IF sy-subrc IS NOT INITIAL.
          LEAVE PROGRAM.
        ENDIF.
      ENDIF.
*  WHEN .
*  WHEN OTHERS.
  ENDCASE.
ENDFORM.

FORM uc_spfli USING lv_ucomm    TYPE sy-ucomm
                    ls_selfield TYPE slis_selfield.
  CASE lv_ucomm.
    WHEN '&IC1'.
      IF ls_selfield-fieldname = 'CARRID'.
        SELECT * FROM sflight INTO TABLE gt_sflight WHERE carrid = ls_selfield-value.

**********ALV SFLIGHT
        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
          EXPORTING
            i_callback_program    = sy-repid
            is_layout_lvc         = gs_layout
            it_fieldcat_lvc       = gt_fcat_sflight
            i_screen_start_column = 4
            i_screen_start_line   = 10
            i_screen_end_column   = 140
            i_screen_end_line     = 20
          TABLES
            t_outtab              = gt_sflight
          EXCEPTIONS
            program_error         = 1
            OTHERS                = 2.

        IF sy-subrc IS NOT INITIAL.
          LEAVE PROGRAM.
        ENDIF.
      ENDIF.
*    WHEN .
*    WHEN OTHERS.
  ENDCASE.
ENDFORM.
