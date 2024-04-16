*&---------------------------------------------------------------------*
*& Report ZMG_INDEC_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_indec_07.
*Inline Decleration FS tanimlama: Kullanicinin Tablo secmesi ve Kolon sayisi girmesini isteyecegiz.
**Secilen DB Tablosundan veri okuyup IT'nun istenen Kolonlarini ekrana yazdiracagiz.

PARAMETERS: p_scarr  RADIOBUTTON GROUP xyz,
            p_spfli  RADIOBUTTON GROUP xyz,
            p_sflght RADIOBUTTON GROUP xyz,
            p_spalte TYPE i.

DATA: gv_no TYPE i VALUE 1.

START-OF-SELECTION.

  IF  p_scarr = abap_true.

    SELECT * FROM scarr INTO TABLE @DATA(gt_scarr).
    LOOP AT gt_scarr INTO DATA(gs_scarr).

      DO.
        ASSIGN COMPONENT gv_no OF STRUCTURE gs_scarr TO FIELD-SYMBOL(<fs_field>).
        IF sy-subrc IS INITIAL.
          WRITE: <fs_field>.
        ENDIF.
        gv_no = gv_no + 1.
        IF gv_no > p_spalte.
          EXIT.
        ENDIF.
      ENDDO.

      gv_no = 1.
      SKIP.
    ENDLOOP.

  ELSEIF p_spfli = abap_true.

    SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).
    LOOP AT gt_spfli INTO DATA(gs_spfli).

      DO.
        ASSIGN COMPONENT gv_no OF STRUCTURE gs_spfli TO <fs_field>.
        IF sy-subrc IS INITIAL.
          WRITE: <fs_field>.
        ENDIF.
        gv_no = gv_no + 1.
        IF gv_no > p_spalte.
          EXIT.
        ENDIF.
      ENDDO.

      gv_no = 1.
      SKIP.
    ENDLOOP.

  ELSE.

    SELECT * FROM sflight INTO TABLE @DATA(gt_sflight).
    LOOP AT gt_sflight INTO DATA(gs_sflight).

      DO.
        ASSIGN COMPONENT gv_no OF STRUCTURE gs_sflight TO <fs_field>.
        IF sy-subrc IS INITIAL.
          WRITE: <fs_field>.
        ENDIF.
        gv_no = gv_no + 1.
        IF gv_no > p_spalte.
          EXIT.
        ENDIF.
      ENDDO.

      gv_no = 1.
      SKIP.
    ENDLOOP.

  ENDIF.
