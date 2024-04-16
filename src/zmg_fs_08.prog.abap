*&---------------------------------------------------------------------*
*& Report ZMG_FS_08
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_fs_08.
*S.330-Übung - 4: Erstellen Sie einen neuen Bericht.
*Definieren Sie 7 verschiedene Variablen vom Typ C, N, D, T, I, P und String.
*Anschließend definieren Sie mit Hilfe des Befehls TYPE ANY ein neues Feldsymbol.
*Weisen Sie die Variablen nacheinander dem Feldsymbol zu und geben Sie sie auf dem Bildschirm aus.
*Nach jeder Ausgabeoperation setzen Sie das Feldsymbol mit dem Befehl "unassign" zurück,
*sodass keinem der Variablen das Feldsymbol mehr zugewiesen ist.

DATA: gv_1 TYPE c LENGTH 10,
      gv_2 TYPE n LENGTH 5,
      gv_3 TYPE datum,
      gv_4 TYPE uzeit,
      gv_5 TYPE i,
      gv_6 TYPE p DECIMALS 3,
      gv_7 TYPE string.

FIELD-SYMBOLS: <fs_1> TYPE any.

gv_1 = 'Beispieltekst'.
gv_2 = '12345'.
gv_3 = '20240222'.
gv_4 = '185300'.
gv_5 = 100.
gv_6 = 5 / 7.
gv_7 = 'Beispieltext vom Typ String'.

ASSIGN gv_1 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN <fs_1>.
ENDIF.

ASSIGN gv_2 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN <fs_1>.
ENDIF.

ASSIGN gv_3 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN <fs_1>.
ENDIF.

ASSIGN gv_4 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN <fs_1>.
ENDIF.

ASSIGN gv_5 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN <fs_1>.
ENDIF.

ASSIGN gv_6 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN <fs_1>.
ENDIF.

ASSIGN gv_7 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN <fs_1>.
ENDIF.

BREAK-POINT.
