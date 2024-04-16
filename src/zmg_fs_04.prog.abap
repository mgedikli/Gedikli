*&---------------------------------------------------------------------*
*& Report ZMG_FS_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_fs_04.
*Runtime FS TYPE ANY, ANY TABLE
DATA: gv_text  TYPE string VALUE 'FS-Nutzung Beispielbericht',
      gs_scarr TYPE scarr,
      gt_spfli TYPE TABLE OF spfli.


FIELD-SYMBOLS: <fs_general> TYPE any,
               <fs_field>   TYPE any,
               <fs_str>     TYPE any.

START-OF-SELECTION.

  ASSIGN gv_text TO <fs_general>.

  WRITE: <fs_general>.
  SKIP.

  SELECT SINGLE * FROM scarr INTO gs_scarr WHERE carrid = 'LH'.

  ASSIGN gs_scarr TO <fs_general>.

  ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_general> TO <fs_field>. "<fs_general>Satirin carrid bilesenini <fs_field> ata.
  IF sy-subrc IS INITIAL.
    WRITE: <fs_field>.
  ENDIF.

  BREAK-POINT.
