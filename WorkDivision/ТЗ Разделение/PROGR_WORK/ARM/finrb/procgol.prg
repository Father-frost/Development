PROCEDURE Chapsk
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=5
nstrn=17
ncoll=0
ncolr=77
step=1
npolscrm=2
DEFINE WINDOW Chapsk FROM 3,0 TO 23,79 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chapsk
SET COLOR TO &color8
@ nstrv-5 ,70 SAY "-->"
SET COLOR TO &color4
@ nstrv-5 ,ncoll SAY "            � � � � � � � � � �    � �     � � � � � � � � � � � �"
   *@ nstrv-4 ,ncoll SAY "��������������������������������������������������������������������������������������������������"
   *@ nstrv-3 ,ncoll SAY " ���   �                  H�����������                    �     ��த     �   ���   �  ������  "
   *@ nstrv-2 ,ncoll SAY "�࣠����                                                  �               �  �����  �    ���     "
   *@ nstrv-1 ,ncoll SAY "��������������������������������������������������������������������������������������������������"
@ nstrv-4 ,ncoll SAY "�������������������������������������������������������������������������� "
@ nstrv-3 ,ncoll SAY " ���   �                  H�����������                    �     ��த      "
@ nstrv-2 ,ncoll SAY "�࣠����                                                  �                "
@ nstrv-1 ,ncoll SAY "�������������������������������������������������������������������������� "
@ nstrv+12,ncoll SAY "�� ����: F2 � ���, F3 � ������������, F4 - p/���, F5 - ���⥪�� ,F6 - ��� ��"
@ nstrv+13,ncoll SAY "�� F8 - �।�⠢����� � ���⥦�� �� F9 - ��������.p�������� �� F10 - ����� ��"
SAVE SCREEN TO scr
SET COLOR TO &color8
@ nstrv-5 ,70 SAY "   "
@ nstrv-5 ,5 SAY "<--"
SET COLOR TO &color4
    *@ nstrv-4 ,ncoll SAY "�����������������������������������������������������������������������������"
    *@ nstrv-3 ,ncoll SAY " ���   �����ᯮ����.�          �⤥�����  �����          �  ��த  ����� ����"
    *@ nstrv-2 ,ncoll SAY "�࣠����     ���    �                                    �               �p��"
    *@ nstrv-1 ,ncoll SAY "������������������������������������������������������������������������������"
@ nstrv-4 ,ncoll SAY "���������������������������������������������������������������������������"
@ nstrv-3 ,ncoll SAY "   ���   �  ������  �          �⤥�����  �����         � ��த  �����  "
@ nstrv-2 ,ncoll SAY "  �����  �    ���     �                                   �               "
@ nstrv-1 ,ncoll SAY "���������������������������������������������������������������������������"
SAVE SCREEN TO scr1
RESTORE SCREEN FROM scr
RETURN
*
PROCEDURE Strsaysk
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
DO CASE
  * CASE npolscr=1
  *     @ nstr,0  SAY kkl
  *     @ nstr,8  SAY ikl
  *     @ nstr,39 SAY gor
  *     @ nstr,55 SAY mfo
  *     @ nstr,65 SAY sch
  * CASE npolscr=2
  *     @ nstr,0  SAY kkl
  *     @ nstr,8  SAY korr
  *     @ nstr,22 SAY otd
  *     @ nstr,59 SAY gorb
  *     @ nstr,75 SAY pr_reg
CASE npolscr=1
    @ nstr,0  SAY kkl
    @ nstr,8  SAY ikl
    @ nstr,59 SAY gor
      *@ nstr,55 SAY mfo
      *@ nstr,65 SAY sch
CASE npolscr=2
        *@ nstr,0  SAY kkl
    @ nstr,0 SAY mfo
    @ nstr,10 SAY sch
          * @ nstr,8  SAY korr
    @ nstr,24 SAY otd
    @ nstr,60 SAY gorb
          *@ nstr,75 SAY pr_reg
ENDCASE
RETURN
*
PROCEDURE Strgetsk
PARAMETERS nstr,npolscr
PRIVATE nz,fkkl,scr,sss
IF EMPTY(kkl)
    pr_per=.T.
    IF nastf_o=1
         RESTORE FROM tek_b ADDITIVE
         tek_b_11=LEFT(RIGHT('0000000'+LTRIM(STR(VAL(tek_b_11)+1,7,0)),LEN(RTRIM(tek_b_11)))+SPACE(7),7)
         REPLACE kkl WITH tek_b_11
         sss=FULLPATH('tek_b.mem')
         SAVE TO &sss ALL LIKE tek_b_??
         RELEASE ALL LIKE tek_b_??
    ENDIF
ELSE
    pr_per=.F.
ENDIF
DO CASE
CASE npolscr=1
    nz=RECNO()
    DO WHILE .T.
         @ nstr,0 GET kkl
         READ
         IF LASTKEY()=27
              IF pr_per
                   prudalv=prudalv+1
                   DELETE
              ENDIF
              RETURN
         ENDIF
         fkkl=kkl
         SET ORDER TO kkl
         IF SEEK(fkkl)
              SKIP
              IF fkkl=kkl
                   DO Net_n WITH 10," ����� ��� 㦥 ����. ������... "
              ELSE
                   GO nz
                   EXIT
              ENDIF
         ELSE
              DO Net_n WITH 10," �����-� ���p�� � ��⥬�. ������, p��p�襭 ������... "
              RETURN
         ENDIF
         GO nz
    ENDDO
        *@ nstr,8  GET ikl
        *@ nstr,39 GET gor
        *@ nstr,55 GET mfo
        *@ nstr,65 GET sch
    @ nstr,8  GET ikl
    @ nstr,59 GET gor
CASE npolscr=2
        *@ nstr, 8 GET korr
        *@ nstr,22 GET otd
        *@ nstr,59 GET gorb
        *@ nstr,75 GET pr_reg VALID Poisk_tg('skl.pr_reg') ERROR 'H�� ⠪��� ����...'
    @ nstr,0 GET mfo
    @ nstr,10 GET sch
    @ nstr,24 GET otd
    @ nstr,60 GET gorb
ENDCASE
READ
IF (LASTKEY()#27.OR.READKEY()=271.OR.READKEY()=15).AND.npolscr=2
    DO F9sk
ENDIF
RETURN
*
PROCEDURE F2sk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE i,fpoisk,nz
nz=RECNO()
SET ORDER TO kkl
DEFINE WINDOW F2sk FROM 14,33 TO 16,47 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW F2sk
SET COLOR TO &color14
fpoisk=SPACE(LEN(kkl))
@ 0,1 SAY "���" GET fpoisk
READ
RELEASE WINDOW F2sk
IF LASTKEY()=27
    RETURN
ENDIF
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H�� ⠪��� ����. ������... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3sk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
SET ORDER TO ikl
DEFINE WINDOW F3sk FROM 14,18 TO 16,64 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW F3sk
SET COLOR TO &color14
fpoisk=SPACE(LEN(ikl))
@ 0,1 SAY "H�����������" GET fpoisk
READ
RELEASE WINDOW F3sk
IF LASTKEY()=27
    RETURN
ENDIF
fpoisk=CHRTRAN(STRTRAN(fpoisk," ",""),"��������������������������������","��������������������������������")
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H�� ⠪��� ������������. ������... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4sk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
DEFINE WINDOW F4sk FROM 9,25 TO 11,55 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW F4sk
SET COLOR TO &color14
fpoisk=SPACE(LEN(skl.sch))
@ 0,1 SAY "������ ���" GET fpoisk
READ
RELEASE WINDOW F4sk
IF LASTKEY()=27
    RETURN
ENDIF
SET ORDER TO sch
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 13,'H�� ⠪��� p���⭮�� ���...'
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F5sk
IF RECCOUNT()=0
	RETURN
ENDIF
PRIVATE nz
nz=RECNO()
DEFINE WINDOW F5sk FROM 14,22 TO 16,64 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW F5sk
SET COLOR TO &color14
fpoiskk=SPACE(LEN(ikl))
@ 0,1 SAY "�ࠣ����" GET fpoiskk
READ
RELEASE WINDOW F5sk
IF LASTKEY()=27
    RETURN
ENDIF
fpoiskk=CHRTRAN(STRTRAN(fpoiskk," ",""),"��������������������������������","��������������������������������")
SET FILTER TO (fpoiskk $ CHRTRAN(STRTRAN(ikl," ",""),"��������������������������������","��������������������������������"))
GO TOP
IF EOF()
    SET FILTER TO
    DO Net_n WITH 10," H�� ⠪��� ���祭��. ������... "
    GO nz
ELSE
    DEFINE POPUP listfrag FROM 8,20 TO 18,60 COLOR SCHEME 17 SHADOW IN SCREEN PROMPT FIELD kkl+" "+ikl;
           TITLE ' �࣠����樨 � �ࠣ���⮬ ...'+fpoiskk+'...' SCROLL
    ON SELECTION POPUP listfrag DEACTIVATE POPUP listfrag
    ACTIVATE POPUP listfrag
    SET FILTER TO
ENDIF
RETURN
*
PROCEDURE F6sk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
DEFINE WINDOW F6sk FROM 9,25 TO 11,55 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW F6sk
SET COLOR TO &color14
fpoisk=SPACE(LEN(skl.unn))
@ 0,1 SAY " ���  - " GET fpoisk
READ
RELEASE WINDOW F6sk
IF LASTKEY()=27
    RETURN
ENDIF
SET ORDER TO unn
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 13,'H�� ⠪��� ��� ...'
    GO nz
ENDIF
SET EXACT ON
RETURN
*
*
PROCEDURE F8sk
IF RECCOUNT()=0
    RETURN
ENDIF
DEFINE WINDOW F8sk FROM 8,3 TO 15,77 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW F8sk
SET COLOR TO &color13
@ 0,1 SAY '�����⥫�'+SPACE(45)+'---------------'
@ 1,1 SAY '���'+SPACE(42)+'----------|    ��. N    |'
@ 2,1 SAY SPACE(45)+'|   ���   |             |'
@ 3,1 SAY '���� ���.'+SPACE(36)+'|         |             |'
@ 4,1 SAY SPACE(45)+'------------------------|'
@ 5,1 SAY '� �.'+SPACE(65)+'|'
SET COLOR TO &color12
@ 0,12 GET ikl
@ 0,42 GET ikl1
@ 1, 5 GET unn
@ 1,16 GET ikld
@ 2, 1 GET ikldd
@ 2,57 GET sch
@ 3,11 GET otd
@ 3,47 GET mfo
@ 3,57 GET korr
@ 4, 1 GET otdd
@ 5, 6 GET gorb
READ
RELEASE WINDOW F8sk
RETURN
*
PROCEDURE F9sk
IF RECCOUNT()=0
    RETURN
ENDIF
DEFINE WINDOW F9sk FROM 10,8 TO 22,78 COLOR SCHEME 19 SHADOW DOUBLE
    *DEFINE WINDOW F9sk FROM 9,8 TO 23,78 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW F9sk
SET COLOR TO &color14
@ 0,1 SAY '���.............................' GET unn
@ 1,1 SAY '��� �� ����.....................' GET okpo
@ 2,1 SAY '��� �� �����....................' GET okonx
       *@ 3,1 SAY '����䮭.........................' GET telef
       *@ 4,1 SAY '����............................' GET faks
       *@ 5,1 SAY '�����⥫��⢮ ��� �/�...........' GET kommer1
       *@ 4,1 SAY '����..' GET adr FUNCTION 'S60'
@ 4,1 SAY '����..' GET adr FUNCTION 'S44'
       *@ 7,1 SAY '���.���.�� �/�' GET sch_1
       *@ 8,1 SAY '���.���.�� �/�' GET kor_1
       *@ 9,1 SAY '��ᯮ��' GET dop_inf
       *@ 10,9 GET dop_inf1
@ 5,1 SAY '���.����. �࣠����樨' GET ikl1
@ 6,11 GET ikld
       * @ 7,11 GET ikldd
@ 7,1 SAY '���.����. �⤥�. �����' GET otdd
@ 8,1 SAY '������⢮ ���� ���㬥�⮮��p��' GET kol_dn
@ 9,1 SAY '�p�業� ���� �� ���� �p��p�窨..' GET pr_pen
      *@ 11,1 SAY '������⢮ ���� ���㬥�⮮��p��' GET kol_dn
      *@ 12,1 SAY '�p�業� ���� �� ���� �p��p�窨..' GET pr_pen
READ
RELEASE WINDOW F9sk
RETURN
*
*
PROCEDURE Chapsr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=22
ncoll=19
ncolr=70
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-7,ncoll FILL TO nstrv+11,ncolr+2 COLOR &color20
@ nstrv-8,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-7 ,ncoll-1 SAY "�             ��ࠢ�筨� ࠡ�⭨���"
@ nstrv-6 ,ncoll-1 SAY "����������������������������������������������������Ķ"
@ nstrv-5 ,ncoll-1 SAY "� ���:"
@ nstrv-4 ,ncoll-1 SAY "����������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "�������멳  ��� �             �.�.�."
@ nstrv-2 ,ncoll-1 SAY "�  �����  �      �"
@ nstrv-1 ,ncoll-1 SAY "����������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "� ����:F2�⠡.�����,F3-���,F4-�ࠣ���� � F10į���� "
RETURN
*
PROCEDURE Strsaysr
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    SELECT sch
    SET ORDER TO sch
    SEEK sprrab.cex
    @ 7,25 SAY sch.icsk
    SELECT sprrab
ENDIF
SET COLOR TO &color
@ nstr,21 SAY tab
@ nstr,29 SAY cex
@ nstr,36 SAY fio
RETURN
*
PROCEDURE Strgetsr
PARAMETERS nstr,npolscr
PRIVATE nz,ftab
pr_per=IIF(EMPTY(tab),.T.,.F.)
nz=RECNO()
DO WHILE .T.
    @ nstr,21 GET tab
    READ
    IF LASTKEY()=27
         IF pr_per
              prudalv=prudalv+1
              DELETE
         ENDIF
         RETURN
    ENDIF
    ftab=tab
    SET ORDER TO tab
    IF SEEK(ftab)
         SKIP
         IF ftab=tab
              DO Net_n WITH 10," ����� ��� 㦥 ����. ������... "
         ELSE
              GO nz
              REPLACE tbn WITH VAL(tab)
              EXIT
         ENDIF
    ELSE
         DO Net_n WITH 10," �����-� ���p�� � ��⥬�. ������, p��p�襭 ������... "
         RETURN
    ENDIF
    GO nz
ENDDO
@ nstr,29 GET cex VALID Poisk_ns('sprrab.cex',.F.,7,25,30) ERROR 'H�� ⠪��� ����...'
@ nstr,36 GET fio
READ
RETURN
*
PROCEDURE F2sr
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
SET ORDER TO tab
nz=RECNO()
@ 15,35 FILL TO 17,59 COLOR &color20
SET COLOR TO &color13
@ 14,34,16,58 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(tab))
@ 15,35 SAY " ������� �����" GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10,"  H�� ⠪��� �����. ������... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3sr
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
SET ORDER TO fio
nz=RECNO()
@ 15,20 FILL TO 17,71 COLOR &color20
SET COLOR TO &color13
@ 14,19,16,70 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(fio))
@ 15,20 SAY " ������� �.�." GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H�� ⠪�� 䠬����. ������... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4sr
IF RECCOUNT()=0
	RETURN
ENDIF
PRIVATE nz
nz=RECNO()
@ 15,23 FILL TO 17,70 COLOR &color20
SET COLOR TO &color13
@ 14,22,16,69 BOX "�ͻ���Ⱥ "
SET COLOR TO &color14
fpoiskk=SPACE(LEN(fio))
@ 15,23 SAY " �ࠣ����" GET fpoiskk
READ
IF LASTKEY()=27
    RETURN
ENDIF
fpoiskk=CHRTRAN(STRTRAN(fpoiskk," ",""),"��������������������������������","��������������������������������")
SET FILTER TO (fpoiskk $ CHRTRAN(STRTRAN(fio," ",""),"��������������������������������","��������������������������������"))
GO TOP
IF EOF()
    SET FILTER TO
    DO Net_n WITH 10," H�� ⠪��� ���祭��. ������... "
    GO nz
ELSE
    ACTIVATE SCREEN
    DEFINE POPUP listfrag FROM 8,20 TO 18,60 COLOR SCHEME 17 SHADOW IN SCREEN PROMPT FIELD tab+" "+fio;
           TITLE ' ����⭨� � �ࠣ���⮬ ...'+fpoiskk+'...' SCROLL
    ON SELECTION POPUP listfrag DEACTIVATE POPUP listfrag
    ACTIVATE POPUP listfrag
    SET FILTER TO
ENDIF
RETURN
*
*
PROCEDURE Chapbk
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=22
ncoll=1
step=1
npolscrm=1
ncolr=IIF(nastf_d=1,78,70)
SET COLOR TO &color4
@ nstrv-10-IIF(nastf_d=1,1,0),ncoll-1,nstrv+11,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv- 9-IIF(nastf_d=1,1,0),ncoll-1 SAY '�         �������� �������� �।�� �� �����ᮢ��� ����'
@ nstrv- 8-IIF(nastf_d=1,1,0),ncoll-1 SAY '���������������������������������������������������������������'+IIF(nastf_d=0,'','��������')+'�������Ķ'
@ nstrv- 7-IIF(nastf_d=1,1,0),ncoll-1 SAY '� ������:'
@ nstrv- 6-IIF(nastf_d=1,1,0),ncoll-1 SAY '� �࣠�-��:                                '+IIF(nastf_11=0,'','����')
IF nastf_d=1
    @ nstrv-6 ,ncoll SAY ' ���㬥��:'
ENDIF
@ nstrv-5 ,ncoll-1 SAY '�����������������������������������������������������������������������'+IIF(nastf_d=0,'','��������')+'�'
@ nstrv-4 ,ncoll-1 SAY '�����H���� ���   �H���� �   ���   �   ���   �����       �㬬�      '+IIF(nastf_d=0,'','��������')
@ nstrv-3 ,ncoll-1 SAY '�������室��࣠��������. � ���㬥�- �  ������  ����'+IIF(gpr_val,'�����',SPACE(6))+SPACE(12)+IIF(nastf_d=0,'','�����⥪')
@ nstrv-2 ,ncoll-1 SAY '� ���騩 �(ࠡ��)�����.�    �    �          �    �                  '+IIF(nastf_d=0,'','��.���')
@ nstrv-1 ,ncoll-1 SAY '�����������������������������������������������������������������������'+IIF(nastf_d=0,'','��������')+'�'
@ nstrv+10,ncoll-1 SAY '�� ����: F2-�࣠�.,F3-����.,F4-�㬬� �� F5-ᯨ᮪ � Alt+F2-��� �'+IIF(nastf_d=0,'����',' F10į���� ')+'�'
@ nstrv+11,ncoll-1 SAY '�� �⮣: F6-���㬥��,F7-��� ������,F8 - ��� ���㬥��,F9-�/��� '
SET COLOR TO &color21
@ nstrv-9-IIF(nastf_d=1,1,0),57 SAY IIF(EMPTY(gfbs),nzk,gfbs)
RETURN
*
PROCEDURE Strsaybk
PARAMETERS color,nstr,npolscr
PRIVATE n_str,nam_file
IF !pr_v_pr
    SET COLOR TO &color21
    @ 3-IIF(nastf_d=1,1,0),57 SAY nzk
    ffnzk=nzk
    ffdat=dat
    IF nastf_d=1
         n_str=4
    ELSE
         n_str=5
    ENDIF
    @ n_str,12 SAY IIF(vo='0','��室','���室')
    @ n_str+1,12 SAY Spr_nam(pr_spr,kp,30)
    IF nastf_11=1
         @ n_str+1,48 SAY pr_sprk
         @ n_str+1,50 SAY kpp
         @ n_str+1,57 SAY Spr_nam(pr_sprk,kpp,22)
    ENDIF
    IF nastf_d=1
         nam_file=ALIAS()
         SELECT sprnaz
         SEEK bk.wid_d
         @ n_str+2,12 SAY sprnaz.nam
         SELECT &nam_file
    ENDIF
    IF gpr_val
         @  9,60 SAY vid_val
         @ 10,53 SAY sm_val PICTURE '999,999,999,999.99'
    ENDIF
ENDIF
SET COLOR TO &color
@ nstr,1  SAY vo
@ nstr,3  SAY pr_spr
@ nstr,5  SAY nvx
@ nstr,11 SAY kp
@ nstr,19 SAY nrd
@ nstr,26 SAY dati
@ nstr,37 SAY dat
@ nstr,48 SAY kor
@ nstr,53 SAY sm PICTURE '999,999,999,999.99'
IF nastf_d=1
    @ nstr,72 SAY wid_d
    @ nstr,76 SAY wid_t
ENDIF
RETURN
*
PROCEDURE Strgetbk
PARAMETERS nstr,npolscr
PUSH KEY
ON KEY
ON KEY LABEL Alt-F1 DO Help_mik
ON KEY LABEL Alt-P DO Calcul
PRIVATE scr,nn_poz,fkp,fnrd,fkor
IF EMPTY(vo)
    IF nastf_d=1
         @ 4,12 SAY SPACE(30)
    ENDIF
    @ 5,12 SAY SPACE(30)
    @ 6,12 SAY SPACE(30)
    REPLACE dat WITH ffdat,nzk WITH gfbs
    IF gpr_val
         SELECT spr_bs
         SET ORDER TO bs
         SEEK gfbs
         SELECT bk
         REPLACE vid_val WITH spr_bs.vid_val
    ENDIF
ENDIF
fpr_spr=pr_spr
fkp=kp
fnrd=nrd
fkor=kor
fdat=dat
fvo=vo
IF nastf_d=1
    n_str=4
ELSE
    n_str=5
ENDIF
IF EMPTY(vid_op)
  replace vid_op with '42'
ENDIF

