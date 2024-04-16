*&---------------------------------------------------------------------*
*& Report ZMG_S174_UBUNG19
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_s174_ubung19.
*Alıştırma – 19: Yeni bir fonksiyon yazın. Kullanıcıdan 1 adet işlem sembolü 2 adet de sayı alsın. Gelen
*sembole göre uygun matematiksel işlemi yapıp sonucunu kullanıcıya versin. İşlem sembolü bos olursa
*bir exception bildirsin. Geçersiz bir işlem sembolü girilirse ayrı bir exception bildirsin. Fonksiyon
*içerisindeki tüm işlemleri ayrı performlar halinde yapın. Fonksiyonu yeni yazacağınız bir raporda
*kullanın. Sonucu ekrana yazdırın.

*S.174-Übung-19:Schreiben Sie eine neue Funktion. Es soll ein Operator und 2 Zahl vom Benutzer entgegengenommen werden.
*Basierend auf dem erhaltenen Operator soll die entsprechende mathematische Operation durchgeführt
*und das Ergebnis dem Benutzer ausgegeben werden. Wenn der Operator leer ist, soll eine Ausnahme gemeldet werden.
*Wenn ein ungültiger Operator eingegeben wird, soll eine separate Ausnahme gemeldet werden.
*Führen Sie alle Operationen innerhalb der Funktion separat aus.
*Verwenden Sie die Funktion in einem neuen Bericht und geben Sie das Ergebnis auf dem Bildschirm aus.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_opr  TYPE c LENGTH 1,
              p_num1 TYPE i,
              p_num2 TYPE i.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_result TYPE i.

START-OF-SELECTION.

  CALL FUNCTION 'ZMG_FM_U19'
    EXPORTING
      iv_operator   = p_opr
      iv_num_1      = p_num1
      iv_num_2      = p_num2
    IMPORTING
      ev_result     = gv_result
    EXCEPTIONS
      not_found_1   = 1
      not_found_2   = 2
      zero_division = 3
      OTHERS        = 4.

  IF sy-subrc = 1.
    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
  ELSEIF sy-subrc = 2.
    MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
  ELSEIF sy-subrc = 3.
    MESSAGE TEXT-004 TYPE 'S' DISPLAY LIKE 'E'.
  ELSE.
    WRITE: TEXT-005, gv_result.
  ENDIF.
