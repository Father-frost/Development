DEFINE POPUP Video FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Video PROMPT " �\<�������� �믫��� �������஢����     "
DEFINE BAR 2 OF Video PROMPT " �p\<娢 �室��� ���ଠ樨              "
ON SELECTION POPUP Video DO Video WITH BAR()
ACTIVATE POPUP Video
RETURN
*
PROCEDURE Video
PARAMETERS ch1
PRIVATE nz,nzz
DO CASE
CASE ch1=1
    fdat1=DATE()
    fdat2=DATE()
    SET COLOR TO &color13
    IF nastf_v=0
         DEFINE WINDOW Zapros FROM 12,45 TO 14,71 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " �� ����� �᫮" GET fdat1
         READ
         fdat2=fdat1
    ELSE
         DEFINE WINDOW Zapros FROM 12,45 TO 15,72 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " � ������ �᫠" GET fdat1
         @ 1,0 SAY " �� ����� �᫮" GET fdat2 VALID fdat2>=fdat1 ERROR 'H���p�� ��p���...'
         READ
    ENDIF
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
         ACTIVATE SCREEN
         RETURN
    ENDIF
    IF fdat2<fdat1
         fdat2=fdat1
    ENDIF
          * ACTIVATE WINDOW Pog_p
          * SET COLOR TO &color15
          * @ 0,0 SAY '�'
          * SET COLOR TO &color13
          * @ 0,1 SAY "��������, ��������..."
      tgod=VAL(nastf_b)
    RESTORE FROM tek_b ADDITIVE
    SELECT sprrab
    SET ORDER TO tab
    SELECT bk
    INDEX ON nzk+kp TO rab
    SET EXACT OFF
    SEEK gfbs
    SET EXACT ON
    DO spis_70 WITH fdat1,fdat2,gfbs
    DELETE TAG rab
CASE ch1=2
    SELECT 0
    USE bk_arc
    SET ORDER TO nzk_kp
    SET EXACT OFF
    SEEK gfbs
    SET EXACT ON
    HIDE POPUP ALL
    DO Vvodn WITH "Chapbr","Strsaybr","Strgetbr",.F.,.T.,.F.,.F.,"nzk#gfbs","",;
                  "F2br","F3br","F4br","F5br","F6br","","","","F10br","",.T.
    USE
    SHOW POPUP Glavn,Bank
ENDCASE
SHOW POPUP Glavn,Bank,Video
RETURN
*
*
PROCEDURE Chapbr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
step=1
npolscrm=1
ncolr=78
SET COLOR TO &color4
@ nstrv-11,ncoll-1,nstrv+11,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-10,ncoll-1 SAY '�         � � � � �   � � � � � � � �   � � � � � � � �   � � � � � � �'
@ nstrv- 9,ncoll-1 SAY '������������������������������������������������������������������������������Ķ'
@ nstrv- 8,ncoll-1 SAY '� ������:'
@ nstrv- 7,ncoll-1 SAY '� �࣠������:                                '+IIF(nastf_11=0,'','����')
@ nstrv-6 ,ncoll-1 SAY '� ���㬥��:'
@ nstrv-5 ,ncoll-1 SAY '������������������������������������������������������������������������������Ķ'
@ nstrv-4 ,ncoll-1 SAY '� �����.���������H���� ���   �H���� �  ���  �  ���  �����       �㬬�      '
@ nstrv-3 ,ncoll-1 SAY '�  ��� ������೨�室��࣠��������. ����㬥�-� ������ ���Ⳣ����            '
@ nstrv-2 ,ncoll-1 SAY '�       ���1/0��騩 �(ࠡ��)�����.�   �   �        �    �                  '
@ nstrv-1 ,ncoll-1 SAY '������������������������������������������������������������������������������Ķ'
@ nstrv+11,ncoll-1 SAY '� ����: F2-�࣠������,F3-���㬥��,F4-�㬬�,F5-��� � F6 - ��࠭ � F10-����� '
RETURN
*
PROCEDURE Strsaybr
PARAMETERS color,nstr,npolscr
SET COLOR TO &color21
IF !pr_v_pr
    SET COLOR TO &color21
    @ 4,12 SAY IIF(vo='0','��室','���室')
    @ 5,15 SAY Spr_nam(pr_spr,kp,30)
    SELECT sprnaz
    SEEK bk_arc.wid_d
    @ 6,12 SAY sprnaz.nam
    SELECT bk_arc
    IF nastf_11=1
         @ 5,51 SAY pr_sprk
         @ 5,53 SAY kpp
         @ 6,48 SAY Spr_nam(pr_sprk,kpp,30)
    ENDIF
    @  9,68 SAY vid_val
    @ 10,61 SAY sm_val PICTURE '999,999,999,999.99'