fpr_val=.F.
@ nstr,1  GET vo VALID vo='0'.OR.vo='1' ERROR '0 - ��室, 1 - ��室...'
@ nstr,3  GET pr_spr VALID pr_spr='0'.OR.pr_spr='1' ERROR '���祭�� 0 - p���⭨�, 1 - �p��������'
@ nstr,5  GET nvx
@ nstr,11 GET kp  VALID Poisk_kp('bk.kp',pr_spr,n_str+1,12,30) ERROR '��� ⠪��� ����...'
@ nstr,19 GET nrd VALID !EMPTY(nrd).OR.Nom_doc()
@ nstr,26 GET dati
@ nstr,37 GET dat VALID EMPTY(dat).OR.nastf_9=0.OR.MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b ERROR '�����४⭠ ���...'
@ nstr,48 GET kor VALID Poisk_sc('bk.kor',.F.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
IF gpr_val
    @  9,60 GET vid_val VALID Poisk_wl('bk.vid_val',.F.,0,0,0) ERROR 'H�� ⠪�� ������...'
    @ 10,53 GET sm_val VALID Repl_sum('sm',vid_val,sm_val,IIF(EMPTY(dat),dati,dat),nstr,53) PICTURE '999,999,999,999.99'
ENDIF
@ nstr,53 GET sm PICTURE '999,999,999,999.99'
IF nastf_d=1
    @ nstr,72 GET wid_d VALID Poisk_wd('bk.wid_d',.F.,n_str+2,12,30) ERROR 'H�� ⠪��� ����...'
    if wid_t=0
      @ nstr,76 GET wid_t VALID Poisk_wt('bk.wid_t',.F.) ERROR 'H�� ⠪��� ����...'
    else
      @ nstr,76 GET wid_t 
    endif
ENDIF
IF nastf_11=1
    @ n_str+1,48 GET pr_sprk VALID pr_sprk='0'.OR.pr_sprk='1' ERROR '0 - ࠡ�⭨�, 1 - �࣠������...'
    @ n_str+1,50 GET kpp VALID Poisk_kp('bk.kpp',pr_sprk,n_str+1,57,22) ERROR '��� ⠪��� ����...'
ENDIF
READ
SAVE SCREEN TO scr
i=14
SET COLOR TO &color13
pr_t=.F.
IF LASTKEY()#27.OR.READKEY()=15.OR.READKEY()=271
    IF nastf_d=1
         pr_t=.T.
         ON KEY LABEL Alt-H DO AltH
         @ 7,21 FILL TO 14,74 COLOR &color20
         @ 6,20,13,73 BOX "�ͻ���Ⱥ�"
         SET COLOR TO &color14
         @  8,22 GET text_1
         @  9,22 GET text_2
         @ 10,22 GET text_3
         @ 11,22 GET text_4
         SET COLOR TO &color13
         DO CASE
         CASE vo='0'.AND.wid_d=1
              i=i+1
              @ i,21 SAY SPACE(53)
              @ i,21 SAY ' H���� ॥���........' GET nazn_pl
         CASE vo='1'.AND.wid_d=2
              i=i+3
              @ i-2,21 SAY SPACE(53)
              @ i-1,21 SAY SPACE(53)
              @ i  ,21 SAY SPACE(53)
                  * @ i-1,21 SAY ' ��� ���p�樨.........' GET vid_op
                  * @ i  ,21 SAY ' H����祭�� ���⥦�...' GET nazn_pl
              @ i-2,21 SAY ' ��।� ���⥦�......' GET vid_op
              @ i-1,21 SAY ' ��� ���⥦�..........' GET nazn_pl
              @ i  ,21 SAY ' ��� ����祭�� ⮢�p�' GET dat_tov
         ENDCASE
    ENDIF
    IF vo='0'.AND.(wid_d=1.OR.nastf_w=1).OR.vo='1'.AND.nastf_w=1.OR.nastf_i=1.AND.kor=nastf_j
         IF nastf_i=1.AND.kor=nastf_j.AND.vo='1'
              i=i+2
              @ i-1,21 SAY SPACE(53)
              @ i  ,21 SAY SPACE(53)
              @ i-1,21 SAY ' ������p..............' GET dog VALID Poisk_kr('bk.dog',.F.) ERROR '��� ⠪��� �������...'
              @ i  ,21 SAY ' �।��(0),��業��(1)' GET kred VALID kred='0'.OR.kred='1' ERROR '����୮� ���祭��...'
         ELSE
              i=i+1
              @ i,21 SAY SPACE(53)
              @ i,21 SAY ' ������p..............' GET dog VALID nastf_i=0.OR.kor#nastf_j.OR.Poisk_kr('bk.dog',.F.) ERROR '��� ⠪��� �������...'
         ENDIF
    ENDIF
    IF EMPTY(dat).AND.nastf_5=1
         i=i+1
         @ i,21 SAY SPACE(53)
         @ i,21 SAY ' ��� ����⥪�........' GET pr_usl VALID Poisk_kt(.F.,'bk.pr_usl') ERROR 'H�� ⠪��� ����...'
    ENDIF
    IF nastf_y=1.AND.nastf__=kor
         i=i+1
         @ i,21 SAY SPACE(53)
         @ i,21 SAY ' ����� ��������......' GET ndep
    ENDIF
    IF vo='1'.AND.pr_spr='0'.AND.LEFT(kor,LEN(RTRIM(kor)))=RTRIM(nastf_r)
         fms=IIF(smo=0,0,sm/smo)
         i=i+3
         @ i-2,21 SAY SPACE(53)
         @ i-1,21 SAY SPACE(53)
         @ i  ,21 SAY SPACE(53)
         @ i-2,21 SAY ' ��� �࣠����樨 ����' GET kpp VALID Poisk_kl('bk.kpp',.F.,0,0,0) ERROR 'H�� ⠪��� ����...'
         @ i-1,21 SAY ' ��� ��砫� �믫���..' GET dats
         @ i  ,21 SAY ' ������⢮ ����楢...' GET fms PICTURE '99'
    ENDIF
    IF nastf_12=1
         i=i+1
         @ i,21 SAY SPACE(53)
         @ i,21 SAY ' ������ 䨭�����......' GET razd
         i=i+1
         @ i,21 SAY SPACE(53)
         @ i,21 SAY ' ����� 䨭�����......' GET podrazd
    ENDIF
     *?i
     *=inkey(0)
    IF i>14.OR.pr_t
         IF i>14
              SET COLOR TO &color13
              @ i+2,21 FILL TO i+2,74 COLOR &color20
              @ 15,74 FILL TO i+2,74 COLOR &color20
              @ 14,20 TO i+1,73 DOUBLE
         ENDIF
         SET COLOR TO &color14
         READ
         RESTORE SCREEN FROM scr
    ENDIF
    ON KEY LABEL Alt-H
ENDIF
IF vo='1'.AND.pr_spr='0'.AND.LEFT(kor,LEN(RTRIM(kor)))=RTRIM(nastf_r)
    REPLACE smo WITH IIF(fms=0,0,ROUND(sm/fms,0))
ENDIF
IF nastf_x=1.AND.!EMPTY(fkp).AND.(fkp#kp.OR.nrd#fnrd.OR.fkor#kor.OR.fdat#dat.OR.vo#fvo)
    SELECT lim_nsk
    DO WHILE SEEK(fkp+fnrd+fkor+gfbs+fvo+DTOC(fdat,1))
         REPLACE kp WITH bk.kp,nrd WITH bk.nrd,kor WITH bk.kor,nzk WITH gfbs,vo WITH bk.vo,dat WITH bk.dat
    ENDDO
    SELECT bk
ENDIF
RESTORE FROM tek_b ADDITIVE
IF tek_b_38=1.AND.nzk#tek_b_40.AND.!EMPTY(fkp).AND.(fkp#kp.OR.nrd#fnrd.OR.fkor#kor.OR.fdat#dat.OR.vo#fvo.OR.pr_spr#fpr_spr)
    forder=ORDER()
    ffpr_spr=pr_spr
    ffkp=kp
    ffnrd=nrd
    ffdat=dat
    ffvo=vo
    nz=RECNO()
    IF !EMPTY(tek_b_39)
         SELECT 0
         sss=RTRIM(tek_b_39)+'\bk ALIAS bkd'
         USE &sss
    ENDIF
    SET ORDER TO kp_dat
    SET EXACT OFF
    DO WHILE SEEK(tek_b_40+fvo+fpr_spr+fkp+fnrd+DTOC(fdat,1))
         REPLACE kp WITH ffkp,nrd WITH ffnrd,pr_spr WITH ffpr_spr,vo WITH ffvo,dat WITH ffdat
    ENDDO
    SET EXACT ON
    IF !EMPTY(tek_b_39)
         USE
         SELECT bk
    ELSE
         SET ORDER TO &forder
         GO nz
    ENDIF
ENDIF
RELEASE ALL LIKE tek_b_??
IF nastf_8=1.AND.fpr_val.AND.sm_val=0
    SELECT kurs_val
    SET NEAR ON
    SEEK bk.vid_val+DTOC(bk.dat,1)
    SET NEAR OFF
    IF !FOUND()
         SKIP -1
    ENDIF
    IF bk.vid_val=kod.AND.kurs_val.summa#0
         SELECT bk
         REPLACE sm_val WITH ROUND(bk.sm*kurs_val.kurs/kurs_val.summa,2)
    ENDIF
    SELECT bk
ENDIF
IF LASTKEY()=27
    POP KEY
    RETURN
ENDIF
IF nastf_t=1.AND.!EMPTY(dat).AND.(LEFT(kor,2)='10'.OR.LEFT(kor,2)='12').AND.FILE('DV_MOL.DBF').AND.FILE('PR.DBF').AND.FILE('NASTR.MEM')
    DEFINE POPUP Tekm FROM 10,54 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " �\<�室 �� ᪫��       "
    DEFINE BAR 2 OF Tekm PROMPT " ��\<�室 � �ந�����⢮ "
    ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
    ACTIVATE POPUP Tekm
    IF BAR()=0
         RETURN
    ENDIF
    SAVE SCREEN TO scr
    RESTORE FROM nastr ADDITIVE
    SELECT 0
    USE matr
    SET ORDER TO mat
    SELECT 0
    USE kodzk
    SET ORDER TO kodzk
    fnrd=bk.nrd
    fnp=SPACE(10)
    fnsk=SPACE(5)
    fpr_spr=bk.pr_spr
    fkp=bk.kp
    fmat=SPACE(13)
    fdat=bk.dat
    fkol=1
    fbss=SPACE(4)
    fpr_nds=' '
    fnzk=SPACE(6)
    SELECT 0
    DO CASE
    CASE BAR()=1
         USE pr
         SET ORDER TO nsk
         @ 10,22 FILL TO 18,61 COLOR &color20
         SET COLOR TO &color13
         @ 9,21,17,60 BOX box_1
         SET COLOR TO &color14
         @ 10,23 SAY '����� ���㬥��.......' GET fnrd
         @ 11,23 SAY '��� ���㬥��........' GET fdat
         @ 12,23 SAY '����� ���.............' GET fnp
         @ 13,23 SAY '��� ᪫���............' GET fnsk VALID Poisk_ns('fnsk',.T.,0,0,0) ERROR 'H�� ⠪��� ����'
         @ 14,23 SAY '���⠢騪.............' GET fpr_spr VALID fpr_spr='0'.OR.fpr_spr='1'.OR.fpr_spr='2' ERROR "0 - p���⭨�, 1 - �p��������, 2 - ���..."
         @ 14,48 GET fkp VALID IIF(fpr_spr='0',Poisk_ta('fkp',.T.,0,0,0),IIF(fpr_spr='1',Poisk_kl('fkp',.T.,0,0,0),Poisk_ns('fkp',.T.,0,0,0))) ERROR 'H�� ⠪��� ����'
         @ 15,23 SAY '������������ �����..' GET fmat VALID Poisk_mt('fmat',.T.,'bk.kor',0,0,0,0,0,0,0,0,.F.,.F.) ERROR 'H�� ⠪��� ����...'
         @ 16,23 SAY '������⢮............' GET fkol PICTURE '9999999.999'
         READ
         DEFINE POPUP Tekm FROM 18,23 COLOR SCHEME 19 SHADOW
         DEFINE BAR 1 OF Tekm PROMPT " �\<�ନ஢��� ��室�� ���㬥��   "
         DEFINE BAR 2 OF Tekm PROMPT " ��\<�ନ஢��� ��室�� ���㬥�� "
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         SELECT pr
         IF BAR()=1
              APPEND BLANK
              REPLACE bs WITH matr.bs,cen WITH IIF(fkol#0,ROUND(bk.sm/fkol,2),0),dat WITH fdat,;
                     kol WITH fkol,kor WITH bk.nzk,kp WITH fkp,mat WITH fmat,np WITH fnp,npd WITH fnrd,;
                     nsk WITH fnsk,summa WITH bk.sm,vo WITH IIF(fpr_spr='0','06','05')
         ENDIF
         USE
    CASE BAR()=2
         USE dv_mol
         SET ORDER TO nsk
         @ 10,22 FILL TO IIF(bk.kor=nastr_s.OR.bk.kor=nastr_h,20,17),61 COLOR &color20
         SET COLOR TO &color13
         @ 9,21,IIF(bk.kor=nastr_s.OR.bk.kor=nastr_h,19,16),60 BOX box_1
         SET COLOR TO &color14
         @ 10,23 SAY '����� ���㬥��.......' GET fnrd
         @ 11,23 SAY '��� ���㬥��........' GET fdat
         @ 12,23 SAY '����� ���.............' GET fnp
         @ 13,23 SAY '��� ᪫���............' GET fnsk VALID Poisk_ns('fnsk',.T.,0,0,0) ERROR 'H�� ⠪��� ����'
         @ 14,23 SAY '���⠢騪.............' GET fpr_spr VALID fpr_spr='0'.OR.fpr_spr='1'.OR.fpr_spr='2' ERROR "0 - p���⭨�, 1 - �p��������, 2 - ���..."
         @ 14,48 GET fkp VALID IIF(fpr_spr='0',Poisk_ta('fkp',.T.,0,0,0),IIF(fpr_spr='1',Poisk_kl('fkp',.T.,0,0,0),Poisk_ns('fkp',.T.,0,0,0))) ERROR 'H�� ⠪��� ����'
         @ 15,23 SAY '������������ �����..' GET fmat VALID Poisk_mt('fmat',.T.,'bk.kor',0,0,0,0,0,0,0,0,.F.,.F.) ERROR 'H�� ⠪��� ����...'
         @ 16,23 SAY '������⢮............' GET fkol PICTURE '9999999.999'
         IF bk.kor=nastr_s.OR.bk.kor=nastr_h
              @ 17,23 SAY '�����ᮢ� ��� �/�-�' GET fbss VALID Poisk_sc('fbss',.T.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
              @ 18,23 SAY '��� ������............' GET fnzk VALID Poisk_nz('fnzk',.T.,0,0,0) ERROR 'H�� ⠪��� ����...'
         ENDIF
         READ
         DEFINE POPUP Tekm FROM 20,23 COLOR SCHEME 19 SHADOW
         DEFINE BAR 1 OF Tekm PROMPT " �\<�ନ஢��� ��室�� ���㬥��   "
         DEFINE BAR 2 OF Tekm PROMPT " ��\<�ନ஢��� ��室�� ���㬥�� "
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         SELECT dv_mol
         IF BAR()=1
              APPEND BLANK
              REPLACE bs WITH matr.bs,cen WITH IIF(fkol#0,ROUND(bk.sm/fkol,2),0),dat WITH fdat,;
                     kol WITH fkol,kor WITH bk.nzk,kp WITH fkp,mat WITH fmat,np WITH fnp,nrd WITH fnrd,;
                     nsk WITH fnsk,pr_spr WITH fpr_spr,summa WITH bk.sm,vo WITH '0',bss WITH fbss
              REPLACE nzk WITH fnzk
         ENDIF
         USE
    ENDCASE
    RESTORE SCREEN FROM scr
    RELEASE ALL nastr_??
    SELECT matr
    USE
    SELECT kodzk
    USE
    SELECT bk
ENDIF
IF nastf_x=1.AND.nastf_u=kor
    DO F3abk
ENDIF
POP KEY
RETURN
*
PROCEDURE F1bk
PUSH KEY
ON KEY
SET COLOR TO gr+/n
RESTORE FROM tek_b ADDITIVE
i=IIF(prvvod,1,0)+IIF(prudal,1,0)+IIF(prcorr,1,0)+nastf_x+nastf_t+tek_b_38
DEFINE WINDOW Zap_help FROM 0,20 TO 18+i,62 SHADOW
ACTIVATE WINDOW Zap_help
i=0
@  0,0 SAY "           - �।���� ��ப�"
@  1,0 SAY "           - ᫥����� ��ப�"
@  2,0 SAY " PageUp     - �।��騩 ��࠭"
@  3,0 SAY " PageDown   - ᫥���騩 ��࠭"
@  4,0 SAY " ->  (<-)   - ��࠭ ��ࠢ� (�����)"
@  5,0 SAY " Ctrl+Home  - � ��砫� 䠩��"
@  6,0 SAY " Ctrl+End   - � ����� 䠩��"
@  7,0 SAY " Ctrl+Enter - ࠧ������ ��ப�"
@  8,0 SAY " Alt+F1     - ���⥪�⭠� ������"
IF nastf_x=1
    @ 9,0 SAY " Alt+F3     - �ਢ離� � ���ࠧ�������"
    i=i+1
ENDIF
@  9+i,0 SAY " Alt+F4     - ᬥ�� �����ᮢ��� ���"
@ 10+i,0 SAY " Alt+F5     - ���� �� ��㫥"
@ 11+i,0 SAY " Alt+F6     - ���४�஢�� ���.���"
IF tek_b_38=1
    @ 12+i,0 SAY " Alt+F7     - �㡫�஢���� �����"
    i=i+1
ENDIF
RELEASE ALL LIKE tek_b_??
IF nastf_t=1
    @ 12+i,0 SAY " Alt+F8     - ��ᬮ�� ��室� ���ਠ���"
    i=i+1
ENDIF
@ 12+i,0 SAY " Alt+F9     - �ࠢ�筨��"
@ 13+i,0 SAY " Esc        - ��室"
IF prvvod
     @ 14+i,0 SAY " Insert     - ��⠢�� ����� �����"
     i=i+1
ENDIF
IF prcorr
     @ 14+i,0 SAY " Enter      - ���४�஢��� ��ப�"
     i=i+1
ENDIF
IF prudal
     @ 14+i,0 SAY " Delete     - 㤠���� ��ப�"
     i=i+1
ENDIF
@ 14+i,0 SAY " Ctrl+F5     - �롮ઠ ���㬥��"
@ 15+i,0 SAY " Ctrl+F6     - �뤥����� ⥫.ᡮ�"
@ 16+i,0 SAY " Ctrl+F7     - �㡫�஢���� ��ப�"
READ
DEACTIVATE WINDOW Zap_help
POP KEY
RETURN
*
PROCEDURE F2bk
IF gfbs#nzk
    RETURN
ENDIF
PUSH KEY
ON KEY
PRIVATE fnrd,fvo,fdat,nz
nz=RECNO()
@ 11,20 FILL TO 16,48 COLOR &color20
SET COLOR TO &color13
@ 10,19,15,47 BOX box_2
SET COLOR TO &color14
fnrd=SPACE(LEN(nrd))
fkp=SPACE(LEN(kp))
IF pr_spr='0'
@ 12,21 SAY ' ������� �����' GET fkp VALID Poisk_ta('fkp',.T.,0,0,0) ERROR 'H�� ⠪��� ⠡��쭮�� �����...'
ELSE
@ 12,21 SAY ' ��� �࣠����樨' GET fkp VALID Poisk_kl('fkp',.T.,0,0,0) ERROR 'H�� ⠪��� ����...'
ENDIF
@ 13,21 SAY " H���� ���㬥��" GET fnrd
READ
IF EMPTY(fkp)
    POP KEY
    RETURN
ENDIF
SET ORDER TO kp
SET EXACT OFF
IF !SEEK(RTRIM(gfbs+fkp+fnrd))
    DO Net_n WITH 10," H�� ⠪�� ���p��樨. ����p��... "
    GO nz
ENDIF
SET EXACT ON
POP KEY
RETURN
*
PROCEDURE F3bk
IF gfbs#nzk
    RETURN
ENDIF
PUSH KEY
ON KEY
PRIVATE fnrd
nz=RECNO()
@ 11,20 FILL TO 15,49 COLOR &color20
SET COLOR TO &color13
@ 10,19,14,48 BOX "�ͻ���Ⱥ�"
SET COLOR TO &color14
fnrd=SPACE(LEN(bk.nrd))
@ 12,21 SAY " H���� ���㬥��..." GET fnrd
READ
IF LASTKEY()=27
    POP KEY
    RETURN
ENDIF
SET ORDER TO nrd
IF !SEEK(gfbs+fnrd)
    DO Net_n WITH 15," H�� ⠪��� ���㬥��. ����p��... "
    GO nz
ENDIF
POP KEY
RETURN
*
PROCEDURE F4bk
PUSH KEY
ON KEY
PRIVATE fpoisk
fpoisk=0
DEFINE WINDOW Zapros FROM 11,32 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " �㬬�" GET fpoisk PICTURE '999,999,999,999.99'
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    POP KEY
    RETURN
ENDIF
SET ORDER TO summa
SET NEAR ON
SEEK gfbs+STR(fpoisk,15,2)
SET NEAR OFF
IF EOF()
    GO TOP
ENDIF
POP KEY
RETURN
*
PROCEDURE F5bk
PUSH KEY
ON KEY
SET ORDER TO kp_dat
ffnzk=nzk
ffvo=vo
ffdat=dat
ffdati=dati
ffnrd=nrd
ffkor=kor
ffkp=kp
ffkpp=kpp
ffnvx=nvx
ffwid_d=wid_d
ffwid_t=wid_t
fftext_1=text_1
fftext_2=text_2
fftext_3=text_3
fftext_4=text_4
ffpr_spr=pr_spr
ffpr_spk=pr_sprk
ffdat_tov=dat_tov
ffvid_val=vid_val
ffdog=dog
SET EXACT OFF
SEEK gfbs+ffvo+ffpr_spr+ffkp+ffnrd+DTOC(ffdat,1)
SET EXACT ON
DO Vvodn WITH "Chapbb","Strsaybb","Strgetbb",.T.,.T.,.T.,.F.,"(gfbs#nzk.OR.ffvo#vo.OR.ffpr_spr#pr_spr.OR.kp#ffkp.OR.nrd#ffnrd.OR.ffdat#dat)","",;
     "","","","","F6bb","F7bb","F8bb","","","",.T.
SET EXACT OFF
SEEK gfbs+ffvo+ffpr_spr+ffkp+ffnrd+DTOC(ffdat,1)
SET EXACT ON
POP KEY
RETURN
*
PROCEDURE F6bk
IF gfbs#nzk
    RETURN
ENDIF
PUSH KEY
ON KEY
PRIVATE fnrd,nz,scr,fsum
nz=RECNO()
fkp=bk.kp
fnrd=bk.nrd
SET ORDER TO kp
SET EXACT OFF
SEEK gfbs+fkp+fnrd
SET EXACT ON
fsum=0
SCAN REST WHILE gfbs=nzk.AND.fkp=kp.AND.fnrd=bk.nrd FOR !DELETE()
    fsum=fsum+bk.sm
ENDSCAN
DO Net_n WITH 6," �⮣� �� ���㬥��� "+fnrd+". �㬬� "+TRANSFORM(fsum,'999,999,999,999.99')+"."
GO nz
POP KEY
RETURN
*
PROCEDURE F7bk
IF gfbs#nzk
    RETURN
ENDIF
PUSH KEY
ON KEY
PRIVATE fvo,fnzk,nz,scr,fsum
nz=RECNO()
fvo=vo
fnzk=nzk
fdat=dat
SET ORDER TO bk3
SET EXACT OFF
SEEK fnzk+DTOC(fdat,1)+fvo
SET EXACT ON
fsum=0
SCAN REST WHILE fnzk=nzk.AND.fdat=dat.AND.vo=fvo FOR !DELETE()
    fsum=fsum+sm
ENDSCAN
DO Net_n WITH 6,' �⮣� �� '+DTOC(fdat)+' �� ���p�樨 '+fvo+". �㬬� "+TRANSFORM(fsum,'999,999,999,999.99')+"."
GO nz
POP KEY
RETURN
*
PROCEDURE F8bk
IF gfbs#nzk
    RETURN
ENDIF
PUSH KEY
ON KEY
PRIVATE fvo,fnzk,nz,scr,fsum
nz=RECNO()
fvo=vo
fnzk=nzk
fdati=dati
SET ORDER TO bk3
SET EXACT OFF
SEEK fnzk
SET EXACT ON
fsum=0
SCAN REST WHILE fnzk=nzk FOR fdati=dati.AND.vo=fvo.AND.!DELETE()
    fsum=fsum+sm
ENDSCAN
DO Net_n WITH 6,' �⮣� �� '+DTOC(fdati)+' �� ���p�樨 '+fvo+". �㬬� "+TRANSFORM(fsum,'999,999,999,999.99')+"."
GO nz
POP KEY
RETURN
*
PROCEDURE F9bk
IF gfbs#nzk
    RETURN
ENDIF
PUSH KEY
ON KEY
PRIVATE fdat,fkor,nz,scr,fsum,fsum1
nz=RECNO()
fkor=kor
DEFINE WINDOW Zapros FROM 11,32 TO 13,51 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " ����. ��� " GET fkor VALID Poisk_sc('fkor',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    POP KEY
    RETURN
ENDIF
fdat=dat
SET ORDER TO kor_kp
SET EXACT OFF
SEEK gfbs+fkor
SET EXACT ON
IF kor=fkor
    nz=RECNO()
ENDIF
fsum=0
fsum1=0
SCAN REST WHILE fkor=kor FOR MONTH(dat)=ntmec.AND.!DELETE()
    IF fdat=dat
         fsum1=fsum1+IIF(vo='0',sm,-sm)
    ENDIF
    fsum=fsum+IIF(vo='0',sm,-sm)
ENDSCAN
DO Net_n WITH 6,'�⮣� �� '+fkor+' �ᥣ� - '+TRANSFORM(fsum,'999,999,999,999.99')+', �� ���� - '+TRANSFORM(fsum1,'999,999,999,999.99')+'.'
GO nz
POP KEY
RETURN
*
PROCEDURE Udal_bk
PARAMETERS pr_ud
PRIVATE nz
IF nastf_x=1
    PRIVATE pr_net
    SELECT lim_nsk
    SEEK bk.kp+bk.nrd+bk.kor+bk.nzk+bk.vo+DTOC(bk.dat,1)
    pr_net=.F.
    SCAN REST WHILE kp=bk.kp.AND.nrd=bk.nrd.AND.kor=bk.kor.AND.nzk=bk.nzk.AND.vo=bk.vo.AND.dat=bk.dat
         pr_net=.T.
         DELETE
    ENDSCAN
    SELECT bk
ENDIF
RESTORE FROM tek_b ADDITIVE
IF tek_b_38=1.AND.nzk#tek_b_40
    fdat=bk.dat
    fvo=vo
    fpr_usl=pr_usl
    fdati=dati
    fkp=kp
    nz=RECNO()
    IF !EMPTY(tek_b_39)
         SELECT 0
         sss=RTRIM(tek_b_39)+'\bk ALIAS bkd'
         USE &sss
    ENDIF
    SET ORDER TO bk3
    IF SEEK(tek_b_40+DTOC(fdat,1)+fvo+fpr_usl+DTOC(fdati,1)+fkp)
         DELETE
    ENDIF
    IF !EMPTY(tek_b_39)
         USE
         SELECT bk
    ELSE
         GO nz
    ENDIF
ENDIF
RELEASE ALL LIKE tek_b_??
pr_ud=.T.
RETURN
*
PROCEDURE Poisk_kp
PARAMETERS pfile,fprspr,pnstr,ppoz,plen
IF ALIAS()='BK'.AND.nastf_11=1.AND.(EMPTY(bk.kpp).OR.EMPTY(pr_sprk)).AND.SYS(18)='KP'
    REPLACE kpp WITH kp,pr_sprk WITH pr_spr
ENDIF
DO CASE
CASE fprspr='0'
    RETURN Poisk_ta(pfile,.F.,pnstr,ppoz,plen)
CASE fprspr='1'
    RETURN Poisk_kl(pfile,.F.,pnstr,ppoz,plen)
ENDCASE
RETURN .F.
*
PROCEDURE AltH
PRIVATE sss
sss=SYS(18)
RESTORE FROM tek_b ADDITIVE
REPLACE &sss WITH '� �.�.: ��� - '+LTRIM(TRANSFORM(ROUND(sm*tek_b_30/(100.0+tek_b_30+tek_b_31),tek_b_36),'999999999999.99'))+;
                         IIF(tek_b_31=0,'',', �� - '+LTRIM(TRANSFORM(ROUND(sm*tek_b_31/(100.0+tek_b_30+tek_b_31),tek_b_36),'999999999999.99')))
RELEASE ALL LIKE tek_b_??
RETURN
*
PROCEDURE F2abk
PUSH KEY
ON KEY
SET COLOR TO &color13
=SYS(2002,1)
@ nstr,37 GET dat
READ
=SYS(2002)
SET COLOR TO &color12
@ nstr,37 SAY dat
POP KEY
RETURN
*
PROCEDURE F3abk
PUSH KEY
ON KEY
PRIVATE scr
SELECT lim_nsk
SEEK bk.kp+bk.nrd+bk.kor+bk.nzk+bk.vo+DTOC(bk.dat,1)
DO Vvodn WITH "Chapln","Strsayln","Strgetln",.T.,.T.,.T.,.F.,"(kp#bk.kp.OR.nrd#bk.nrd.OR.kor#bk.kor.OR.nzk#bk.nzk.OR.vo#bk.vo.OR.dat#bk.dat)","",;
     "","","F4ln","F5ln","F6ln","","","","","",.T.
SELECT bk
POP KEY
RETURN
*
PROCEDURE F4abk
PRIVATE fff
PUSH KEY
ON KEY
SET COLOR TO &color13
=SYS(2002,1)
fff=gfbs
DEFINE WINDOW Zapros FROM 11,23 TO 13,46 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " �����ᮢ� ���" GET gfbs VALID Poisk_sc('gfbs',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
READ
RELEASE WINDOW Zapros
IF fff#gfbs
    IF spr_bs.pr_prov='1'.AND.glpar#spr_bs.scho3
         DEFINE WINDOW Zapros FROM 11,31 TO 13,46 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " ��஫�"
         SET COLOR TO &color20
         @ 0,8 GET glpar
         READ
         RELEASE WINDOW Zapros
         IF glpar#spr_bs.scho3
              =SYS(2002)
              POP KEY
              gfbs=fff
              RETURN
         ENDIF
    ENDIF
    gpr_val=IIF(nastf_8=0.OR.spr_bs.pr_val='0',.F.,.T.)
    SET ORDER TO kp
    SET EXACT OFF
    SEEK gfbs
    SET EXACT ON
    SET COLOR TO &color21
    @ nstrv-9-IIF(nastf_d=1,1,0),57 SAY gfbs
    SET COLOR TO &color13
    @ nstrv,ncoll CLEAR TO nstrn-1,ncolr
    @ 9,53 SAY IIF(gpr_val,'�����',SPACE(6))+SPACE(12)
    @ 10,53 SAY SPACE(18)
    @ IIF(nastf_d=1,4,5),12 SAY SPACE(6)
    @ IIF(nastf_d=1,5,6),12 SAY SPACE(30)
    @ IIF(nastf_d=1,4,5),60 SAY SPACE(7)
    @ IIF(nastf_d=1,5,6),53 SAY SPACE(16)
    IF nastf_d=1
         @ IIF(nastf_d=1,6,7),12 SAY SPACE(30)
    ENDIF
    ntek=1
    nstr=nstrv
    nzkvvodv=RECNO()
    IF !(EOF().OR.&usl)
         DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
               ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
    ENDIF
    color=IIF(DELETE(),colorv4,colorv2)
    pr_pusto=RECCOUNT()#0.AND.!&usl
    IF pr_pusto
         pr_v_pr=.F.
         DO &Strsay WITH color,nstr,npolscr
         pr_v_pr=.T.
    ENDIF
ENDIF
=SYS(2002)
POP KEY
RETURN
*
PROCEDURE F5abk
PRIVATE fvid,scr,fpr_spr,fnvx,fkp,fnrd,fdat,fdati,fwid_d,fwid_t,ftext_1,ftext_2,ftext_3,ftext_4,i
PUSH KEY
ON KEY
SAVE SCREEN TO scr
SET COLOR TO &color13
=SYS(2002,1)
nz=RECNO()
fvid='  '
SELECT 0
USE spr_vid
SET ORDER TO kod
SELECT bk
@ 16,41 FILL TO 18,58 COLOR &color20
SET COLOR TO &color13
@ 15,40,17,57 BOX "�ͻ���Ⱥ "
SET COLOR TO &color14
@ 16,41 SAY " ��� �p���" GET fvid VALID Poisk_sb('fvid',.T.) ERROR '��� ⠪�� ����...'
READ
RESTORE SCREEN FROM scr
IF EMPTY(fvid)
    SELECT spr_vid
    USE
    SELECT bk
    =SYS(2002)
    POP KEY
    RETURN
ENDIF
* ���� ��������� ���祭��
fpr_spr=' '
fnvx='      '
fkp=SPACE(7)
fnrd=SPACE(6)
fdati=DATE()
fdat=DATE()
fwid_d=0
fwid_t=0
ftext_1=SPACE(50)
ftext_2=SPACE(50)
ftext_3=SPACE(50)
ftext_4=SPACE(50)
SET COLOR TO &color13
@ 7,6 FILL TO 16,75 COLOR &color20
@ 6,5,15,74 BOX "�ͻ���Ⱥ "
SET COLOR TO &color14
@  7, 7 SAY '�� ���� (����).' GET fpr_spr VALID fpr_spr='0'.OR.fpr_spr='1' ERROR '���祭�� 0 - p���⭨�, 1 - �p��������'
@  8, 7 SAY '��� �����⥫� ' GET fkp VALID IIF(fpr_spr='0',Poisk_ta('fkp',.T.,5,12,30),Poisk_kl('fkp',.T.,5,12,30)) ERROR '��� ⠪��� ����...'
@  9, 7 SAY '����� ��室�騩 (�室�騩)' GET fnvx
@ 10, 7 SAY '����� ���㬥��' GET fnrd
@  7,45 SAY '��� ���㬥��.' GET fdati
@  8,45 SAY '��� ������....' GET fdat VALID EMPTY(fdat).OR.nastf_9=0.OR.MONTH(fdat)=ntmec.AND.RIGHT(STR(YEAR(fdat),4),2)=nastf_b ERROR '�����४⭠ ���...'
@  9,45 SAY '��� ���㬥��..' GET fwid_d PICTURE '9' VALID Poisk_wd('fwid_d',.T.,0,0,0) ERROR 'H�� ⠪��� ����...'
@ 10,45 SAY '��� ⥪��.....' GET fwid_t PICTURE '99' VALID Poisk_wt('fwid_t',.T.) ERROR 'H�� ⠪��� ����...'
@ 11, 7 SAY '����� ���㬥��' GET ftext_1
@ 12,23 GET ftext_2
@ 13,23 GET ftext_3
@ 14,23 GET ftext_4
READ
IF LASTKEY()=27
    SELECT spr_vid
    USE
    SELECT bk
    =SYS(2002)
    POP KEY
    RESTORE SCREEN FROM scr
    RETURN
ENDIF
*
SET ORDER TO kp
SELECT spr_bs
SET ORDER TO bs
SELECT spr_vid
SET EXACT OFF
SEEK fvid
SET EXACT ON
RESTORE SCREEN FROM scr
SET COLOR TO &color14
i=0
SCAN REST WHILE kod=fvid FOR pr_kor='0'.AND.!DELETE()
    i=i+1
    fobozn=spr_vid.obozn
    &fobozn=0
    @ 5+i,14 SAY ' '+spr_vid.nam GET &fobozn PICTURE '999,999,999,999.99'
ENDSCAN
SET COLOR TO &color13
@ 5,13 TO i+6,59 DOUBLE
@ i+7,14 FILL TO i+7,60 COLOR &color20
@ 6,60 FILL TO i+7,60 COLOR &color20
SET COLOR TO &color14
READ
=SYS(2002)
IF LASTKEY()=27
    SELECT spr_vid
    USE
    SELECT bk
    POP KEY
    RESTORE SCREEN FROM scr
    RETURN
ENDIF
SELECT 0
USE bkr EXCLUSIVE
ZAP
INDEX ON nzk+kp+nrd+DTOC(dat,1)+kor TAG rab
SELECT spr_vid
SET EXACT OFF
SEEK fvid
SET EXACT ON
SCAN REST WHILE kod=fvid FOR pr_kor='1'.AND.!DELETE()
    fobozn=spr_vid.obozn
    fform=spr_vid.form
    SELECT bkr
    APPEND BLANK
    REPLACE kp WITH fkp,nrd WITH fnrd,pr_spr WITH fpr_spr,;
           dat WITH fdat,dati WITH fdati,nvx WITH fnvx,wid_d WITH fwid_d,;
         wid_t WITH fwid_t,text_1 WITH ftext_1,text_2 WITH ftext_2,text_3 WITH ftext_3,text_4 WITH ftext_4
    IF LEFT(spr_vid.bs,1)='5'.OR.LEFT(spr_vid.kor,1)#'5'
         REPLACE vo WITH '0',kor WITH spr_vid.kor,nzk WITH spr_vid.bs
    ELSE
         REPLACE vo WITH '1',kor WITH spr_vid.bs,nzk WITH spr_vid.kor
    ENDIF
    IF EMPTY(spr_vid.form)
         &fobozn=sm
    ELSE
         &fobozn=&fform
         REPLACE sm WITH &fobozn
         IF !EMPTY(spr_vid.vid_val)
              sss=spr_vid.vid_val
              ssss=spr_vid.formv
              REPLACE vid_val WITH &sss,sm_val WITH &ssss
         ENDIF
    ENDIF
ENDSCAN
USE
SELECT bkr
RESTORE SCREEN FROM scr
SET COLOR TO &color14
@ 6,25 SAY ' �����  �।��       �㬬�      '
i=1
SCAN
    i=i+1
    @ 5+i,25 SAY '  '+IIF(vo='0',nzk+'    '+kor,kor+'    '+nzk)+' '+TRANSFORM(sm,'999,999,999,999.99')+' '
ENDSCAN
SET COLOR TO &color13
@ 5,24 TO i+6,59 DOUBLE
@ i+7,25 FILL TO i+7,60 COLOR &color20
@ 6,60 FILL TO i+7,60 COLOR &color20
DEFINE POPUP Tekm FROM i+7,29 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Tekm PROMPT " �\<�ନ஢��� �஢����   "
DEFINE BAR 2 OF Tekm PROMPT " ��\<�ନ஢��� �஢���� "
ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
ACTIVATE POPUP Tekm
SET COLOR TO &color14
SCAN FOR BAR()=1.AND.(sm#0.OR.sm_val#0)
    SELECT bk
    IF SEEK(bkr.nzk+bkr.kp+bkr.nrd+DTOC(bkr.dat,1)+bkr.kor).AND.DELETE()
         RECALL
    ELSE
         APPEND BLANK
         REPLACE nzk WITH bkr.nzk,kp WITH bkr.kp,nrd WITH bkr.nrd,dat WITH bkr.dat,kor WITH bkr.kor
    ENDIF
    REPLACE pr_spr WITH bkr.pr_spr,dati WITH bkr.dati,nvx WITH bkr.nvx,wid_d WITH bkr.wid_d,;
             wid_t WITH bkr.wid_t,text_1 WITH bkr.text_1,text_2 WITH bkr.text_2,text_3 WITH bkr.text_3,text_4 WITH bkr.text_4,;
                vo WITH bkr.vo,sm WITH bkr.sm,vid_val WITH bkr.vid_val,sm_val WITH bkr.sm_val
ENDSCAN
ZAP
DELETE TAG rab
USE
*
RESTORE SCREEN FROM scr
SELECT bk
SET ORDER TO kp
SET EXACT OFF
SEEK gfbs
SET EXACT ON
SET COLOR TO &color13
@ nstrv,ncoll CLEAR TO nstrn-1,ncolr
ntek=1
nstr=nstrv
nzkvvodv=RECNO()
IF !(EOF().OR.&usl)
    DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
          ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
ENDIF
color=IIF(DELETE(),colorv4,colorv2)
pr_pusto=RECCOUNT()#0.AND.!&usl
IF pr_pusto
    pr_v_pr=.F.
    DO &Strsay WITH color,nstr,npolscr
    pr_v_pr=.T.
ENDIF
POP KEY
RETURN
*
PROCEDURE F6abk
IF gfbs#nzk
    RETURN
ENDIF
PRIVATE scr
PUSH KEY
ON KEY
SAVE SCREEN TO scr
SET COLOR TO &color13
=SYS(2002,1)
@ nstrv-9-IIF(nastf_d=1,1,0),57 GET nzk VALID Poisk_sc('bk.nzk',.F.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
READ
IF nzk#gfbs
    gfbs=nzk
    IF spr_bs.pr_prov='1'.AND.glpar#spr_bs.scho3
         DEFINE WINDOW Zapros FROM 11,31 TO 13,46 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " ��஫�"
         SET COLOR TO &color20
         @ 0,8 GET glpar
         READ
         RELEASE WINDOW Zapros
         IF glpar#spr_bs.scho3
              =SYS(2002)
              POP KEY
              RETURN
         ENDIF
    ENDIF
    gpr_val=IIF(nastf_8=0.OR.spr_bs.pr_val='0',.F.,.T.)
    SET ORDER TO kp
    SET EXACT OFF
    SEEK gfbs
    SET EXACT ON
    SET COLOR TO &color13
    @ nstrv,ncoll CLEAR TO nstrn-1,ncolr
    @ nstrv-9-IIF(nastf_d=1,1,0),57 SAY gfbs
    @ 9,53 SAY IIF(gpr_val,'�����',SPACE(6))+SPACE(12)
    @ 10,53 SAY SPACE(18)
    ntek=1
    nstr=nstrv
    nzkvvodv=RECNO()
    IF !(EOF().OR.&usl)
         DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
               ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
    ENDIF
    color=IIF(DELETE(),colorv4,colorv2)
    pr_pusto=RECCOUNT()#0.AND.!&usl
    IF pr_pusto
         pr_v_pr=.F.
         DO &Strsay WITH color,nstr,npolscr
         pr_v_pr=.T.
    ENDIF
ELSE
    RESTORE SCREEN FROM scr
ENDIF
=SYS(2002)
POP KEY
RETURN
*
PROCEDURE F7abk
PRIVATE scr,nz
PUSH KEY
ON KEY
fkor='    '
SAVE SCREEN TO scr
SET COLOR TO &color13
=SYS(2002,1)
DEFINE WINDOW Zapros FROM 11,31 TO 13,46 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " �/���" GET fkor VALID Poisk_sc('fkor',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
READ
RELEASE WINDOW Zapros
IF EMPTY(fkor)
    =SYS(2002)
    POP KEY
    RETURN
ENDIF
RESTORE FROM tek_b ADDITIVE
forder=ORDER()
fdat=dat
fvo=vo
fpr_usl=pr_usl
fdati=dati
fkp=kp
fkpp=kpp
fdat_tov=dat_tov
fdog=dog
fwid_d=wid_d
fnrd=nrd
fnvx=nvx
fnazn_pl=nazn_pl
fpr_spr=pr_spr
fpr_sprk=pr_sprk
fsm=sm
fwid_t=wid_t
fsm_val=sm_val
ftext_1=text_1
ftext_2=text_2
ftext_3=text_3
ftext_4=text_4
fvid_op=vid_op
fvid_val=vid_val
nz=RECNO()
IF !EMPTY(tek_b_39)
    SELECT 0
    sss=RTRIM(tek_b_39)+'\bk ALIAS bkd'
    USE &sss
ENDIF
SET ORDER TO kp_dat
IF !SEEK(tek_b_40+fvo+fpr_spr+fkp+fnrd+DTOC(fdat,1)+fkor)
    APPEND BLANK
    REPLACE nzk WITH tek_b_40,dat WITH fdat,kp WITH fkp,nrd WITH fnrd,kor WITH fkor,;
             vo WITH fvo,pr_spr WITH fpr_spr
ENDIF
REPLACE pr_usl WITH fpr_usl,dati WITH fdati,kpp WITH fkpp,pr_sprk WITH fpr_sprk
REPLACE dat_tov WITH fdat_tov,dog WITH fdog,wid_d WITH fwid_d,;
            nvx WITH fnvx,nazn_pl WITH fnazn_pl,sm WITH fsm,;
          wid_t WITH fwid_t,sm_val WITH fsm_val,text_1 WITH ftext_1
REPLACE text_2 WITH ftext_2,text_3 WITH ftext_3,text_4 WITH ftext_4,vid_op WITH fvid_op,;
       vid_val WITH fvid_val
IF !EMPTY(tek_b_39)
    USE
    SELECT bk
ELSE
    SET ORDER TO &forder
    GO nz
ENDIF
RELEASE ALL LIKE tek_b_??
=SYS(2002)
POP KEY
RETURN
*
PROCEDURE F8abk
PUSH KEY
ON KEY
DEFINE POPUP Tekm FROM 10,54 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Tekm PROMPT " �\<�室 �� ᪫��       "
DEFINE BAR 2 OF Tekm PROMPT " ��\<�室 � �ந�����⢮ "
ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
ACTIVATE POPUP Tekm
IF BAR()=0
    RETURN
ENDIF
SELECT 0
USE matr
SET ORDER TO mat
SELECT 0
DO CASE
CASE BAR()=1
	USE so
	SET ORDER TO vo
	SELECT 0
    USE pr
    SET ORDER TO npd
    IF SEEK(bk.nrd)
         DO Vvodn WITH "Chappr","Strsaypr","",.F.,.F.,.T.,.F.,"bk.nrd#npd","","","","","","","","","","","",.T.
    ENDIF
    USE
    SELECT so
CASE BAR()=2
    USE dv_mol
    SET ORDER TO kp
    IF SEEK('0'+bk.nrd)
         DO Vvodn WITH "Chapdm","Strsaydm","",.F.,.F.,.T.,.F.,"(vo#'0'.OR.bk.nrd#nrd)","","","","","","","","","","","",.T.
    ENDIF
ENDCASE
USE
SELECT matr
USE
SELECT bk
POP KEY
RETURN
*
PROCEDURE F5cbk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fkp,scr,fnrd,fdat,fpr_spr,nz
nz=RECNO()
PUSH KEY
ON KEY
SAVE SCREEN TO scr
SET COLOR TO &color13
=SYS(2002,1)
fpr_spr=' '
fkp=SPACE(7)
fnrd=SPACE(6)
fdat=CTOD('  /  /  ')
@ 16,41 FILL TO 20,68 COLOR &color20
SET COLOR TO &color13
@ 15,40,19,67 BOX "�ͻ���Ⱥ "
SET COLOR TO &color14
@ 16,41 SAY " ��� �࣠�/ࠡ��" GET fpr_spr VALID fpr_spr='0'.OR.fpr_spr='1' ERROR '0 - ࠡ�⭨�, 1 - �࣠������...'
@ 16,60 GET fkp VALID IIF(fpr_spr='0',Poisk_ta('fkp',.T.,0,0,0),Poisk_kl('fkp',.T.,0,0,0)) ERROR 'H�� ⠪��� ����...'
@ 17,41 SAY " ����� ���㬥��" GET fnrd
@ 18,41 SAY " ��� ���㬥��." GET fdat
READ
RESTORE SCREEN FROM scr
IF LASTKEY()=27.OR.EMPTY(fkp)
    =SYS(2002)
    POP KEY
    RETURN
ENDIF
SET FILTER TO nrd=fnrd.AND.fkp=kp.AND.fpr_spr=pr_spr.AND.fnrd=nrd.AND.dat=fdat
GO TOP
IF EOF()
    SET FILTER TO
    DO Net_n WITH 10," H�� ⠪�� ���ଠ樨. ������... "
ELSE
    ACTIVATE SCREEN
    DEFINE POPUP Listfrag FROM 8,10 TO 18,70 COLOR SCHEME 17 SHADOW IN SCREEN PROMPT FIELD '  '+vo+'  '+nzk+' '+kor+' '+pr_spr+' '+kp+' '+nvx+' '+DTOC(dati)+' '+TRANSFORM(sm,'999,999,999,999.99');
           TITLE ' ���㬥�� '+RTRIM(fnrd)+' �� '+DTOC(fdat)+' �� '+RTRIM(Spr_nam(fpr_spr,fkp,30)) SCROLL
    ON SELECTION POPUP Listfrag DEACTIVATE POPUP Listfrag
    ACTIVATE POPUP Listfrag
    SET FILTER TO
    nz=RECNO()
ENDIF
*
RESTORE SCREEN FROM scr
GO nz
gfbs=nzk
SELECT bk
SET ORDER TO kp
SET COLOR TO &color13
@ nstrv,ncoll CLEAR TO nstrn-1,ncolr
ntek=1
nstr=nstrv
nzkvvodv=RECNO()
IF !(EOF().OR.&usl)
    DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
          ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
ENDIF
color=IIF(DELETE(),colorv4,colorv2)
pr_pusto=RECCOUNT()#0.AND.!&usl
IF pr_pusto
    pr_v_pr=.F.
    DO &Strsay WITH color,nstr,npolscr
    pr_v_pr=.T.
ENDIF
POP KEY
RETURN
*
PROCEDURE F6cbk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fkp,scr,fkor,fpr_spr,nz,fsum
nz=RECNO()
PUSH KEY
ON KEY
SAVE SCREEN TO scr
SET COLOR TO &color13
=SYS(2002,1)
fpr_spr=' '
fkp=SPACE(7)
fkor=SPACE(4)
RESTORE FROM tek_b ADDITIVE
fsum=tek_b_29
RELEASE ALL LIKE tek_b_??
@ 16,41 FILL TO 20,70 COLOR &color20
SET COLOR TO &color13
@ 15,40,19,69 BOX "�ͻ���Ⱥ "
SET COLOR TO &color14
@ 16,41 SAY " ��� �࣠�/ࠡ��" GET fpr_spr VALID fpr_spr='0'.OR.fpr_spr='1' ERROR '0 - ࠡ�⭨�, 1 - �࣠������...'
@ 16,60 GET fkp VALID IIF(fpr_spr='0',Poisk_ta('fkp',.T.,0,0,0),Poisk_kl('fkp',.T.,0,0,0)) ERROR 'H�� ⠪��� ����...'
@ 17,41 SAY " ����ᯮ��.���" GET fkor VALID Poisk_sc('fkor',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
@ 18,41 SAY " �㬬� ᡮ�" GET fsum PICTURE '999,999,999.99'
READ
RESTORE SCREEN FROM scr
IF LASTKEY()=27.OR.EMPTY(fkp).OR.EMPTY(fkor).OR.fsum=0
    =SYS(2002)
    POP KEY
    RETURN
ENDIF
ffnzk=nzk
ffvo=vo
ffdat=dat
ffdati=dati
ffnrd=nrd
ffkpp=kpp
ffnvx=nvx
ffwid_d=wid_d
ffwid_t=wid_t
fftext_1=text_1
fftext_2=text_2
fftext_3=text_3
fftext_4=text_4
ffpr_spk=pr_sprk
ffdat_tov=dat_tov
ffvid_val=vid_val
ffdog=dog
REPLACE sm WITH sm-fsum
APPEND BLANK
REPLACE dati WITH ffdati,wid_d WITH ffwid_d,wid_t WITH ffwid_t,;
        kp WITH fkp,nrd WITH ffnrd,dat WITH ffdat,pr_spr WITH fpr_spr,;
       kpp WITH ffkpp,pr_sprk WITH ffpr_spk,vid_val WITH ffvid_val
REPLACE vo WITH ffvo,nzk WITH ffnzk,nvx WITH ffnvx,kor WITH fkor,;
        sm WITH fsum
REPLACE dat_tov WITH ffdat_tov,text_1 WITH fftext_1,text_2 WITH fftext_2,;
        text_3 WITH fftext_3,text_4 WITH fftext_4,dog WITH ffdog
GO nz
SET COLOR TO &color13
@ nstrv,ncoll CLEAR TO nstrn-1,ncolr
ntek=1
nstr=nstrv
nzkvvodv=RECNO()
IF !(EOF().OR.&usl)
    DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
          ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
ENDIF
color=IIF(DELETE(),colorv4,colorv2)
pr_pusto=RECCOUNT()#0.AND.!&usl
IF pr_pusto
    pr_v_pr=.F.
    DO &Strsay WITH color,nstr,npolscr
    pr_v_pr=.T.
ENDIF
POP KEY
RETURN
*
PROCEDURE F7cbk
IF RECCOUNT()=0
    RETURN
ENDIF
PUSH KEY
PRIVATE fkp,scr,fkor,fpr_spr,nz,fsum
ffnzk=nzk
ffvo=vo
ffdat=dat
ffdati=dati
ffnrd=nrd
ffkor=kor
ffkp=kp
ffkpp=kpp
ffnvx=nvx
ffwid_d=wid_d
ffwid_t=wid_t
fftext_1=text_1
fftext_2=text_2
fftext_3=text_3
fftext_4=text_4
ffpr_spr=pr_spr
ffpr_spk=pr_sprk
ffdat_tov=dat_tov
ffvid_val=vid_val
ffdog=dog
APPEND BLANK
REPLACE dati WITH ffdati,wid_d WITH ffwid_d,wid_t WITH ffwid_t,;
        kp WITH ffkp,nrd WITH ffnrd,dat WITH ffdat,pr_spr WITH ffpr_spr,;
       kpp WITH ffkpp,pr_sprk WITH ffpr_spk,vid_val WITH ffvid_val
REPLACE vo WITH ffvo,nzk WITH ffnzk,nvx WITH ffnvx,kor WITH ffkor
REPLACE dat_tov WITH ffdat_tov,text_1 WITH fftext_1,text_2 WITH fftext_2,;
        text_3 WITH fftext_3,text_4 WITH fftext_4,dog WITH ffdog
SET COLOR TO &color13
@ nstrv,ncoll CLEAR TO nstrn-1,ncolr
ntek=1
nstr=nstrv
nzkvvodv=RECNO()
IF !(EOF().OR.&usl)
    DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
          ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
ENDIF
color=IIF(DELETE(),colorv4,colorv2)
pr_pusto=RECCOUNT()#0.AND.!&usl
IF pr_pusto
    pr_v_pr=.F.
    DO &Strsay WITH color,nstr,npolscr
    pr_v_pr=.T.
ENDIF
POP KEY
RETURN
*
PROCEDURE Ctr_bk
IF RECCOUNT()=0
    RETURN
ENDIF
PUSH KEY
ON KEY
=SYS(2002,1)
PRIVATE scr
SAVE SCREEN TO scr
SET COLOR TO &color13
@ 0,0,23,79 BOX "�ͻ���Ⱥ "
@  4,0 SAY '�'+REPLICATE('�',78)+'�'
@ 10,0 SAY '�'+REPLICATE('�',78)+'�'
@ 14,0 SAY '�'+REPLICATE('�',78)+'�'
@ 17,0 SAY '�'+REPLICATE('�',78)+'�'
SET COLOR TO &color14
@  1, 1 SAY '��� ����樨...' GET vo VALID vo='0'.OR.vo='1' ERROR '0 - ��室, 1 - ��室...'
@  1,20 SAY IIF(vo='0','��室','���室')
@  2, 1 SAY '�� ���� (����).' GET pr_spr VALID pr_spr='0'.OR.pr_spr='1' ERROR '���祭�� 0 - p���⭨�, 1 - �p��������'
@  2,19 SAY ' 0 - p���⭨�, 1 - �p��������'
@  3, 1 SAY '�����ᮢ� ��� '+nzk
@  3,25 SAY '����ᯮ������騩 ���' GET kor VALID Poisk_sc('bk.kor',.F.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
@  2,51 SAY '����� ��室�騩 (�室�騩)'
@  3,69 GET nvx
@  5, 1 SAY '��� �����⥫�'
@  6, 4 SAY '(���⥫�騪�)'
@  7, 6 GET kp VALID IIF(pr_spr='0',Poisk_ta('bk.kp',.F.,5,38,30),Poisk_kl('bk.kp',.F.,5,38,30)) ERROR '��� ⠪��� ����...'
IF pr_spr='0'
    @  5,25 SAY '������� �.�.' GET sprrab.fio
ELSE
    @  5,25 SAY '������������' GET skl.ikl
    @  6,21 SAY '���.������������' GET skl.ikld
    @  7,33 GET skl.ikldd
    @  8,22 SAY '�⤥����� �����' GET skl.otd
    @  9,22 SAY '������ ��� ' GET skl.sch
    @  9,55 SAY '�ਧ��� ॣ����' GET skl.pr_reg VALID Poisk_tg('skl.pr_reg') ERROR 'H�� ⠪��� ����...'
ENDIF
@ 11, 1 SAY '����� ���㬥��' GET nrd
@ 12, 1 SAY '��� ���㬥��.' GET dati
@ 13, 1 SAY '��� ������....' GET dat VALID EMPTY(dat).OR.nastf_9=0.OR.MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(fdat),4),2)=nastf_b ERROR '�����४⭠ ���...'
@ 11,40 SAY '��� ������' GET vid_val VALID nastf_8=0.OR.Poisk_wl('bk.vid_val',.F.,0,0,0) ERROR 'H�� ⠪�� ������...'
@ 11,60 SAY '����'+STR(IIF(sm_val=0,0,ROUND(sm/sm_val,5)),15,5)
@ 12,36 SAY '�㬬� � �����' GET sm_val
@ 13,36 SAY '�㬬� � �㡫��' GET sm
@ 15, 1 SAY '��� ����祭�� ⮢�p�' GET dat_tov
@ 16, 1 SAY '������p..............' GET dog VALID nastf_i=0.OR.kor#nastf_j.OR.Poisk_kr('bk.dog',.F.) ERROR '��� ⠪��� �������...'
@ 15,44 SAY 'H����祭�� ���⥦�...' GET nazn_pl
@ 16,44 SAY '��� ���p�樨' GET vid_op
@ 16,62 SAY '��� ����⥪�' GET pr_usl VALID nastf_5=0.OR.Poisk_kt(.F.,'bk.pr_usl') ERROR 'H�� ⠪��� ����...'
@ 18, 1 SAY '��� ���㬥��..' GET wid_d VALID Poisk_wd('bk.wid_d',.F.,18,19,30) ERROR 'H�� ⠪��� ����...'
@ 18,51 SAY '��� ⥪��.....' GET wid_t VALID Poisk_wt('bk.wid_t',.F.) ERROR 'H�� ⠪��� ����...'
@ 19, 1 SAY '����� ���㬥��' GET text_1
@ 20,17 GET text_2
@ 21,17 GET text_3
@ 22,17 GET text_4
READ
=SYS(2002)
RESTORE SCREEN FROM scr
color=IIF(DELETE(),'gr+/gr',"w+/n")
DO &Strsay WITH color,nstr,npolscr
POP KEY
RETURN
*
PROCEDURE Repl_sum
PARAMETERS fiel_rep,fvid_val,fsm_val,fdat,nstr,npoz
REPLACE &fiel_rep WITH Kurs_dat(fvid_val,fdat,fsm_val)
IF !EMPTY(nstr)
    @ nstr,npoz SAY &fiel_rep PICTURE '999,999,999,999.99'
ENDIF
RETURN .T.
*
PROCEDURE Nom_doc
IF gfbs#nzk
    RETURN .T.
ENDIF
PRIVATE fnrd
IF nastf_a=1
    SELECT 0
    USE spr_nrd
    SET ORDER TO nrd
    SET EXACT OFF
    SEEK bk.nzk+bk.vo
    SET EXACT ON
    fnrd=nrd+1
    REPLACE nrd WITH fnrd
    USE
    SELECT bk
    REPLACE nrd WITH LTRIM(STR(fnrd,6))
ENDIF
RETURN .T.
*
PROCEDURE Chapbb
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=4
nstrn=7
ncoll=54
ncolr=76
step=1
npolscrm=1
@ nstrv-2,ncoll FILL TO nstrv+5,ncolr+2 COLOR &color20
SET COLOR TO &color4
@ nstrv-3,ncoll-1,nstrv+3,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-3,ncoll-1 SAY "������"
@ nstrv-2,ncoll-1 SAY "��/��      �㬬�"
@ nstrv-1,ncoll-1 SAY "�����������������������Ķ"
@ nstrv+3,ncoll-1 SAY "�F6�������F7-� �.�᫥�"
@ nstrv+4,ncoll-1 SAY "��� F8 - ᢥ���� �����ͼ"
RETURN
*
PROCEDURE Strsaybb
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,54 SAY kor
@ nstr,59 SAY sm PICTURE '999,999,999,999.99'
RETURN
*
PROCEDURE Strgetbb
PARAMETERS nstr,npolscr
IF EMPTY(nzk)
    REPLACE dati WITH ffdati,wid_d WITH ffwid_d,wid_t WITH ffwid_t,;
            kp WITH ffkp,nrd WITH ffnrd,dat WITH ffdat,pr_spr WITH ffpr_spr,;
           kpp WITH ffkpp,pr_sprk WITH ffpr_spk,vid_val WITH ffvid_val
    REPLACE vo WITH ffvo,nzk WITH ffnzk,nvx WITH ffnvx,kor WITH ffkor
    REPLACE dat_tov WITH ffdat_tov,text_1 WITH fftext_1,text_2 WITH fftext_2,;
            text_3 WITH fftext_3,text_4 WITH fftext_4,dog WITH ffdog
ENDIF
@ nstr,54 GET kor VALID Poisk_sc('bk.kor',.F.,.F.,0,0,0,' ','.F.') ERROR " H�� ⠪��� ���..."
@ nstr,59 GET sm PICTURE '999,999,999,999.99'
READ
RETURN
*
PROCEDURE F6bb
PRIVATE fsm,scr,fnds,fsp
fnds=SPACE(4)
fsp=SPACE(4)
SAVE SCREEN TO scr
RESTORE FROM tek_b ADDITIVE
@ 18,41 FILL TO IIF(tek_b_31=0,20,21),70 COLOR &color20
SET COLOR TO &color13
@ 17,40,IIF(tek_b_31=0,19,20),69 BOX "�ͻ���Ⱥ "
SET COLOR TO &color14
@ 18,41 SAY ' ����.��� ���.......' GET fnds VALID Poisk_sc('fnds',.T.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
IF tek_b_31#0
    @ 19,41 SAY ' ����.��� ᯥ歠����' GET fsp  VALID Poisk_sc('fsp',.T.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
ENDIF
READ
RESTORE SCREEN FROM scr
IF LASTKEY()=27.AND.READKEY()#271
    RELEASE ALL LIKE tek_b_??
    RETURN
ENDIF
fsm=sm
fsm_val=sm_val
SET ORDER TO kp_dat
IF tek_b_30#0
    IF SEEK(gfbs+ffvo+ffpr_spr+ffkp+ffnrd+DTOC(ffdat,1)+fnds)
         RECALL
    ELSE
         APPEND BLANK
         REPLACE kp WITH ffkp,nrd WITH ffnrd,kor WITH fnds,nzk WITH gfbs,pr_spr WITH ffpr_spr,;
                 vo WITH ffvo,dat WITH ffdat,dati WITH ffdati,nvx WITH ffnvx,;
                kpp WITH ffkpp,pr_sprk WITH ffpr_spk,dog WITH ffdog,vid_val WITH ffvid_val
         REPLACE wid_d WITH ffwid_d,wid_t WITH ffwid_t,dat_tov WITH ffdat_tov,;
                text_1 WITH fftext_1,text_2 WITH fftext_2,text_3 WITH fftext_3,text_4 WITH fftext_4
    ENDIF
    REPLACE sm WITH ROUND(fsm*tek_b_30/100.0,tek_b_36)
    REPLACE sm_val WITH ROUND(fsm_val*tek_b_30/100.0,tek_b_36)
ENDIF
IF tek_b_31#0
    IF SEEK(gfbs+ffvo+ffpr_spr+ffkp+ffnrd+DTOC(ffdat,1)+fsp)
         RECALL
    ELSE
         APPEND BLANK
         REPLACE kp WITH ffkp,nrd WITH ffnrd,kor WITH fsp,nzk WITH gfbs,pr_spr WITH ffpr_spr,;
                 vo WITH ffvo,dat WITH ffdat,dati WITH ffdati,nvx WITH ffnvx,;
                kpp WITH ffkpp,pr_sprk WITH ffpr_spk,dog WITH ffdog,vid_val WITH ffvid_val
         REPLACE wid_d WITH ffwid_d,wid_t WITH ffwid_t,dat_tov WITH ffdat_tov,;
                text_1 WITH fftext_1,text_2 WITH fftext_2,text_3 WITH fftext_3,text_4 WITH fftext_4
    ENDIF
    REPLACE sm WITH ROUND(fsm*tek_b_31/100.0,tek_b_36)
    REPLACE sm_val WITH ROUND(fsm_val*tek_b_31/100.0,tek_b_36)
ENDIF
RELEASE ALL LIKE tek_b_??
SET EXACT OFF
SEEK gfbs+ffvo+ffpr_spr+ffkp+ffnrd+DTOC(ffdat,1)
SET EXACT ON
RETURN
*
PROCEDURE F7bb
PRIVATE fsm,scr,fnds,fsp,nz
fnds=SPACE(4)
fsp=SPACE(4)
nz=RECNO()
SAVE SCREEN TO scr
RESTORE FROM tek_b ADDITIVE
@ 18,41 FILL TO IIF(tek_b_31=0,20,21),70 COLOR &color20
SET COLOR TO &color13
@ 17,40,IIF(tek_b_31=0,19,20),69 BOX "�ͻ���Ⱥ "
SET COLOR TO &color14
@ 18,41 SAY ' ����.��� ���.......' GET fnds VALID Poisk_sc('fnds',.T.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
IF tek_b_31#0
    @ 19,41 SAY ' ����.��� ᯥ歠����' GET fsp  VALID Poisk_sc('fsp',.T.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
ENDIF
READ
RESTORE SCREEN FROM scr
IF LASTKEY()=27.AND.READKEY()#271
    RELEASE ALL LIKE tek_b_??
    RETURN
ENDIF
fsm=sm
fsm_val=sm_val
REPLACE sm WITH ROUND(fsm*100.0/(100.0+tek_b_30+tek_b_31),tek_b_36)
REPLACE sm_val WITH ROUND(fsm_val*100.0/(100.0+tek_b_30+tek_b_31),tek_b_36)
ff1=sm
ff1v=sm_val
IF tek_b_30#0
    APPEND BLANK
    REPLACE kp WITH ffkp,nrd WITH ffnrd,kor WITH fnds,nzk WITH gfbs,pr_spr WITH ffpr_spr,;
            vo WITH ffvo,dat WITH ffdat,dati WITH ffdati,nvx WITH ffnvx,;
           kpp WITH ffkpp,pr_sprk WITH ffpr_spk,dog WITH ffdog,vid_val WITH ffvid_val
    REPLACE wid_d WITH ffwid_d,wid_t WITH ffwid_t,dat_tov WITH ffdat_tov,;
           text_1 WITH fftext_1,text_2 WITH fftext_2,text_3 WITH fftext_3,text_4 WITH fftext_4
    REPLACE sm WITH ROUND(fsm*tek_b_30/(100.0+tek_b_30+tek_b_31),tek_b_36)
    REPLACE sm_val WITH ROUND(fsm_val*tek_b_30/(100.0+tek_b_30+tek_b_31),tek_b_36)
    ff1=ff1+sm
    ff1v=ff1v+sm_val
ENDIF
IF tek_b_31#0
    APPEND BLANK
    REPLACE kp WITH ffkp,nrd WITH ffnrd,kor WITH fsp,nzk WITH gfbs,pr_spr WITH ffpr_spr,;
            vo WITH ffvo,dat WITH ffdat,dati WITH ffdati,nvx WITH ffnvx,;
           kpp WITH ffkpp,pr_sprk WITH ffpr_spk,dog WITH ffdog,vid_val WITH ffvid_val
    REPLACE wid_d WITH ffwid_d,wid_t WITH ffwid_t,dat_tov WITH ffdat_tov,;
           text_1 WITH fftext_1,text_2 WITH fftext_2,text_3 WITH fftext_3,text_4 WITH fftext_4
    REPLACE sm WITH ROUND(fsm*tek_b_31/(100.0+tek_b_30+tek_b_31),tek_b_36),;
        sm_val WITH ROUND(fsm_val*tek_b_31/(100.0+tek_b_30+tek_b_31),tek_b_36)
    ff1=ff1+sm
    ff1v=ff1v+sm_val
ENDIF
RELEASE ALL LIKE tek_b_??
IF fsm-ff1#0.OR.fsm_val-ff1v#0
    GO nz
    REPLACE sm WITH sm+fsm-ff1,sm_val WITH sm_val+fsm_val-ff1v
ENDIF
SET EXACT OFF
SEEK gfbs+ffvo+ffpr_spr+ffkp+ffnrd+DTOC(ffdat,1)
SET EXACT ON
RETURN
*
PROCEDURE F8bb
PRIVATE fsm,fsm_val,nz
IF RECCOUNT()=0
    RETURN
ENDIF
fsm=0
fsm_val=0
nz=RECNO()
SET EXACT OFF
SEEK gfbs+ffvo+ffpr_spr+ffkp+ffnrd+DTOC(ffdat,1)
SET EXACT ON
SCAN REST WHILE nzk=gfbs.AND.vo=ffvo.AND.pr_spr=ffpr_spr.AND.kp=ffkp.AND.nrd=nrd.AND.dat=ffdat FOR !DELETE()
    fsm=fsm+sm
    fsm_val=fsm_val+sm_val
    IF RECNO()#nz
         DELETE
         REPLACE sm WITH 0,sm_val WITH 0
    ENDIF
ENDSCAN
GO nz
REPLACE sm WITH fsm,sm_val WITH fsm_val
RETURN
*
*
PROCEDURE Chapln
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=6
nstrn=9
ncoll=53
ncolr=76
step=1
npolscrm=1
@ nstrv-2,ncoll FILL TO nstrv+5,ncolr+2 COLOR &color20
SET COLOR TO &color4
@ nstrv-3,ncoll-1,nstrv+3,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-3,ncoll-1 SAY "�������"
@ nstrv-2,ncoll-1 SAY "����p.�     �㬬�"
@ nstrv-1,ncoll-1 SAY "������������������������Ķ"
@ nstrv+3,ncoll-1 SAY "� F4-�⮣ �� F5-���⮪ ͹"
@ nstrv+4,ncoll-1 SAY "� F6 - p���.p��p���������"
RETURN
*
PROCEDURE Strsayln
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,53 SAY nsk
@ nstr,59 SAY summa PICTURE '999,999,999,999.99'
RETURN
*
PROCEDURE Strgetln
PARAMETERS nstr,npolscr
IF EMPTY(nsk)
    REPLACE kp WITH bk.kp,nrd WITH bk.nrd,kor WITH bk.kor,nzk WITH bk.nzk,vo WITH bk.vo,dat WITH bk.dat
ENDIF
@ nstr,53 GET nsk VALID Poisk_ns('lim_nsk.nsk',.F.,0,0,0) ERROR 'H�� ⠪��� ���p���������...'
@ nstr,59 GET summa PICTURE '999,999,999,999.99'
READ
RETURN
*
PROCEDURE F4ln
IF RECCOUNT()=0
	RETURN
ENDIF
PRIVATE nz,fsum
nz=RECNO()
SEEK bk.kp+bk.nrd+bk.kor+bk.nzk+bk.vo+DTOC(bk.dat,1)
fsum=0
SCAN REST WHILE kp=bk.kp.AND.nrd=bk.nrd.AND.kor=bk.kor.AND.nzk=bk.nzk.AND.vo=bk.vo.AND.dat=bk.dat FOR !DELETE()
    fsum=fsum+summa
ENDSCAN
DO Net_n WITH 12," �㬬� -"+STR(fsum,15,2)+'. � ����� -'+STR(bk.sm,15,2)+'. ������ -'+STR(bk.sm-fsum,15,2)
GO nz
RETURN
*
PROCEDURE F5ln
IF RECCOUNT()=0.OR.summa#0
	RETURN
ENDIF
PRIVATE nz,kolz,del_sum,fsum
nz=RECNO()
SEEK bk.kp+bk.nrd+bk.kor+bk.nzk+bk.vo+DTOC(bk.dat,1)
fsum=0
SCAN REST WHILE kp=bk.kp.AND.nrd=bk.nrd.AND.kor=bk.kor.AND.nzk=bk.nzk.AND.vo=bk.vo.AND.dat=bk.dat FOR !DELETE()
    fsum=fsum+summa
ENDSCAN
GO nz
REPLACE summa WITH bk.sm-fsum
RETURN
*
PROCEDURE F6ln
IF RECCOUNT()=0
	RETURN
ENDIF
PRIVATE nz,kolz,del_sum,fsum
nz=RECNO()
SEEK bk.kp+bk.nrd+bk.kor+bk.nzk+bk.vo+DTOC(bk.dat,1)
kolz=0
SCAN REST WHILE kp=bk.kp.AND.nrd=bk.nrd.AND.kor=bk.kor.AND.nzk=bk.nzk.AND.vo=bk.vo.AND.dat=bk.dat FOR !DELETE()
    kolz=kolz+1
ENDSCAN
del_sum=ROUND(bk.sm/kolz,2)
fsum=bk.sm
SEEK bk.kp+bk.nrd+bk.kor+bk.nzk+bk.vo+DTOC(bk.dat,1)
SCAN REST WHILE kp=bk.kp.AND.nrd=bk.nrd.AND.kor=bk.kor.AND.nzk=bk.nzk.AND.vo=bk.vo.AND.dat=bk.dat FOR !DELETE()
    kolz=kolz-1
    IF kolz=0
         REPLACE summa WITH fsum
         EXIT
    ENDIF
    REPLACE summa WITH del_sum
    fsum=fsum-del_sum
ENDSCAN
GO nz
RETURN
*
*
PROCEDURE Chapak
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-9+f15,ncoll-1,nstrv+11,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-8+f15,ncoll-1 SAY "�                  � � � p � �     � �    � p � � � � � � � � � �"
@ nstrv-7+f15,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-6+f15,ncoll-1 SAY "� �p��������:                                 ���줮"
IF f15=0
    @ nstrv-5,ncoll-1 SAY "� �������:"
ENDIF
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "�  ���    ����.�     C��줮    �    C��줮     �     ���p��    �    ���p��"
@ nstrv-2 ,ncoll-1 SAY "��p����������     �����     �    �।��     �     �����     �    �।��"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+11,ncoll-1 SAY "�� F2 � ���� � F3 - ᠫ줮 � F4 - �������� � F5 - ����� "+IIF(chgk=7,'� F6 - �p������ ',IIF(nastf_h=0,'� F6 - ���.����� ',''))
RETURN
*
PROCEDURE Strsayak
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 6+f15,16 SAY Spr_nam(pr_spr,kp,30)
    @ 7,16 SAY IIF(f15=1,'',dog)
    sss=db-kr+smd-smk
    DO CASE
    CASE sss>0
         @ 6+f15,54 SAY '�����  '+TRANSFORM(sss,'999,999,999,999.99')
    CASE sss<0
         @ 6+f15,54 SAY '�p���� '+TRANSFORM(-sss,'999,999,999,999.99')
    OTHERWISE
         @ 6+f15,54 SAY SPACE(25)
    ENDCASE
ENDIF
IF !EMPTY(pr_prib)
    SET COLOR TO &color8
    @ nstr,2 SAY pr_prib
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY pr_spr
@ nstr, 3 SAY kp
@ nstr,11 SAY bs
@ nstr,16 SAY db
@ nstr,32 SAY kr
@ nstr,48 SAY smd
@ nstr,64 SAY smk
RETURN
*
PROCEDURE Strgetak
PARAMETERS nstr,npolscr
IF EMPTY(kp)
    @ 6+f15,15 SAY SPACE(30)
    REPLACE bs WITH f_l
ENDIF
@ nstr,1  GET pr_spr VALID pr_spr='0'.OR.pr_spr='1' ERROR '���祭�� 0 - p���⭨�, 1 - �p��������'
@ nstr,3  GET kp VALID IIF(pr_spr='0',Poisk_ta('osdkomr.kp',.F.,7,16,30),Poisk_kl('osdkomr.kp',.F.,7,16,30)) ERROR 'H�� ⠪��� ����...'
@ nstr,11 GET bs VALID Poisk_sc('osdkomr.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
READ
RETURN
*
PROCEDURE F2av
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
@ 14,28 FILL TO 16,53 COLOR &color20
SET COLOR TO &color13
@ 13,26,15,51 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(skl.kkl))
@ 14,28 SAY IIF(pr_spr='1',"��� �࣠����樨","������� �����") GET fpoisk VALID IIF(pr_spr='0',Poisk_ta('fpoisk',.T.,0,0,0),Poisk_kl('fpoisk',.T.,0,0,0)) ERROR 'H�� ⠪��� ����...'
READ
IF EMPTY(fpoisk)
     RETURN
ENDIF
SET ORDER TO bs_kp
SET EXACT OFF
IF !SEEK(osdkomr.bs+fpoisk)
    DO Net_n WITH 10," H�� ⠪��� ���p��. ������... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3ak
SELECT osdkom
SET ORDER TO bs_kp
SET EXACT OFF
SEEK osdkomr.bs+osdkomr.kp
SET EXACT ON
DO Vvodn WITH "Chapok","Strsayok","Strgetok",.F.,.F.,.F.,.T.,"(bs#osdkomr.bs.OR.kp#osdkomr.kp)",;
              "","F2ok","F3ok","F4ok","","","","","","","",.T.
SELECT osdkomr
RETURN
*
PROCEDURE F3_pr
SELECT osd_pr
SET ORDER TO bs_kp
SET EXACT OFF
SEEK osdkomr.bs+osdkomr.kp
SET EXACT ON
DO Vvodn WITH "Chaps_","Strsays_","Strgets_",.F.,.F.,.F.,.F.,"(bs#osdkomr.bs.OR.kp#osdkomr.kp)",;
              "","F2s_","F3s_","","","","","","","","",.T.
SELECT osdkomr
RETURN
*
PROCEDURE F4_pr
SELECT dv_pr
SET ORDER TO kp_dog
SET EXACT OFF
SEEK osdkomr.kp
SET EXACT ON
DO Vvodn WITH "Chapd_","Strsayd_","Strgetd_",.F.,.F.,.F.,.F.,"kp#osdkomr.kp",;
              "","F2d_","F2d_","","","","","","","","",.T.
SELECT osdkomr
RETURN
*
PROCEDURE F5_pr
gpr_val=.F.
gfbs=''
SELECT bkr
SET EXACT OFF
SEEK osdkomr.pr_spr+osdkomr.kp
SET EXACT ON
DO Vvodn WITH "Chapbk","Strsaybk","",.F.,.F.,.F.,.F.,"(pr_spr#osdkomr.pr_spr.OR.kp#osdkomr.kp)",;
              "","","","","","","","","","","",.T.
SELECT osdkomr
RETURN
*
PROCEDURE F6_pr
PRIVATE fnrd,fdat,fkp,fkol,nz,fsum,fvo,fnzk,fkor
SET COLOR TO &color13
@ 14,24 FILL TO IIF(nastf_4=0,22,23),56 COLOR &color20
@ 13,23,IIF(nastf_4=0,21,22),55 BOX box_2
fdat=dv_pr.dat
fkor=dv_pr.kor
fnsk=dv_pr.nsk
fdog=dv_pr.dog
IF sss>0
    fsmk=sss
    fsmd=0
ELSE
    fsmd=-sss
    fsmk=0
ENDIF
SET COLOR TO &color14
@ 15,25 SAY " H���� �������" GET fdog
@ 16,25 SAY " ��� ���㬥��" GET fdat
@ 17,25 SAY " ��pp.���....." GET fkor VALID Poisk_sc('fkor',.T.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
@ 18,25 SAY " �㬬� �����..." GET fsmd
@ 19,25 SAY "       �p����.." GET fsmk
IF nastf_4=1
    @ 20,25 SAY " ���p���������.." GET fnsk VALID Poisk_ns('fnsk',.T.,0,0,0) ERROR 'H�� ⠪��� ���p���������...'
ENDIF
READ
IF LASTKEY()=27.AND.READKEY()#271.OR.fsmk=0.AND.fsmd=0
    RETURN
ENDIF
SELECT dv_pr
APPEND BLANK
REPLACE dog WITH fdog,nsk WITH fnsk,kp WITH osdkomr.kp,dat WITH fdat,;
        kor WITH fkor,bs WITH osdkomr.bs,pr_spr WITH osdkomr.pr_spr,;
        smd WITH fsmd,smk WITH fsmk
IF nastf_0=1
    SAVE SCREEN TO scr
    @ 20,24 FILL TO 22,63 COLOR &color20
    SET COLOR TO &color13
    @ 19,23,21,62 BOX "�ͻ���Ⱥ "
    SET COLOR TO &color14
    @ 20,25 SAY '�����' GET text
    READ
    RESTORE SCREEN FROM scr
ENDIF
IF nastf_7=1.AND.LEFT(kor,1)='2'
    SAVE SCREEN TO scr
    @ 20,44 FILL TO 22,60 COLOR &color20
    SET COLOR TO &color13
    @ 19,43,21,59 BOX "�ͻ���Ⱥ "
    SET COLOR TO &color14
    @ 20,45 SAY nastf_s GET nzk VALID Poisk_nz('dv_pr.nzk',.F.,0,0,0) ERROR 'H�� ⠪��� ����...'
    READ
    RESTORE SCREEN FROM scr
ENDIF
SELECT osdkomr
REPLACE smd WITH smd+fsmd,smk WITH smk+fsmk
RETURN
*
*
PROCEDURE Chapaa
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=22
ncoll=12
ncolr=56
step=1
npolscrm=1
@ nstrv-6,ncoll FILL TO nstrv+12,ncolr+2 COLOR &color20
RESTORE FROM tek_b ADDITIVE
SET COLOR TO &color4
@ nstrv-8,ncoll-1,nstrv+11,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-7 ,ncoll-1 SAY "�           ��������  ��  �p������樨"
@ nstrv-6 ,ncoll-1 SAY "���������������������������������������������Ķ"
@ nstrv-5 ,ncoll-1 SAY '� '+nastf_s+':'
@ nstrv-4 ,ncoll-1 SAY "���������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY '� H���p�'+tek_b_7+'�  ���  �'+nastf_s+'�  �㬬� �����'
@ nstrv-2 ,ncoll-1 SAY '� ����.�'+tek_b_8+'�        �      �'
@ nstrv-1 ,ncoll-1 SAY "���������������������������������������������Ķ"
@ nstrv+11,ncoll-1 SAY "�� F1 � ������ "
RELEASE ALL LIKE tek_b_??
@ 2,53 FILL TO 8,IIF(nastf_g=0,74,79) COLOR &color20
@ 1,52 SAY "���������������������"+IIF(nastf_g=0,"�","�����ͻ")
@ 2,52 SAY "��/��     �㬬�     "+IIF(nastf_g=0,"�","����p.�")
@ 3,52 SAY "���������������������"+IIF(nastf_g=0,"�","�����Ķ")
@ 4,52 SAY "�                    "+IIF(nastf_g=0,"�","      �")
@ 5,52 SAY "�                    "+IIF(nastf_g=0,"�","      �")
@ 6,52 SAY "�                    "+IIF(nastf_g=0,"�","      �")
@ 7,52 SAY "���������������������"+IIF(nastf_g=0,"�","�����ͼ")
RETURN
*
PROCEDURE Strsayaa
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    IF FILE('KODZK.DBF')
         SELECT kodzk
         SEEK supavot.nzk
         @ 6,21 SAY kodzk.nam
         SELECT supavot
    ENDIF
    @ 4,53 CLEAR TO 6,IIF(nastf_g=0,72,77)
    SELECT avot
    SET EXACT OFF
    SEEK supavot.bs+supavot.kp+supavot.nrd
    SET EXACT ON
    i=0
    SCAN REST WHILE supavot.bs=bs.AND.supavot.kp=kp.AND.supavot.nrd=nrd FOR !DELETE()
         IF i>2
              EXIT
         ENDIF
         @ 4+i,53 SAY kor
         @ 4+i,58 SAY smd
         IF nastf_g=1
             @ 4+i,74 SAY nsk
         ENDIF
         i=i+1
    ENDSCAN
    SELECT supavot
ENDIF
SET COLOR TO &color
@ nstr,12 SAY nrd
@ nstr,19 SAY nvx
@ nstr,26 SAY dat
@ nstr,35 SAY nzk
@ nstr,42 SAY smd
RETURN
*
PROCEDURE Strgetaa
PARAMETERS nstr,npolscr
PRIVATE fff1,fff2,fnrd,fnvx,fdat,fnzk,fnsk
fnrd=nrd
fnvx=nvx
fdat=dat
fnzk=nzk
IF EMPTY(kp)
    @ 7,27 SAY SPACE(30)
    REPLACE kp WITH osdkomr.kp,bs WITH osdkomr.bs,pr_spr WITH osdkomr.pr_spr
ENDIF
@ nstr,12 GET nrd
@ nstr,19 GET nvx
@ nstr,26 GET dat
@ nstr,35 GET nzk VALID IIF(FILE('KODZK.DBF'),Poisk_nz('supavot.nzk',.F.,6,21,30),.T.) ERROR 'H�� ⠪��� ����...'
READ
SELECT avot
SET EXACT OFF
IF fnrd#supavot.nrd.OR.fnvx#supavot.nvx.OR.fdat#supavot.dat.OR.fnzk#supavot.nzk
    SEEK supavot.bs+supavot.kp+fnrd
    IF fnrd#supavot.nrd
         DO WHILE FOUND()
              REPLACE nrd WITH supavot.nrd,nvx WITH supavot.nvx,dat WITH supavot.dat,nzk WITH supavot.nzk
              SEEK supavot.bs+supavot.kp+fnrd
         ENDDO
    ELSE
         SCAN REST WHILE bs=supavot.bs.AND.kp=supavot.kp.AND.nrd=fnrd
              REPLACE nvx WITH supavot.nvx,dat WITH supavot.dat,nzk WITH supavot.nzk
         ENDSCAN
    ENDIF
ENDIF
SEEK supavot.bs+supavot.kp+supavot.nrd
SET EXACT ON
DO Vvodn WITH "Chapcc","Strsaycc","Strgetcc",.T.,.T.,.T.,.F.,"(bs#supavot.bs.OR.kp#supavot.kp.OR.nrd#supavot.nrd)",;
    "","","","","","","","","","","",.T.
SET EXACT OFF
SEEK supavot.bs+supavot.kp+supavot.nrd
SET EXACT ON
fff1=0
SCAN REST WHILE supavot.bs=bs.AND.supavot.kp=kp.AND.supavot.nrd=nrd FOR !DELETE()
    fff1=fff1+avot.smd
ENDSCAN
SELECT supavot
REPLACE smd WITH fff1
RETURN
*
*
PROCEDURE Chapcc
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=4
nstrn=7
ncoll=53
ncolr=IIF(nastf_g=0,72,77)
step=1
npolscrm=1
SET COLOR TO &color4
@ 1,52 SAY "���������������������"+IIF(nastf_g=0,"�","�����ͻ")
@ 2,52 SAY "��/��     �㬬�     "+IIF(nastf_g=0,"�","����p.�")
@ 3,52 SAY "���������������������"+IIF(nastf_g=0,"�","�����Ķ")
@ 4,52 SAY "�                    "+IIF(nastf_g=0,"�","      �")
@ 5,52 SAY "�                    "+IIF(nastf_g=0,"�","      �")
@ 6,52 SAY "�                    "+IIF(nastf_g=0,"�","      �")
@ 7,52 SAY "���������������������"+IIF(nastf_g=0,"�","�����ͼ")
RETURN
*
PROCEDURE Strsaycc
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,53 SAY kor
@ nstr,58 SAY smd
IF nastf_g=1
    @ nstr,74 SAY nsk
ENDIF
RETURN
*
PROCEDURE Strgetcc
PARAMETERS nstr,npolscr
IF EMPTY(bs)
    pr_per=.T.
    REPLACE dat WITH supavot.dat,kp WITH supavot.kp,nzk WITH supavot.nzk,nvx WITH supavot.nvx,;
            bs  WITH supavot.bs,pr_spr WITH supavot.pr_spr,nrd WITH supavot.nrd
ELSE
    pr_per=.F.
ENDIF
@ nstr,53 GET kor VALID Poisk_sc('avot.kor',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
@ nstr,58 GET smd
IF nastf_g=1
    @ nstr,74 GET nsk VALID Poisk_ns('avot.nsk',.F.,0,0,0) ERROR 'H�� ⠪��� ����...'
ENDIF
READ
RETURN
*
*
PROCEDURE Chapdd
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=7
nstrn=21
ncoll=1
ncolr=55
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-7,ncoll-1,nstrv+17,79 BOX "�ͻ���Ⱥ "
@ nstrv-7 ,3  SAY ' F2 - ���� ���� F8 - �p�� ���⪠ ����� '+IIF(nastf_h=0,'','���� F9 - ������ ')
@ nstrv-6 ,65 SAY ' ��� '+ff2
@ nstrv-6 ,ncoll-1 SAY "�                 � � � � � �    � �    � � � � � � � � � �     �"
@ nstrv-5 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-4 ,ncoll-1 SAY '� �����⥫�:                                          �      � � � �'
@ nstrv-3 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-2 ,ncoll-1 SAY '� N ����   ���   ��/��  �㬬� �����  � �㬬� ������ � N ���� �㬬� �p����'
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv   ,ncoll-1 SAY "�                                                      �"
@ nstrv+1 ,ncoll-1 SAY "�                                                      �"
@ nstrv+2 ,ncoll-1 SAY "�                                                      �"
@ nstrv+3 ,ncoll-1 SAY "�                                                      �"
@ nstrv+4 ,ncoll-1 SAY "�                                                      �"
@ nstrv+5 ,ncoll-1 SAY "�                                                      �"
@ nstrv+6 ,ncoll-1 SAY "�                                                      �"
@ nstrv+7 ,ncoll-1 SAY "�                                                      �"
@ nstrv+8 ,ncoll-1 SAY "�                                                      �"
@ nstrv+9 ,ncoll-1 SAY "�                                                      �"
@ nstrv+10,ncoll-1 SAY "�                                                      �"
@ nstrv+11,ncoll-1 SAY "�                                                      �"
@ nstrv+12,ncoll-1 SAY "�                                                      �"
@ nstrv+13,ncoll-1 SAY "�                                                      �"
@ nstrv+14,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+15,ncoll-1 SAY "�   �⮣�              �               �               �"
@ nstrv+16,ncoll-1 SAY "�   �ᥣ�              �               �               ����⮪"
@ nstrv+17,ncoll-1 SAY "� F3-�⮣ � �㡫�:F4-����,F5-��p��� � F6-���� � F7��p�� ���⪠ � F10-�����"
SET COLOR TO &color21
sss=0
fsum=0
fsumv=0
SCAN FOR !DELETE()
    sss=sss+smd
    fsumv=fsumv+smdo
    IF bs_op=ff2
         fsum=fsum+smdo
    ENDIF
ENDSCAN
@ 23,24 SAY sss PICTURE '999999999999.99'
sopl=0
SELECT bkr
i=nstrv
SCAN FOR !DELETE()
    sopl=sopl+IIF(vo='0',sm,-sm)
    IF i<nstrn
         @ i,56 SAY pr_otk
         @ i,58 SAY nrd
         @ i,64 SAY IIF(vo='0',sm,-sm) PICTURE '999999999999.99'
         i=i+1
    ENDIF
ENDSCAN
GO TOP
@ 22,63 SAY sopl PICTURE '999999999999.99'
@ 3,15 SAY Spr_nam(osdkomr.pr_spr,osdkomr.kp,30)
SELECT dv_kp
GO TOP
RETURN
*
PROCEDURE Strsaydd
PARAMETERS color,nstr,npolscr
SET COLOR TO &color21
@ 22,40 SAY fsum  PICTURE '999999999999.99'
@ 23,40 SAY fsumv PICTURE '999999999999.99'
IF sopl-fsum<0
    SET COLOR TO &color22
ENDIF
@ 23,63 SAY sopl-fsum PICTURE '999999999999.99'
SET COLOR TO &color
@ nstr, 1 SAY pr_otk
@ nstr, 2 SAY nrd
@ nstr, 9 SAY dat
@ nstr,20 SAY kor
@ nstr,25 SAY smd
IF smdo>smd
    SET COLOR TO w+/r
ENDIF
@ nstr,40 SAY smdo
SET COLOR TO n/bg
IF bs_op=ff2
    @ nstr,55 SAY '*'
ELSE
    @ nstr,55 SAY '�'
ENDIF
RETURN
*
PROCEDURE Strgetdd
PARAMETERS nstr,npolscr
PRIVATE fsmdo
fsmdo=smdo
@ nstr,40 GET smdo
READ
IF fsmdo#smdo
    IF nastf_h=1
         DO Opl_tran
    ENDIF
    fsum=fsum-fsmdo+smdo
    fsumv=fsumv-fsmdo+smdo
ENDIF
REPLACE bs_op WITH IIF(smdo=0,'    ',ff2)
RETURN
*
*
PROCEDURE Chapok
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
RESTORE FROM tek_b ADDITIVE
SET COLOR TO &color4
@ nstrv-8-nastf_g,ncoll-1,nstrv+12,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-7-nastf_g,ncoll-1 SAY "�              � � � � � � �      � �     � � � � � � � �"
@ nstrv-6-nastf_g,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
IF nastf_g=1
@ nstrv-6 ,ncoll-1 SAY "� ���p���������:"
ENDIF
@ nstrv-5 ,ncoll-1 SAY "� �p��������:"
@ nstrv-4 ,ncoll-1 SAY "�������������������������������������������������������������������������"+IIF(nastf_g=0,"�","�")+"����Ķ"
@ nstrv-3 ,ncoll-1 SAY '��/c � H���p�'+tek_b_7+'�   ���   �  ���  ����.����.�    C㬬�    �   C㬬�  '+IIF(nastf_g=0,'      ','� ��� ')
@ nstrv-2 ,ncoll-1 SAY '����.���.����'+tek_b_8+'�          ��࣠����������    �����    �   �।�� '+IIF(nastf_g=0,'      ','����p.')
@ nstrv-1 ,ncoll-1 SAY "�������������������������������������������������������������������������"+IIF(nastf_g=0,"�","�")+"����Ķ"
@ nstrv+11,ncoll-1 SAY "�� ����: F2 � �࣠������, F3 - ���㬥�� ��� F4 � �⮣ ��� F5-��騩 �⮣ ����͹"
@ nstrv+12,ncoll-1 SAY "�� F6- �p��஢���� �p��뫨 � ��⪮� ������� F10 - ����� "
RELEASE ALL LIKE tek_b_??
RETURN
*
PROCEDURE Strsayok
PARAMETERS color,nstr,npolscr
SET COLOR TO &color21                          '+tek_b_7+'
IF !pr_v_pr
    ffdat=dat
    ffkp=kp
    ffnrd=nrd
    ffnvx=nvx
    ffpr_spr=pr_spr
    ffbs=bs
    ffnsk=nsk
    ffnzk=nzk
    IF nastf_g=1
         SELECT sch
         SEEK osdkom.nsk
         @ 6,17 SAY sch.icsk
    ENDIF
    SELECT osdkom
    @ 7,15 SAY Spr_nam(pr_spr,kp,30)
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY substr(nzk,1,4)
@ nstr, 4 SAY pr_prib
@ nstr, 6 SAY nrd
@ nstr,13 SAY nvx
@ nstr,20 SAY dat
@ nstr,31 SAY kp
@ nstr,39 SAY bs
@ nstr,44 SAY kor
@ nstr,49 SAY db PICTURE '9999999999.99'
IF nastf_g=1
    @ nstr,61 SAY kr PICTURE '999999999.99'
    @ nstr,74 SAY nsk
ELSE
    @ nstr,63 SAY kr PICTURE '9,999,999,999.99'
ENDIF
RETURN
*
PROCEDURE Strgetok
PARAMETERS nstr,npolscr
IF EMPTY(kp)
    REPLACE kp WITH ffkp,nvx WITH ffnvx,nrd WITH ffnrd,dat WITH ffdat,pr_spr WITH ffpr_spr,;
            bs WITH ffbs,nsk WITH ffnsk,nzk WITH '0'
    @ 7,15 SAY SPACE(30)
    IF nastf_g=1
         @ 6,17 SAY SPACE(30)
    ENDIF
ENDIF
@ nstr, 1 GET nzk
@ nstr, 6 GET nrd
@ nstr,13 GET nvx
@ nstr,20 GET dat
*@ nstr,29 GET pr_spr VALID pr_spr='0'.OR.pr_spr='1' ERROR '���祭�� 0 - p���⭨�, 1 - �p��������'
@ nstr,31 GET kp  VALID IIF(pr_spr='1',Poisk_kl('osdkom.kp',.F.,7,15,30),Poisk_ta('osdkom.kp',.F.,7,15,30)) ERROR 'H�� ⠪��� ����...'
@ nstr,39 GET bs  VALID Poisk_sc('osdkom.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
@ nstr,44 GET kor VALID IIF(bs=nastf_k,.T.,Poisk_sc('osdkom.kor',.F.,.F.,0,0,0,' ','.F.')) ERROR 'H�� ⠪��� ���...'
@ nstr,49 GET db PICTURE '9999999999.99'
IF nastf_g=1
    @ nstr,61 GET kr PICTURE '999999999.99'
    @ nstr,74 GET nsk VALID IIF(bs=nastf_k,.T.,Poisk_ns('osdkom.nsk',.F.,6,17,30)) ERROR 'H�� ⠪��� ����...'
ELSE
    @ nstr,63 GET kr PICTURE '9,999,999,999.99'
ENDIF
READ
IF nastf_h=1.AND.EMPTY(uni)
    sss=FULLPATH('unin.mem')
    RESTORE FROM unin ADDITIVE
    unin=unin+1
    SAVE TO &sss ALL LIKE unin
    REPLACE uni WITH unin
    RELEASE unin
ENDIF
RETURN
*
PROCEDURE F2ok
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,fpoisk1,fpoisk2
nz=RECNO()
@ 14,24 FILL TO 17,52 COLOR &color20
SET COLOR TO &color13
@ 13,23,16,51 BOX box_1
SET COLOR TO &color14
fpoisk1=SPACE(LEN(skl.kkl))
fpoisk2=SPACE(LEN(osdkom.nrd))
@ 14,25 SAY "��� �࣠����樨..." GET fpoisk1 VALID Poisk_kl('fpoisk1',.T.,0,0,0) ERROR 'H�� ⠪��� ����...'
@ 15,25 SAY "H���� ����.���㬥�" GET fpoisk2
READ
IF EMPTY(fpoisk1).AND.EMPTY(fpoisk2)
    RETURN
ENDIF
SET ORDER TO kp_nrd
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk1+fpoisk2))
    DO Net_n WITH 10," H�� ⠪��� ���⪠. ������... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3ok
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
@ 14,24 FILL TO 16,52 COLOR &color20
SET COLOR TO &color13
@ 13,23,15,51 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(osdkom.nrd))
@ 14,25 SAY "H���� ����.���㬥�" GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
SET ORDER TO osdkom
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H�� ⠪��� ���⪠. ������... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4ok
PRIVATE fnrd,nz,fsum
nz=RECNO()
SET ORDER TO kp_nrd
fkp=kp
fnrd=nrd
fsum=0
IF SEEK(fkp+fnrd)
    SCAN REST WHILE fkp=kp.AND.fnrd=nrd FOR !DELETE()
         fsum=fsum+db+kr
    ENDSCAN
    DO Net_n WITH 14,"�㬬� "+STR(fsum,15,2)+".�த������� - �� ������..."
ENDIF
IF RECCOUNT()#0
    GO nz
ENDIF
RETURN
*
PROCEDURE F5ok
PRIVATE fsumd,nz,fsumk
nz=RECNO()
fsumd=0
fsumk=0
SCAN FOR !DELETE()
    fsumd=fsumd+db
    fsumk=fsumk+kr
ENDSCAN
DO Net_n WITH 14,"�⮣�: ����� - "+STR(fsumd,15,2)+", �p���� - "+STR(fsumk,15,2)
IF RECCOUNT()#0
    GO nz
ENDIF
RETURN
*
PROCEDURE F6ok
IF bs=nastf_k
    IF pr_prib=' '
         REPLACE pr_prib WITH '*'
    ELSE
         REPLACE pr_prib WITH ' '
    ENDIF
ENDIF
RETURN
*
*
PROCEDURE Chapsv
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=22
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-6,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-5 ,ncoll-1 SAY "�              � � p � � � � � � �     � � � � �    � � � p � � � �"
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "�  ��� � N ��p��������pp�       H�����������      ������        ��p�㫠        �"
@ nstrv-2 ,ncoll-1 SAY "���p㧳�/���/��⠳���                         �    �        p����        �"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "��� F1 � ������ "
RETURN
*
PROCEDURE Strsaysv
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr, 3 SAY kod
@ nstr, 8 SAY npp
@ nstr,15 SAY pr_kor
@ nstr,20 SAY kor
@ nstr,25 SAY nam
@ nstr,51 SAY obozn
@ nstr,56 SAY LEFT(form,22)
RETURN
*
PROCEDURE Strgetsv
PARAMETERS nstr,npolscr
@ nstr, 3 GET kod
@ nstr, 8 GET npp
@ nstr,15 GET pr_kor VALID pr_kor='0'.OR.pr_kor='1' ERROR "0 - ��� ��pp.���, 1 - ��pp.���..."
READ
IF pr_kor='1'
    @ nstr,20 GET kor VALID Poisk_sc('spr_vid.kor',.F.,.F.,nstr,25,25,' ','.F.') ERROR 'H�� ⠪��� ���...'
ELSE
    @ nstr,25 GET nam
ENDIF
@ nstr,51 GET obozn VALID Prov(obozn) ERROR '������祭�� ����p��...'
@ nstr,56 GET form FUNCTION 'S22' VALID Prov(form)  ERROR '��p�㫠 ����pp��⭠...'
READ
IF pr_kor='1'
    REPLACE nam WITH spr_bs.nam
ENDIF
RETURN
*
*
PROCEDURE Chapsb
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=22
ncoll=1
ncolr=78
step=1
npolscrm=IIF(nastf_8=0,1,2)
SET COLOR TO &color4
@ nstrv-6,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-5 ,ncoll-1 SAY "�              � � p � � � � � � �     � � � � �    � � � � � � � �"
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "����� N ��p���������.���pp�      ������������       ������       ��p�㫠       �"
@ nstrv-2 ,ncoll-1 SAY "�   ��/�� ��� �������                         �    �       p����       �"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "��� F1 � ������ "
IF nastf_8=1
    @ nstrv+3,ncolr+1 SAY ''
    @ nstrv+4,ncolr+1 SAY ''
    @ nstrv+5,ncolr+1 SAY ''
    @ nstrv+6,ncolr+1 SAY ''
    SAVE SCREEN TO scr
    @ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
    @ nstrv-3 ,ncoll-1 SAY "����� N ��p���������.���pp�    ��ࠦ���� ���   �    ���㫠 ��� �㬬� ������   �"
    @ nstrv-2 ,ncoll-1 SAY "�   ��/�� ��� �������     ���� ������    �                               �"
    @ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
    @ nstrv+3,ncoll-1 SAY ''
    @ nstrv+4,ncoll-1 SAY ''
    @ nstrv+5,ncoll-1 SAY ''
    @ nstrv+6,ncoll-1 SAY ''
    @ nstrv+3,ncolr+1 SAY '�'
    @ nstrv+4,ncolr+1 SAY '�'
    @ nstrv+5,ncolr+1 SAY '�'
    @ nstrv+6,ncolr+1 SAY '�'
    SAVE SCREEN TO scr1
    RESTORE SCREEN FROM scr
ENDIF
RETURN
*
PROCEDURE Strsaysb
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr, 1 SAY kod
@ nstr, 5 SAY npp
@ nstr,12 SAY pr_kor
@ nstr,17 SAY bs
@ nstr,22 SAY kor
DO CASE
CASE npolscr=1
    @ nstr,27 SAY nam
    @ nstr,53 SAY obozn
    @ nstr,58 SAY LEFT(form,21)
CASE npolscr=2
    @ nstr,27 SAY vid_val
    @ nstr,48 SAY LEFT(formv,31)
ENDCASE
RETURN
*
PROCEDURE Strgetsb
PARAMETERS nstr,npolscr
DO CASE
CASE npolscr=1
    @ nstr, 1 GET kod
    @ nstr, 5 GET npp
    @ nstr,12 GET pr_kor VALID pr_kor='0'.OR.pr_kor='1' ERROR "0 - ��� ��pp.���, 1 - ��pp.���..."
    READ
    IF pr_kor='1'
         @ nstr,17 GET bs  VALID Poisk_sc('spr_vid.bs',.F.,.F.,nstr,27,25,' ','.F.') ERROR 'H�� ⠪��� ���...'
         @ nstr,22 GET kor VALID Poisk_sc('spr_vid.kor',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
    ELSE
         @ nstr,27 GET nam
    ENDIF
    @ nstr,53 GET obozn VALID Prov(obozn) ERROR '������祭�� ����p��...'
    @ nstr,58 GET form FUNCTION 'S21' VALID Prov(form)  ERROR '��p�㫠 ����pp��⭠...'
CASE npolscr=2
    @ nstr,27 GET vid_val
    @ nstr,48 GET formv FUNCTION 'S31' VALID Prov(formv)  ERROR '��p�㫠 ����pp��⭠...'
ENDCASE
READ
IF pr_kor='1'
    SELECT spr_bs
    SEEK spr_vid.bs
    SELECT spr_vid
    REPLACE nam WITH spr_bs.nam
ENDIF
RETURN
*
*
PROCEDURE Chapoo
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=22
ncoll=1
ncolr=IIF(nastf_g=0,65,71)
step=1
npolscrm=1
RESTORE FROM tek_b ADDITIVE
SET COLOR TO &color4
@ nstrv-8-nastf_g,ncoll-1,nstrv+11,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-7-nastf_g,ncoll-1 SAY "�              � � � � � � � �    � �     � � � � � � � � � � �"
@ nstrv-6-nastf_g,ncoll-1 SAY "������������������������������������������������������������������"+IIF(nastf_g=0,"�","�����Ķ")
IF nastf_g=1
@ nstrv-6 ,ncoll-1 SAY "� ���p���������:"
ENDIF
@ nstrv-5 ,ncoll-1 SAY "� �����⥫�:"
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������"+IIF(nastf_g=0,"�","�����Ķ")
@ nstrv-3 ,ncoll-1 SAY '� H���p�'+tek_b_7+'�    ���    �  ���    ����.����.�       C㬬�      '+IIF(nastf_g=0,'','� ��� ')
@ nstrv-2 ,ncoll-1 SAY '���.����'+tek_b_8+'�            ��࣠�����������       �����      '+IIF(nastf_g=0,'','����p.')
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������"+IIF(nastf_g=0,"�","�����Ķ")
@ nstrv+11,ncoll-1 SAY "�� F1 � ������ �� ����: F2Į࣠������, F3-���㬥�� �� F4 - �⮣ "+IIF(nastf_g=0,"�","�����͹")
@ nstrv+12,ncoll-1 SAY "�� F6 � ���� �� �p�㫠� � F7 � �p��� p���� �� F10 - ����� ��"+IIF(nastf_g=0,"�","�����ͼ")
RELEASE ALL LIKE tek_b_??
RETURN
*
PROCEDURE Strsayoo
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    ffdat=dat
    ffkp=kp
    ffnrd=nrd
    ffnvx=nvx
    ffpr_spr=pr_spr
    ffbs=bs
    ffnsk=nsk
    ffnpp=npp
    SET COLOR TO &color21
    IF nastf_g=1
         SELECT sch
         SEEK avot.nsk
         @ 5,17 SAY sch.icsk
    ENDIF
    SELECT avot
    @ 6,15 SAY Spr_nam(pr_spr,kp,30)
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY nrd
@ nstr, 8 SAY nvx
@ nstr,16 SAY dat
@ nstr,28 SAY pr_spr
@ nstr,30 SAY kp
@ nstr,38 SAY bs
@ nstr,43 SAY kor
@ nstr,48 SAY smd PICTURE '999,999,999,999.99'
IF nastf_g=1
    @ nstr,67 SAY nsk
ENDIF
RETURN
*
PROCEDURE Strgetoo
PARAMETERS nstr,npolscr
IF EMPTY(kp)
    REPLACE kp WITH ffkp,nvx WITH ffnvx,nrd WITH ffnrd,dat WITH ffdat,pr_spr WITH ffpr_spr,;
            bs WITH ffbs,nsk WITH ffnsk,npp WITH ffnpp
    @ 6,15 SAY SPACE(30)
ENDIF
@ nstr, 1 GET nrd
@ nstr, 8 GET nvx
@ nstr,16 GET dat
@ nstr,28 GET pr_spr VALID pr_spr='0'.OR.pr_spr='1' ERROR '���祭�� 0 - p���⭨�, 1 - �p��������'
@ nstr,30 GET kp  VALID IIF(pr_spr='1',Poisk_kl('avot.kp',.F.,6,15,30),Poisk_ta('avot.kp',.F.,6,15,30)) ERROR 'H�� ⠪��� ����...'
@ nstr,38 GET bs  VALID Poisk_sc('avot.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
@ nstr,43 GET kor VALID Poisk_sc('avot.kor',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
@ nstr,48 GET smd PICTURE '999,999,999,999.99'
IF nastf_g=1
    @ nstr,67 GET nsk VALID Poisk_ns('avot.nsk',.F.,5,17,30) ERROR 'H�� ⠪��� ����...'
ENDIF
READ
IF nastf_h=1.AND.EMPTY(uni)
    sss=FULLPATH('unin.mem')
    RESTORE FROM unin ADDITIVE
    unin=unin+1
    SAVE TO &sss ALL LIKE unin
    REPLACE uni WITH unin
    RELEASE unin
ENDIF
RETURN
*
PROCEDURE F2oo
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,fpoisk1,fpoisk2
nz=RECNO()
@ 14,24 FILL TO 17,52 COLOR &color20
SET COLOR TO &color13
@ 13,23,16,51 BOX box_1
SET COLOR TO &color14
fpoisk1=SPACE(LEN(skl.kkl))
fpoisk2=SPACE(LEN(nrd))
@ 14,25 SAY "��� �࣠����樨..." GET fpoisk1 VALID Poisk_kl('fpoisk1',.T.,0,0,0) ERROR 'H�� ⠪��� ����...'
@ 15,25 SAY "H���� ����.���㬥�" GET fpoisk2
READ
IF EMPTY(fpoisk1).AND.EMPTY(fpoisk2)
    RETURN
ENDIF
SET ORDER TO avot1
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk1+fpoisk2))
    DO Net_n WITH 10," H�� ⠪�� ���p��樨... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3oo
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
@ 14,24 FILL TO 16,52 COLOR &color20
SET COLOR TO &color13
@ 13,23,15,51 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(nrd))
@ 14,25 SAY "H���� ����.���㬥�" GET fpoisk
READ
IF LASTKEY()=27
     RETURN
ENDIF
SET ORDER TO avot
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H�� ⠪�� ���p��樨... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4oo
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnrd,nz,fsum
nz=RECNO()
SET ORDER TO bs_kp
fbs=bs
fkp=kp
fnrd=nrd
fsum=0
SET EXACT OFF
IF SEEK(fbs+fkp+fnrd)
    SUM smd TO fsum REST WHILE fbs=bs.AND.fkp=kp.AND.fnrd=nrd
    DO Net_n WITH 14,"�㬬� "+STR(fsum,15,2)+".�த������� - �� ������..."
ENDIF
SET EXACT ON
GO nz
RETURN
*
PROCEDURE F7oo
PRIVATE f_poisk,nam_file,nz
nam_file=ALIAS()
SELECT 0
USE spr_vid
SET ORDER TO kod
DO Vvodn WITH "Chapsv","Strsaysv","Strgetsv",.T.,.T.,.T.,.F.,'.F.',"",;
     "","","","","","","","","","",.T.
USE
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN
*
*
PROCEDURE Chapsc
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=4
nstrn=14
ncoll=0
IF nastf_z=0
    ncolr=35
ELSE
    ncolr=45
ENDIF
DEFINE WINDOW Chapsc FROM 6,17 TO 22,IIF(nastf_z=0,54,64) COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chapsc
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-4 ,ncoll SAY '    ��ࠢ�筨� ���ࠧ�������  (���)'
@ nstrv-3 ,ncoll SAY '������������������������������������'+IIF(nastf_z=0,'','����������')
@ nstrv-2 ,ncoll SAY ' ��� �       H�����������           '+IIF(nastf_z=0,'','���� �p-��')
@ nstrv-1 ,ncoll SAY '������������������������������������'+IIF(nastf_z=0,'','����������')
@ nstrv+10,ncoll SAY '����:F2Ī��,F3-������. � F10į����'+IIF(nastf_z=0,'','����������')
RETURN
*
PROCEDURE Strsaysc
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,0 SAY nsk
@ nstr,6 SAY icsk
IF nastf_z=1
    @ nstr,37 SAY vid_pr
ENDIF
RETURN
*
PROCEDURE Strgetsc
PARAMETERS nstr,npolscr
PRIVATE scr
@ nstr,0 GET nsk
@ nstr,6 GET icsk
IF nastf_z=1
    @ nstr,37 GET vid_pr
ENDIF
READ
IF nastf_c=1
    DEFINE WINDOW Zapros FROM 17,20 TO 19,42 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,1 SAY '�p㯯� �����' GET vid_lim
    READ
    RELEASE WINDOW Zapros
ENDIF
RETURN
*
PROCEDURE F2sc
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz,scr
nz=RECNO()
fpoisk=SPACE(LEN(nsk))
SET ORDER TO sch
DEFINE WINDOW Zapros FROM 7,32 TO 9,47 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "��� ���" GET fpoisk
READ
RELEASE WINDOW Zapros
IF EMPTY(fpoisk)
    RETURN
ENDIF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H�� ⠪��� ���. ������... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F3sc
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz,scr
nz=RECNO()
fpoisk=SPACE(LEN(icsk))
DEFINE WINDOW Zapros FROM 7,17 TO 9,62 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "������������" GET fpoisk
READ
RELEASE WINDOW Zapros
IF EMPTY(fpoisk)
    RETURN
ENDIF
fpoisk=CHRTRAN(STRTRAN(fpoisk," ",""),"��������������������������������","��������������������������������")
SET ORDER TO nam
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H�� ⠪��� ���. ������... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
*
PROCEDURE Chapsw
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
DEFINE WINDOW Chapsw FROM 4,0 TO 23,79 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chapsw
nstrv=5
nstrn=17
ncoll=0
ncolr=77
step=4
npolscrm=1
SET COLOR TO &color4
@ nstrv-5 ,ncoll SAY "                 � � � � � � � � � �      � � � � � � �"
@ nstrv-4 ,ncoll SAY "������������������������������������������������������������������������������"
@ nstrv-3 ,ncoll SAY " ��� �             H � � � � � � � � � � �              �   ���   � H����祭��"
@ nstrv-2 ,ncoll SAY "⥪��                                                  ����p�樨 �  ���⥦�"
@ nstrv-1 ,ncoll SAY "������������������������������������������������������������������������������"
@ nstrv+12,ncoll SAY "������ F1 � ������ ������� ����: F2 � ���, F3 - ������������ ����������������"
RETURN
*
PROCEDURE Strsaysw
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr  , 2 SAY wid_t
@ nstr  , 6 SAY text_1
@ nstr  ,60 SAY vid_op
@ nstr  ,70 SAY nazn_pl
@ nstr+1, 6 SAY text_2
@ nstr+2, 6 SAY text_3
@ nstr+3, 6 SAY text_4
RETURN
*
PROCEDURE Strgetsw
PARAMETERS nstr,npolscr
PRIVATE nz,fwid_t
nz=RECNO()
DO WHILE .T.
    @ nstr,2 GET wid_t
    READ
    fwid_t=wid_t
    SET ORDER TO wid_t
    IF SEEK(fwid_t)
         SKIP
         IF fwid_t=wid_t
              DO Net_n WITH 10," ����� ��� 㦥 ����. ������... "
         ELSE
              GO nz
              EXIT
         ENDIF
    ELSE
         DO Net_n WITH 10," �����-� ���p�� � ��⥬�. ������, p��p�襭 ������... "
         RETURN
    ENDIF
    GO nz
ENDDO
@ nstr  ,6 GET text_1
@ nstr+1,6 GET text_2
@ nstr+2,6 GET text_3
@ nstr+3,6 GET text_4
@ nstr ,60 GET vid_op
@ nstr ,70 GET nazn_pl
READ
RETURN
*
PROCEDURE F2sw
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz,scr
nz=RECNO()
SET ORDER TO wid_t
fpoisk=0
DEFINE WINDOW Zapros FROM 12,41 TO 14,51 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "��� " GET fpoisk PICTURE "99"
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    RETURN
ENDIF
IF !SEEK(fpoisk)
    DO Net_n WITH 10," H�� ⠪��� ����. ������... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F3sw
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz,scr
nz=RECNO()
SET ORDER TO text
fpoisk=SPACE(LEN(text_1))
DEFINE WINDOW Zapros FROM 12,7 TO 14,73 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "������������" GET fpoisk
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    RETURN
ENDIF
fpoisk=CHRTRAN(STRTRAN(fpoisk," ",""),"��������������������������������","��������������������������������")
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H�� ⠪��� ⥪��. ������... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
*
PROCEDURE Chapsn
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
DEFINE WINDOW Chapsn FROM 7,25 TO 22+IIF(chg=5,1,0),63 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chapsn
nstrv=5
nstrn=14
ncoll=0
ncolr=36
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-5 ,ncoll SAY "     ��p���筨� ����� ���㬥�⮢"
@ nstrv-4 ,ncoll SAY "�������������������������������������"
@ nstrv-3 ,ncoll SAY " ���  �      H����������� ����"
@ nstrv-2 ,ncoll SAY "����.�          ���㬥��"
@ nstrv-1 ,ncoll SAY "�������������������������������������"
IF chg=5
    @ nstrn ,ncoll SAY " F3��ଠ� F6-�������. �� ⥪��.䠩��"
ENDIF
RETURN
*
PROCEDURE Strsaysn
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,2 SAY wid_d
@ nstr,7 SAY nam
RETURN
*
PROCEDURE Strgetsn
PARAMETERS nstr,npolscr
PRIVATE nz,fwid_d,scr
nz=RECNO()
IF EMPTY(wid_d)
    GO BOTTOM
    fwid_d=wid_d+1
    GO nz
    REPLACE wid_d WITH fwid_d
ENDIF
DO WHILE .T.
    @ nstr,2 GET wid_d
    READ
    fwid_d=wid_d
    SET ORDER TO wid_d
    IF SEEK(fwid_d)
         SKIP
         IF fwid_d=wid_d
              DO Net_n WITH 10,' ����� ��� 㦥 ����. ������...'
         ELSE
              GO nz
              EXIT
         ENDIF
    ELSE
         DO Net_n WITH 10," �����-� ���p�� � ��⥬�. ������, p��p�襭 ������..."
         RETURN
    ENDIF
    GO nz
ENDDO
@ nstr,7 GET nam
READ
IF chg=5
    DO F3sn
ENDIF
RETURN
*
PROCEDURE F3sn
HIDE WINDOW Chapsn
ACTIVATE SCREEN
SELECT form_ot
SET EXACT OFF
SEEK STR(sprnaz.wid_d,3)
SET EXACT ON
ffnpp=STR(1,6)
DO Vvodn WITH "Chapfo","Strsayfo","Strgetfo",.T.,.T.,.T.,.F.,"STR(sprnaz.wid_d,3)#nf","",;
     "","","","","","F7fo","F8fo","F9fo","","",.T.
SELECT sprnaz
ACTIVATE WINDOW Chapsn
RETURN
*
PROCEDURE F6sn
DEFINE WINDOW Zapros FROM 15,30 TO 17,75 COLOR SCHEME 19 SHADOW
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
ffile=SPACE(25)
@ 0,0 SAY " ���� ��� 䠩���" GET ffile
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
     RETURN
ENDIF
IF FILE(ffile)
    ACTIVATE WINDOW Pog_p
    SET COLOR TO &color15
    @ 0,0 SAY '�'
    SET COLOR TO &color13
    @ 0,1 SAY "��������, ��������..."
    SELECT form_ot
    SET EXACT OFF
    SET NEAR ON
    SEEK STR(sprnaz.wid_d+1,3)
    SET EXACT ON
    SET NEAR OFF
    SKIP -1
    i=IIF(nf=STR(sprnaz.wid_d,3),VAL(npp),0)
    ffile=RTRIM(ffile)
    SELECT 0
    USE rabf EXCLUSIVE
    ZAP
    APPEND FROM &ffile TYPE SDF
    SCAN FOR !DELETE()
         i=i+1
         SELECT form_ot
         APPEND BLANK
         REPLACE nf WITH STR(sprnaz.wid_d,3),npp WITH STR(i,6),text WITH rabf.text
    ENDSCAN
    SELECT rabf
    ZAP
    USE
    SELECT sprnaz
    HIDE WINDOW ALL
    ACTIVATE SCREEN
ELSE
    DO Net_n WITH 10,'�� ������ 䠩� '+ffile+'.'
ENDIF
RETURN
*
*
PROCEDURE Chapob
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=21
ncoll=1
step=1
npolscrm=1
SET COLOR TO &color4
ncolr=78
@ nstrv-9,ncoll-1,nstrv+11+IIF(gpr_val,1,0),ncolr+1 BOX "�ͻ���Ⱥ "
IF nastf_v=0
@ nstrv-8 ,ncoll-1 SAY "�   ���p�⭠� ��������� �������� �������� �।�� �� ���� "+fnzk+" �� "+DTOC(fdat1)
@ nstrv-7 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-6 ,ncoll-1 SAY "� ���줮 �� ��砫� ���: "+TRANSFORM(fsum,'999,999,999,999.99')
ELSE
@ nstrv-8 ,ncoll-1 SAY "�  ��������� �������� �������� �।�� �� ���� "+fnzk+" � "+DTOC(fdat1)+" �� "+DTOC(fdat2)
@ nstrv-7 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-6 ,ncoll-1 SAY "� ���줮 �� ��砫� ��p����: "+TRANSFORM(fsum,'999,999,999,999.99')
ENDIF
@ nstrv-5 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-4 ,ncoll-1 SAY "�H����H���� �     �㬬�     �     �㬬�     � ���   �   H������� �p������樨"
@ nstrv-3 ,ncoll-1 SAY "��室ﳤ���.�    �p�室�    �    p��室�    ��࣠����   (�.�.�. p���⭨��)"
@ nstrv-2 ,ncoll-1 SAY "� 騩 �      �               �               �(ࠡ��)�"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+9 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "� �⮣�      :"
IF gpr_val
@ nstrv+11,ncoll-1 SAY "�                                � ���業��� �� ����� ��� : "
ENDIF
@ nstrv+11+IIF(gpr_val,1,0),ncoll-1 SAY "������������ F1 � ������ ��������������������������� F10 - ����� "
SET COLOR TO &color21
@ nstrv+10,14 SAY STR(sum1,15,2)+" "+STR(sum2,15,2)+" �� ����� ���: "+TRANSFORM(fsum+sum1-sum2,'999,999,999,999.99')
IF gpr_val
@ nstrv+11,60 SAY TRANSFORM(Kurs_dat(spr_bs.vid_val,fdat2,spr_bs.sm_valt+sumv1-sumv2),'999,999,999,999.99')
ENDIF
RETURN
*
PROCEDURE Strsayob
PARAMETERS color,nstr,npolscr
SET COLOR TO &color21
@ nstrv+10,ncoll+13 SAY STR(sum1,15,2)+" "+STR(sum2,15,2)+" �� ����� ���: "+TRANSFORM(fsum+sum1-sum2,'999,999,999,999.99')
SET COLOR TO &color
@ nstr,1  SAY nvx
@ nstr,7  SAY nrd
DO CASE
CASE vo='0'
    @ nstr,14 SAY sm
    @ nstr,30 SAY SPACE(15)
CASE vo='1'
    @ nstr,14 SAY SPACE(15)
    @ nstr,30 SAY sm
ENDCASE
@ nstr,46 SAY kp
@ nstr,54 SAY Spr_nam(pr_spr,kp,25)
SELECT bkr
RETURN
*
PROCEDURE Strgetob
PARAMETERS nstr,npolscr
PRIVATE nz,i,fnvx,fnrd,fsm,fkp
fnvx=nvx
fnrd=nrd
fsm=sm
fkp=kp
SELECT bk
GO bkr.nzap
@ nstr,1 GET nvx
@ nstr,7 GET nrd
IF vo='0'
    @ nstr,14 GET sm
    @ nstr,30 SAY SPACE(15)
ELSE
    @ nstr,14 SAY SPACE(15)
    @ nstr,30 GET sm
ENDIF
@ nstr,46 GET kp VALID IIF(pr_spr='0',Poisk_ta('bk.kp',.F.,nstr,54,25),Poisk_kl('bk.kp',.F.,nstr,54,25)) ERROR 'H�� ⠪��� ����...'
READ
SELECT bkr
REPLACE nvx WITH bk.nvx,nrd WITH bk.nrd,sm WITH bk.sm,kp WITH bk.kp,smo WITH smo+bk.sm-fsm
IF fsm#sm
    IF vo='0'
         sum1=sum1-fsm+sm
    ELSE
         sum2=sum2-fsm+sm
    ENDIF
ENDIF
RETURN
*
*
PROCEDURE Chapss
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
DEFINE WINDOW Chapss FROM 4,0 TO 23,79 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chapss
nstrv=5
nstrn=16
ncoll=0
ncolr=77
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-5 ,ncoll SAY "   � � � �   � � � � � �   � � � � � � � � p � � � � �   � � � � �"
@ nstrv-4 ,ncoll SAY "������������������������������������������������������������������������������"
@ nstrv-3 ,ncoll SAY " �������      H�����������        � H���� �      H�����������        � �ਧ���"
@ nstrv-2 ,ncoll SAY "       �        p������           � ��� �         ���            � ������"
@ nstrv-1 ,ncoll SAY "������������������������������������������������������������������������������"
@ nstrv+11,ncoll SAY "������������������������������������������������������������������������������"
@ nstrv+12,ncoll SAY "�� ��������� �p������樨: F8-����७���,F9-���譨� ������� F10 - ����� ������"
RETURN
*
PROCEDURE Strsayss
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
IF grup#ggrup.AND.pr_v_pr.OR.nstr=nstrv.OR.nstr=nstrn-1
    SELECT spr_grup
    SEEK spr_bs.grup
    SELECT spr_bs
    @ nstr,0 SAY grup
    @ nstr,8 SAY spr_grup.nam
    ggrup=grup
ENDIF
@ nstr,35 SAY bs
@ nstr,43 SAY nam
@ nstr,74 SAY pr_val
RETURN
*
PROCEDURE Strgetss
PARAMETERS nstr,npolscr
@ nstr, 0 GET grup VALID Poisk_sg('spr_bs.grup',.F.,nstr,8,25) ERROR 'H�� ⠪��� ����...'
@ nstr,35 GET bs
@ nstr,43 GET nam
@ nstr,74 GET pr_val VALID pr_val='0'.OR.pr_val='1' ERROR '���祭�� 0 - �����, 1 - ������...'
READ
RETURN
*
PROCEDURE F8ss
IF RECCOUNT()=0
    RETURN
ENDIF
RESTORE FROM nsch ADDITIVE
DEFINE WINDOW Zapros FROM 8,3 TO 14,77 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color13
@ 0,1 SAY '���⥫�騪'+SPACE(45)+'---------------'
@ 1,1 SAY '���'+SPACE(42)+'----------|    ��. N    |'
@ 2,1 SAY '���� ����.'+SPACE(35)+'|   ���   |             |'
@ 3,1 SAY SPACE(45)+'|         |             |'
@ 4,1 SAY '� �.'+SPACE(41)+'------------------------|               |'
SET COLOR TO &color12
@ 0,12 GET nschn1
@ 1, 5 GET nschn3
@ 1,16 GET schn3
@ 2,12 GET scho1
@ 2,57 GET schl
@ 3, 1 GET scho2
@ 3,47 GET schs
@ 3,57 GET schk
@ 4, 6 GET schg
READ
RELEASE WINDOW Zapros
sss=FULLPATH('nsch.mem')
SAVE TO &sss ALL LIKE nsch??
RETURN
*
PROCEDURE F9ss
IF RECCOUNT()=0
    RETURN
ENDIF
DEFINE WINDOW Zapros FROM 8,3 TO 14,77 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color13
@ 0,1 SAY '���⥫�騪'+SPACE(45)+'---------------'
@ 1,1 SAY '���'+SPACE(42)+'----------|    ��. N    |'
@ 2,1 SAY '���� ����.'+SPACE(35)+'|   ���   |             |'
@ 3,1 SAY SPACE(45)+'|         |             |'
@ 4,1 SAY '� �.'+SPACE(41)+'------------------------|               |'
SET COLOR TO &color12
@ 0,12 GET nschn1v
@ 1, 5 GET nschn3v
@ 1,16 GET schn3v
@ 2,12 GET scho1v
@ 2,57 GET schlv
@ 3, 1 GET scho2v
@ 3,47 GET schsv
@ 3,57 GET schkv
@ 4, 6 GET schgv
READ
RELEASE WINDOW Zapros
RETURN
*
*
PROCEDURE Chapsd
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=10
nstrn=21
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-8,ncoll-1,nstrv+13,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-7 ,ncoll-1 SAY "�                ���⪨ �������� �p���� �� ����"
@ nstrv-6 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-5 ,ncoll-1 SAY "� H����������� ���:"
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "����     ���줮      �      �㬬�       �      �㬬�       �  ��⥭樠�쭮�"
@ nstrv-2 ,ncoll-1 SAY "�    �    �� ����     �      �����       �      �p����      �     ᠫ줮"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+11,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+12,ncoll-1 SAY "��⮣"
@ nstrv+13,ncoll-1 SAY "��� F1 - ������ ��� F3 - ����� ��� F4 - �p���� ��� F10 - ����� "
SET COLOR TO &color21
@ nstrv+12, 6 SAY fsumn PICTURE '99,999,999,999.99'
@ nstrv+12,24 SAY fsum1 PICTURE '999,999,999,999.99'
@ nstrv+12,43 SAY fsum2 PICTURE '999,999,999,999.99'
@ nstrv+12,62 SAY fsumk PICTURE '99,999,999,999.99'
RETURN
*
PROCEDURE Strsaysd
PARAMETERS color,nstr,npolscr
IF color#color21
    SET COLOR TO &color21
    @ 5,27 SAY nam
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY bs
@ nstr, 6 SAY sald PICTURE '99,999,999,999.99'
@ nstr,24 SAY sum_pr PICTURE '999,999,999,999.99'
@ nstr,43 SAY sum_rx PICTURE '999,999,999,999.99'
@ nstr,62 SAY sald+sum_pr-sum_rx PICTURE '99,999,999,999.99'
RETURN
*
PROCEDURE Strgetsd
PARAMETERS nstr,npolscr
IF DAY(fdat)#1
    RETURN
ENDIF
PRIVATE sss,scr
sss=sald
IF nastf_8=1.AND.spr_bs.pr_val='1'
    DO Kurs_val WITH 'spr_bs.vid_val',fdat-1,'�㬬�','spr_bs.sm_val','spr_bs.sald','','',''
ELSE
    @ nstr,6 GET sald PICTURE '99,999,999,999.99'
    READ
ENDIF
IF sss#sald
    fsumn=fsumn-sss+sald
    fsumk=fsumn+fsum1-fsum2
    SET COLOR TO &color21
    @ nstrv+12, 6 SAY fsumn PICTURE '99,999,999,999.99'
    @ nstrv+12,62 SAY fsumk PICTURE '99,999,999,999.99'
ENDIF
REPLACE saldm WITH sald
RETURN
*
PROCEDURE F3sd
PRIVATE fdat
ffvid='  '
IF nastf_5=1
    SELECT 0
    USE spr_kart
    SET ORDER TO kod
    DEFINE WINDOW Zapros FROM 15,40 TO 17,59 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " ��� ����⥪�" GET ffvid VALID Poisk_kt(.T.,'ffvid') ERROR 'H�� ⠪��� ����...'
    READ
    RELEASE WINDOW Zapros
    USE
    SELECT spr_bs
    IF EMPTY(ffvid)
         RETURN
    ENDIF
ENDIF
fdat=CTOD("  /  /  ")
SELECT bk
SET ORDER TO bk3
SET EXACT OFF
SEEK RTRIM(spr_bs.bs+DTOC(fdat,1)+'0'+ffvid)
fvo='0'
sum1=0
SCAN REST WHILE nzk=spr_bs.bs.AND.vo=fvo.AND.dat=fdat.AND.(EMPTY(ffvid).OR.pr_usl=ffvid) FOR vo='0'.AND.!DELETE()
    sum1=sum1+sm
ENDSCAN
SEEK RTRIM(spr_bs.bs+DTOC(fdat,1)+fvo+ffvid)
SET EXACT ON
DO Vvodn WITH "Chapdk","Strsaydk","Strgetdk",.F.,.T.,.F.,.T.,"((nzk#spr_bs.bs).OR.(vo#fvo).OR.(dat#fdat).OR.(pr_usl#ffvid).AND.!EMPTY(ffvid))",;
              "","F2dk","","","","","","","","F10dk","",.T.
SELECT spr_bs
RETURN
*
PROCEDURE F4sd
ffvid='  '
IF nastf_5=1
    SELECT 0
    USE spr_kart
    SET ORDER TO kod
    DEFINE WINDOW Zapros FROM 15,40 TO 17,59 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " ��� ����⥪�" GET ffvid VALID Poisk_kt(.T.,'ffvid') ERROR 'H�� ⠪��� ����...'
    READ
    RELEASE WINDOW Zapros
    USE
    SELECT spr_bs
    IF EMPTY(ffvid)
         RETURN
    ENDIF
ENDIF
fdat=CTOD("  /  /  ")
SELECT bk
SET ORDER TO bk3
SET EXACT OFF
SEEK RTRIM(spr_bs.bs+DTOC(fdat,1)+'1'+ffvid)
fvo='1'
sum1=0
sum_vkl=0
sum_vkln=0
sum_vklb=0
SCAN REST WHILE nzk=spr_bs.bs.AND.vo=fvo.AND.dat=fdat.AND.(EMPTY(ffvid).OR.pr_usl=ffvid) FOR vo='1'.AND.!DELETE()
    sum1=sum1+sm
    IF pr_vkl=''
         sum_vkl=sum_vkl+sm
         IF vid_vkl='�'
              sum_vkln=sum_vkln+sm
         ELSE
              sum_vklb=sum_vklb+sm
         ENDIF
    ENDIF
ENDSCAN
SEEK RTRIM(spr_bs.bs+DTOC(fdat,1)+fvo+ffvid)
SET EXACT ON
DO Vvodn WITH "Chapdk","Strsaydk","Strgetdk",.F.,.T.,.F.,.T.,"((nzk#spr_bs.bs).OR.(vo#fvo).OR.(dat#fdat).OR.(pr_usl#ffvid).AND.!EMPTY(ffvid))",;
              "","F2dk","","","F5dk","","","","","F10dk","",.T.
SELECT spr_bs
RETURN
*
*
PROCEDURE Chapdr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=10
nstrn=21
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-6,ncoll-1,nstrv+13,ncolr+1 BOX "�ͻ���Ⱥ "
IF nastf_v=0
@ nstrv-5 ,ncoll-1 SAY "����p�⭠� ��������� �������� �������� �।�� �� ��⠬ �� "+DTOC(fdat1)
ELSE
@ nstrv-5 ,ncoll-1 SAY "�  ��������� �������� �������� �।�� �� ��⠬ � "+DTOC(fdat1)+" �� "+DTOC(fdat2)
ENDIF
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "����     ���줮      �      �p�室      �      ���室      �      ���줮"
@ nstrv-2 ,ncoll-1 SAY "�    �    �� ��砫�    �                  �                  �     �� �����"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+11,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+12,ncoll-1 SAY "��⮣�                 �                  �                  �"
@ nstrv+13,ncoll-1 SAY "���������� F2 - ���p�⪠ �� ���� ����������������������������"
SET COLOR TO &color14
@ nstrv+12, 6 SAY fsumn PICTURE "9,999,999,999,999"
@ nstrv+12,24 SAY fsum1 PICTURE "9,999,999,999,999"
@ nstrv+12,43 SAY fsum2 PICTURE "9,999,999,999,999"
@ nstrv+12,62 SAY fsumk PICTURE "9,999,999,999,999"
RETURN
*
PROCEDURE Strsaydr
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr, 1 SAY bs
@ nstr, 6 SAY sald PICTURE "9,999,999,999,999"
@ nstr,24 SAY sum_pr PICTURE "9,999,999,999,999"
@ nstr,43 SAY sum_rx PICTURE "9,999,999,999,999"
@ nstr,62 SAY sald+sum_pr-sum_rx PICTURE '9,999,999,999,999'
RETURN
*
PROCEDURE F2dr
DO Obor_dn WITH fdat1,fdat2,spr_bs.bs
SELECT spr_bs
RETURN
*
*
PROCEDURE Chapsg
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
DEFINE WINDOW Chapsg FROM 6,30 TO 22,64 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chapsg
nstrv=4
nstrn=15
ncoll=0
ncolr=32
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-4 ,ncoll SAY "        ������� ����� ��⮢"
@ nstrv-3 ,ncoll SAY "����������������������������������"
@ nstrv-2 ,ncoll SAY " �������      H�����������"
@ nstrv-1 ,ncoll SAY "����������������������������������"
RETURN
*
PROCEDURE Strsaysg
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,2 SAY grup
@ nstr,8 SAY nam
RETURN
*
PROCEDURE Strgetsg
PARAMETERS nstr,npolscr
@ nstr,2 GET grup
@ nstr,8 GET nam
READ
RETURN
*
*
PROCEDURE Chapdk
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=21
ncoll=1
step=1
npolscrm=1
SET COLOR TO &color4
ncolr=78
@ nstrv-7,ncoll-1,nstrv+11+tek_b_19,ncolr+1 BOX "�ͻ���Ⱥ "
IF fvo='0'
@ nstrv-6 ,ncoll-1 SAY "�      �����p᪠� ������������� �� ���� "+spr_bs.bs
ELSE
@ nstrv-6 ,ncoll-1 SAY "�      �p����p᪠� ������������� �� ���� "+spr_bs.bs
ENDIF
@ nstrv-5 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-4 ,ncoll-1 SAY "�   ���    ��-���H���� �     �㬬�     � ���   �    H������� �p������樨"
@ nstrv-3 ,ncoll-1 SAY "�    ��     ����������.�               ��࣠����    (�.�.�. p���⭨��)"
@ nstrv-2 ,ncoll-1 SAY "�  ������  ������      �               �(ࠡ��)�"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+9 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "� �⮣�:"+SPACE(32)+IIF(fvo='1',' �ᥣ� �⬥祭�: ','')
IF tek_b_19=1.AND.fvo='1'
@ nstrv+11,ncoll-1 SAY "�         � �.�.: ��������묨 -                , �����묨 -"
ENDIF
@ nstrv+11+tek_b_19,ncoll-1 SAY '��� F2 - ᬥ�� ���� �p���⠢����� '+IIF(fvo='1','�� F5 - �⬥⪠ ','')+'�� F10 - ����� '
RETURN
*
PROCEDURE Strsaydk
PARAMETERS color,nstr,npolscr
SET COLOR TO &color21
@ nstrv+10,25 SAY sum1 PICTURE '999999999999.99'
IF fvo='1'
    @ nstrv+10,ncoll+54 SAY sum_vkl PICTURE '999999999999.99'
    IF tek_b_19=1
         @ nstrv+11,ncoll+32 SAY sum_vklb PICTURE '999999999999.99'
         @ nstrv+11,ncoll+61 SAY sum_vkln PICTURE '999999999999.99'
    ENDIF
ENDIF
SET COLOR TO &color
@ nstr,1 SAY pr_vkl
IF tek_b_19=1
    @ nstr,2 SAY vid_vkl
ENDIF
@ nstr, 4 SAY dati
@ nstr,13 SAY DATE()-dati PICTURE '9999'
@ nstr,18 SAY nrd
@ nstr,25 SAY sm
@ nstr,41 SAY kp
@ nstr,49 SAY Spr_nam(pr_spr,kp,30)
RETURN
*
PROCEDURE Strgetdk
PARAMETERS nstr,npolscr
PRIVATE nz,i,fsum
fsum=sm
@ nstr, 4 GET dati
@ nstr,18 GET nrd
@ nstr,25 GET sm
@ nstr,41 GET kp VALID IIF(pr_spr='0',Poisk_ta('bk.kp',.F.,nstr,49,30),Poisk_kl('bk.kp',.F.,nstr,49,30)) ERROR 'H�� ⠪��� ����...'
READ
IF fsum#sm
    sum1=sum1-fsum+sm
    IF vo='1'
	     sum_vkl=sum_vkl-fsum+sm
         REPLACE spr_bs.sum_rx WITH spr_bs.sum_rx+sm-fsum
    ELSE
         REPLACE spr_bs.sum_pr WITH spr_bs.sum_pr+sm-fsum
	ENDIF
ENDIF
RETURN
*
PROCEDURE F2dk
PRIVATE i
@ 9,25 FILL TO 14,48 COLOR &color20
SET COLOR TO &color13
@ 8,24,13,47 BOX "�ͻ���Ⱥ "
@ 9,25,12,46 BOX "�Ŀ����� "
SET COLOR TO &color14
@ 10,26 PROMPT " �� ��� �� ������ "
@ 11,26 PROMPT " �� �㬬�           "
MENU TO i
IF i=0
    RETURN
ENDIF
DO CASE
CASE i=1
    SET ORDER TO bk3
CASE i=2
     SET ORDER TO bk4
ENDCASE
SET EXACT OFF
SEEK spr_bs.bs+DTOC(fdat,1)+fvo+ffvid
SET EXACT ON
RETURN
*
PROCEDURE F5dk
IF RECCOUNT()=0
	RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
fpoisk=sm
ffnzk=nzk
ffvo=vo
ffdat=dat
ffdati=dati
ffnrd=nrd
ffkor=kor
ffkp=kp
IF EMPTY(pr_vkl)
    DEFINE WINDOW Zapros FROM 11,32 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " �㬬�" GET fpoisk PICTURE '999,999,999,999.99'
    READ
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
	     RETURN
    ENDIF
	IF fpoisk#sm
		ffkpp=kpp
		ffnvx=nvx
		ffwid_d=wid_d
		ffwid_t=wid_t
		fftext_1=text_1
		fftext_2=text_2
		fftext_3=text_3
		fftext_4=text_4
		ffpr_spr=pr_spr
		ffpr_spk=pr_sprk
		ffdat_tov=dat_tov
		ffpr_usl=pr_usl
		REPLACE sm WITH sm-fpoisk
		SEEK RTRIM(spr_bs.bs+DTOC(fdat,1)+fvo+ffvid+DTOC(ffdati,1)+ffkp)
		pr_zap=.F.
     	SCAN WHILE nzk=spr_bs.bs.AND.fdat=dat.AND.vo=fvo.AND.ffvid=pr_usl.AND.dati=ffdati.AND.kp=ffkp FOR RECNO()#nz.AND.kor=ffkor.AND.nrd=ffnrd.AND.sm=0.AND.DELETE()
			RECALL
			pr_zap=.T.
			EXIT
		ENDSCAN
		IF !pr_zap
			APPEND BLANK
		ENDIF
    	REPLACE dati WITH ffdati,wid_d WITH ffwid_d,wid_t WITH ffwid_t,;
                   kp WITH ffkp,nrd WITH ffnrd,dat WITH ffdat,pr_spr WITH ffpr_spr,;
                  kpp WITH ffkpp,pr_sprk WITH ffpr_spk,pr_usl WITH ffpr_usl
    	REPLACE vo WITH ffvo,nzk WITH ffnzk,nvx WITH ffnvx,kor WITH ffkor
    	REPLACE dat_tov WITH ffdat_tov,text_1 WITH fftext_1,text_2 WITH fftext_2,;
                  text_3 WITH fftext_3,text_4 WITH fftext_4
		REPLACE sm WITH fpoisk
	ENDIF
ELSE
	SEEK RTRIM(spr_bs.bs+DTOC(fdat,1)+fvo+ffvid+DTOC(ffdati,1)+ffkp)
	pr_zap=.F.
	SCAN WHILE nzk=spr_bs.bs.AND.fdat=dat.AND.vo=fvo.AND.ffvid=pr_usl.AND.dati=ffdati.AND.kp=ffkp FOR RECNO()#nz.AND.kor=ffkor.AND.nrd=ffnrd.AND.!DELETE()
         REPLACE sm WITH sm+fpoisk
         GO nz
         REPLACE sm WITH 0
         DELETE
         pr_zap=.T.
         EXIT
	ENDSCAN
	IF !pr_zap
		GO nz
	ENDIF
ENDIF
sum_vkl=sum_vkl+IIF(pr_vkl=' ',fpoisk,-fpoisk)
sum_vkln=sum_vkln+IIF(vid_vkl='�',-fpoisk,0)
sum_vklb=sum_vklb+IIF(vid_vkl='�',-fpoisk,0)
REPLACE pr_vkl WITH IIF(pr_vkl=' ','',' ')
REPLACE vid_vkl WITH IIF(pr_vkl=' ',' ','')
IF pr_vkl=''.AND.tek_b_19=1
    @ 17,36 FILL TO 20,57 COLOR &color20
    SET COLOR TO &color13
    @ 16,35,19,56 BOX "�ͻ���Ⱥ "
    SET COLOR TO &color14
    @ 17,36 PROMPT " ������ p����    "
    @ 18,36 PROMPT " ��������� p���� "
    MENU TO i
    DO CASE
    CASE i=1
         REPLACE vid_vkl WITH '�'
         sum_vkln=sum_vkln+fpoisk
    CASE i=2
         REPLACE vid_vkl WITH '�'
         sum_vklb=sum_vklb+fpoisk
    ENDCASE
ENDIF
RETURN
*
*
PROCEDURE Chapkk
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=8
nstrn=18
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-8,ncoll-1,nstrv+16,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-7 ,ncoll-1 SAY "� ��p�窠 �࣠����樨 �� ��p��� � "+DTOC(fdat1)+" �� "+DTOC(fdat2)
@ nstrv-6 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-5 ,ncoll-1 SAY "� �࣠������:"
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "����.�   ���   �   ���   �H���p �   �㬬� ��室�  �  �㬬� ��室�   ����-��"
@ nstrv-2 ,ncoll-1 SAY "���Ⳮ� �����᮳  ������  �����.�                  �                  ��� ���"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+11,ncoll-1 SAY "� �⮣�                    �      �                  �                  �"
@ nstrv+12,ncoll-1 SAY "� � �.�.������祭�         �      �                  �                  �"
@ nstrv+13,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+14,ncoll-1 SAY "�                            ����p���"
@ nstrv+15,ncoll-1 SAY "�         ������           ���ᨬ�         �p����� �p���"
@ nstrv+16,ncoll-1 SAY '���������������� F10 - ����� '
SET COLOR TO &color14
@ nstrv- 5,17 SAY skl.ikl+LEFT(skl.ikld,24)
@ nstrv+11,28 SAY f_kol PICTURE "999999" FUNCTION 'Z'
@ nstrv+11,35 SAY fsumpr PICTURE '999,999,999,999.99' FUNCTION 'Z'
@ nstrv+11,54 SAY fsumrx PICTURE '999,999,999,999.99' FUNCTION 'Z'
@ nstrv+11,75 SAY f_del  PICTURE "9999" FUNCTION 'Z'
@ nstrv+12,35 SAY fsumprn PICTURE '999,999,999,999.99' FUNCTION 'Z'
@ nstrv+12,54 SAY fsumrxn PICTURE '999,999,999,999.99' FUNCTION 'Z'
@ nstrv+15,21 SAY fmin PICTURE "9999" FUNCTION 'Z'
@ nstrv+15,40 SAY fmax PICTURE "9999" FUNCTION 'Z'
@ nstrv+15,72 SAY IIF(f_kol=0,0,ROUND((f_del/f_kol),0)) PICTURE "9999" FUNCTION 'Z'
RETURN
*
PROCEDURE Strsaykk
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    IF vo='0'
         @ 6,35 SAY vid_val
         @ 6,41 SAY sm_val PICTURE '9,999,999.99' FUNCTION 'Z'
         @ 6,54 SAY SPACE(18)
    ELSE
         @ 6,35 SAY SPACE(18)
         @ 6,54 SAY vid_val
         @ 6,60 SAY sm_val PICTURE '9,999,999.99' FUNCTION 'Z'
    ENDIF
    SELECT bkr
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY nzk
@ nstr, 6 SAY dati
@ nstr,17 SAY dat
@ nstr,28 SAY nrd
IF vo='0'
    @ nstr,35 SAY sm PICTURE '999,999,999,999.99'
ELSE
    @ nstr,54 SAY sm PICTURE '999,999,999,999.99'
ENDIF
@ nstr,73 SAY dat-dati PICTURE '9999' FUNCTION 'Z'
RETURN
*
*
PROCEDURE Chapks
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=22
ncoll=15
ncolr=69
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-6,ncoll FILL TO nstrv+12,ncolr+2 COLOR &color20
@ nstrv-7,ncoll-1,nstrv+11,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-6 ,ncoll-1 SAY "�            ���ଠ��   ��   �࣠������"
@ nstrv-5 ,ncoll-1 SAY "�������������������������������������������������������Ķ"
@ nstrv-4 ,ncoll-1 SAY "� ������������:"
@ nstrv-3 ,ncoll-1 SAY "�������������������������������������������������������Ķ"
@ nstrv-2 ,ncoll-1 SAY "� ���   �        H�����������           �     ��த"
@ nstrv-1 ,ncoll-1 SAY "�������������������������������������������������������Ķ"
@ nstrv+11,ncoll-1 SAY "� ����:F2Ī��,F3ĭ���,F4-p/���,F5-����. � F6-��p�窠ͼ"
RETURN
*
PROCEDURE Strsayks
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ nstrv-4,30 SAY skl.ikld
ENDIF
SET COLOR TO &color
@ nstr,15 SAY kkl
@ nstr,23 SAY ikl
@ nstr,55 SAY gor
RETURN
*
PROCEDURE F6ks
ACTIVATE WINDOW Pog_p
SET COLOR TO &color15
@ 0,0 SAY '�'
SET COLOR TO &color13
@ 0,1 SAY "��������, ��������..."
SELECT bkr
ZAP
IF fdat1<CTOD('01'+RIGHT(DTOC(DATE()),8))
    SELECT bk_arc
    SET EXACT OFF
    SEEK skl.kkl
    SET EXACT ON
    *SCAN REST WHILE kp=skl.kkl FOR dat>=fdat1.AND.dat<=fdat2.AND.(EMPTY(fnzk).OR.fnzk=nzk)
    SCAN REST WHILE kp=skl.kkl FOR dat>=fdat1.AND.dat<=fdat2.AND.(kor=fnzk.OR.nzk=fnzk);
                       .AND.(fpr='2'.OR.vo=fpr).AND.pr_spr='1'.AND.!DELETE()
         SELECT bkr
         APPEND BLANK
         REPLACE nzk WITH bk_arc.nzk,dati WITH bk_arc.dati,dat WITH bk_arc.dat,nrd WITH bk_arc.nrd,sm WITH bk_arc.sm,kor WITH bk_arc.kor,;
                  vo WITH bk_arc.vo,kp WITH bk_arc.kp,vid_val WITH bk_arc.vid_val,sm_val WITH bk_arc.sm_val,;
                 kpp WITH bk_arc.kpp
    ENDSCAN
ENDIF
SELECT bk
SET ORDER TO kp_kor
SET EXACT OFF
SEEK skl.kkl
SET EXACT ON
*SCAN REST WHILE kp=skl.kkl FOR (EMPTY(dat).OR.dat>=fdat1.AND.dat<=fdat2).AND.(EMPTY(fnzk).OR.fnzk=nzk)
SCAN REST WHILE kp=skl.kkl FOR (EMPTY(dat).OR.dat>=fdat1.AND.dat<=fdat2).AND.(kor=fnzk.OR.nzk=fnzk);
                  .AND.(fpr='2'.OR.vo=fpr).AND.pr_spr='1'.AND.!DELETE()
    SELECT bkr
    APPEND BLANK
    REPLACE nzk WITH bk.nzk,dati WITH bk.dati,dat WITH bk.dat,nrd WITH bk.nrd,sm WITH bk.sm,kor WITH bk.kor,;
             vo WITH bk.vo,kp WITH bk.kp,vid_val WITH bk.vid_val,sm_val WITH bk.sm_val,;
            kpp WITH bk.kpp
ENDSCAN
SELECT bkr
f_del=0
f_kol=0
fmax=0
fmin=365
fsumpr=0
fsumprn=0
fsumrx=0
fsumrxn=0
SCAN
    f_del=f_del+(dat-dati)
    f_kol=f_kol+1
    IF dat-dati>fmax
         fmax=dat-dati
    ENDIF
    IF dat-dati<fmin
         fmin=dat-dati
    ENDIF
    IF vo='0'
         fsumpr=fsumpr+sm
         IF EMPTY(dat)
              fsumprn=fsumprn+sm
         ENDIF
    ELSE
         fsumrx=fsumrx+sm
         IF EMPTY(dat)
              fsumrxn=fsumrxn+sm
         ENDIF
    ENDIF
ENDSCAN
GO TOP
HIDE WINDOW Pog_p
ACTIVATE SCREEN
DO Vvodn WITH "Chapkk","Strsaykk","",.F.,.F.,.F.,.T.,".F.","",;
     "","","","","","","","","F10kk","",.T.
SELECT skl
RETURN
*
*
PROCEDURE Chapzk
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=21
ncoll=33
ncolr=69
step=1
npolscrm=1
nam_str=''
nam_str1=''
nam_str2=''
DO Nastr WITH "     ���ଠ��    ��    ",RTRIM(nastf_s),"��",37,nam_str
DO Nastr WITH "",RTRIM(nastf_s),"�",6,nam_str1
DO Nastr WITH "         ",RTRIM(nastf_s),"�",30,nam_str2
SET COLOR TO &color4
@ nstrv-5,ncoll FILL TO nstrv+11,ncolr+2 COLOR &color20
@ nstrv-6,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-5 ,ncoll-1 SAY "�"+nam_str+"�"
@ nstrv-4 ,ncoll-1 SAY "�������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "� ���  �       H�����������"
@ nstrv-2 ,ncoll-1 SAY "�"+nam_str1+"�"+nam_str2+"�"
@ nstrv-1 ,ncoll-1 SAY "�������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "�� ����: F2 � ���, F3 - ������������ "
RETURN
*
PROCEDURE Strsayzk
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,33 SAY nzk
@ nstr,40 SAY nam
RETURN
*
PROCEDURE Strgetzk
PARAMETERS nstr,npolscr
@ nstr,33 GET nzk
@ nstr,40 GET nam
READ
RETURN
*
PROCEDURE F2zk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnpd,nz
nz=RECNO()
fnpd=SPACE(LEN(nzk))
DEFINE WINDOW Zapros FROM 10,41 TO 12,54 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY ' ���' GET fnpd
READ
RELEASE WINDOW Zapros
SET ORDER TO kodzk
IF EMPTY(fnpd)
    RETURN
ENDIF
IF !SEEK(fnpd)
    DO Net_n WITH 14," H�� ⠪��� ����. ����p��..."
    GO nz
ENDIF
RETURN
*
PROCEDURE F3zk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnam,nz
nz=RECNO()
fnam=SPACE(LEN(nam))
DEFINE WINDOW Zapros FROM 10,19 TO 12,65 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY ' ������������' GET fnam
READ
RELEASE WINDOW Zapros
SET ORDER TO nam
IF EMPTY(fnam)
    RETURN
ENDIF
SET EXACT OFF
IF !SEEK(RTRIM(fnam))
    DO Net_n WITH 14," H�� ⠪��� ������������. ����p��..."
    GO nz
ENDIF
SET EXACT ON
RETURN
*
*
PROCEDURE Chapd_
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=22
ncoll=1
step=1
npolscrm=1
SET COLOR TO &color4
ncolr=77
@ nstrv-7-nastf_4,ncoll FILL TO nstrv+12,ncolr+2 COLOR &color20
@ nstrv-8-nastf_4,ncoll-1,nstrv+11,ncolr+1 BOX "�ͻ���Ⱥ "
IF ALIAS()='DV_PR'
    @ nstrv-7-nastf_4,12 SAY '� � � � � � � �     � �    � � � � � � � � � � �'
ELSE
    @ nstrv-7-nastf_4,8 SAY '� � � � �    � � � � � � � �     � �    � � � � � � � � � � �'
ENDIF
@ nstrv-6-nastf_4,ncoll-1 SAY '�����������������������������������������������������������������������������Ķ'
@ nstrv-5-nastf_4,ncoll-1 SAY '� �p��������:'
IF nastf_4=1
@ nstrv-5 ,ncoll-1 SAY '� ���ࠧ�������: '
ENDIF
@ nstrv-4 ,ncoll-1 SAY '���������������������������������������������������'+IIF(nastf_8=1,' ��� ������ ','������������')+'��������������Ķ'
@ nstrv-3 ,ncoll-1 SAY '����.�   ���   �   �����  �  ���  ����.�                  �'
@ nstrv-2 ,ncoll-1 SAY '���ⳮp������� ������� �        ����    C㬬� �����   �    C㬬� �।��'
@ nstrv-1 ,ncoll-1 SAY '�����������������������������������������������������������������������������Ķ'
@ nstrv+11,ncoll-1 SAY '�� F1 � ������ ���� ����: F2 � �࣠������, F3 - ������� '+IIF(ALIAS()='DV_PR','���� F6 � ���� ','')
RETURN
*
PROCEDURE Strsayd_
PARAMETERS color,nstr,npolscr
IF color#color21
    SET COLOR TO &color21
    @ 6-nastf_4,15 SAY Spr_nam(pr_spr,kp,30)
    IF nastf_4=1
         @ 6,17 SAY nsk
         @ 6,23 SAY Spr_nam('2',nsk,30)
    ENDIF
    IF nastf_8=1
         @ 7,63 SAY vid_val
         @ 8,41 SAY sm_vald PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ 8,60 SAY sm_valk PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY bs
@ nstr, 6 SAY pr_spr
@ nstr, 8 SAY kp
@ nstr,16 SAY dog
@ nstr,27 SAY dat
@ nstr,36 SAY kor
@ nstr,41 SAY smd PICTURE '999,999,999,999.99'
@ nstr,60 SAY smk PICTURE '999,999,999,999.99'
RETURN
*
PROCEDURE Strgetd_
PARAMETERS nstr,npolscr
IF EMPTY(kp)
    @ 6-nastf_4,15 SAY SPACE(30)
    IF nastf_4=1
         @ 6,17 SAY SPACE(36)
    ENDIF
    IF nastf_8=1
         @ 7,63 SAY SPACE(6)
         @ 8,41 SAY SPACE(18)
         @ 8,60 SAY SPACE(18)
    ENDIF
ENDIF
@ nstr, 1 GET bs  VALID Poisk_sc('dv_pr.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
@ nstr, 6 GET pr_spr VALID pr_spr='0'.OR.pr_spr='1' ERROR '���祭�� 0 - p���⭨�, 1 - �p��������'
@ nstr, 8 GET kp  VALID IIF(pr_spr='1',Poisk_kl('dv_pr.kp',.F.,6-nastf_4,15,30),Poisk_ta('dv_pr.kp',.F.,6-nastf_4,15,30)) ERROR 'H�� ⠪��� ����...'
@ nstr,16 GET dog
@ nstr,27 GET dat
@ nstr,36 GET kor VALID Poisk_sc('dv_pr.kor',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
IF nastf_8=1
    @ 7,63 GET vid_val VALID Poisk_wl('dv_pr.vid_val',.F.,0,0,0) ERROR 'H�� ⠪�� ������...'
    @ 8,41 GET sm_vald PICTURE '999,999,999,999.99' VALID Repl_sum('smd',vid_val,sm_vald,dat,nstr,41)
    @ 8,60 GET sm_valk PICTURE '999,999,999,999.99' VALID Repl_sum('smk',vid_val,sm_valk,dat,nstr,60)
ENDIF
@ nstr,41 GET smd PICTURE '999,999,999,999.99'
@ nstr,60 GET smk PICTURE '999,999,999,999.99'
IF nastf_4=1
    @ 6,17 GET nsk VALID Poisk_ns('dv_pr.nsk',.F.,6,23,30) ERROR 'H�� ⠪��� ����...'
ENDIF
READ
IF nastf_0=1
    SAVE SCREEN TO scr
    @ 20,24 FILL TO 22,63 COLOR &color20
    SET COLOR TO &color13
    @ 19,23,21,62 BOX "�ͻ���Ⱥ "
    SET COLOR TO &color14
    @ 20,25 SAY '�����' GET text
    READ
    RESTORE SCREEN FROM scr
ENDIF
IF nastf_7=1.AND.LEFT(kor,1)='2'
    SAVE SCREEN TO scr
    @ 20,44 FILL TO 22,60 COLOR &color20
    SET COLOR TO &color13
    @ 19,43,21,59 BOX "�ͻ���Ⱥ "
    SET COLOR TO &color14
    @ 20,45 SAY nastf_s GET nzk VALID Poisk_nz('dv_pr.nzk',.F.,0,0,0) ERROR 'H�� ⠪��� ����...'
    READ
    RESTORE SCREEN FROM scr
ENDIF
RETURN
*
PROCEDURE F2d_
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,fpoisk,fpoisk1,fpoisk2
nz=RECNO()
fpoisk=kp
fpoisk1=SPACE(10)
DEFINE WINDOW F2d_ FROM 13,24 TO 15,51 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW F2d_
SET COLOR TO &color14
@ 0,1 SAY "H���� �������" GET fpoisk1
READ
RELEASE WINDOW F2d_
IF LASTKEY()=27.AND.EMPTY(fpoisk1)
    RETURN
ENDIF
SET ORDER TO kp_dog
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk+fpoisk1))
    DO Net_n WITH 11,"H�� ⠪�� ���ଠ樨. ������..."
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F6d_
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fbs,ftab,fnvx,fdat,fnzk,fnsk,scr,fnds,fsp,fsmk,nz,ff
nz=RECNO()
fnds=SPACE(4)
fsp=SPACE(4)
SAVE SCREEN TO scr
@ 18,41 FILL TO 21,70 COLOR &color20
SET COLOR TO &color13
@ 17,40,20,69 BOX "�ͻ���Ⱥ "
SET COLOR TO &color14
@ 18,41 SAY ' ����.��� ���.......' GET fnds VALID Poisk_sc('fnds',.T.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
@ 19,41 SAY ' ����.��� ᯥ歠����' GET fsp  VALID Poisk_sc('fsp',.T.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
READ
RESTORE SCREEN FROM scr
IF LASTKEY()=27.AND.READKEY()#271
    RETURN
ENDIF
fbs=bs
fkp=kp
fpr_spr=pr_spr
fdog=dog
fdat=dat
fnsk=nsk
fnzk=nzk
ftext=text
ffk=smk
ffd=smd
RESTORE FROM tek_b ADDITIVE
REPLACE smk WITH ROUND(smk*100.0/(100.0+tek_b_30+tek_b_31),tek_b_36),smd WITH ROUND(smd*100.0/(100.0+tek_b_30+tek_b_31),tek_b_36)
fsmk=smk
fsmd=smd
APPEND BLANK
REPLACE bs WITH fbs,kp WITH fkp,pr_spr WITH fpr_spr,dog WITH fdog,dat WITH fdat,nzk WITH fnzk,;
       nsk WITH fnsk,kor WITH fnds,text WITH ftext
REPLACE smk WITH ROUND(fsmk*tek_b_30/100.0,tek_b_36),smd WITH ROUND(fsmd*tek_b_30/100.0,tek_b_36)
RELEASE ALL LIKE tek_b_??
ffk=ffk-fsmk-smk
ffd=ffd-fsmd-smd
APPEND BLANK
REPLACE bs WITH fbs,kp WITH fkp,pr_spr WITH fpr_spr,dog WITH fdog,dat WITH fdat,nzk WITH fnzk,;
       nsk WITH fnsk,kor WITH fsp,text WITH ftext
REPLACE smk WITH ffk,smd WITH ffd
GO nz
RETURN
*
*
PROCEDURE Chaps_
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=22
ncoll=1
step=1
npolscrm=1
SET COLOR TO &color4
ncolr=IIF(nastf_4=0,72,78)
@ nstrv-7,ncoll FILL TO nstrv+12,ncolr+2 COLOR &color20
@ nstrv-8,ncoll-1,nstrv+11,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv- 7,ncoll-1 SAY '�        � � � � � � �    � �    � � � � � � � � � � �'
@ nstrv- 6,ncoll-1 SAY '�������������������������������������������������������������������������'+IIF(nastf_4=0,'','������')+'�'
@ nstrv-5 ,ncoll-1 SAY '� �p��������:'
@ nstrv-4 ,ncoll-1 SAY '����������������������������������������������'+IIF(nastf_8=1,' ��� ������ ','������������')+'���������������'+IIF(nastf_4=0,'','������')+'�'
@ nstrv-3 ,ncoll-1 SAY '����.�   ���   �   �����  �  ���  �                  �                  '+IIF(nastf_4=0,'','����p.')
@ nstrv-2 ,ncoll-1 SAY '���ⳮp������� ������� �        �   C㬬� �����    �    C㬬� �।��  '+IIF(nastf_4=0,'','�     ')
@ nstrv-1 ,ncoll-1 SAY '�������������������������������������������������������������������������'+IIF(nastf_4=0,'','������')+'�'
@ nstrv+11,ncoll-1 SAY '�� F1 � ������ ��� ����: F2 - �࣠������, F3 - ������� '
RETURN
*
PROCEDURE Strsays_
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 6,15 SAY Spr_nam(pr_spr,kp,30)
    IF nastf_8=1
         @ 7,58 SAY vid_val
         @ 8,36 SAY sm_vald PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ 8,55 SAY sm_valk PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY bs
@ nstr, 6 SAY pr_spr
@ nstr, 8 SAY kp
@ nstr,16 SAY dog
@ nstr,27 SAY dat
@ nstr,36 SAY db PICTURE '999,999,999,999.99'
@ nstr,55 SAY kr PICTURE '999,999,999,999.99'
IF nastf_4=1
    @ nstr,74 SAY nsk
ENDIF
RETURN
*
PROCEDURE Strgets_
PARAMETERS nstr,npolscr
IF EMPTY(kp)
    @ 6,15 SAY SPACE(30)
    IF nastf_8=1
         @ 7,58 SAY SPACE(6)
         @ 8,36 SAY SPACE(11)
         @ 8,55 SAY SPACE(11)
    ENDIF
ENDIF
@ nstr, 1 GET bs VALID Poisk_sc('osd_pr.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
@ nstr, 6 GET pr_spr VALID pr_spr='0'.OR.pr_spr='1' ERROR '���祭�� 0 - p���⭨�, 1 - �p��������'
@ nstr, 8 GET kp VALID IIF(pr_spr='1',Poisk_kl('osd_pr.kp',.F.,6,15,30),Poisk_ta('osd_pr.kp',.F.,6,15,30)) ERROR 'H�� ⠪��� ����...'
@ nstr,16 GET dog
@ nstr,27 GET dat
IF nastf_8=1
    @ 7,58 GET vid_val VALID Poisk_wl('osd_pr.vid_val',.F.,0,0,0) ERROR 'H�� ⠪�� ������...'
    @ 8,36 GET sm_vald PICTURE '999,999,999,999.99' VALID Repl_sum('db',vid_val,sm_vald,dat,nstr,36)
    @ 8,55 GET sm_valk PICTURE '999,999,999,999.99' VALID Repl_sum('kr',vid_val,sm_valk,dat,nstr,55)
ENDIF
@ nstr,36 GET db PICTURE '999,999,999,999.99'
@ nstr,55 GET kr PICTURE '999,999,999,999.99'
IF nastf_4=1
    @ nstr,74 GET nsk VALID Poisk_ns('osd_pr.nsk',.F.,0,0,0) ERROR 'H�� ⠪��� ����...'
ENDIF
READ
IF nastf_0=1
    SAVE SCREEN TO scr
    @ 20,24 FILL TO 22,63 COLOR &color20
    SET COLOR TO &color13
    @ 19,23,21,62 BOX "�ͻ���Ⱥ "
    SET COLOR TO &color14
    @ 20,25 SAY '�����' GET text
    READ
    RESTORE SCREEN FROM scr
ENDIF
RETURN
*
PROCEDURE F2s_
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,fpoisk,fpoisk1,fpoisk2
nz=RECNO()
@ 14,24 FILL TO 18,52 COLOR &color20
SET COLOR TO &color13
@ 13,23,17,51 BOX box_1
SET COLOR TO &color14
fpoisk=bs
fpoisk1=SPACE(7)
fpoisk2=SPACE(10)
@ 14,25 SAY "�����ᮢ� ���" GET fpoisk VALID Poisk_sc('fpoisk',.T.,.F.,0,0,0,' ','.F.') ERROR '��� ⠪��� ���...'
@ 15,25 SAY "��� �࣠����樨" GET fpoisk1 VALID Poisk_kl('fpoisk1',.T.,0,0,0) ERROR 'H�� ⠪��� ����...'
@ 16,25 SAY "H���� �������." GET fpoisk2
READ
IF LASTKEY()=27.AND.EMPTY(fpoisk1)
    RETURN
ENDIF
SET ORDER TO bs_kp
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk+fpoisk1+fpoisk2))
    DO Net_n WITH 11,"H�� ⠪��� ���ଠ樨. ������..."
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3s_
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
fpoisk=SPACE(10)
DEFINE WINDOW Zapros FROM 13,23 TO 15,51 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "H���� �������" GET fpoisk
READ
RELEASE WINDOW Zapros
IF EMPTY(fpoisk)
    RETURN
ENDIF
SET ORDER TO dog
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 11,"H�� ⠪��� ����. ������..."
    GO nz
ENDIF
SET EXACT ON
RETURN
*
*
PROCEDURE Chaptg
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=4
nstrn=14
ncoll=0
ncolr=25
step=1
npolscrm=1
DEFINE WINDOW Chaptg FROM 6,41 TO 21,68 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chaptg
SET COLOR TO &color4
@ nstrv-4,ncoll SAY "    ��ࠢ�筨� p�������"
@ nstrv-3,ncoll SAY "��������������������������"
@ nstrv-2,ncoll SAY " ��� �   H�����������"
@ nstrv-1,ncoll SAY "��������������������������"
RETURN
*
PROCEDURE Strsaytg
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,0 SAY kod
@ nstr,5 SAY nam
RETURN
*
PROCEDURE Strgettg
PARAMETERS nstr,npolscr
@ nstr,0 GET kod
@ nstr,5 GET nam
READ
RETURN
*
*
PROCEDURE Chaplm
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=21
ncoll=21
ncolr=62
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-4,ncoll FILL TO nstrv+11,ncolr+2 COLOR &color20
@ nstrv-5,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-4 ,ncoll-1 SAY '�           ��ࠢ�筨� ����⮢'
@ nstrv-3 ,ncoll-1 SAY '������������������������������������������Ķ'
@ nstrv-2 ,ncoll-1 SAY '� ��� �    H�����������    �      �㬬�'
@ nstrv-1 ,ncoll-1 SAY '������������������������������������������Ķ'
@ nstrv+10,ncoll-1 SAY '������ F9 - ᢮� ���� F10 - ���p��������� '
RETURN
*
PROCEDURE Strsaylm
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,21 SAY kod
@ nstr,27 SAY nam
@ nstr,48 SAY summa
RETURN
*
PROCEDURE Strgetlm
PARAMETERS nstr,npolscr
PRIVATE scr
@ nstr,21 GET kod
@ nstr,27 GET nam
@ nstr,48 GET summa
READ
RETURN
*
*
PROCEDURE Chapnp
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=21
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-6,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-5 ,ncoll-1 SAY "�         H���p���� ��p�室������ ���p����� � ��p���"
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "�         �᫮���          �             ��p������                  ���pp�ᯮ�.�"
@ nstrv-2 ,ncoll-1 SAY "�                          �                                        �   ���   �"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "����� F1 � ������ "
RETURN
*
PROCEDURE Strsaynp
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr, 1 SAY LEFT(usl,26)
@ nstr,28 SAY form
@ nstr,69 SAY kor
RETURN
*
PROCEDURE Strgetnp
PARAMETERS nstr,npolscr
@ nstr, 1 GET usl FUNCTION 'S26'
@ nstr,28 GET form
@ nstr,69 GET kor
READ
RETURN
*
*
PROCEDURE Chapnr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=21
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-6,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-5 ,ncoll-1 SAY "�         H���p���� ���᪠ ���p����� �� ��p���"
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "����������-�         �᫮���          �          ��p������          ���pp�ᯮ�.�"
@ nstrv-2 ,ncoll-1 SAY "� ��� 䠩���                          �                             �   ���   �"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "����� F1 � ������ "
RETURN
*
PROCEDURE Strsaynr
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr, 1 SAY nam_fil
@ nstr,12 SAY LEFT(usl,26)
@ nstr,39 SAY LEFT(form,29)
@ nstr,69 SAY kor
RETURN
*
PROCEDURE Strgetnr
PARAMETERS nstr,npolscr
@ nstr, 1 GET nam_fil
@ nstr,12 GET usl FUNCTION 'S26'
@ nstr,39 GET form FUNCTION 'S29'
@ nstr,69 GET kor
READ
RETURN
*
*
PROCEDURE Chapwl
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
DEFINE WINDOW Chapwl FROM 6,25 TO 22,64 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chapwl
nstrv=5
nstrn=15
ncoll=0
ncolr=37
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-5,ncoll SAY "   � � � � � � � � � �    � � � � �"
@ nstrv-4,ncoll SAY "��������������������������������������"
@ nstrv-3,ncoll SAY " ���  �         H�����������          "
@ nstrv-2,ncoll SAY "������            ������             "
@ nstrv-1,ncoll SAY "��������������������������������������"
RETURN
*
PROCEDURE Strsaywl
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,0 SAY kod
@ nstr,7 SAY nam
RETURN
*
PROCEDURE Strgetwl
PARAMETERS nstr,npolscr
@ nstr,0 GET kod
@ nstr,7 GET nam
READ
RETURN
*
*
PROCEDURE Chapkl
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=22
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-5,ncoll FILL TO nstrv+11,ncolr+2 COLOR &color20
@ nstrv-6,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-5 ,ncoll-1 SAY "�            � � � � � � � � � �    � � p � � �    � � � � �"
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "� ���  �         H�����������       � � ������ �    �㬬� �    �    �㬬� �    �"
@ nstrv-2 ,ncoll-1 SAY "�������            ������          �   �᫠  �    �㡫��     �    �����     �"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "����� F1 � ������ "
RETURN
*
PROCEDURE Strsaykl
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
SELECT spr_val
SEEK kurs_val.kod
SELECT kurs_val
@ nstr, 1 SAY kod
@ nstr, 8 SAY spr_val.nam
@ nstr,37 SAY datn
@ nstr,48 SAY summa
@ nstr,64 SAY kurs
RETURN
*
PROCEDURE Strgetkl
PARAMETERS nstr,npolscr
IF EMPTY(kod)
    REPLACE kurs WITH 1
ENDIF
@ nstr, 1 GET kod VALID Poisk_wl('kurs_val.kod',.F.,nstr,8,30) ERROR 'H�� ⠪�� ������...'
@ nstr,37 GET datn
@ nstr,48 GET summa
@ nstr,64 GET kurs
READ
RETURN
*
*
PROCEDURE Chapkt
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
DEFINE WINDOW Chapkt FROM 6,41 TO 21,68 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chapkt
nstrv=4
nstrn=14
ncoll=0
ncolr=25
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-4,ncoll SAY " ��ࠢ�筨� ����� ����⥪"
@ nstrv-3,ncoll SAY "��������������������������"
@ nstrv-2,ncoll SAY " ��� �   H�����������"
@ nstrv-1,ncoll SAY "��������������������������"
RETURN
*
PROCEDURE Strsaykt
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,1 SAY kod
@ nstr,6 SAY nam
RETURN
*
PROCEDURE Strgetkt
PARAMETERS nstr,npolscr
@ nstr,1 GET kod
@ nstr,6 GET nam
READ
RETURN
*
*
PROCEDURE Prov
PARAMETERS str_pr
* �p���p�� �� ��pp��⭮��� �����
PRIVATE n_len,i,k
n_len=LEN(RTRIM(str_pr))
i=1
FOR i=1 TO n_len
    k=SUBSTR(str_pr,i,1)
    IF !(k>="(".AND.k<="?".OR.k>="a".AND.k<="z".OR.;
       k>="A".AND.k<="Z".OR.k="_".OR.k="'".OR.k=" ")
         RETURN .F.
    ENDIF
ENDFOR
RETURN .T.
*
*
PROCEDURE Poisk_wd
PARAMETERS fname,pr_memo,n_str,n_poz,kol_zn
*
* fname   - ��� ��p������� ��� ⥪�饣� ����
* pr_memo - �p����� ��p������� (.T.) ��� ���� (.F.)
* n_str   - ����p ��p���
* n_poz   - ����p ����樨
* kol_zn  - ������⢮ ������ ������������ ��� �뢮��
*
PRIVATE f_poisk,nam_file
nam_file=ALIAS()
SELECT sprnaz
IF &fname=0
    DO WHILE &fname=0
         DO Vvodn WITH "Chapsn","Strsaysn","Strgetsn",.T.,.T.,.F.,.F.,".F.","",;
              "","","","","","","","","","",.F.
         IF pr_memo
              &fname=wid_d
         ELSE
              REPLACE &fname WITH wid_d
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO wid_d
    f_poisk=SEEK(&fname)
ENDIF
IF n_str#0
    @ n_str,n_poz SAY LEFT(sprnaz.nam,kol_zn)
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN f_poisk
*
*
PROCEDURE Poisk_wl
PARAMETERS fname,pr_memo,n_str,n_poz,kol_zn
*
* fname   - ��� ��p������� ��� ⥪�饣� ����
* pr_memo - �p����� ��p������� (.T.) ��� ���� (.F.)
* n_str   - ����p ��p���
* n_poz   - ����p ����樨
* kol_zn  - ������⢮ ������ ������������ ��� �뢮��
*
PRIVATE f_poisk,nam_file
nam_file=ALIAS()
SELECT spr_val
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         ACTIVATE SCREEN
         DO Vvodn WITH "Chapwl","Strsaywl","Strgetwl",.T.,.T.,.F.,.F.,".F.","",;
              "","","","","","","","","","",.F.
         IF pr_memo
              &fname=kod
         ELSE
              REPLACE &fname WITH kod
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO kod
    f_poisk=SEEK(&fname)
ENDIF
IF n_str#0
    @ n_str,n_poz SAY LEFT(spr_val.nam,kol_zn)
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN f_poisk
*
*
PROCEDURE Poisk_wt
PARAMETERS fname,fmemo
*
* fname   - ��� ⥪�饣� ����
*
PRIVATE f_poisk,nam_file
nam_file=ALIAS()
SELECT sprt
SET ORDER TO wid_t
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         DO Vvodn WITH "Chapsw","Strsaysw","Strgetsw",.T.,.T.,.F.,.F.,".F.","",;
                       "F2sw","F3sw","","","","","","","","",.F.
         IF fmemo
              &fname=wid_t
         ELSE
              REPLACE &fname WITH wid_t
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO wid_t
    f_poisk=SEEK(&fname)
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
IF fmemo
    ftext_1=sprt.text_1
    ftext_2=sprt.text_2
    ftext_3=sprt.text_3
    ftext_4=sprt.text_4
ELSE
    *IF EMPTY(text_1).AND.EMPTY(text_2).AND.EMPTY(text_3).AND.EMPTY(text_4)
         REPLACE text_1 WITH sprt.text_1, text_2 WITH sprt.text_2,;
                 text_3 WITH sprt.text_3, text_4 WITH sprt.text_4
                    * vid_op WITH sprt.vid_op,nazn_pl WITH sprt.nazn_pl
       IF !EMPTY(sprt.vid_op)
          REPLACE vid_op WITH sprt.vid_op
       ENDIF
       IF !EMPTY(sprt.nazn_pl)
          REPLACE nazn_pl WITH sprt.nazn_pl
       ENDIF
    *ENDIF
ENDIF
RETURN f_poisk
*
*
PROCEDURE Poisk_tg
PARAMETERS fname
*
* fname  - ��� ⥪�饣� ����
*
PRIVATE f_poisk,nam_file,nz
nam_file=ALIAS()
SELECT spr_reg
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         DO Vvodn WITH "Chaptg","Strsaytg","Strgettg",.T.,.T.,.F.,.F.,".F.","",;
                       "","","","","","","","","","",.F.
         REPLACE &fname WITH kod
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO kod
    nz=RECNO()
    f_poisk=SEEK(&fname)
    IF !f_poisk
         IF RECCOUNT()#0
              GO nz
         ENDIF
    ENDIF
ENDIF
IF !EMPTY(nam_file)
    SELECT &nam_file
ENDIF
RETURN f_poisk
*
*
PROCEDURE Poisk_kt
PARAMETERS fmemo,fname
*
* fname  - ��� ⥪�饣� ����
*
PRIVATE f_poisk,nam_file,nz
nam_file=ALIAS()
SELECT spr_kart
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         DO Vvodn WITH "Chapkt","Strsaykt","Strgetkt",.T.,.T.,.F.,.F.,".F.","",;
                       "","","","","","","","","","",.F.
         IF fmemo
              &fname=kod
         ELSE
              REPLACE &fname WITH kod
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO kod
    nz=RECNO()
    f_poisk=SEEK(&fname)
    IF !f_poisk
         IF RECCOUNT()#0
              GO nz
         ENDIF
    ENDIF
ENDIF
IF !EMPTY(nam_file)
    SELECT &nam_file
ENDIF
RETURN f_poisk
*
PROCEDURE Poisk_alia
PARAMETERS nam_alias
PRIVATE i,s
FOR i=1 TO 25
	s='SELECT '+STR(i,2)
	&s
    IF ALIAS()=nam_alias
         RETURN .T.
    ENDIF
ENDFOR
RETURN .F.
*
PROCEDURE Net_n
PARAMETERS nn_str,nam_titr
PRIVATE n
n=INT((80-LEN(nam_titr))/2)
DEFINE WINDOW Zapros FROM nn_str,n-2 TO nn_str+2,82-n COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY nam_titr
READ
RELEASE WINDOW Zapros
RETURN
*
*
PROCEDURE Chapop
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=14
nstrn=22
ncoll=33
ncolr=77
step=1
npolscrm=1
@ nstrv-3,ncoll FILL TO nstrv+9,ncolr+2 COLOR &color20
SET COLOR TO &color4
@ nstrv-4,ncoll-1,nstrv+8,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-4,ncoll-1 SAY "����������������������������������������������"
@ nstrv-3,ncoll-1 SAY "�  ���  � �����       �㬬�      ��/�糌����"
@ nstrv-2,ncoll-1 SAY "� ������ �����.�      ������      ����.�� ���"
@ nstrv-1,ncoll-1 SAY "���������������������������������������������Ķ"
@ nstrv+8,ncoll-1 SAY "�� F3 - �⮣ "
RETURN
*
PROCEDURE Strsayop
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,33 SAY dat
@ nstr,42 SAY nrd
@ nstr,49 SAY summa PICTURE '999,999,999,999.99'
@ nstr,68 SAY nzk
@ nstr,73 SAY ms
@ nstr,76 SAY god
RETURN
*
PROCEDURE Strgetop
PARAMETERS nstr,npolscr
IF EMPTY(uni)
    REPLACE uni WITH ffuni
ENDIF
@ nstr,33 GET dat
@ nstr,42 GET nrd
@ nstr,49 GET summa PICTURE '999,999,999,999.99'
@ nstr,68 GET nzk VALID Poisk_sc('tran_opl.nzk',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
@ nstr,73 GET ms
@ nstr,76 GET god
READ
RETURN
*
PROCEDURE F3op
PRIVATE fsum
fsum=0
SET EXACT OFF
IF SEEK(STR(ffuni,7))
    SCAN REST WHILE ffuni=uni FOR !DELETE()
         fsum=fsum+summa
    ENDSCAN
    DO Net_n WITH 11,"�㬬� "+TRANSFORM(fsum,'999,999,999,999.99')
ENDIF
SEEK STR(ffuni,7)
SET EXACT ON
RETURN
*
*
PROCEDURE Chapnd
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=21
ncoll=25
ncolr=72
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-4,ncoll FILL TO nstrv+11,ncolr+2 COLOR &color20
@ nstrv-5,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-4 ,ncoll-1 SAY '�     ��ࠢ�筨� ��᫥���� ����஢ ���㬥�⮢'
@ nstrv-3 ,ncoll-1 SAY '������������������������������������������������Ķ'
@ nstrv-2 ,ncoll-1 SAY '��/��    H����������� ���   ���������� �����'
@ nstrv-1 ,ncoll-1 SAY '������������������������������������������������Ķ'
RETURN
*
PROCEDURE Strsaynd
PARAMETERS color,nstr,npolscr
SELECT spr_bs
SET ORDER TO bs
SEEK spr_nrd.bs
SELECT spr_nrd
SET COLOR TO &color
@ nstr,25 SAY bs
@ nstr,30 SAY spr_bs.nam
@ nstr,57 SAY vo
@ nstr,60 SAY IIF(vo='0','��室','���室')
@ nstr,67 SAY nrd
RETURN
*
PROCEDURE Strgetnd
PARAMETERS nstr,npolscr
PRIVATE scr
@ nstr,25 GET bs VALID Poisk_sc('spr_nrd.bs',.F.,.F.,nstr,30,30,' ','.F.') ERROR '��� ⠪��� ���...'
@ nstr,57 GET vo VALID vo='0'.OR.vo='1' ERROR '0 - ��室, 1 - ��室...'
@ nstr,67 GET nrd
READ
RETURN
*
*
PROCEDURE Chapkr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=22
ncoll=1
ncolr=78
step=1
npolscrm=1
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-9,ncoll FILL TO nstrv+11,ncolr+2 COLOR &color20
@ nstrv-10,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-9 ,ncoll-1 SAY '�          � � � � � � � � � �    � � � � � � � �'
@ nstrv-8 ,ncoll-1 SAY '������������������������������������������������������������������������������Ķ'
@ nstrv-7 ,ncoll-1 SAY '� �࣠������:                                �㬬� ��業⮢:'
@ nstrv-6 ,ncoll-1 SAY '�                                          �����饭��� �㬬�:'
@ nstrv-5 ,ncoll-1 SAY '� ��ਮ��筮��� �믫��� %, ���           �믫�祭�� ��業��:'
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "�  ���  �   �����  �   ���   �   ���   �  %   �% ��   �      �㬬�      ��-��"
@ nstrv-2 ,ncoll-1 SAY "��࣠���� ������� �  �뤠�  � ������ ��।�� ����.�     �।��     �����"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "�� F3 - �⮣ ��� F4 - ��� ��� F5 - �ନ஢���� ������ ��� F10 - ����� "
RETURN
*
PROCEDURE Strsaykr
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 5,15 SAY Spr_nam('1',kp,30)
    @ 5,62 SAY sum_proc PICTURE '99,999,999,999.99'
    @ 6,62 SAY summav   PICTURE '99,999,999,999.99'
    @ 7,62 SAY summap   PICTURE '99,999,999,999.99'
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY kp
@ nstr, 9 SAY dog
@ nstr,20 SAY datn
@ nstr,31 SAY dato
@ nstr,42 SAY pr_kred
@ nstr,50 SAY pr_pen
@ nstr,57 SAY summa PICTURE '99,999,999,999.99'
@ nstr,75 SAY kol_dn
RETURN
*
PROCEDURE Strgetkr
PARAMETERS nstr,npolscr
IF usl='.F.'
    @ nstr,1 GET kp VALID Poisk_kl('kredit.kp',.F.,5,15,30) ERROR 'H�� ⠪�� �p������樨...'
ELSE
    REPLACE kp WITH bk.kp
    @ nstr,1 SAY kp
    @ 5,15 SAY Spr_nam('1',kp,30)
ENDIF
@ nstr, 9 GET dog
@ nstr,20 GET datn
@ nstr,31 GET dato
@ nstr,42 GET pr_kred
@ nstr,50 GET pr_pen
@ nstr,57 GET summa PICTURE '99,999,999,999.99'
@ nstr,75 GET kol_dn
@ 6,62 GET summav PICTURE '99,999,999,999.99'
@ 7,62 GET summap PICTURE '99,999,999,999.99'
READ
RESTORE FROM tek_b ADDITIVE
REPLACE sum_proc WITH IIF(tek_b_34=0,0,summa*IIF(kol_dn>dato-datn,dato-datn,kol_dn)*pr_kred/(100.0*tek_b_34)+summa*IIF(kol_dn>dato-datn,kol_dn-(dato-datn),0)*pr_pen/(100.0*tek_b_34))
RELEASE ALL LIKE tek_b_??
RETURN
*
PROCEDURE F3kr
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fsumv,nz,scr,fsum
nz=RECNO()
fsum=0
fsumv=0
SCAN
    fsum=fsum+sum_proc
    fsumv=fsumv+summap
ENDSCAN
DO Net_n WITH 6,"�ᥣ� - "+LTRIM(TRANSFORM(fsum,'999,999,999,999.99'))+", ����祭� - "+LTRIM(TRANSFORM(fsumv,'999,999,999,999.99'))+", ���� - "+LTRIM(TRANSFORM(fsum-fsumv,'999,999,999,999.99'))
GO nz
RETURN
*
PROCEDURE F4kr
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
@ 15,34 FILL TO 17,51 COLOR &color20
SET COLOR TO &color13
@ 14,33,16,50 BOX "�ͻ���Ⱥ "
SET COLOR TO &color14
fdat=DATE()
@ 15,35 SAY " ���" GET fdat
READ
IF LASTKEY()=27
    RETURN
ENDIF
RESTORE FROM tek_b ADDITIVE
REPLACE ALL kol_dn WITH 0
SCAN FOR datn<fdat
    REPLACE kol_dn WITH fdat-datn
    REPLACE sum_proc WITH IIF(tek_b_34=0,0,summa*IIF(kol_dn>dato-datn,dato-datn,kol_dn)*pr_kred/(100.0*tek_b_34)+summa*IIF(kol_dn>dato-datn,kol_dn-(dato-datn),0)*pr_pen/(100.0*tek_b_34))
ENDSCAN
RELEASE ALL LIKE tek_b_??
GO nz
RETURN
*
PROCEDURE F5kr
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,fsumk,fsump
nz=RECNO()
ACTIVATE WINDOW Pog_p
SET COLOR TO &color15
@ 0,0 SAY '�'
SET COLOR TO &color13
@ 0,1 SAY "��������, ��������..."
SELECT bk
SET ORDER TO bk2
SELECT 0
USE bk_arc
SET ORDER TO kp
SELECT kredit
SET EXACT OFF
SCAN
    SELECT bk
    SEEK nastf_j+kredit.kp
    fsumk=0
    fsump=0
    SCAN REST WHILE kor=nastf_j.AND.kp=kredit.kp FOR vo='1'.AND.kredit.dog=dog.AND.!DELETE()
         IF kred='0'
              fsumk=fsumk+sm
         ELSE
              fsump=fsump+sm
         ENDIF
    ENDSCAN
    SELECT bk_arc
    SEEK kredit.kp
    SCAN REST WHILE kp=kredit.kp FOR vo='1'.AND.kor=nastf_j.AND.kredit.dog=dog.AND.!DELETE()
         IF kred='0'
              fsumk=fsumk+sm
         ELSE
              fsump=fsump+sm
         ENDIF
    ENDSCAN
    SELECT kredit
    REPLACE summav WITH fsumk,summap WITH fsump
ENDSCAN
SET EXACT ON
SELECT bk_arc
USE
SELECT kredit
HIDE WINDOW Pog_p
ACTIVATE SCREEN
GO nz
RETURN
*
PROCEDURE Poisk_kr
PARAMETERS fname,pr_memo
*
* fname   - ��� ��p������� ��� ⥪�饣� ����
* pr_memo - �p����� ��p������� (.T.) ��� ���� (.F.)
*
PRIVATE fpoisk_,nam_file,nz
nam_file=STR(SELECT(),2)
SELECT 0
USE kredit
SET ORDER TO kp_dog
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         SET EXACT OFF
         SEEK bk.kp
         SET EXACT ON
         DO Vvodn WITH "Chapkr","Strsaykr","Strgetkr",.T.,.T.,.F.,.F.,"kredit.kp#bk.kp","","","","","","","","","","","",.F.
         IF pr_memo
              &fname=dog
         ELSE
              REPLACE &fname WITH dog
         ENDIF
    ENDDO
    fpoisk_=.T.
ELSE
    SET ORDER TO kp_dog
    IF EOF()
         GO TOP
    ENDIF
    nz=RECNO()
    fpoisk_=SEEK(bk.kp+&fname)
    IF !fpoisk_
         IF RECCOUNT()#0
              GO nz
         ENDIF
    ENDIF
ENDIF
USE
IF !EMPTY(nam_file)
    SELECT &nam_file
ENDIF
RETURN fpoisk_
*
*
PROCEDURE Chapar
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-9 ,ncoll-1,nstrv+11,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-8 ,ncoll-1 SAY "�          � � � � �    � � � � � � � �    � �     � � � � � � � � � � �"
@ nstrv-7 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-6 ,ncoll-1 SAY "� ���p���������:"
@ nstrv-5 ,ncoll-1 SAY "� �����⥫�:"
@ nstrv-4 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY '� H���p� �����    ���    �  ���    ����.����.�       C㬬�      � ��� � �����'
@ nstrv-2 ,ncoll-1 SAY '���.����  ��� �            ��࣠�����������       �����      ����p.� � ���'
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+11,ncoll-1 SAY "�� ����: F2 � �࣠������, F3 - ����� ���㬥�� �� F4 - �⮣ �� F10 - ����� "
RETURN
*
PROCEDURE Strsayar
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    SELECT sch
    SEEK avot_arc.nsk
    @ 6,17 SAY sch.icsk
    SELECT avot_arc
    @ 7,15 SAY Spr_nam(pr_spr,kp,30)
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY nrd
@ nstr, 8 SAY nvx
@ nstr,16 SAY dat
@ nstr,28 SAY pr_spr
@ nstr,30 SAY kp
@ nstr,38 SAY bs
@ nstr,43 SAY kor
@ nstr,48 SAY smd PICTURE '999,999,999,999.99'
@ nstr,67 SAY nsk
@ nstr,73 SAY ms
@ nstr,76 SAY god
RETURN
*
PROCEDURE F2ar
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk1,fpoisk2,nz
nz=RECNO()
fpoisk1=SPACE(LEN(skl.kkl))
fpoisk2=SPACE(LEN(nrd))
@ 14,24 FILL TO 17,50 COLOR &color20
SET COLOR TO &color13
@ 13,23,16,51 BOX box_1
SET COLOR TO &color14
@ 14,25 SAY "��� �࣠����樨..." GET fpoisk1 VALID Poisk_kl('fpoisk1',.T.,0,0,0) ERROR 'H�� ⠪�� �࣠����樨...'
@ 15,25 SAY "H���� ����.���㬥�" GET fpoisk2
READ
IF EMPTY(fpoisk1)
     RETURN
ENDIF
SET ORDER TO kp_nrd
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk1+fpoisk2))
    DO Net_n WITH 10," H�� ⠪�� ���p��樨..."
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3ar
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
fpoisk=SPACE(LEN(nrd))
DEFINE WINDOW Zapros FROM 13,23 TO 15,53 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "H���� ����.���㬥��" GET fpoisk
READ
RELEASE WINDOW Zapros
IF EMPTY(fpoisk)
     RETURN
ENDIF
SET ORDER TO nrd
SET EXACT OFF
IF !SEEK(fpoisk)
    DO Net_n WITH 10," H�� ⠪�� ���p��樨..."
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4ar
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnrd,nz,fsum
nz=RECNO()
SET ORDER TO bs_kp
fbs=bs
fkp=kp
fnrd=nrd
fsum=0
fms=ms
fgod=god
SET EXACT OFF
IF SEEK(fbs+fkp+fnrd)
    SUM smd TO fsum REST WHILE fbs=bs.AND.fkp=kp.AND.fnrd=nrd FOR ms=fms.AND.fgod=god
    DO Net_n WITH 14,"�㬬� "+TRANSFORM(fsum,'999,999,999,999.99')+"..."
ENDIF
SET EXACT ON
GO nz
RETURN
*
*
PROCEDURE Chapdm
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=13
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-12,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-11,ncoll-1 SAY "�                   � � � � � � � �     � �     � � � �"
@ nstrv-10,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv- 9,ncoll-1 SAY "� ���:                                  ���p���:              �      �㬬�"
@ nstrv- 8,ncoll-1 SAY "� �����⥫�/���⠢騪:                                        �    �� ��ப�"
@ nstrv- 7,ncoll-1 SAY "� ���ਠ�:                     ���� (�p����)                �"
@ nstrv- 6,ncoll-1 SAY "� �/���:       ��.���.:             (�� ����)                �"
@ nstrv- 5,ncoll-1 SAY "��������������������������������������������������������������������Ċ�pp.���Ķ"
@ nstrv- 4,ncoll-1 SAY "�������� � H����        �          �   ���   � H���p������������.�"
@ nstrv- 3,ncoll-1 SAY "���������� ����-�  ���  �H���p TTH/�������./����⥦�   �����     �����������Ķ"
@ nstrv- 2,ncoll-1 SAY "���    � ���⠳        ���� ����糯��⠢騪�����.�             �������⢮ �"
@ nstrv- 1,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
RETURN
*
PROCEDURE Strsaydm
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    IF vo='0'
         @ 4,50 SAY '�p�室'
    ELSE
         @ 4,50 SAY 'p��室'
    ENDIF
    SELECT sch
    SEEK dv_mol.nsk
    @ 4,7 SAY sch.icsk
    SELECT matr
    SET ORDER TO mat
    SEEK dv_mol.mat
    @ 7,25 SAY matr.izm
    @ 7,10 SAY matr.bs
    @ 6,12 SAY matr.nam
    @ 6,48 SAY matr.cen
    @ 7,48 SAY dv_mol.cen
    SELECT dv_mol
    @ 5,24 SAY Spr_nam(pr_spr,kp,30)
    @ 6,64 SAY summa
    @ 9,70 SAY kor
    fvo=vo
    fnsk=nsk
    fnrd=nrd
    fnp=np
    fpr_spr=pr_spr
    fkp=kp
    fnpt=npt
ENDIF
SET COLOR TO &color
@ nstr,2  SAY vo
@ nstr,4  SAY nsk
@ nstr,10 SAY nrd
@ nstr,17 SAY dat
IF vo='0'
    @ nstr,26 SAY np
ELSE
    @ nstr,26 SAY datv
    @ nstr,34 SAY SPACE(2)
ENDIF
@ nstr,37 SAY pr_spr
@ nstr,39 SAY kp
@ nstr,47 SAY npt
@ nstr,54 SAY mat
@ nstr,68 SAY kol
RETURN
*
*
PROCEDURE Chapfo
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
npolscrm=1
SCAN REST WHILE nf=STR(sprnaz.wid_d,3) FOR !DELETE().AND.!EMPTY(SUBSTR(text,78,51))
    npolscrm=2
    EXIT
ENDSCAN
SET EXACT OFF
SEEK STR(sprnaz.wid_d,3)
SET EXACT ON
nstrv=3
nstrn=24
ncoll=1
ncolr=78
step=1
SET COLOR TO &color4
@ nstrv-3,ncoll-1,nstrv+21,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-2 ,ncoll-1 SAY "� ��室��� �ଠ: "+sprnaz.nam
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+21,2 SAY ' F7 - �⬥⪠ ��ப� ��� ����஢����: F8 - ⥪��� ���, F9 - ��㣠� ��� '
IF npolscrm=2
    SAVE SCREEN
    @ nstrv+10,ncolr+1 SAY ''
    @ nstrv+11,ncolr+1 SAY ''
    @ nstrv+12,ncolr+1 SAY ''
    @ nstrv+13,ncolr+1 SAY ''
    @ nstrv+14,ncolr+1 SAY ''
    SAVE SCREEN TO scr
    RESTORE SCREEN
    @ nstrv+10,ncoll-1 SAY ''
    @ nstrv+11,ncoll-1 SAY ''
    @ nstrv+12,ncoll-1 SAY ''
    @ nstrv+13,ncoll-1 SAY ''
    @ nstrv+14,ncoll-1 SAY ''
    SAVE SCREEN TO scr1
    RESTORE SCREEN FROM scr
ENDIF
RETURN
*
PROCEDURE Strsayfo
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    ffnpp=npp
ENDIF
SET COLOR TO &color13
@ nstr,ncoll SAY pr_otm
SET COLOR TO &color
DO CASE
CASE npolscr=1
    @ nstr,ncoll+1 SAY LEFT(text,77)
CASE npolscr=2
    @ nstr,ncoll+1 SAY SUBSTR(text,78,51)
ENDCASE
RETURN
*
PROCEDURE Strgetfo
PARAMETERS nstr,npolscr
PRIVATE nz,fnpp
IF EMPTY(nf)
    nz=RECNO()
    REPLACE nf WITH STR(sprnaz.wid_d,3)
    SET NEAR ON
    SET EXACT OFF
    SEEK STR(sprnaz.wid_d+1,3)
    SET EXACT ON
    SET NEAR OFF
    SKIP -1
    DO WHILE nf=STR(sprnaz.wid_d,3).AND.npp>ffnpp
         REPLACE npp WITH STR(VAL(npp)+1,6)
         SKIP -1
    ENDDO
    GO nz
    REPLACE npp WITH STR(VAL(ffnpp)+1,6)
    SELECT razm_ot
    SET NEAR ON
    SEEK STR(sprnaz.wid_d+1,3)
    SET NEAR OFF
    SKIP -1
    DO WHILE nf=form_ot.nf.AND.npp>ffnpp
         REPLACE npp WITH STR(VAL(npp)+1,6)
         SKIP -1
    ENDDO
    SELECT form_ot
ENDIF
DO CASE
CASE npolscr=1
    @ nstr,ncoll+1 GET text FUNCTION 'S77'
    READ
CASE npolscr=2
    IF !EMPTY(SUBSTR(text,78,51))
         KEYBOARD REPLICATE('{RIGHTARROW}',126)
         @ nstr,ncoll GET text FUNCTION 'S51'
         READ
    ENDIF
ENDCASE
IF npolscrm=1.OR.npolscr=2
    DO Form_raz
ENDIF
RETURN
*
PROCEDURE F7fo
REPLACE pr_otm WITH IIF(EMPTY(pr_otm),'',' ')
RETURN
*
PROCEDURE F8fo
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,i,nzz,j,ii
nz=RECNO()
i=1
DO WHILE .T.
    SET EXACT OFF
    SEEK STR(sprnaz.wid_d,3)
    SET EXACT ON
    ii=0
    SCAN REST WHILE STR(sprnaz.wid_d,3)=nf FOR !EMPTY(pr_otm)
         ii=ii+1
         IF ii=i
              j=npp
              ftext=text
              EXIT
         ENDIF
    ENDSCAN
    i=ii+1
    IF STR(sprnaz.wid_d,3)#nf
         GO nz
         RETURN
    ENDIF
    APPEND BLANK
    nz=RECNO()
    REPLACE nf WITH STR(sprnaz.wid_d,3),text WITH ftext
* ��⠢�� ��ப�
    SET NEAR ON
    SET EXACT OFF
    SEEK STR(sprnaz.wid_d+1,3)
    SET EXACT ON
    SET NEAR OFF
    SKIP -1
    DO WHILE nf=STR(sprnaz.wid_d,3).AND.npp>ffnpp
         REPLACE npp WITH STR(VAL(npp)+1,6)
         SKIP -1
    ENDDO
    GO nz
    REPLACE npp WITH STR(VAL(ffnpp)+1,6)
    SELECT razm_ot
    SET NEAR ON
    SEEK STR(sprnaz.wid_d+1,3)
    SET NEAR OFF
    SKIP -1
    DO WHILE nf=form_ot.nf.AND.npp>ffnpp
         REPLACE npp WITH STR(VAL(npp)+1,6)
         SKIP -1
    ENDDO
* ����஢���� ࠧ��⪨
    SELECT razm_ot
    SEEK STR(sprnaz.wid_d,3)+j
    SCAN REST WHILE nf=STR(sprnaz.wid_d,3).AND.j=npp
         nzz=RECNO()
         fformt=formt
         fformula=formula
         fobozn_f=obozn_f
         fnam=nam
         fnom_n=nom_n
         fnom_k=nom_k
         fvid_f=vid_f
         APPEND BLANK
         REPLACE formt WITH fformt,formula WITH fformula,obozn_f WITH fobozn_f,;
                    nf WITH STR(sprnaz.wid_d,3),nam WITH fnam,nom_n WITH fnom_n,nom_k WITH fnom_k;
                 vid_f WITH fvid_f,npp WITH form_ot.npp
         GO nzz
    ENDSCAN
    SELECT form_ot
    ffnpp=npp
ENDDO
RETURN
*
PROCEDURE F9fo
IF RECCOUNT()=0
    RETURN
ENDIF
SELECT sprnaz
fnf=wid_d
DEFINE POPUP Tekm FROM 7,25 TO 20,75 PROMPT FIELD Nam COLOR SCHEME 19 SHADOW
ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
ACTIVATE POPUP Tekm
IF LASTKEY()=27
    SELECT sprnaz
    SEEK fnf
    SELECT form_ot
    RETURN
ENDIF
ffnf=STR(wid_d,3)
PRIVATE nz,i,nzz,j,ii
SELECT form_ot
nz=RECNO()
i=1
DO WHILE .T.
    SET EXACT OFF
    SEEK ffnf
    SET EXACT ON
    ii=0
    SCAN REST WHILE ffnf=nf FOR !EMPTY(pr_otm)
         ii=ii+1
         IF ii=i
              j=npp
              ftext=text
              EXIT
         ENDIF
    ENDSCAN
    i=ii+1
    IF ffnf#nf
         SELECT sprnaz
         SEEK fnf
         SELECT form_ot
         GO nz
         RETURN
    ENDIF
    APPEND BLANK
    nz=RECNO()
    REPLACE nf WITH STR(fnf,3),text WITH ftext
* ��⠢�� ��ப�
    SET NEAR ON
    SET EXACT OFF
    SEEK STR(fnf+1,3)
    SET EXACT ON
    SET NEAR OFF
    SKIP -1
    DO WHILE nf=STR(fnf,3).AND.npp>ffnpp
         REPLACE npp WITH STR(VAL(npp)+1,6)
         SKIP -1
    ENDDO
    GO nz
    REPLACE npp WITH STR(VAL(ffnpp)+1,6)
    SELECT razm_ot
    SET NEAR ON
    SEEK STR(fnf+1,3)
    SET NEAR OFF
    SKIP -1
    DO WHILE nf=STR(fnf,3).AND.npp>ffnpp
         REPLACE npp WITH STR(VAL(npp)+1,6)
         SKIP -1
    ENDDO
* ����஢���� ࠧ��⪨
    SELECT razm_ot
    SEEK ffnf+j
    SCAN REST WHILE nf=ffnf.AND.j=npp
         nzz=RECNO()
         fformt=formt
         fformula=formula
         fobozn_f=obozn_f
         fnam=nam
         fnom_n=nom_n
         fnom_k=nom_k
         fvid_f=vid_f
         APPEND BLANK
         REPLACE formt WITH fformt,formula WITH fformula,obozn_f WITH fobozn_f,;
                    nf WITH STR(fnf,3),nam WITH fnam,nom_n WITH fnom_n,nom_k WITH fnom_k;
                 vid_f WITH fvid_f,npp WITH form_ot.npp
         GO nzz
    ENDSCAN
    SELECT form_ot
    ffnpp=npp
ENDDO
RETURN
*
*
PROCEDURE Form_raz
PRIVATE i,j,ii,n1,n2,scr,scr1
SAVE SCREEN TO scr1
*    ��ࠡ�⪠ ࠧ��⪨
i=1
j=1
DO WHILE !EMPTY(AT('',text,i))
    n1=AT('',text,i)
    i=i+1
    n2=AT('',text,i)
    IF EMPTY(AT('',text,i))
         DO Net_n WITH 10,'�����४⭠ ࠧ��⪠ � ⥪�饩 ��ப�...'
         RESTORE SCREEN FROM scr1
         RETURN
    ENDIF
    SELECT razm_ot
    SEEK form_ot.nf+form_ot.npp
    ii=0
    SCAN REST WHILE nf=form_ot.nf.AND.npp=form_ot.npp FOR !DELETE()
         ii=ii+1
         IF ii=j
              EXIT
         ENDIF
    ENDSCAN
    IF ii<j
         APPEND BLANK
         REPLACE nf WITH form_ot.nf,npp WITH form_ot.npp
    ENDIF
    REPLACE nom_n WITH n1,nom_k WITH n2
    fform=IIF(EMPTY(formt),REPLICATE('9',n2-n1+1),RIGHT(RTRIM(REPLICATE('9',n2-n1+1)+formt),n2-n1+1))
*   �।������� ��� �ନ஢���� ࠧ��⪨
    DEFINE WINDOW Zapros FROM 8,0 TO 17,78 COLOR SCHEME 19 SHADOW
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color13
    @ 1,0 SAY REPLICATE("�",77)
    DO CASE
    CASE n2<=77
         @ 0,1 SAY LEFT(form_ot.text,77)
         SET COLOR TO &color14
         @ 0,n1 SAY ''
         @ 0,n2 SAY ''
    CASE n1>77
         @ 0,1 SAY SUBSTR(form_ot.text,78,50)
         SET COLOR TO &color14
         @ 0,n1-77 SAY ''
         @ 0,n2-77 SAY ''
    OTHERWISE
         @ 0,1 SAY SUBSTR(form_ot.text,n1,77)
         SET COLOR TO &color14
         @ 0,1 SAY ''
         @ 0,n2-n1+1 SAY ''
    ENDCASE
    SET COLOR TO &color13
    @ 2, 1 SAY '��� ��ࠦ���� ( 0 - ��������, 1 - ����塞�� )' GET vid_f VALID vid_f='0'.OR.vid_f='1' ERROR '����୮� ���祭��...'
    @ 3, 1 SAY '������祭��' GET nam
    @ 3,31 SAY '��ଠ� ' GET fform VALID Provf(fform) ERROR '�����४⭠ ������...'
    READ
    IF LASTKEY()=27
         SELECT form_ot
         RELEASE WINDOW Zapros
         ACTIVATE SCREEN
         RESTORE SCREEN FROM scr1
         RETURN
    ENDIF
    REPLACE formt WITH fform
    DO CASE
    CASE vid_f='0'
         REPLACE formula WITH SPACE(80),obozn_f WITH SPACE(10)
    CASE vid_f='1'
         REPLACE obozn_f WITH SPACE(10)
         @ 4,1 SAY '��ࠦ����  ' GET formula
         READ
         IF LASTKEY()=27
              SELECT form_ot
              RELEASE WINDOW Zapros
              ACTIVATE SCREEN
              RESTORE SCREEN FROM scr1
              RETURN
         ENDIF
    ENDCASE
    RELEASE WINDOW Zapros
    ACTIVATE SCREEN
    SELECT form_ot
    j=j+1
    i=i+1
ENDDO
RESTORE SCREEN FROM scr1
RETURN
*
*
PROCEDURE Provf
PARAMETERS str_pr
* �p���p�� �� ��pp��⭮��� �����
PRIVATE n_len,i,k
n_len=LEN(RTRIM(str_pr))
i=1
FOR i=1 TO n_len
    k=SUBSTR(str_pr,i,1)
    IF k#'9'.AND.k#','.AND.k#".".AND.k#"X"
         RETURN .F.
    ENDIF
ENDFOR
RETURN .T.
*
*
PROCEDURE Poisk_sg
PARAMETERS fname,pr_memo,n_str,n_poz,kol_zn
*
* fname   - ��� ��p������� ��� ⥪�饣� ����
* pr_memo - �p����� ��p������� (.T.) ��� ���� (.F.)
* n_str   - ����p ��p���
* n_poz   - ����p ����樨
* kol_zn  - ������⢮ ������ ������������ ��� �뢮��
*
PRIVATE f_poisk,nam_file
nam_file=ALIAS()
SELECT spr_grup
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         DO Vvodn WITH "Chapsg","Strsaysg","Strgetsg",.T.,.T.,.F.,.T.,".F.","",;
              "","","","","","","","","","",.F.
         IF pr_memo
              &fname=grup
         ELSE
              REPLACE &fname WITH grup
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO grup
    f_poisk=SEEK(&fname)
ENDIF
IF n_str#0
    @ n_str,n_poz SAY LEFT(spr_grup.nam,kol_zn)
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN f_poisk
*
*
PROCEDURE Poisk_sb
PARAMETERS fname,pr_memo
*
* fname   - ��� ��p������� ��� ⥪�饣� ����
* pr_memo - �p����� ��p������� (.T.) ��� ���� (.F.)
*
PRIVATE f_poisk,nam_file
nam_file=ALIAS()
SELECT spr_vid
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         DO Vvodn WITH "Chapsb","Strsaysb","Strgetsb",.T.,.T.,.F.,.F.,".F.","",;
                       "","","","","","","","","","",.F.
         IF pr_memo
              &fname=kod
         ELSE
              REPLACE &fname WITH kod
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO kod
    SET EXACT OFF
    f_poisk=SEEK(&fname)
    SET EXACT ON
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN f_poisk
*
*
FUNCTION Checkpass
PARAMETERS nCase
PRIVATE cpass,i
IF Cryppass("WithoutPas") = tek_b_45   && �� ��⠭�����
	RETURN .T.
ENDIF
IF nCase=1
	WAIT WINDOW "������ ��஫�..." NOWAIT
ENDIF
FOR i=1 TO 3
	cpass=getpass(nCase)
	IF TYPE("CPASS") = "L"		&& ����� Esc
		RETURN .F.
	ENDIF
	IF CPASS = 'KOV'
		RETURN .T.
	ENDIF
    IF Cryppass(cpass) = tek_b_45
		RETURN .T.
	ENDIF
	?? REPLICATE(CHR(7),4)
	WAIT WINDOW STR(i,1)+". ��஫� �� ��७! ������ ����." NOWAIT
ENDFOR
WAIT WINDOW "����⪠ ��ᠭ�樮��஢������ ����㯠 !"
IF nCase = 1
    RETURN .F.
ENDIF
RETURN .F.
*
*
FUNCTION Getpass
PARAMETERS nCase
PRIVATE icol,cpass,nc
DEFINE WINDOW pass FROM 10,20 TO 12,45 SHADOW COLOR n/w
ACTIVATE WINDOW pass
@ 0,2 SAY "��஫� ?: "
icol=COL()
cpass=""
DO WHILE LEN(cpass) < 10
    nc=ABS(INKEY(0))
    DO CASE
    CASE nc=27
         IF nCase = 1
              QUIT
         ELSE
              RELEASE WINDOW pass
              RETURN .F.
         ENDIF
    CASE nc=13
         IF EMPTY(cpass)
              LOOP
         ELSE
              EXIT
         ENDIF
    CASE nc=127  && Backspace
         IF EMPTY(cpass)
              LOOP
         ENDIF
         cpass=LEFT(cpass,LEN(cpass)-1)
         icol=icol-1
         @ 0,icol SAY " "
         @ 0,icol
         LOOP
    ENDCASE
    cpass=cpass+CHR(nc)
    @ 0,icol SAY "*"
    icol=icol+1
ENDDO
RELEASE WINDOW pass
RETURN cpass
*
*
FUNCTION cryppass
PARAMETERS cpass
PRIVATE cKey,i,cCod
cpass=padr(cpass,len(tek_b_45)-1)
cKey=substr(tek_b_45,1,1)
cCod=cKey
FOR i=1 TO LEN(cpass)
	cCod=cCod+chr((asc(substr(cpass,i,1))+asc(cKey)+i)%256)
ENDFOR
RETURN cCod
*
*
FUNCTION fpass1
PARAMETERS nCase
PRIVATE cpass1,cpass2
*��⠭����� (nCase=1) / �������� (nCase=2)
WAIT WINDOW "������ "+IIF(nCase=1,"","���� ")+"��஫� ��� ��⠭����..." NOWAIT
cpass1=Getpass(2)
IF TYPE("CPASS1") = "L"      && ����� Esc
	RETURN .F.
ENDIF
WAIT WINDOW "...������ ��஫� �� ࠧ..." NOWAIT
cpass2=Getpass(2)
IF TYPE("CPASS2") = "L"      && ����� Esc
    RETURN .F.
ENDIF
IF cpass1 == cpass2
    DO setpass WITH cpass1
    IF nCase=1
		mk1="DISABLE"
		mk2=""
    ENDIF
    RETURN .T.
ENDIF
WAIT WINDOW "H����� ���� ��஫�! ������." NOWAIT
RETURN .F.
*
*
PROCEDURE Setpass
PARAMETERS cpass1
PRIVATE cKey,cCod,i,cali
cpass1=padr(cpass1,LEN(tek_b_45)-1)
=RAND(-1)
cKey=CHR(int((250+1)*RAND()+5))
cCod=cKey
FOR i=1 TO LEN(cpass1)
     cCod=cCod+chr((ASC(SUBSTR(cpass1,i,1))+ASC(cKey)+i)%256)
ENDFOR
tek_b_45=cCod
RETURN
*
*
FUNCTION Fpass2
WAIT WINDOW "������ ���� ��஫�..." NOWAIT
IF !checkpass(2)
    RETURN .F.
ENDIF
IF ncp = 1
*	��������
    IF !fpass1(2)  && ����� Esc ��� �訡��
         RETURN .F.
    ENDIF
ELSE
*	�⪫����
    DO setpass WITH "WithoutPas"
	mk1=""
	mk2="DISABLE"
ENDIF
RETURN .T.
*
*
PROCEDURE Chappr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=13
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-13,ncoll-1,nstrv+10,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-12,ncoll-1 SAY "�                   � � � � � � � � �    � � � � � � � � �                     �"
@ nstrv-11,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv-10,ncoll-1 SAY "� �����:                                                       �     �㬬�     �"
@ nstrv-9 ,ncoll-1 SAY "� ������:                                                    �   �� ��ப�   �"
@ nstrv-8 ,ncoll-1 SAY "� ��ࠢ�⥫�:                                                 �               �"
@ nstrv-7 ,ncoll-1 SAY "� ���ਠ�:                      ���� (�p����)                ���������������Ķ"
@ nstrv-6 ,ncoll-1 SAY "�                                    (�� ����)                �   ��pp.���   �"
@ nstrv-5 ,ncoll-1 SAY "��������������������������������������������������������������Ĵ               �"
@ nstrv-4 ,ncoll-1 SAY "� H����          �H���ೂ���  ���  �H���� �             �     ���������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "���室�H���� TTH �᪫�-����� ���-����⥦�H���������멳 ������⢮�  ���   �"
@ nstrv-2 ,ncoll-1 SAY "�����.�          ���   ��� ��⥫��ॡ���   �����     �           �         �"
@ nstrv-1 ,ncoll-1 SAY "������������������������������������������������������������������������������Ķ"
@ nstrv+10,ncoll-1 SAY "�� F1 � ������ ��� F2 � ���� ��� F3 � �⮣ �� ���㬥��� "
RETURN
*
PROCEDURE Strsaypr
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 3,15 SAY Spr_nam('2',nsk,30)
    DO CASE
    CASE vo="07"
         @ 5,15 SAY Spr_nam('2',kp,30)
    CASE vo="05"
         @ 5,15 SAY Spr_nam('1',kp,30)
    CASE vo="06"
         @ 5,15 SAY Spr_nam('0',kp,30)
    ENDCASE
    SELECT so
    SEEK pr.vo
    @ 4,15 SAY so.nop
    SELECT matr
    SET ORDER TO mat
    SEEK pr.mat
    @ 6,12 SAY matr.nam
    @ 6,48 SAY matr.cen
    @ 7,48 SAY pr.cen
    @ 7,9 SAY SPACE(25)
    SELECT pr
    @ 5,64 SAY summa
    @ 8,72 SAY kor
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY npd
@ nstr, 8 SAY np
@ nstr,19 SAY nsk
@ nstr,25 SAY vo
@ nstr,29 SAY kp
@ nstr,37 SAY npt
@ nstr,44 SAY mat
@ nstr,58 SAY kol
@ nstr,70 SAY dat
RETURN