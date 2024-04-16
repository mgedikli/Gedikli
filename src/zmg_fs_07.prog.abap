*&---------------------------------------------------------------------*
*& Report ZMG_FS_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_fs_07.
*Alıştırma – 3: Yeni bir rapor oluşturun. İçinde C, N, D, T, I, P ve String tipinde 7 farklı değişken tanımlayın.
*Ayrıca her bir değişken için ayni tipte birer tane field sembol tanımlayın.
*Değişkenleri ilgili field sembollere assign edin ve ekrana yazdırın.
*
*S.330-Übung-3: Erstellen Sie einen neuen Bericht. Definieren Sie 7 verschiedene Variablen vom Typ C, N, D, T, I, P und String.
*Definieren Sie außerdem für jede Variable ein Feldsymbol desselben Typs.
*Weisen Sie die Variablen den entsprechenden Feldsymbolen zu und geben Sie sie auf dem Bildschirm aus.

DATA: gv_1 TYPE c LENGTH 10,
      gv_2 TYPE n LENGTH 5,
      gv_3 TYPE datum,
      gv_4 TYPE uzeit,
      gv_5 TYPE i,
      gv_6 TYPE p DECIMALS 3,
      gv_7 TYPE string.

FIELD-SYMBOLS: <fs_1> TYPE c,
               <fs_2> TYPE n,
               <fs_3> TYPE datum,
               <fs_4> TYPE uzeit,
               <fs_5> TYPE i,
               <fs_6> TYPE p,
               <fs_7> TYPE string.

gv_1 = 'Beispieltext'.
gv_2 = '12345'.
gv_3 = '20240222'.
gv_4 = '185300'.
gv_5 = 100.
gv_6 = 5 / 7.
gv_7 = 'Beispieltext vom Typ String'.

ASSIGN gv_1 TO <fs_1>.
ASSIGN gv_2 TO <fs_2>.
ASSIGN gv_3 TO <fs_3>.
ASSIGN gv_4 TO <fs_4>.
ASSIGN gv_5 TO <fs_5>.
ASSIGN gv_6 TO <fs_6>.
ASSIGN gv_7 TO <fs_7>.

WRITE: <fs_1>, <fs_2>, <fs_3>, <fs_4>, <fs_5>, <fs_6>, <fs_7>.

UNASSIGN: <fs_1>, <fs_2>, <fs_3>, <fs_4>, <fs_5>, <fs_6>, <fs_7>.

BREAK-POINT.
