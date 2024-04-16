*&---------------------------------------------------------------------*
*& Report ZMG_FS_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_fs_02.

TYPES: BEGIN OF gty_table,
         carrid    TYPE s_carr_id,
         connid    TYPE s_conn_id,
         fldate    TYPE s_date,
         leer_sitz TYPE int4,
       END OF gty_table.

TYPES: gtt_table TYPE TABLE OF gty_table.

DATA: gt_table   TYPE TABLE OF gty_table,
      gt_sflight TYPE TABLE OF sflight,
      gs_sflight TYPE sflight.

FIELD-SYMBOLS: <gt_table> TYPE gtt_table,
               <gs_str>   TYPE gty_table.

START-OF-SELECTION.

ASSIGN gt_table to <gt_table>.

  SELECT * FROM sflight INTO TABLE gt_sflight.

  LOOP AT gt_sflight INTO gs_sflight.

    APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.

    <gs_str>-carrid = gs_sflight-carrid.
    <gs_str>-connid = gs_sflight-connid.
    <gs_str>-fldate = gs_sflight-fldate.
    <gs_str>-leer_sitz = gs_sflight-seatsmax - gs_sflight-seatsocc.

  ENDLOOP.
