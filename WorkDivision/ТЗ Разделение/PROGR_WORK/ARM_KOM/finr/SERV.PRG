PRIVATE scr2,ch2,ch3
*
DEFINE POPUP Servg FROM 7,25 COLOR SCHEME 19 SHADOW
DEFINE BAR  1 OF Servg PROMPT " �\<���஢���� 䠩���              "
DEFINE BAR  2 OF Servg PROMPT " ��\<cc⠭������� 䠩���           "
DEFINE BAR  3 OF Servg PROMPT " �\<������� 䠩���               "
DEFINE BAR  4 OF Servg PROMPT " �\<������� ����祭��� ����ᥩ     "
DEFINE BAR  5 OF Servg PROMPT " H\<���p���� ����                  "
DEFINE BAR  6 OF Servg PROMPT " �\<��� �� �p㣨� �����            "
DEFINE BAR  7 OF Servg PROMPT " H��\<�p���� ����� �� ��㣨� ����� "
DEFINE BAR  8 OF Servg PROMPT " �\<뢮� ��� �p㣨� �����          "
DEFINE BAR  9 OF Servg PROMPT " �\<������ ��室��� ��         "
DEFINE BAR 10 OF Servg PROMPT ' ��\<�㬥����                    '
DEFINE BAR 11 OF Servg PROMPT " ��⠭���� �\<���� �p���p�       "
DEFINE BAR 12 OF Servg PROMPT " ��⠭���� ���\<p���� ��p��       "
DEFINE BAR 13 OF Servg PROMPT " ��\<��� � ��娢���               "
DEFINE BAR 14 OF Servg PROMPT " ��\<�� �訡��                    "
ON SELECTION POPUP Servg DO Serv WITH BAR()
*
SET COLOR OF SCHEME 1 TO w+/bg,w+/bg,n/bg,w+/bg,w+/bg,w+/n,gr+/bg,w/n,w+/n,w+/n
DEFINE POPUP Serv FROM 1,34 TO 23,76 COLOR SCHEME 19 SHADOW
DEFINE BAR  1 OF Serv PROMPT " �\<��� - ����                            "
DEFINE BAR  2 OF Serv PROMPT " �\<�p���筨� ��⮢                       "
DEFINE BAR  3 OF Serv PROMPT " ��\<�줮 �� �p�稬 �����p��-�p����p��   "
DEFINE BAR  4 OF Serv PROMPT " ��\<ࠢ�筨� ����� ���㬥�⮢             "
DEFINE BAR  5 OF Serv PROMPT " �\<������� �� �p�稬 �����p��-�p����p�� "
DEFINE BAR  6 OF Serv PROMPT " ��p��\<�筨� p������� ����� ��⮢        "
DEFINE BAR  7 OF Serv PROMPT " ��\<�室                                  "
DEFINE BAR  8 OF Serv PROMPT " ��p���\<筨� ⥪�⮢                      "
DEFINE BAR  9 OF Serv PROMPT " �\<�� - ᪫���                           "
DEFINE BAR 10 OF Serv PROMPT " ��\<������樨                             "
DEFINE BAR 11 OF Serv PROMPT " ����\<樨                                "
DEFINE BAR 12 OF Serv PROMPT " ��\<��⭨��                               "
DEFINE BAR 13 OF Serv PROMPT " ���� �p���樨 �p����\<����           "
DEFINE BAR 14 OF Serv PROMPT " ���\<�ᮢ� �����                        "
DEFINE BAR 15 OF Serv PROMPT " ���\<줮 �� ����� �p���樨 �p��������"
DEFINE BAR 16 OF Serv PROMPT " ����\<�� �� �������p�����                 "
DEFINE BAR 17 OF Serv PROMPT " ���ਠ�\<�                               "
DEFINE BAR 18 OF Serv PROMPT " ���줮 �� \<6-�� ��ୠ��                  "
DEFINE BAR 19 OF Serv PROMPT " ��p���筨\<� p�������                     "
DEFINE BAR 20 OF Serv PROMPT " \<���줮 �� �����宧��⢥��� ���⠬  "
DEFINE BAR 21 OF Serv PROMPT " ���\<�祭�� ���p�����                    "
DEFINE BAR 22 OF Serv PROMPT " ����p���\<�� ��p���� �� �������� ��栬"
DEFINE BAR 23 OF Serv PROMPT " ��p���筨� \<�p�� �� ��p㧪�           "
DEFINE BAR 24 OF Serv PROMPT " ��p���筨� ����� ���\<��                  "
DEFINE BAR 25 OF Serv PROMPT " ��p���筨� ��p\<ᮢ �����                 "
DEFINE BAR 26 OF Serv PROMPT " ����\<���� � ����� �� ���ࠧ�������    "
DEFINE BAR 27 OF Serv PROMPT " ��ࠢ�筨� ����� ���\<�⥪               "
DEFINE BAR 28 OF Serv PROMPT " ����\<����� �� �������஢���              "
DEFINE BAR 29 OF Serv PROMPT " \<���� ���⭮��                        "
DEFINE BAR 30 OF Serv PROMPT ' \<�����⪠ �� ���⭮��                '
DEFINE BAR 31 OF Serv PROMPT ' \<�������� �� �����宧��⢥��� ���⠬'
DEFINE BAR 32 OF Serv PROMPT ' \<��娢 �������� �� �����宧-� ���⠬  '
DEFINE BAR 33 OF Serv PROMPT ' �\<������� �������⮢                     '
DEFINE BAR 34 OF Serv PROMPT ' \<��ࠢ�筨� �������                      '
*
ACTIVATE POPUP Servg
RETURN
*
PROCEDURE Serv
PARAMETERS ch2
DO CASE
CASE ch2<5
    pr_ind=1
    IF INLIST(ch2,1,3,4)
         DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
         SET COLOR TO &color14
         DO CASE
         CASE ch2=1
              DEFINE BAR 1 OF Tekm PROMPT " �\<�䠩����� ����p������ "
              DEFINE BAR 2 OF Tekm PROMPT " �\<�娢��� ��� 䠩���  "
         CASE ch2=3
              DEFINE BAR 1 OF Tekm PROMPT " �\<������� ��� 䠩��� "
              DEFINE BAR 2 OF Tekm PROMPT " �\<�䠩����� ��������  "
         CASE ch2=4
              DEFINE BAR 1 OF Tekm PROMPT " �\<������� ��� 䠩���   "
              DEFINE BAR 2 OF Tekm PROMPT " �\<�䠩����� 㯠�����    "
         ENDCASE
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         pr_ind=BAR()
         IF pr_ind=0
              RETURN
         ENDIF
    ENDIF
    DO CASE
    CASE ch2=1.AND.pr_ind=2
         HIDE POPUP ALL
         SAVE SCREEN TO scr
         CLEAR
         CLOSE DATA
         SET RESOURCE OFF
         sss='!del finr_b'+LTRIM(STR(ntmec,2))+'.exe'
         &sss
         sss='!lha a finr_b'+LTRIM(STR(ntmec,2))+' *.dbf *.cdx *.mem'
         &sss
         sss='!lha s finr_b'+LTRIM(STR(ntmec,2))
         &sss
         sss='!del finr_b'+LTRIM(STR(ntmec,2))+'.lzh'
         &sss
         RESTORE FROM tek_b ADDITIVE
         sss='!copy finr_b'+LTRIM(STR(ntmec,2))+'.exe '+tek_b_50
         &sss
         RELEASE ALL LIKE tek_b_??
         SET RESOURCE ON
         SELECT 0
         USE sch
         SET ORDER TO sch
         SELECT 0
         USE sprt
         SET ORDER TO wid_t
         SELECT 0
         USE sprnaz
         SET ORDER TO wid_d
         SELECT 0
         USE skl
         SET ORDER TO kkl
         SELECT 0
         USE sprrab
         SET ORDER TO tab
         SELECT 0
         USE bk
         SET ORDER TO kp
         SELECT 0
         USE spr_bs
         SET ORDER TO grup
         SELECT 0
         USE spr_grup
         SET ORDER TO grup
         ggrup='@@@'
         SELECT 0
         USE spr_reg
         SET ORDER TO kod
         IF nastf_8=1
              SELECT 0
              USE spr_val
              SET ORDER TO kod
              SELECT 0
              USE kurs_val
              SET ORDER TO kod
         ENDIF
         RESTORE SCREEN FROM scr
         SHOW POPUP Glavn,Servg
    CASE ch2=3.AND.pr_ind=1
         FOR ch3=1 TO 59
              DO Ind_file WITH ch3,ch2
         ENDFOR
    CASE ch2=4.AND.pr_ind=1
         FOR ch3=1 TO 34
              DO Ind_file WITH ch3,ch2
         ENDFOR
    OTHERWISE
         ON SELECTION POPUP Serv DO Ind_file WITH BAR(),ch2
         ACTIVATE POPUP Serv
    ENDCASE
