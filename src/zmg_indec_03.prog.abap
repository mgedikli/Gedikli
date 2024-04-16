*&---------------------------------------------------------------------*
*& Report ZMG_INDEC_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_indec_03.

*Inline Decleration S.331-Video 68 dk2:40

*DATA: gt_scarr TYPE TABLE OF scarr.

START-OF-SELECTION.

  SELECT * FROM scarr INTO TABLE @DATA(gt_scarr).

  LOOP AT gt_scarr INTO DATA(gs_scarr).
    WRITE: gs_scarr-carrid, gs_scarr-carrname,
           gs_scarr-currcode, gs_scarr-url.
  ENDLOOP.
