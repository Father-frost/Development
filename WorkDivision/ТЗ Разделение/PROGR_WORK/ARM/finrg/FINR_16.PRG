DEFINE POPUP Finr_16 FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Finr_16 PROMPT " �\<������ �ࠢ�筨���    "
DEFINE BAR 2 OF Finr_16 PROMPT "\-"
DEFINE BAR 3 OF Finr_16 PROMPT " �\<室��� ���ଠ��      "
DEFINE BAR 4 OF Finr_16 PROMPT "\-"
DEFINE BAR 5 OF Finr_16 PROMPT " �\<����                  "
DEFINE BAR 6 OF Finr_16 PROMPT "\-"
DEFINE BAR 7 OF Finr_16 PROMPT " �\<�室�� ���          "
ON SELECTION POPUP Finr_16 DO Finr_16 WITH BAR()
ACTIVATE POPUP Finr_16 BAR 3
RETURN
*
PROCEDURE Finr_16
PARAMETERS chg15
*
DEFINE POPUP Spr_16 FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Spr_16 PROMPT " �\<࣠����樨   "
DEFINE BAR 2 OF Spr_16 PROMPT " �\<��p��������� "
ON SELECTION POPUP Spr_16 DO Spr_16 WITH BAR()
*
DEFINE POPUP Vx_16 FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vx_16 PROMPT " �\<��p�� �� �����⥫�   "
DEFINE BAR 2 OF Vx_16 PROMPT " �\<������� �� �����⥫� "
DEFINE BAR 3 OF Vx_16 PROMPT " �\<��⪨ �� �����⥫�  "
DEFINE BAR 4 OF Vx_16 PROMPT " �\<�娢 ���㧮�         "
ON SELECTION POPUP Vx_16 DO Vx_16 WITH BAR()
*
DEFINE POPUP Ras_16 FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Ras_16 PROMPT " �\<ਥ� ������           "
DEFINE BAR 2 OF Ras_16 PROMPT " �\<��室 � ᫥�. ������ "
ON SELECTION POPUP Ras_16 DO Ras_16 WITH BAR()
*
DEFINE POPUP Vyx_16 FROM 7,40 COLOR SCHEME 19 SHADOW
DEFINE BAR  1 OF Vyx_16 PROMPT " ����\<����� �� ����� �p���樨  "
DEFINE BAR  2 OF Vyx_16 PROMPT "    �\<�������� �� �p��������    "
DEFINE BAR  3 OF Vyx_16 PROMPT " �����\<���� �� ����ᠬ ����祭�� "
DEFINE BAR  4 OF Vyx_16 PROMPT "   ��\<�p���� �� �p��������    "
DEFINE BAR  5 OF Vyx_16 PROMPT "   �\<������� �� ���p���������   "
DEFINE BAR  6 OF Vyx_16 PROMPT "      �\<��p���� �� p�������     "
DEFINE BAR  7 OF Vyx_16 PROMPT "      ���\<p���� �� ����⠬      "
DEFINE BAR  8 OF Vyx_16 PROMPT " �������\<� � ��⮬ ���㬥�⮮�. "
DEFINE BAR  9 OF Vyx_16 PROMPT " ��������\<� �� �p���� � ��⪠� "
DEFINE BAR 10 OF Vyx_16 PROMPT "      ���\<��� �� �p��������     "
DEFINE BAR 11 OF Vyx_16 PROMPT "         ��\<������� 5�            "
DEFINE BAR 12 OF Vyx_16 PROMPT "      �\<��� �� ������������      "
DEFINE BAR 13 OF Vyx_16 PROMPT "     �\<����஢�� �� ��⠬      "
DEFINE BAR 14 OF Vyx_16 PROMPT "     ���\<�ଠ�� �� ॠ����樨    "
DEFINE BAR 15 OF Vyx_16 PROMPT "     ��ᬮ�� �\<�室��� ��      "
ON SELECTION POPUP Vyx_16 DO Vyxfdb WITH BAR()
*
SET COLOR TO &color14
DO CASE
CASE chg15=1
    ACTIVATE POPUP Spr_16
CASE chg15=3
    ACTIVATE POPUP Vx_16
CASE chg15=5
    ACTIVATE POPUP Ras_16
CASE chg15=7
    ACTIVATE POPUP Vyx_16
ENDCASE
RETURN
*
PROCEDURE Spr_16
PARAMETERS chspr
HIDE POPUP ALL
DO CASE
CASE chspr=1
    SELECT skl
    DO Vvodn WITH "Chapsk","Strsaysk","Strgetsk",.T.,.T.,.T.,.T.,".F.","",;
         "F2sk","F3sk","F4sk","F5sk","","","F8sk","F9sk","prskl","",.T.
