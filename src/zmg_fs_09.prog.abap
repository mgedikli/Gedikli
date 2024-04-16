*&---------------------------------------------------------------------*
*& Report ZMG_FS_09
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_fs_09.
*Alıştırma – 5: Yeni bir rapor oluşturun ve SFLIGHT tablosunun bütün satırlarını okuyup
*internal tablo içine kaydedin.
*SFLIGHT tablosu ile ayni satır yapısına sahip yeni bir field sembol oluşturun
*ve field sembolü kullanarak loop edin. İstediğiniz herhangi 3 kolonu ekrana yazdırın.
*
*Übung - 5: Erstellen Sie einen neuen Bericht und lesen Sie alle Zeilen der Tabelle SFLIGHT ein
*und speichern Sie sie in einer internen Tabelle.
*Erstellen Sie ein neues Feldsymbol mit der gleichen Zeilenstruktur wie die Tabelle SFLIGHT
*und verwenden Sie das Feldsymbol, um eine Schleife auszuführen.
*Drucken Sie drei beliebige Spalten auf dem Bildschirm aus.

DATA: gt_sflight TYPE TABLE OF sflight,
      gs_sflight TYPE sflight.

FIELD-SYMBOLS: <fs_sflight> TYPE zmg_tt_sflight3,
               <fs_str>     TYPE sflight.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.

  ASSIGN gt_sflight TO <fs_sflight>.

  LOOP AT <fs_sflight> INTO gs_sflight.
    WRITE: gs_sflight-carrid, gs_sflight-connid, gs_sflight-fldate.
    SKIP.
  ENDLOOP.

  LOOP AT <fs_sflight> ASSIGNING <fs_str>.
    WRITE: <fs_str>-carrid, <fs_str>-connid, <fs_str>-fldate.
    SKIP.
  ENDLOOP.
