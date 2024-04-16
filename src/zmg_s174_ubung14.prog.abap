*&---------------------------------------------------------------------*
*& Report ZMG_TEST_72
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_s174_ubung14.
*s.174 -Alıştırma – 14: Yeni bir fonksiyon yazın. Kullanıcıdan 20 karakter uzunluğunda 3 adet text alsın. Bütün
*textleri birleştirsin ve tek bir text halinde kullanıcıya geri versin. Ayrıca yeni oluşan textin içerisinde kaç
*karakter olduğu bilgisini de versin. Fonksiyonu yeni yazacağınız bir raporda kullanın. Oluşan texti ve
*karakter sayısını ekrana yazdırın.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_text1 TYPE c LENGTH 20,
              p_text2 TYPE c LENGTH 20,
              p_text3 TYPE c LENGTH 20.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_text TYPE c LENGTH 60.

START-OF-SELECTION.

  CALL FUNCTION 'ZMG_FM_A14'
    EXPORTING
      iv_text_01 = p_text1
      iv_text_02 = p_text2
      iv_text_03 = p_text3
    IMPORTING
      ev_text    = gv_text.

  WRITE: gv_text, 'Bu metin toplam', strlen( gv_text ), 'karakterden olusmaktadir.'.