CASE ch2=5
    RESTORE FROM nastf ADDITIVE
    RESTORE FROM nsch ADDITIVE
    RESTORE FROM tek_b ADDITIVE
    RESTORE FROM sgat_prn ADDITIVE
    DEFINE POPUP Tekm FROM 9,44 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " �\<�������� �p������樨       "
    DEFINE BAR 2 OF Tekm PROMPT " �\<���                       "
    DEFINE BAR 3 OF Tekm PROMPT " �\<��� <-> ����              "
    DEFINE BAR 4 OF Tekm PROMPT " ��\<���� � ���⠢騪���      "
    DEFINE BAR 5 OF Tekm PROMPT " ���\<��� � �����⥫ﬨ      "
    DEFINE BAR 6 OF Tekm PROMPT " ����\<�� � �������. ��栬� "
    DEFINE BAR 7 OF Tekm PROMPT " �����\<� � �p�稬� ���.-�p�� "
    IF nastf_f=1
         DEFINE BAR 8 OF Tekm PROMPT " �\<����宧��⢥��� ����� "
    ENDIF
    IF nastf_y=1
         DEFINE BAR 8+nastf_f OF Tekm PROMPT " ��\<����� �������⮢ "
    ENDIF
    DEFINE BAR 8+nastf_f+nastf_y OF Tekm PROMPT " �\<�஫� "
    DEFINE BAR 9+nastf_f+nastf_y OF Tekm PROMPT " �\<��⥬���                   "
    ON SELECTION POPUP Tekm DO Servs WITH BAR()
    ACTIVATE POPUP Tekm
CASE ch2=6
    DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " �\<�p����: p��室�� �p��p�      "
    DEFINE BAR 2 OF Tekm PROMPT " ��p\<����: 㤥p����� �� 71 ���� "
    DEFINE BAR 3 OF Tekm PROMPT " �\<�⮢�� �p�����: ��p㧪�     "
    DEFINE BAR 4 OF Tekm PROMPT " ��\<⮢�� �p�����: �࣠����樨  "
    DEFINE BAR 5 OF Tekm PROMPT " ��\<��: ���ࠧ�������             "
    ON SELECTION POPUP Tekm DO Obmen WITH BAR()
    ACTIVATE POPUP Tekm
CASE ch2=7
    DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " �\<��p����: �p�室            "
    DEFINE BAR 2 OF Tekm PROMPT " ��\<�p����: ���� �� ��p��� "
    ON SELECTION POPUP Tekm DO Pr_rx WITH BAR()
    ACTIVATE POPUP Tekm
CASE ch2=8
    DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " �\<�p����: ���p����� �믫��� "
    DEFINE BAR 2 OF Tekm PROMPT " �\<�⮢�� �p�����: �p������樨 "
    DEFINE BAR 3 OF Tekm PROMPT " ��\<��: ���ࠧ�������            "
    ON SELECTION POPUP Tekm DO Pr_arm WITH BAR()
    ACTIVATE POPUP Tekm
