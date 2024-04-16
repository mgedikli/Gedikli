*&---------------------------------------------------------------------*
*& Report ZMG_S174_UBUNG18
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_s174_ubung18.
*S.174-Alıştırma – 18: Yeni bir fonksiyon yazın. Bir adet CARRID alsın. Gelen CARRID bossa kullanıcıya SCARR
*tablosunun tüm satırlarını versin. Doluysa tek bir satir versin. Doluysa ve buna rağmen SCARR
*içerisinde uygun bir satir bulunamadıysa “SATIR_BULUNMAMADI” seklinde bir exception versin.
*Fonksiyonu yeni yazacağınız bir raporda kullanın. Sonuç ne olursa olsun ekrana yazdırın.
*
*S.174-Übung-18: Schreiben Sie eine neue Funktion. Es soll eine CARRID erhalten.
*Wenn CARRID leer ist, geben Sie dem Benutzer alle Zeilen der SCARR-Tabelle.
*Wenn es gefüllt ist, geben Sie eine einzelne Zeile aus.
*Wenn es gefüllt ist und dennoch keine geeignete Zeile in SCARR gefunden werden kann, werfen Sie eine Ausnahme "Zeile nicht gefunden".
*Verwenden Sie die Funktion in einem neu zu schreibenden Bericht. Drucken Sie das Ergebnis unabhängig davon auf dem Bildschirm.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_carrid TYPE s_carr_id.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gs_scarr TYPE zmg_s_scarr16,
      gt_scarr TYPE zmg_tt_scarr16.

START-OF-SELECTION.

  CALL FUNCTION 'ZMG_FM_U18'
    EXPORTING
      iv_carrid = p_carrid
    IMPORTING
      et_scarr  = gt_scarr
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.

  IF sy-subrc NE 0.
    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
  ELSE.
    LOOP AT gt_scarr INTO gs_scarr.
      WRITE: gs_scarr-carrid,
             gs_scarr-carrname,
             gs_scarr-currcode,
             gs_scarr-url.
      SKIP. ULINE.
    ENDLOOP.
  ENDIF.
