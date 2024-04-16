*&---------------------------------------------------------------------*
*& Report ZMG_FS_07B
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMG_SUBMIT_01B.

PARAMETERS: p_num  TYPE s_agncynum,
            p_street TYPE s_street.

START-OF-SELECTION.
  UPDATE zmg_stravelag SET street       = p_street
                       WHERE agencynum  = p_num.
