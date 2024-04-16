*&---------------------------------------------------------------------*
*& Report ZMG_FS_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_submit_01.
*Alıştırma – 2: Yeni bir rapor oluşturun. Raporda 2 adet radiobutton 2 adet secim ekranı olsun.
*Birinci radiobutton seçilirse birinci seçim ekranı görünür hale gelsin.
*İkinci radiobutton seçilirse ikinci seçim ekranı görünür hale gelsin.
*Birinci secim ekranı kendinize ait STRAVELAG tablosundaki ilgili satirin şirket ismini değiştirebilmek için kullanıcıdan ID ve yeni isim alsın.
*İkinci secim ekranı ise ayni tablodaki ilgili satirin adres hücresini (STREET kolonu) değiştirebilmek için kullanıcıdan ID ve yeni adres alsın.
*Secim ekranından gelen veriye göre rapor içinde ilgili programı SUBMIT WITH komutu yardımıyla çağırın ve AND RETURN komutu ile geri dönün.
*
*S.330-Übung-2:Erstellen Sie einen neuen Bericht. Der Bericht soll 2 Radio-Buttons und 2 Auswahlfelder enthalten.
*Wenn der erste Radio-Button ausgewählt wird, soll das erste Auswahlfeld sichtbar werden.
*Wenn der zweite Radio-Button ausgewählt wird, soll das zweite Auswahlfeld sichtbar werden.
*Das erste Auswahlfeld soll vom Benutzer die ID und den neuen Namen erhalten, um den Firmennamen der entsprechenden Zeile in Ihrer STRAVELAG-Tabelle zu ändern.
*Das zweite Auswahlfeld soll vom Benutzer die ID und die neue Adresse erhalten, um die Adresszelle (STREET-Spalte) der entsprechenden Zeile in derselben Tabelle zu ändern.
*Rufen Sie das entsprechende Programm basierend auf den ausgewählten Daten im Auswahlfeld im Bericht mit dem Befehl SUBMIT WITH auf und kehren Sie mit dem Befehl AND RETURN zurück.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_1 RADIOBUTTON GROUP abc DEFAULT 'X' USER-COMMAND c1 MODIF ID m1,
              p_2 RADIOBUTTON GROUP abc MODIF ID m1.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002 NO INTERVALS.
  PARAMETERS: p_num1 TYPE s_agncynum,
              p_name TYPE s_agncynam.
SELECTION-SCREEN END OF BLOCK a2.

SELECTION-SCREEN BEGIN OF BLOCK a3 WITH FRAME TITLE TEXT-002 NO INTERVALS.
  PARAMETERS: p_num2   TYPE s_agncynum,
              p_street TYPE s_street.
SELECTION-SCREEN END OF BLOCK a3.

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF p_1 = abap_true.
      IF screen-name    = '%_P_NUM2_%_APP_%-TEXT'   OR screen-name = 'P_NUM2' OR
         screen-name    = '%_P_STREET_%_APP_%-TEXT' OR screen-name = 'P_STREET'.
         screen-active  = 0.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name    = '%_P_NUM1_%_APP_%-TEXT' OR screen-name = 'P_NUM1' OR
         screen-name    = '%_P_NAME_%_APP_%-TEXT' OR screen-name = 'P_NAME'.
         screen-active  = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.

START-OF-SELECTION.

  IF p_1 = abap_true.

    SUBMIT zmg_submit_01a WITH p_num  = p_num1
                      WITH p_name = p_name AND RETURN.

  ELSE.

    SUBMIT zmg_submit_01b WITH p_num    = p_num2
                      WITH p_street = p_street AND RETURN.
  ENDIF.
