*&---------------------------------------------------------------------*
*& Report ZMG_FS_10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_fs_10.
*Alıştırma – 6: Yeni bir rapor oluşturun ve SFLIGHT tablosunun bütün satırlarını okuyup internal tablo
*içine kaydedin. TYPE ANY TABLE komutu yardımıyla yeni bir field sembol oluşturun
*ve field sembolü kullanarak loop edin. İstediğiniz herhangi 3 kolonu ekrana yazdırın.
*
*S.330-Übung-6: Erstellen Sie einen neuen Bericht und lesen Sie alle Zeilen der Tabelle SFLIGHT ein
*und speichern Sie sie in einer internen Tabelle. Erstellen Sie mithilfe des Befehls TYPE ANY TABLE ein neues Feldsymbol
*und verwenden Sie das Feldsymbol, um eine Schleife auszuführen. Drucken Sie drei beliebige Spalten auf dem Bildschirm aus.

DATA: gt_sflight TYPE TABLE OF sflight,
      gs_sflight TYPE sflight.

FIELD-SYMBOLS: <fs_sflight> TYPE ANY TABLE,
               <fs_str>     TYPE sflight,
               <fs_field>   TYPE any.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.

  ASSIGN gt_sflight TO <fs_sflight>.

  LOOP AT <fs_sflight> ASSIGNING <fs_str>.
    ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_str> TO <fs_field>.
    IF <fs_field> IS ASSIGNED.
      WRITE: <fs_field>.
      UNASSIGN: <fs_field>.
    ENDIF.

    ASSIGN COMPONENT 'CONNID' OF STRUCTURE <fs_str> TO <fs_field>.
    IF <fs_field> IS ASSIGNED.
      WRITE: <fs_field>.
      UNASSIGN: <fs_field>.
    ENDIF.

    ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_str> TO <fs_field>.
    IF <fs_field> IS ASSIGNED.
      WRITE: <fs_field>.
      UNASSIGN: <fs_field>.
    ENDIF.

    SKIP.
  ENDLOOP.
