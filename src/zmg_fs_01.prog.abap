*&---------------------------------------------------------------------*
*& Report ZMG_FS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_fs_01.

TYPES: BEGIN OF gty_table,
         carrid    TYPE s_carr_id,
         connid    TYPE s_conn_id,
         fldate    TYPE s_date,
         leer_sitz TYPE int4,
         occu_%  TYPE p DECIMALS 0,
       END OF gty_table.

DATA: gt_table   TYPE TABLE OF gty_table,
      gt_sflight TYPE TABLE OF sflight,
      gs_sflight TYPE sflight.

FIELD-SYMBOLS: <gs_str> TYPE gty_table.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.

  LOOP AT gt_sflight INTO gs_sflight.

    APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.

    <gs_str>-carrid     = gs_sflight-carrid.
    <gs_str>-connid     = gs_sflight-connid.
    <gs_str>-fldate     = gs_sflight-fldate.
    <gs_str>-leer_sitz  = gs_sflight-seatsmax - gs_sflight-seatsocc.
    <gs_str>-occu_%   = gs_sflight-seatsocc / gs_sflight-seatsmax * 100.

  ENDLOOP.
  BREAK-POINT.
