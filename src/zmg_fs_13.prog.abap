*&---------------------------------------------------------------------*
*& Report ZMG_FS_13
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_fs_13.

*Alıştırma – 8: Yeni bir rapor oluşturun. Raporda 2 adet radiobutton olsun.
*Kullanıcı ilk radiobuttonu seçerse ZCM_TABLO_1, ikinci radiobuttonu seçerse ZCM_TABLO_2 tablosundaki bütün satırların
*okuyup internal tablo içine kaydedin. Select komutunu sadece 1 kere kullanılan.
*TYPE ANY TABLE komutu yardımıyla bir field sembol tanımlayın ve internal tabloyu bu field sembole assign edin.
*Field sembol üzerinde loop ederek tüm kolonları ekrana yazdırın.
*
*S.330-Übung-8: Erstellen Sie einen neuen Bericht. Im Bericht sollen 2 Radiobuttons vorhanden sein.
*Wenn der Benutzer den ersten Radiobutton auswählt, lesen Sie alle Zeilen in der Tabelle ZCM_TABLO_1 ein,
*wenn der Benutzer den zweiten Radiobutton auswählt, lesen Sie alle Zeilen in der Tabelle ZCM_TABLO_2 ein.
*Verwenden Sie den SELECT-Befehl nur einmal. Definieren Sie mit dem Befehl TYPE ANY TABLE ein Feldsymbol
*und weisen Sie dem internen Tabelleninhalt dieses Feldsymbol zu. Durchlaufen Sie das Feldsymbol
*und geben Sie alle Spalten auf dem Bildschirm aus.

PARAMETERS: p_tb1 RADIOBUTTON GROUP abc,
            p_tb2 RADIOBUTTON GROUP abc.

DATA: gt_table_1 TYPE TABLE OF zmg_table_1,
      gt_table_2 TYPE TABLE OF zmg_table_2,
      gv_tabname TYPE tabname.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

IF p_tb1 = abap_true.
  ASSIGN gt_table_1 TO <fs_table>.
  gv_tabname = 'ZMG_TABLE_1'.

ELSE.
  ASSIGN gt_table_2 TO <fs_table>.
  gv_tabname = 'ZMG_TABLE_2'.
ENDIF.

SELECT * FROM (gv_tabname) INTO TABLE <fs_table>.

BREAK-POINT.
