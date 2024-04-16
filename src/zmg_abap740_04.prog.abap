*&---------------------------------------------------------------------*
*& Report ZMG_ABAP740_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_abap740_04.
*ABAP-7.40'la gelen yenilikler: Value Komutu ile Veri atma: 1.Vers.

TYPES: BEGIN OF gty_table,
         id      TYPE n LENGTH 6,
         name    TYPE c LENGTH 20,
         surname TYPE c LENGTH 20,
         address TYPE c LENGTH 50,
       END OF gty_table.

*TYPES: gtt_table TYPE TABLE OF gty_table.

DATA: gs_str   TYPE gty_table,
      gt_table TYPE TABLE OF gty_table.

START-OF-SELECTION.

*  vor Abap 7.40:
  gs_str-id      = '00001'.
  gs_str-name    = 'Lia'.
  gs_str-surname = 'Bayer'.
  gs_str-address = 'Rosastr. 44, 70734 Fellbach'.
  APPEND gs_str TO gt_table.
  CLEAR: gs_str.

  "nach Abap 7.40 :Wir können der Tabelle gleichzeitig mehr als eine Zeile hinzufügen.Aynı anda birden fazla satırı Tabloya atabiliyoruz.
  gs_str = VALUE #( id      = '00002'
                    name    = 'Kai'
                    surname = 'Meyer'
                    address = 'Rosastr. 4, 70734 Fellbach').

  DATA(gs_str_new) = VALUE gty_table( id      = '00003'
                                      name    = 'Lale'
                                      surname = 'Mauer'
                                      address = 'Halestr. 44, 70200 Stuttgart' ).

  gt_table = VALUE #( ( id = '00004' name = 'Ali'     surname  = 'Bal' address     = 'Blumenstr. 22, 73344 Waiblingen' )
*  DATA(gt_table) = VALUE gtt_table( ( id = '00004' name     = 'Selim'   surname = 'Balta' address   = 'Blumenstr. 40, 7332 Waiblingen' ) "2. versiyon:InDec + Value
                      ( id = '00005' name = 'Hasan'   surname  = 'Has'    address  = 'Blumenstr. 33, 73344 Waiblingen' )
                      ( id = '00006' name = 'Markus'  surname  = 'Pusse'   address = 'Königstr. 20, 86220 Böblingen' )
                      ( id = '00007' name = 'Heidi'   surname  = 'Pala'   address  = 'Blumenstr. 4, 73344 Waiblingen' ) ).


  BREAK-POINT.
