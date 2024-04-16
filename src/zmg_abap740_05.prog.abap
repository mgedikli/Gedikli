*&---------------------------------------------------------------------*
*& Report ZMG_ABAP740_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_abap740_05.

*ABAP-7.40 Yenilikler/Value Komutu ile For In Döngüsü

TYPES: BEGIN OF gty_table,                "VERSIYON 1 ve 2 icin
         id        TYPE zmg_de_yeni_id,
         agencynum TYPE s_agncynum,
         name      TYPE s_agncynam,
         street    TYPE s_street,
         url       TYPE s_url,
       END OF gty_table.

DATA: gt_table TYPE TABLE OF gty_table,   "VERSIYON 1 ve 2 icin
      gs_table TYPE gty_table.
**********************************************************************************************
START-OF-SELECTION.

  SELECT * FROM zmg_stravelag INTO TABLE @DATA(gt_stravelag).

*  LOOP AT gt_stravelag INTO DATA(gs_str) WHERE id < 20.          "VERSIYON 1  ("Bu Loop at bölümünü comment yapalim ve For In ile ayni seyi yapalim)
*
*    gs_table-id        = gs_str-id.
*    gs_table-agencynum = gs_str-agencynum.
*    gs_table-name      = gs_str-name.
*    gs_table-street    = gs_str-street.
*    gs_table-url       = gs_str-url.
*    APPEND gs_table TO gt_table.
*    CLEAR: gs_table.
*
*  ENDLOOP.
*  BREAK-POINT.
**********************************************************************************************
  "VERSIYON2 (DATA: gt_table ve  gs_table tanimlamasi ile)
  gt_table = VALUE #( FOR gs_stravelag IN gt_stravelag     "FOR IN kullandik; gs_stravelag tanimlamaya veya Inline Dec. yapmaya ihtiyac kalmadi.
                        WHERE ( id < 20 )                  " Opsiyonel Where kosulu verilebilir!
                      ( id        = gs_stravelag-id
                        agencynum = gs_stravelag-agencynum
                        name      = gs_stravelag-name
                        street    = gs_stravelag-street
                        url       = gs_stravelag-url ) ).
  BREAK-POINT.
***********************************************************************************************
