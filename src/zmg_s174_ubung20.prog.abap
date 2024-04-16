*&---------------------------------------------------------------------*
*& Report ZMG_S174_UBUNG20
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_s174_ubung20.
*Alıştırma – 20: Yeni bir fonksiyon yazın. Kullanıcıdan 1 adet gün ismi, 1 adet de sayı alin. Kullanıcının
*girdiği sayı kadar gün sonra günlerden hangi gün olacağını hesaplayın ve kullanıcıya geri bildirin.
*Fonksiyonu yeni yazacağınız bir raporda kullanın. Sonucu ekrana yazdırın.
*
*S.174-Übung-20:Schreiben Sie eine neue Funktion. Nehmen Sie einen Tag-Namen und eine Zahl vom Benutzer entgegen.
*Berechnen Sie, welcher Tag nach der vom Benutzer eingegebenen Anzahl von Tagen sein wird, und geben Sie dem Benutzer eine Rückmeldung.
*Verwenden Sie die Funktion in einem neuen Bericht, den Sie schreiben werden. Drucken Sie das Ergebnis auf dem Bildschirm aus.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_day TYPE c LENGTH 10,
              p_num TYPE i.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_result TYPE c LENGTH 15.

START-OF-SELECTION.

CALL FUNCTION 'ZMG_FM_U20'
  EXPORTING
    iv_day_name = p_day
    iv_number   = p_num
  IMPORTING
    ev_new_day  = gv_result.

write: Text-002, gv_result.
