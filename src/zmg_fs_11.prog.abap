*&---------------------------------------------------------------------*
*& Report ZMG_FS_11
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_fs_11.

*Alıştırma – 7: Yeni bir rapor oluşturun. Raporda 3 adet radiobutton olsun.
*Rapor içinde STRAVELAG tablosunun tüm satırlarını okuyup internal tablo içine kaydedin.
*Kullanıcı ilk radiobuttonu seçerse tablonun ilk 3 kolonunu, ikinci radiobuttonu seçerse ilk 6 kolonunu,
*üçüncü radiobuttonu seçerse bütün kolonları ekrana yazdırın.
*Loop işlemini field sembol kullanarak yapın. Field sembol TYPE ANY TABLE komutu yardımıyla tanımlanmış olsun.
*
*S.330-Übung-7: Erstellen Sie einen neuen Bericht. Im Bericht sollen 3 Radiobuttons vorhanden sein.
*Lesen Sie alle Zeilen der Tabelle STRAVELAG in den Bericht ein und speichern Sie sie in einer internen Tabelle.
*Wenn der Benutzer den ersten Radiobutton auswählt, geben Sie die ersten 3 Spalten der Tabelle aus.
*Wenn der Benutzer den zweiten Radiobutton auswählt, geben Sie die ersten 6 Spalten aus.
*Wenn der Benutzer den dritten Radiobutton auswählt, geben Sie alle Spalten aus. Führen Sie die Schleife mit einem Feldsymbol durch.
*Das Feldsymbol sollte mithilfe des Befehls TYPE ANY TABLE definiert sein.

PARAMETERS: p_1 RADIOBUTTON GROUP xyz,
            p_2 RADIOBUTTON GROUP xyz,
            p_3 RADIOBUTTON GROUP xyz.

DATA: gt_table TYPE TABLE OF stravelag,
      gv_no    TYPE i VALUE 1.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE,
               <fs_str>   TYPE any,
               <fs_field> TYPE any.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE gt_table.
  ASSIGN gt_table TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING <fs_str>.
    IF p_1 = abap_true.

      DO.
        ASSIGN COMPONENT gv_no OF STRUCTURE <fs_str> TO <fs_field>.
        IF <fs_field> IS ASSIGNED.
          WRITE: <fs_field>.
          UNASSIGN: <fs_field>.
        ENDIF.
        gv_no = gv_no + 1.
        IF gv_no > 3.
          gv_no = 1.
          EXIT.
        ENDIF.
      ENDDO.
      SKIP.

    ELSEIF p_2 = abap_true.
      DO.
        ASSIGN COMPONENT gv_no OF STRUCTURE <fs_str> TO <fs_field>.
        IF <fs_field> IS ASSIGNED.
          WRITE: <fs_field>.
          UNASSIGN: <fs_field>.
        ENDIF.
        gv_no = gv_no + 1.
        IF gv_no > 6.
          gv_no = 1.
          EXIT.
        ENDIF.
      ENDDO.
      SKIP.

    ELSEIF p_3 = abap_true.
      DO.
        ASSIGN COMPONENT gv_no OF STRUCTURE <fs_str> TO <fs_field>.
        IF <fs_field> IS ASSIGNED.
          WRITE: <fs_field>.
          UNASSIGN: <fs_field>.
          gv_no = gv_no + 1.
        ELSE.
          gv_no = 1.
          EXIT.
        ENDIF.
      ENDDO.
      SKIP.
    ENDIF.
  ENDLOOP.
