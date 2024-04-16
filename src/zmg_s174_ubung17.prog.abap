*&---------------------------------------------------------------------*
*& Report ZMG_TEST_74A17
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_s174_ubung17.
*S.174-Alıştırma – 17: Yeni bir fonksiyon yazın. Bir adet CARRNAME alsın. Gelen CARRNAME bilgisine göre
*SCARR tablosunu okusun ve kullanıcıya bir internal tablo versin. Ayrıca elde edilen internal tablodaki
*CARRID değerlerini kullanarak SPFLI ve SFLIGHT tablolarını da okuyup kullanıcıya versin. Fonksiyonu
*yeni yazacağınız bir raporda kullanın. Gelen satırları ekrana yazdırın.
*
*Übung 17: Schreiben Sie eine neue Funktion, die eine Variable CARRNAME entgegennimmt.
*Basierend auf der empfangenen CARRNAME-Information soll sie die Tabelle SCARR lesen
*und dem Benutzer eine interne Tabelle zur Verfügung stellen.
*Darüber hinaus soll sie die Tabellen SPFLI und SFLIGHT basierend auf den erhaltenen CARRID-Werten lesen
*und dem Benutzer zur Verfügung stellen. Verwenden Sie die Funktion in einem neuen Bericht, den Sie schreiben.
*Geben Sie die empfangenen Zeilen auf dem Bildschirm aus.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_cname TYPE text20. "s_carrname (CHAR20) (büyük kücük hassasiyetinden kaynaklanan sorunu cözmek icin text20 verdik
SELECTION-SCREEN END OF BLOCK a1.

DATA: gs_scarr   TYPE zmg_s_scarr16,
      gs_spfli   TYPE zmg_s_spfli,
      gs_sflight TYPE zmg_s_sflight,
      gt_scarr   TYPE zmg_tt_scarr16,
      gt_spfli   TYPE zmg_tt_spfli17,
      gt_sflight TYPE zmg_tt_sflight17.

START-OF-SELECTION.

  CALL FUNCTION 'ZMG_FM_A17'
    EXPORTING
      iv_carrname = p_cname
    IMPORTING
      et_scarr    = gt_scarr
      et_spfli    = gt_spfli
      et_sflight  = gt_sflight.

  LOOP AT gt_scarr INTO gs_scarr.
    WRITE: /
          gs_scarr-carrid,
          gs_scarr-carrname,
          gs_scarr-currcode,
          gs_scarr-url.
    ULINE.
  ENDLOOP.

  LOOP AT gt_spfli INTO gs_spfli.
    WRITE: /
            gs_spfli-carrid   ,
            gs_spfli-connid   ,
            gs_spfli-countryfr,
            gs_spfli-cityfrom ,
            gs_spfli-airpfrom ,
            gs_spfli-countryto,
            gs_spfli-cityto   ,
            gs_spfli-airpto   ,
            gs_spfli-fltime   ,
            gs_spfli-deptime  ,
            gs_spfli-arrtime  ,
            gs_spfli-distance ,
            gs_spfli-distid   ,
            gs_spfli-fltype   ,
            gs_spfli-period.
    ULINE.
  ENDLOOP.

  LOOP AT gt_sflight INTO gs_sflight.
    WRITE: /
            gs_sflight-carrid    ,
            gs_sflight-connid    ,
            gs_sflight-fldate    ,
            gs_sflight-price     ,
            gs_sflight-currency  ,
            gs_sflight-planetype ,
            gs_sflight-seatsmax  ,
            gs_sflight-seatsocc  ,
            gs_sflight-paymentsum,
            gs_sflight-seatsmax_b,
            gs_sflight-seatsocc_b,
            gs_sflight-seatsmax_f,
            gs_sflight-seatsocc_f.
  ENDLOOP.