CASE ch2=9
    SELECT 0
    USE razm_ot
    SET ORDER TO nf_npp
    SELECT 0
    USE form_ot
    SET ORDER TO nf_npp
    SELECT sprnaz
    HIDE POPUP ALL
    DO Vvodn WITH "Chapsn","Strsaysn","Strgetsn",.T.,.T.,.T.,.F.,".F.","",;
         "",IIF(chg=5,"F3sn",''),"","",IIF(chg=5,"F6sn",''),"","","","","",.T.
    SELECT razm_ot
    USE
    SELECT form_ot
    USE
CASE ch2=10
    DEFINE WINDOW Zapros FROM 10,49 TO 16,71 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 PROMPT " ��p冷� ���⠫��樨 " && 1
    @ 1,0 PROMPT " ��᪮�������        " && 2
    @ 2,0 PROMPT " ���冷� ����p����   " && 3
    @ 3,0 PROMPT " ��ᯫ����        " && 4
    @ 4,0 PROMPT " ��p� - ����p        " && 5
    MENU TO ch3
    HIDE WINDOW ALL
    DO CASE
    CASE ch3=1
         MODIFY COMMAND ruk_1.txt WINDOW Out NOEDIT
    CASE ch3=2
         MODIFY COMMAND ruk_2.txt WINDOW Out NOEDIT
    CASE ch3=3
         MODIFY COMMAND ruk_3.txt WINDOW Out NOEDIT
    CASE ch3=4
         MODIFY COMMAND ruk_4.txt WINDOW Out NOEDIT
    CASE ch3=5
         MODIFY COMMAND ruk_5.txt WINDOW Out NOEDIT
    ENDCASE
CASE ch2=11
    DEFINE WINDOW Zapros FROM 11,48 TO 14,59 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 PROMPT " ���쭮�  " && 1
    @ 1,0 PROMPT " ������   " && 2
    MENU TO ch3
    IF ch3#0
         DO WHILE .T.
              IF SYS(13)="OFFLINE"
                   DEFINE WINDOW Zapros FROM 10,22 TO 13,55 COLOR SCHEME 19 SHADOW
                   ACTIVATE WINDOW Zapros
                   SET COLOR TO &color14
                   @ 0,1 SAY "�p���p �� ��⮢. ����p��..."
                   @ 1,0 SAY "   ����p襭�� - <Esc>."
                   READ
                   RESTORE SCREEN
                   IF LASTKEY()=27
                        EXIT
                   ENDIF
              ELSE
                   SET DEVICE TO PRINT
                   @ 0,0 SAY IIF(ch3=1,&sgat1,&sgat2)
                   SET DEVICE TO SCREEN
                   EXIT
              ENDIF
         ENDDO
    ENDIF
CASE ch2=12
    DO WHILE .T.
         IF SYS(13)="OFFLINE"
              DEFINE WINDOW Zapros FROM 10,22 TO 13,55 COLOR SCHEME 19 SHADOW
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,1 SAY "�p���p �� ��⮢. ����p��..."
              @ 1,0 SAY "   ����p襭�� - <Esc>."
              READ
              RESTORE SCREEN
              IF LASTKEY()=27
                   EXIT
              ENDIF
         ELSE
              SET DEVICE TO PRINT
              @ 0,0 SAY &sgat3
              SET DEVICE TO SCREEN
              EXIT
         ENDIF
    ENDDO
CASE ch2=13
    DEFINE POPUP Tekm1 FROM 10,44 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm1 PROMPT " �\<��⪠ ��娢��       "
    DEFINE BAR 2 OF Tekm1 PROMPT " �\<����祭�� �� ��娢�� "
    ON SELECTION POPUP Tekm1 DO Arc_zap WITH BAR()
    ACTIVATE POPUP Tekm1
CASE ch2=14
    DEFINE POPUP Tekm FROM 8,35 TO 22,70 PROMPT FILES LIKE *.dbf COLOR SCHEME 19 SHADOW
    ON SELECTION POPUP Tekm DO Poisk_err WITH BAR()
    ACTIVATE POPUP Tekm
ENDCASE
HIDE WINDOW ALL
SHOW POPUP Glavn,Servg
ACTIVATE SCREEN
SET COLOR TO &color13
@ 24,46 SAY "������ ����� : "+tmec
RETURN
*
PROCEDURE Servs
PARAMETERS ch3
SET COLOR TO &color13
n1=2
DO CASE
CASE ch3=1
    DEFINE WINDOW Zapros FROM 10,10 TO 13,70 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY ' H�����������' GET nschn1
    @ 1,0 SAY ' ��� ���������⥫�騪�' GET nschn3
    READ
