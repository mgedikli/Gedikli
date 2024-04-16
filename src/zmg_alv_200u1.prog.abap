*&---------------------------------------------------------------------*
*& Report ZMG_ALV_200U1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_alv_200u1.
*Alıştırma – 1: Yeni bir database tablosu oluşturun. (Örneğin ZCM_STRAVELAG) Satir yapısı STRAVELAG
*database tablosu ile tamamen ayni olsun. Daha sonra yeni bir rapor oluşturun ve STRAVELAG
*tablosundaki bütün bilgileri okuyup oluşturduğunuz yeni database tablosu içine kaydedin.

*S.200-Übung - 1: Erstellen Sie eine neue Datenbanktabelle. (Zum Beispiel ZCM_STRAVELAG)
*Die Zeilenstruktur soll genau der STRAVELAG-Datenbanktabelle entsprechen.
*Erstellen Sie dann einen neuen Bericht und lesen Sie alle Informationen aus der Tabelle
*STRAVELAG ein und speichern Sie sie in der neu erstellten Datenbanktabelle.

DATA: gt_stravelag TYPE TABLE OF stravelag,
      gs_stravelag TYPE stravelag..

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE gt_stravelag.

  LOOP AT  gt_stravelag INTO gs_stravelag.
    INSERT zmg_stravelag_2 FROM gs_stravelag.
  ENDLOOP.