CASE chspr=2
    SELECT sch
    DO Vvodn WITH "Chapsc","Strsaysc","Strgetsc",.T.,.T.,.T.,.F.,".F.","",;
         "F2sc","F3sc","","","","","","","F10sc","",.T.
ENDCASE
SHOW POPUP Glavn,Proch,Finr_16,Spr_16
RETURN
*
PROCEDURE Vx_16
PARAMETERS chs
DO CASE
CASE chs=1
    DO Obor_pol
CASE chs=2
    SELECT 0
    USE avot
    SET ORDER TO avot1
    ffnpp=npp
    ffdat=dat
    ffkp=kp
    ffnrd=nrd
    ffnvx=nvx
    ffpr_spr=pr_spr
    ffbs=bs
    ffnsk=nsk
    HIDE POPUP ALL
    ON KEY LABEL Alt-F9 DO Menu_spr
    DO Vvodn WITH "Chapoo","Strsayoo","Strgetoo",.T.,.T.,.T.,.T.,".F.","",;
         "F2oo","F3oo","F4oo","","F6oo","F7oo","","","F10oo","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='AVOT'
         USE
    ENDIF
CASE chs=3
    SELECT 0
    USE osdkom
    SET ORDER TO osdkom
    ffnpp=npp
    ffdat=dat
    ffkp=kp
    ffnrd=nrd
    ffnvx=nvx
    ffpr_spr=pr_spr
    ffbs=bs
    ffnsk=nsk
    HIDE POPUP ALL
    ON KEY LABEL Alt-F9 DO Menu_spr
    DO Vvodn WITH "Chapok","Strsayok","Strgetok",.T.,.T.,.T.,.T.,".F.","",;
         "F2ok","F3ok","F4ok","F5ok","F6ok","","","","F10ok","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='OSDKOM'
         USE
    ENDIF
CASE chs=4
    SELECT 0
    USE avot_arc
    SET ORDER TO kp_nrd
    HIDE POPUP ALL
    ON KEY LABEL Alt-F9 DO Menu_spr
    DO Vvodn WITH "Chapar","Strsayar","",.F.,.F.,.F.,.F.,".F.","",;
         "F2ar","F3ar","F4ar","","","","","","F10aro","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='AVOT_ARC'
         USE
    ENDIF
ENDCASE
SHOW POPUP Glavn,Proch,Finr_16,Vx_16
RETURN
*
PROCEDURE Ras_16
PARAMETERS chspr
DO CASE
CASE chspr=1
    DEFINE POPUP Tekm FROM 11,54 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " �\<��p����: ���� �p��������       "
    DEFINE BAR 2 OF Tekm PROMPT " ��\<�p����: ���� �� ������ ���� "
    DEFINE BAR 3 OF Tekm PROMPT " �\<�⮢�� �p�����: ��p㧪�          "
    ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
    ACTIVATE POPUP Tekm
    menu_v=BAR()
    DO CASE
    CASE menu_v=0
         RETURN
    CASE menu_v=1.OR.menu_v=2.OR.menu_v=3
         fpath=SPACE(32)
         IF menu_v=1.OR.menu_v=2
              DEFINE WINDOW Zapros FROM 10,17 TO 13,77 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              fpath1=SPACE(32)
              @ 0,0 SAY " ������ ���� (p��室).." GET fpath
              @ 1,0 SAY " (�p���筨� ���p�����)" GET fpath1
         ELSE
              DEFINE WINDOW Zapros FROM 10,17 TO 12,77 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,0 SAY " ������ ���� ��� 䠩���" GET fpath
         ENDIF
         READ
         HIDE WINDOW Zapros
         IF LASTKEY()=27
              ACTIVATE SCREEN
              RETURN
         ENDIF
         ACTIVATE WINDOW Pogal
         SET COLOR TO &color15
         @ 0,0 SAY '�'
         SET COLOR TO &color13
         @ 0,1 SAY "��������, ��������..."
         @ 1,2 SAY ' �ᥣ� ����ᥩ:       '
         @ 2,2 SAY ' ������ ������:      '
         SET COLOR TO &color14
         fpath=RTRIM(fpath)
         DO CASE
         CASE menu_v=1.OR.menu_v=2
              DO Preo_mat
         CASE menu_v=3
              DO Preob
         ENDCASE
         HIDE WINDOW Pogal
         ACTIVATE SCREEN
    ENDCASE
CASE chspr=2
    DEFINE WINDOW Zapros FROM 10,17 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    key=2
    SET COLOR TO &color14
    @ 0,1 SAY "�믮������ ���室 � ᫥���饬� ������."
    @ 1,1 SAY "�� 㢥७� ?"
    @ 1,21 PROMPT " ��  "
    @ 1,31 PROMPT " H�� "
    MENU TO key
    RELEASE WINDOW Zapros
    IF key=1
         DO Perex16
    ENDIF
ENDCASE
RETURN