CASE ch3=2
    DEFINE WINDOW Zapros FROM 4,7 TO 22,76 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @  0,0 SAY " ������ �����..........................................." GET tek_b_2 PICTURE "99" VALID tek_b_2>=1.AND.tek_b_2<=12 ERROR '���祭�� ����୮...'
       * @  1,0 SAY ' ������ ���.............................................' GET nastf_b VALID nastf_b>='00'.AND.nastf_b<='99' ERROR '���祭� ����୮...'
    @  1,0 SAY ' ������ ���.............................................' GET nastf_b VALID nastf_b>='1995'.AND.nastf_b<='2099' ERROR '���祭�� ����୮...'
    @  2,0 SAY " H����������� (�����/��ꥪ�)..............................." GET nastf_s
    @  3,0 SAY " ��� ���� ⥪�� �p� ������祭�� ���p��樨 �� ��p����...." GET tek_b_3 PICTURE "99"
    @  4,0 SAY " ��pp�ᯮ���p��騩 ��� ��� ���p������ �믫��............" GET tek_b_1 VALID Poisk_sc('tek_b_1',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
    @  5,0 SAY " �ᯮ�짮���� �����宧��⢥��� �����: 0 - ���, 1 - ��." GET nastf_f PICTURE "9" VALID nastf_f=0.OR.nastf_f=1 ERROR '���祭�� ����୮...'
    @  6,0 SAY " �ᯮ�짮���� ������ �����: 0 - ���, 1 - ��............." GET nastf_8 PICTURE "9" VALID nastf_8=0.OR.nastf_8=1 ERROR '���祭�� ����୮...'
    @  7,0 SAY " �ᯮ�짮���� ������� �������⮢: 0 - ���, 1 - ��.........." GET nastf_y PICTURE "9" VALID nastf_y=0.OR.nastf_y=1 ERROR '���祭�� ����୮...'
    @  8,0 SAY " ��� ��� ���業�� ������.................................." GET tek_b_23 VALID nastf_8=0.OR.Poisk_sc('tek_b_23',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
    @  9,0 SAY ' �ਧ��� �ਢ離� ������ � ���㬥�⠬: 0 - ���, 1 - ��.....' GET nastf_h PICTURE "9" VALID nastf_h=0.OR.nastf_h=1 ERROR '���祭�� ����୮...'
    @ 10,0 SAY ' ��� ࠧ���� "������� �।�⢠" � �ࠢ�筨�� ��⮢......' GET tek_b_25
    @ 11,0 SAY ' ��⮬���᪨ ��ᢠ����� ��� �࣠����樨: 0 - ���, 1 - ��' GET nastf_o PICTURE "9" VALID nastf_o=0.OR.nastf_o=1 ERROR '���祭�� ����୮...'
    @ 12,0 SAY ' ��᫥���� ��� �࣠����樨.................................' GET tek_b_11
    @ 13,0 SAY ' ������� �ࠧ� ��室�� ���㬥��� �� ���ਠ��(���-0,��-1)' GET nastf_t PICTURE "9" VALID nastf_t=0.OR.nastf_t=1 ERROR '���祭�� ����୮...'
    @ 14,0 SAY ' ��業� ���...............................................' GET tek_b_30 PICTURE "99.99"
    @ 15,0 SAY ' ��業� ᯥ歠����........................................' GET tek_b_31 PICTURE "99.99"
    @ 16,0 SAY ' ������⢮ ������ ���㣫���� � �����...................' GET tek_b_36 PICTURE "99"
    READ
CASE ch3=3
    DEFINE POPUP Tekmn FROM 10,60 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekmn PROMPT " �\<室��� ���ଠ��  "
    DEFINE BAR 2 OF Tekmn PROMPT " �\<�室��� ���ଠ�� "
    ON SELECTION POPUP Tekmn DEACTIVATE POPUP Tekmn
    ACTIVATE POPUP Tekmn
    menu_v=BAR()
    DO CASE
    CASE menu_v=1
         DEFINE WINDOW Zapros FROM 5,9 TO 22,75 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @  0, 0 SAY " �����: �� ���� - 0, �� ��p��� - 1........................" GET nastf_v  PICTURE "9" VALID nastf_v=0.OR.nastf_v=1 ERROR '���祭�� ����୮...'
         @  1, 0 SAY ' ��p뢠�� ��� � ⥪�⮢�� ���㬥��: 0 - ���, 1 - ��......' GET nastf_d  PICTURE "9" VALID nastf_d=0.OR.nastf_d=1 ERROR '���祭�� ����୮...'
         @  2, 0 SAY " ��p뢠�� ��� �࣠����樨 ��� ����������: 0 -���, 1 - ��" GET nastf_11 PICTURE "9" VALID nastf_11=0.OR.nastf_11=1 ERROR '���祭�� ����୮...'
         @  3, 0 SAY " �p���뢠�� ���㬥��� � ���p��������� ? (0 - ���, 1 - ��)" GET nastf_x  PICTURE "9" VALID nastf_x=0.OR.nastf_x=1 ERROR '���祭�� ����୮...'
         @  4, 0 SAY "                       � ���� ����⥪� ? (0 - ���, 1 - ��)" GET nastf_5  PICTURE "9" VALID nastf_5=0.OR.nastf_5=1 ERROR '���祭�� ����୮...'
         @  5, 0 SAY "                       � �������� ? (0 - ���, 1 - ��)......" GET nastf_w  PICTURE "9" VALID nastf_w=0.OR.nastf_w=1 ERROR '���祭�� ����୮...'
         @  6, 0 SAY "                       � �।�⭮�� �������� ? (0-���,1-��)" GET nastf_i  PICTURE "9" VALID nastf_i=0.OR.nastf_i=1 ERROR '���祭�� ����୮...'
         @  7, 0 SAY "                       � ࠧ����� 䨭����� ? (0-���,1-��).." GET nastf_12 PICTURE "9" VALID nastf_12=0.OR.nastf_12=1 ERROR '���祭�� ����୮...'
         @  8, 0 SAY " �p���뢠�� ���p��������� � ����⠬  ? ( 0 - ���, 1 - �� )" GET nastf_c  PICTURE "9" VALID nastf_c=0.OR.nastf_c=1 ERROR '���祭�� ����୮...'
         @  9, 0 SAY '                      ����.��� ��� ����⮢ � "����-����")' GET tek_b_48 VALID nastf_c=0.OR.Poisk_sc('tek_b_48',.T.,.F.,0,0,0,' ','.F.') ERROR '���祭�� ����୮...'
         @ 10, 0 SAY " � ��p�⥪� �⬥��� ������ / ��������� ? (0-���,1-��)" GET tek_b_19 PICTURE "9" VALID tek_b_19=0.OR.tek_b_19=1 ERROR '���祭�� ����୮...'
         @ 11, 0 SAY " �p���p��� ���� ������ �� ��pp��⭮��� ? (0 - ���, 1 - ��)." GET nastf_9  PICTURE "9" VALID nastf_9=0.OR.nastf_9=1 ERROR '���祭�� ����୮...'
         @ 12, 0 SAY " ��⮬���᪨ ��ᢠ����� ����� ���㬥�� ? (0-���,1-��).." GET nastf_a  PICTURE "9" VALID nastf_a=0.OR.nastf_a=1 ERROR '���祭�� ����୮...'
         @ 13, 0 SAY " �����ᮢ� ��� �।�⮢.................................." GET nastf_j VALID Poisk_sc('nastf_j',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
         @ 14, 0 SAY " �����ᮢ� ��� ���......................................" GET nastf_r VALID Poisk_sc('nastf_r',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
         @ 15, 0 SAY " ������⢮ ���� � ���� ��� ���� �।�⮢..............." GET tek_b_34 PICTURE "999" VALID tek_b_34>0.AND.tek_b_34<=366 ERROR '���祭�� ����୮...'
         READ
    CASE menu_v=2
         DEFINE WINDOW Zapros FROM 7,10 TO 22,75 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @  0,0 SAY " ��p뢠�� ���p�� �� ��� �p���-樨: ��஭���/����ਣ��.(0/1)" GET tek_b_16 PICTURE "9" VALID tek_b_16=0.OR.tek_b_16=1 ERROR '���祭�� ����୮...'
         @  1,0 SAY " � �p��������-��p�祭��: ������ �㬬� ? ( 0 - ���,1 - ��).." GET tek_b_17 PICTURE "9" VALID tek_b_17=0.OR.tek_b_17=1 ERROR '���祭�� ����୮...'
         @  2,0 SAY " �뤠���� ⥪�� ���㬥�� : � ����������....................." GET tek_b_10 PICTURE "9" VALID tek_b_10=0.OR.tek_b_10=1 ERROR '���祭�� ����୮...'
         @  3,0 SAY "    (0 - ���,1 - ��)        � ���������� ���p�⪥............" GET tek_b_12 PICTURE "9" VALID tek_b_12=0.OR.tek_b_12=1 ERROR '���祭�� ����୮...'
         @  4,0 SAY "                            � �������� �� ���ࠧ�������...." GET tek_b_35 PICTURE "9" VALID tek_b_35=0.OR.tek_b_35=1 ERROR '���祭�� ����୮...'
         @  5,0 SAY "                            � ���ᮢ�� �����................." GET tek_b_41 PICTURE "9" VALID tek_b_41=0.OR.tek_b_41=1 ERROR '���祭�� ����୮...'
         @  6,0 SAY "                            � ���ଠ樨 �� ॣ�����........." GET tek_b_42 PICTURE "9" VALID tek_b_42=0.OR.tek_b_42=1 ERROR '���祭�� ����୮...'
         @  7,0 SAY " � ���ᮢ�� ����� �⤥���� ���� �� ��࠭��� ? (0 - ���, 1-��)" GET tek_b_49 PICTURE "9" VALID tek_b_49=0.OR.tek_b_49=1 ERROR '���祭�� ����୮...'
         @  8,0 SAY " � p��室��� �p��p� ������ �㬬� �p������ ? (0 - ���, 1-��)" GET tek_b_18 PICTURE "9" VALID tek_b_18=0.OR.tek_b_18=1 ERROR '���祭�� ����୮...'
         @  9,0 SAY " ������⢮ ����権 ᬥ饭�� � ���⥦��� ����祭��..........." GET tek_b_52 PICTURE '99'
         @ 10,0 SAY " �㬬� ⥫���䭮�� ᡮ�......................." GET tek_b_29 PICTURE '999,999,999.99'
         @ 11,0 SAY " �p����� �뤠� �㬬� �p������ �� �몥 �p�������(0-���,1-��)" GET tek_b_32 PICTURE '9' VALID tek_b_32=0.OR.tek_b_32=1 ERROR '���祭�� ����୮...'
         @ 12,0 SAY "                        ��� �����p�� � �p���筨�� �����" GET tek_b_33 VALID nastf_8=0.OR.Poisk_wl('tek_b_33',.T.,0,0,0) ERROR 'H�� ⠪�� ������...'
         @ 13,0 SAY " � ����⥪� �뤠���� ���� �� ���⥦�� ? (0 - ���, 1 - ��)..." GET tek_b_51 PICTURE "9" VALID tek_b_51=0.OR.tek_b_51=1 ERROR '���祭�� ����୮...'
         READ
    ENDCASE
CASE ch3=4
    DEFINE WINDOW Zapros FROM 8,10 TO 15,76 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " ��� ��� p���⮢ � ���⠢騪���......................." GET nastf_1 VALID Poisk_sc('nastf_1',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
    @ 1,0 SAY " �᭮���� ��� ��� ���᫥��� ����ᮢ..................." GET nastf_2 VALID Poisk_sc('nastf_2',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
    @ 2,0 SAY " �p���뢠�� ���㬥��� � ���p���������: 0 - ���, 1 - ��" GET nastf_3 PICTURE "9" VALID nastf_3=0.OR.nastf_3=1 ERROR '���祭�� ����୮...'
    @ 3,0 SAY " ���뢠�� ����� �� �����(��ꥪ�): 0 - ���, 1 - ��....." GET nastf_m PICTURE "9" VALID nastf_m=0.OR.nastf_m=1 ERROR '���祭�� ����୮...'
    @ 4,0 SAY " ������������ ᮯ஢���⥫쭮�� ���㬥��..............." GET tek_b_46
    @ 5,0 SAY " ��।����� �� ���ਠ��� ����� ��� (0) ��� ��.�थ�(1)" GET tek_b_47 PICTURE '9' VALID tek_b_47=0.OR.tek_b_47=1 ERROR '���祭�� ����୮...'
    READ
CASE ch3=5
    DEFINE WINDOW Zapros FROM 10,9 TO 20,76 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " ��� ��� p���⮢ � �����⥫ﬨ: � ���p��..............." GET nastf_l VALID Poisk_sc('nastf_l',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
    @ 1,0 SAY "                                   � �����................." GET nastf_e VALID Poisk_sc('nastf_e',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
    @ 2,0 SAY " �᭮���� ��� ��� ���᫥��� ����ᮢ......................" GET nastf_k VALID Poisk_sc('nastf_k',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
    @ 3,0 SAY " �p���뢠�� ���㬥��� � ���p���������: 0 - ���, 1 - ��..." GET nastf_g  PICTURE "9" VALID nastf_g=0.OR.nastf_g=1 ERROR '���祭�� ����୮...'
    @ 4,0 SAY " � �⮣�� �� ���p���������: �뤠���� �� ����.��⠬ (1/0)." GET tek_b_21 PICTURE "9" VALID tek_b_21=0.OR.tek_b_21=1 ERROR '���祭�� ����୮...'
    @ 5,0 SAY " �p���뢠�� ���p��������� � ����� �p��������: 0-���,1-��." GET nastf_z  PICTURE "9" VALID nastf_z=0.OR.nastf_z=1 ERROR '���祭�� ����୮...'
    @ 6,0 SAY " H����������� ��p㧮筮�� ���㬥�� � ����������.........." GET tek_b_7
    @ 7,60 GET tek_b_8
    @ 8,0 SAY ' �p����� p������p���� p��p�������� ���筮� ������ (1/0).' GET tek_b_22 PICTURE "9" VALID tek_b_22=0.OR.tek_b_22=1 ERROR '���祭�� ����୮...'
    READ
CASE ch3=6
    DEFINE WINDOW Zapros FROM 10,12 TO 16,76 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " ���祭� �ᯮ��㥬�� ��⮢ " GET tek_b_24
    @ 1,0 SAY " ���p뢠�� �㬬� ����ᮢ��� ����: 0 - ���, 1 - ��....." GET tek_b_9  PICTURE "9" VALID tek_b_9=0.OR.tek_b_9=1 ERROR '���祭�� ����୮...'
    @ 2,0 SAY " �����ᮢ� ��� ��௫���................................" GET tek_b_5  VALID Poisk_sc('tek_b_5',.T.,.F.,0,0,0,' ','.F.')  ERROR '��� ⠪��� ���...'
    @ 3,0 SAY " � ॥��� ����ᮢ�� ���⮢ �뤠���� ������������ ������" GET tek_b_26 PICTURE "9" VALID tek_b_26=0.OR.tek_b_26=1 ERROR '0 - ���, 1 - ��...'
    @ 4,0 SAY " � ����� ���뢠�� �����: 0-���,1-��,2-⮫쪮 ��� ����." GET tek_b_43 PICTURE "9" VALID tek_b_43>=0.AND.tek_b_43<=2 ERROR '0 - ���, 1 - ��, 2 - ⮫쪮 ��� �����...'
    READ
CASE ch3=7
    DEFINE WINDOW Zapros FROM 10,10 TO 16,75 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " ���祭� �ᯮ��㥬�� ��⮢ " GET tek_b_4
    @ 1,0 SAY " ���p�稢��� ᠫ줮 �� �࣠����樨: 0 - ���, 1 - ��........" GET tek_b_15 PICTURE "9" VALID tek_b_15=0.OR.tek_b_15=1 ERROR '���祭�� ����୮...'
    @ 2,0 SAY " �p���뢠�� ���㬥��� � ���p���������: 0 - ���, 1 - ��..." GET nastf_4  PICTURE "9" VALID nastf_4=0.OR.nastf_4=1 ERROR '���祭�� ����୮...'
    @ 3,0 SAY " �뤠���� �������⥫�� ⥪��: 0 - ���, 1 - ��............" GET nastf_0  PICTURE "9" VALID nastf_0=0.OR.nastf_0=1 ERROR '���祭�� ����୮...'
    @ 4,0 SAY " ���뢠�� ����� �� �����(��ꥪ�): 0 - ���, 1 - ��........" GET nastf_7  PICTURE "9" VALID nastf_7=0.OR.nastf_7=1 ERROR '���祭�� ����୮...'
    READ
CASE ch3=8.AND.nastf_f=1
    DEFINE WINDOW Zapros FROM 12,10 TO 15,75 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " �����ᮢ� ��� ��� �����宧��⢥���� ���⮢........." GET nastf_u VALID Poisk_sc('nastf_u',.T.,.F.,0,0,0,' ','.F.')  ERROR '��� ⠪��� ���...'
    @ 1,0 SAY " ��� 業�ࠫ쭮�� ���ࠧ������� ��� �����宧-��� ���⮢" GET tek_b_37
    READ
CASE nastf_y=1.AND.(ch3=8.AND.nastf_f=0.OR.ch3=9.AND.nastf_f=1)
    DEFINE WINDOW Zapros FROM 13,10 TO 16,75 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " �����ᮢ� ��� ��� �������⮢..........................." GET nastf__ VALID Poisk_sc('nastf__',.T.,.F.,0,0,0,' ','.F.')  ERROR '��� ⠪��� ���...'
    @ 1,0 SAY " �����ᮢ� ��� �����...................................." GET tek_b_44 VALID Poisk_sc('tek_b_44',.T.,.F.,0,0,0,' ','.F.')  ERROR '��� ⠪��� ���...'
    READ
CASE ch3=8+nastf_f+nastf_y
    DEFINE WINDOW Zapros FROM 15,10 TO 19,63 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
   	@ 0,0 SAY " ��஫� ���室� � ᫥���饬� ������"
	IF Cryppass("WithoutPas")=tek_b_45
		mk1=""
		mk2="DISABLE"
	ELSE
		mk1="DISABLE"
		mk2=""
	ENDIF
	@ 0,37 GET ncp PICTURE "@*HN \<��⠭�����" ;
         SIZE 1,14,1 DEFAULT 1 VALID Fpass1(1) COLOR SCHEME 7 &mk1
	@ 1,37 GET ncp PICTURE "@*VN \<��������;\<�⬥����" ;
         SIZE 1,14,0 DEFAULT 1 VALID Fpass2() COLOR SCHEME 7 &mk2
    READ
CASE ch3=9+nastf_f+nastf_y
    DEFINE WINDOW Zapros FROM 6,0 TO 22,77 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @  0,0 SAY " ���� ��� �p㣨� �����" GET nastf_p FUNCTION 'S51'
    @  1,0 SAY " �p����� ��室�: � ��� - 1, � �p��p���� - 0 ..............." GET nastf_q PICTURE "9" VALID nastf_q=0.OR.nastf_q=1 ERROR '���祭�� ����୮...'
    @  2,0 SAY " ��� ��᪮���� ��� ����p������ � ����⠭������� 䠩���....." GET tek_b_13
    @  3,0 SAY " ������� �ࠢ����� �p���p��:"
    @  4,0 SAY "   ᨫ쭮� ᦠ⨥......" GET sgat1 FUNCTION 'S51'
    @  5,0 SAY "   ᫠��� ᦠ⨥......." GET sgat2 FUNCTION 'S51'
    @  6,0 SAY "   ���p��� ����� ��p��" GET sgat3 FUNCTION 'S51'
    @  7,0 SAY "   �⬥�� ��⠭����...." GET sgat4 FUNCTION 'S51'
    @  8,0 SAY " ��� �㬠��: ���⮢�� - 0 , p㫮���� - 1..................." GET nastf_n PICTURE "9" VALID nastf_n=0.OR.nastf_n=1 ERROR '���祭�� ����୮...'
    @  9,0 SAY " ������⢮ ��p�� �� ��࠭��.............................." GET tek_b_14 PICTURE "99"
    @ 10,0 SAY " ������⢮ ��p�� ����� ���⠬� �p� p㫮���� �㬠��........" GET nastf_6 PICTURE "99"
    @ 11,0 SAY " ���뢠�� �㡫�஢���� 䠩�� ����-���� �� Alt-F7 (1/0)..." GET tek_b_38 PICTURE "9" VALID tek_b_38=0.OR.tek_b_38=1 ERROR '0 - ���, 1 - ��...'
    @ 12,0 SAY " ���� ��� �㡫�-䠩�� ����-����.." GET tek_b_39 FUNCTION 'S40'
    @ 13,0 SAY " �����ᮢ� ��� � �㡫�-䠩�� ����-����.................." GET tek_b_40
    @ 14,0 SAY " ���� ��� ��࠭���� ��娢� 䠩���" GET tek_b_50 FUNCTION 'S40'
    READ
ENDCASE
HIDE WINDOW ALL
ntmec=tek_b_2
kolstr=tek_b_14
tmec=name_mec(ntmec)
SET PATH TO &nastf_p
sss=FULLPATH('nsch.mem')
SAVE TO &sss ALL LIKE nsch??
sss=FULLPATH('nastf.mem')
  * nastf_b = '1999'
SAVE TO &sss ALL LIKE nastf???
sss=FULLPATH('tek_b.mem')
SAVE TO &sss ALL LIKE tek_b_??
sss=FULLPATH('sgat_prn.mem')
SAVE TO &sss ALL LIKE sgat?
RELEASE ALL LIKE tek_b_??
IF nastf_8=1
    IF !Poisk_alia('SPR_VAL')
         SELECT 0
         USE spr_val
         SET ORDER TO kod
         SELECT 0
         USE kurs_val
         SET ORDER TO kod
    ENDIF
ELSE
    IF Poisk_alia('SPR_VAL')
         SELECT spr_val
         USE
         SELECT kurs_val
         USE
    ENDIF
ENDIF
ACTIVATE SCREEN
SET COLOR TO &color13
@ 24,46 SAY "������ ����� : "+tmec
RETURN
*
PROCEDURE Obmen
PARAMETERS ch3
fpath=SPACE(32)
DEFINE WINDOW Zapros FROM 10,17 TO 12,77 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " ������ ���� ��� 䠩���" GET fpath
READ
HIDE WINDOW ALL
IF LASTKEY()=27
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
IF ch3#3.AND.ch3#4
    IF RIGHT(fpath,1)#"\"
         fpath=fpath+"\"
    ENDIF
ENDIF
DO CASE
CASE ch3=1
    path_r=fpath+"zarp_k.dbf"
    IF FILE(path_r)
         SELECT sprt
         RESTORE FROM tek_b ADDITIVE
         SEEK tek_b_3
         SELECT 0
         USE &path_r
         @ 1,18 SAY RECCOUNT() PICTURE '999999'
         SCAN FOR !DELETE()
              @ 2,18 SAY RECNO() PICTURE '999999'
              SELECT bk
              APPEND BLANK
              REPLACE vo WITH '1',dati WITH DATE(),sm WITH zarp_k.symz,;
                      kp WITH LTRIM(zarp_k.tab),wid_t WITH tek_b_3
              REPLACE text_1 WITH sprt.text_1,text_2 WITH sprt.text_2
         ENDSCAN
         RELEASE ALL LIKE tek_b_??
         USE
    ELSE
         DO Net_n WITH 11,'H� ������ 䠩�: '+path_r+'.'
    ENDIF
CASE ch3=2
    DO Pr_zarp
CASE ch3=3
    DO Preob
CASE ch3=4
    DO Pr_sk_ot
CASE ch3=5
    DO Pri_bank
ENDCASE
HIDE WINDOW ALL
RETURN
*
PROCEDURE Pr_rx
PARAMETERS ch3
HIDE POPUP ALL
DO CASE
CASE ch3=1
    SELECT 0
    USE nast_pr
    DO Vvodn WITH "Chapnp","Strsaynp","Strgetnp",.T.,.T.,.T.,.F.,".F.","",;
                  "","","","","","","","","","",.T.
    USE
CASE ch3=2
    SELECT 0
    USE nast_rx
    DO Vvodn WITH "Chapnr","Strsaynr","Strgetnr",.T.,.T.,.T.,.F.,".F.","",;
                  "","","","","","","","","","",.T.
    USE
ENDCASE
SHOW POPUP Glavn,Servg,Tekm
RETURN
*
PROCEDURE Pr_arm
PARAMETERS ch3
DEFINE WINDOW Zapros FROM 10,13 TO IIF(ch3=3,13,12),77 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
fpath=SPACE(37)
@ 0,0 SAY " ������ ���� ��� 䠩��" GET fpath
IF ch3=3
    knsk=SPACE(5)
    @ 1,0 SAY " ��� ���ࠧ�������....." GET knsk
ENDIF
READ
HIDE WINDOW ALL
IF LASTKEY()=27
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
IF LEN(fpath)#0
    IF RIGHT(fpath,1)#"\"
         fpath=fpath+"\"
    ENDIF
ENDIF
DO CASE
CASE ch3=1
    RESTORE FROM tek_b ADDITIVE
    path_r=fpath+"kassa.dbf"
    COPY FILE kassa.dbf TO &path_r
    SELECT 0
    USE &path_r EXCLUSIVE
    ZAP
    SELECT bk
    SET ORDER TO
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    SCAN FOR kor=tek_b_1.AND.MONTH(dat)=ntmec.AND.pr_spr='0'
         @ 2,18 SAY RECNO() PICTURE '999999'
         SELECT kassa
         APPEND BLANK
         REPLACE tbn WITH VAL(bk.kp),nd WITH bk.nrd
         IF bk.vo='0'
              REPLACE symk WITH -bk.sm
         ELSE
              REPLACE symk WITH bk.sm
         ENDIF
    ENDSCAN
    SELECT kassa
    USE
    SELECT bk
    SET ORDER TO kp
    RELEASE ALL LIKE tek_b_??
CASE ch3=2
    DO Prg_skl
CASE ch3=3
    DO Pr_bank
ENDCASE
HIDE WINDOW ALL
RETURN
*
PROCEDURE Poisk_err
PARAMETERS nerr
PRIVATE nam_file,i
* �뤥����� ������������
FOR i=1 TO LEN(PROMPT())
    IF EMPTY(AT('\',PROMPT(),i))
         i=i-1
         EXIT
    ENDIF
ENDFOR
nam_file=RTRIM(SUBSTR(PROMPT(),AT('\',PROMPT(),i)+1,LEN(PROMPT())))
nam_file=LEFT(nam_file,LEN(nam_file)-4)
* �஢�ઠ � ᯨ᪥ �᭮���� 䠩���
IF Poisk_alia(nam_file)
    RETURN
ENDIF
* ����⨥ 䠩��
ON ERROR DO Err_dbf WITH ERROR()
USE &nam_file
ON ERROR DO Err_finr WITH ERROR(),MESSAGE(),MESSAGE(1)
RETURN
*
PROCEDURE Arc_zap
PARAMETERS ch3
DEFINE POPUP Tekm FROM 11,55 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Tekm PROMPT " �\<��� - ����              "
DEFINE BAR 2 OF Tekm PROMPT " �\<��⠢騪�                "
DEFINE BAR 3 OF Tekm PROMPT " ��\<���⥫�                "
DEFINE BAR 4 OF Tekm PROMPT " ��\<������ ���          "
DEFINE BAR 5 OF Tekm PROMPT " �\<�稥 �������-�।���� "
ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
ACTIVATE POPUP Tekm
menu_v=BAR()
IF menu_v=0
     RETURN
ENDIF
DO CASE
CASE ch3=1
    fdat=CTOD('  /  /  ')
    DEFINE WINDOW Zapros FROM 16,48 TO 18,75 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " �� ������ �᫠" GET fdat
    READ
    RELEASE WINDOW Zapros
    ACTIVATE SCREEN
    IF EMPTY(fdat)
         RETURN
    ENDIF
    key=2
    DEFINE WINDOW Zapros FROM 10,10 TO 13,71 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,1 SAY "�믮������ 㤠����� ����ᥩ �� ��娢� � ��⮩ �� "+DTOC(fdat)+"."
    @ 1,8 SAY "�� 㢥७� ?"
    @ 1,28 PROMPT " ��  "
    @ 1,38 PROMPT " H�� "
    MENU TO key
    RELEASE WINDOW Zapros
    IF key=1
         ACTIVATE WINDOW Pog_p
         SET COLOR TO &color15
         @ 0,0 SAY '�'
         SET COLOR TO &color13
         @ 0,1 SAY "��������, ��������..."
         SELECT 0
         DO CASE
         CASE menu_v=1
              USE bk_arc EXCLUSIVE
         CASE menu_v=2
              USE atot_arc EXCLUSIVE
         CASE menu_v=3
              USE avot_arc EXCLUSIVE
         CASE menu_v=4
              USE avtr_arc EXCLUSIVE
         CASE menu_v=5
              USE dvpr_arc EXCLUSIVE
         ENDCASE
         DELETE FOR dat<fdat
         PACK
         USE
         HIDE WINDOW Pog_p
    ENDIF
CASE ch3=2
    fms=0
    fgod=0
    DEFINE WINDOW Zapros FROM 15,53 TO 18,75 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " �� ����� �����" GET fms PICTURE '99' VALID fms>0.AND.fms<13 ERROR '����୮� ���祭�� �����...'
    @ 1,0 SAY "          ���.." GET fgod PICTURE '9999' VALID fgod>0.AND.fgod<2100 ERROR '����୮� ���祭�� ����...'
    READ
    RELEASE WINDOW Zapros
    ACTIVATE SCREEN
    IF EMPTY(fgod)
         RETURN
    ENDIF
    key=2
    DEFINE WINDOW Zapros FROM 10,5 TO 13,76 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,1 SAY "�믮������ ����⠭������� ����ᥩ �� ��娢� �� ����� "+STR(fms,2)+' '+STR(fgod,4)+' ����.'
    @ 1,8 SAY "�� 㢥७� ?"
    @ 1,28 PROMPT " ��  "
    @ 1,38 PROMPT " H�� "
    MENU TO key
    RELEASE WINDOW Zapros
    IF key=1
         ACTIVATE WINDOW Pog_p
         SET COLOR TO &color15
         @ 0,0 SAY '�'
         SET COLOR TO &color13
         @ 0,1 SAY "��������, ��������..."
         SELECT 0
         DO CASE
         CASE menu_v=1
              SELECT bk
              SET DELETED ON
              APPEND FROM bk_arc FOR MONTH(dat)=fms.AND.YEAR(dat)=fgod
              SET DELETED OFF
              SELECT 0
              USE bk_arc EXCLUSIVE
              IF ALIAS()='BK_ARC'
                   DELETE FOR MONTH(dat)=fms.AND.YEAR(dat)=fgod
                   PACK
                   USE
              ENDIF
         CASE menu_v=2
         CASE menu_v=3
         CASE menu_v=4
         CASE menu_v=5
         ENDCASE
         HIDE WINDOW Pog_p
    ENDIF
ENDCASE
ACTIVATE SCREEN
RETURN