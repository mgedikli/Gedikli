*&---------------------------------------------------------------------*
*& Report ZMG_FS_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_fs_03.
*Runtime FS TYPE ANY, ANY TABLE
DATA: gv_1 TYPE n LENGTH 5,
      gv_2 TYPE c LENGTH 10,
      gv_3 TYPE datum,
      gv_4 TYPE p DECIMALS 4,
      gv_5 TYPE i,
      gv_6 TYPE string,
      gv_7 TYPE uzeit.

FIELD-SYMBOLS: <fs_1> TYPE i,
               <fs_2> TYPE string,
               <fs_3> TYPE zmg_stravelag.

FIELD-SYMBOLS: <fs_4> TYPE any.

ASSIGN gv_1 TO <fs_4>.
ASSIGN gv_2 TO <fs_4>.
ASSIGN gv_3 TO <fs_4>.
ASSIGN gv_4 TO <fs_4>.
ASSIGN gv_5 TO <fs_4>.
ASSIGN gv_6 TO <fs_4>.
ASSIGN gv_7 TO <fs_4>.
