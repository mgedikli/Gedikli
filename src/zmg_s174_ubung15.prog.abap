*&---------------------------------------------------------------------*
*& Report ZMG_TEST_73
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_s174_ubung15.
*S.174-Übung–15: schreiben Sie eine neue Function. Erhalten Sie vom Benutzer eine Zahl zwischen 1 und 7.
*Informieren Sie den Benutzer über den Tag, der der vom ihm eingegebenen Nummer entspricht.
*Verwenden Sie di Functionin einem neuen Bericht, den Sie schreiben werden.
*Drucken Sie den Tag aus, an dem der Benutzer erhalten hat.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_tagnum   TYPE i.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_tag              TYPE c LENGTH 10,
      gv_concatenate_text TYPE string.

START-OF-SELECTION.

  CALL FUNCTION 'ZMG_FM_A15'
    EXPORTING
      iv_tagnum = p_tagnum
    IMPORTING
      ev_tag    = gv_tag.

  CONCATENATE TEXT-002 gv_tag INTO gv_concatenate_text SEPARATED BY space.

  WRITE: gv_concatenate_text.     "WRITE: TEXT-002, gv_tag. (ohne concatenate)
