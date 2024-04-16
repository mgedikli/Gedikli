*&---------------------------------------------------------------------*
*& Report ZMG_TEST_74
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_s174_ubung16.
*S.174-Alıştırma – 16: Yeni bir fonksiyon yazın. Bir adet CARRID alsın. Gelen CARRID bilgisine göre SCARR
*tablosunu okusun ve kullanıcıya bir internal tablo versin. Fonksiyonu yeni yazacağınız bir raporda
*kullanın. Gelen satırları ekrana yazdırın.

*S.174-Übung 16: Erstellen Sie eine neue Funktion, die eine "carrid"-Variable entgegennimmt.
*Basierend auf der empfangenen "carrid"-Information soll sie die Tabelle SCARR lesen
*und dem Benutzer eine interne Tabelle zur Verfügung stellen.
*Verwenden Sie die Funktion in einem neuen Bericht, den Sie schreiben.
*Geben Sie die empfangenen Zeilen auf dem Bildschirm aus.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_carrid TYPE s_carr_id.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gt_scarr TYPE ZMG_TT_SCARR16,
      gs_scarr TYPE scarr.

START-OF-SELECTION.

  CALL FUNCTION 'ZMG_FM_A16'
    EXPORTING
      iv_carrid = p_carrid
    IMPORTING
      et_scarr  = gt_scarr.
  LOOP AT gt_scarr INTO gs_scarr.
    WRITE:  gs_scarr-carrid,
            gs_scarr-carrname,
            gs_scarr-currcode,
            gs_scarr-url.
  ENDLOOP.