ENDIF
SET COLOR TO &color
@ nstr, 3 SAY nzk
@ nstr,10 SAY vo
@ nstr,14 SAY pr_spr
@ nstr,17 SAY nvx
@ nstr,23 SAY kp
@ nstr,31 SAY nrd
@ nstr,38 SAY dati
@ nstr,47 SAY dat
@ nstr,56 SAY kor
@ nstr,61 SAY sm PICTURE '999,999,999,999.99'
RETURN
*
PROCEDURE Strgetbr
PARAMETERS nstr,npolscr
@ nstr,14 GET pr_spr VALID pr_spr='0'.OR.pr_spr='1' ERROR '���祭�� 0 - p���⭨�, 1 - �p��������'
@ nstr,23 GET kp VALID Poisk_kp('bk_arc.kp',pr_spr,5,15,30) ERROR '��� ⠪��� ����...'
IF nastf_11=1
    @ 5,51 GET pr_sprk VALID pr_sprk='0'.OR.pr_sprk='1' ERROR '���祭�� 0 - p���⭨�, 1 - �p��������'
    @ 5,53 GET kpp VALID Poisk_kp('bk_arc.kpp',pr_sprk,6,48,30) ERROR '��� ⠪��� ����...'
ENDIF
READ
RETURN
*
PROCEDURE F2br
IF RECCOUNT()=0
    RETURN
ENDIF
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
    RETURN
ENDIF
SET ORDER TO nzk_kp
SET EXACT OFF
IF !SEEK(RTRIM(gfbs+fkp+fnrd))
    DO Net_n WITH 10," H�� ⠪�� ���p��樨. ����p��... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnrd
nz=RECNO()
fnrd=SPACE(LEN(bk.nrd))
DEFINE WINDOW Zapros FROM 12,22 TO 14,48 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " H���� ���㬥��" GET fnrd
READ
RELEASE WINDOW Zapros
IF EMPTY(nrd)
    RETURN
ENDIF
SET ORDER TO nrd
IF !SEEK(gfbs+fnrd)
    DO Net_n WITH 15," H�� ⠪��� ���㬥��. ����p��... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F4br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk
fpoisk=0
DEFINE WINDOW Zapros FROM 11,32 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " �㬬�" GET fpoisk PICTURE '999,999,999,999.99'
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    RETURN
ENDIF
SET ORDER TO summa
SET NEAR ON
SEEK gfbs+STR(fpoisk,15,2)
SET NEAR OFF
IF EOF()
    GO BOTTOM
ELSE
    IF !FOUND().AND.nzk#gfbs
         SKIP -1
         IF nzk#gfbs
              SET EXACT OFF
              SEEK gfbs
              SET EXACT ON
         ENDIF
    ENDIF
ENDIF
RETURN
*
PROCEDURE F5br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk
fpoisk=DATE()
DEFINE WINDOW Zapros FROM 11,43 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " ���" GET fpoisk
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    RETURN
ENDIF
SET ORDER TO datd
SET NEAR ON
SEEK gfbs+DTOC(fpoisk,1)
SET NEAR OFF
IF EOF()
    GO BOTTOM
ENDIF
RETURN
*
PROCEDURE F6br
IF RECCOUNT()=0
    RETURN
ENDIF
SET COLOR TO &color13
@ 0,0,23,79 BOX "�ͻ���Ⱥ "
@  4,0 SAY '�'+REPLICATE('�',78)+'�'
@ 10,0 SAY '�'+REPLICATE('�',78)+'�'
@ 14,0 SAY '�'+REPLICATE('�',78)+'�'
@ 17,0 SAY '�'+REPLICATE('�',78)+'�'
SET COLOR TO &color14
@  1, 1 SAY '��� ����樨....'+vo
@  1,20 SAY IIF(vo='0','��室','���室')
@  2, 1 SAY '�� ���� (����)..'+pr_spr
@  2,19 SAY ' 0 - p���⭨�, 1 - �p��������'
@  3, 1 SAY '�����ᮢ� ��� '+nzk
@  3,25 SAY '����ᯮ������騩 ��� '+kor
@  2,51 SAY '����� ��室�騩 (�室�騩)'
@  3,69 SAY nvx
@  5, 1 SAY '��� �����⥫�'
@  6, 4 SAY '(���⥫�騪�)'
@  7, 6 SAY kp
IF pr_spr='0'
    @  5,25 SAY '������� �.�. '+sprrab.fio
ELSE
    @  5,25 SAY '������������ '+skl.ikl
    @  6,21 SAY '���.������������ '+skl.ikld
    @  7,33 SAY skl.ikldd
    @  8,22 SAY '�⤥����� ����� '+skl.otd
    @  9,22 SAY '������ ���  '+skl.sch
    @  9,55 SAY '�ਧ��� ॣ���� '+skl.pr_reg
ENDIF
@ 11, 1 SAY '����� ���㬥�� '+nrd
@ 12, 1 SAY '��� ���㬥��..'+DTOC(dati)
@ 13, 1 SAY '��� ������.....'+DTOC(dat)
@ 11,40 SAY '��� ������.'+vid_val
@ 11,60 SAY '����'+STR(IIF(sm_val=0,0,ROUND(sm/sm_val,5)),15,5)
@ 12,36 SAY '�㬬� � ����� '+STR(sm_val,15,2)
@ 13,36 SAY '�㬬� � �㡫�� '+STR(sm,15,2)
@ 16, 1 SAY '������p...............'+dog
@ 18, 1 SAY '��� ���㬥��...'+STR(wid_d,2)
SELECT sprnaz
SEEK bk_arc.wid_d
SELECT bk_arc
@ 18,19 SAY sprnaz.nam
@ 18,51 SAY '��� ⥪��......'+STR(wid_t,2)
@ 19, 1 SAY '����� ���㬥��.'+text_1
@ 20,17 SAY text_2
@ 21,17 SAY text_3
@ 22,17 SAY text_4
READ
RETURN
*
*