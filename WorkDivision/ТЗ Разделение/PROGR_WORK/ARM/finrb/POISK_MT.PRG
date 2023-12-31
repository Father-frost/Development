PARAMETERS fname,pr_memo,fusl,n_str1,n_poz1,n_str2,n_poz2,n_str3,n_poz3,n_str4,n_poz4,;
           pr_cen,pr_bs
*
* fname   - ��� ��p������� ��� ⥪�饣� ����
* fusl    - �����ᮢ� ��� ��� �室� � �ࠢ�筨�
* pr_memo - �p����� ��p������� (.T.) ��� ���� (.F.)
* n_str1  - ����p ��p��� ��� ������������
* n_poz1  - ����p ����樨 ��� ������������
* n_str2  - ����p ��p��� ��� 業�
* n_poz2  - ����p ����樨 ��� 業�
* n_str3  - ����p ��p��� ��� ������� ����p����
* n_poz3  - ����p ����樨 ��� ������� ����p����
* n_str4  - ����p ��p��� ��� �����ᮢ��� ���
* n_poz4  - ����p ����樨 ��� �����ᮢ��� ���
* pr_cen  - �p����� ������ 業�
* pr_bs   - �p����� ������ �����ᮢ��� ���
*
PRIVATE fpoisk_,fmat_,nam_file,nz,sssss
nam_file=STR(SELECT(),2)
IF nastr_v=1
     fmat_=TRANSFORM(&fname,'@J')
     IF pr_memo
          &fname=fmat_
     ELSE
          REPLACE &fname WITH fmat_
     ENDIF
ENDIF
SELECT matr
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         IF EMPTY(fusl)
              SET ORDER TO mat
         ELSE
              SET ORDER TO bs_mat
              sssss=&fusl
              SET EXACT OFF
              SEEK sssss
              SET EXACT ON
         ENDIF
         DO Vvodn WITH "Chapmt","Strsaymt","Strgetmt",.T.,.T.,.F.,.F.,IIF(EMPTY(fusl),".F.",'sssss#bs'),"",;
                       "F2mt","F3mt","","","","","","","","",.F.
         IF pr_memo
              &fname=mat
         ELSE
              REPLACE &fname WITH mat
         ENDIF
    ENDDO
    fpoisk_=.T.
ELSE
    IF EOF()
         GO TOP
    ENDIF
    nz=RECNO()
    IF EMPTY(fusl)
         SET ORDER TO mat
         fpoisk_=SEEK(&fname)
         IF !fpoisk_
              IF RECCOUNT()#0
                   GO nz
              ENDIF
         ENDIF
    ELSE
         SET ORDER TO bs_mat
         fpoisk_=SEEK(&fusl+&fname)
    ENDIF
    IF !fpoisk_
         IF RECCOUNT()#0
              GO nz
         ENDIF
    ENDIF
ENDIF
IF n_str1#0
    @ n_str1,n_poz1 SAY matr.nam
ENDIF
IF n_str2#0
    @ n_str2,n_poz2 SAY matr.cen
ENDIF
IF n_str3#0
    @ n_str3,n_poz3 SAY matr.izm
ENDIF
IF n_str4#0
    @ n_str4,n_poz4 SAY matr.bs
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
IF pr_cen
    REPLACE cen WITH matr.cen
ENDIF
IF pr_bs
    REPLACE bs WITH matr.bs
ENDIF
RETURN fpoisk_
*
PROCEDURE Chapmt
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=22
ncoll=2
step=1
npolscrm=1
ncolr=65
@ nstrv-5,ncoll FILL TO nstrv+12,ncolr+2 COLOR &color20
SET COLOR TO &color4
@ nstrv-6,ncoll-1,nstrv+11,ncolr+1 BOX "�ͻ���Ⱥ "
@ nstrv-5 ,ncoll-1 SAY "�             � � � � � � � � � �     � � � � � � � � � �"
@ nstrv-4 ,ncoll-1 SAY "����������������������������������������������������������������Ķ"
@ nstrv-3 ,ncoll-1 SAY "�H����������.�    H�����������    �����. �     ����      �������"
@ nstrv-2 ,ncoll-1 SAY "�    �����    �                    ������.�               � ��� �"
@ nstrv-1 ,ncoll-1 SAY "����������������������������������������������������������������Ķ"
@ nstrv+11,ncoll-1 SAY "� ����: F2 � ���, F3 - ������������"
RETURN
*
PROCEDURE Strsaymt
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,2  SAY mat
@ nstr,16 SAY nam
@ nstr,37 SAY izm
@ nstr,44 SAY cen
@ nstr,60 SAY bs
RETURN
*
PROCEDURE Strgetmt
PARAMETERS nstr,npolscr
PRIVATE nz,fmat_,sss
IF EMPTY(mat)
    pr_per=.T.
    IF nastr_o=1
         RESTORE FROM tek_n ADDITIVE
         fmat_=RIGHT(REPLICATE('0',13)+LTRIM(STR(VAL(tek_n_8)+1,13)),LEN(RTRIM(tek_n_8)))
         tek_n_8=LEFT(fmat_+SPACE(13),13)
         sss=FULLPATH('tek_n.mem')
         SAVE TO &sss ALL LIKE tek_n_??
         RELEASE ALL LIKE tek_n_??
         REPLACE mat WITH fmat_
    ENDIF
    IF !EMPTY(usl)
         REPLACE bs WITH sssss
    ENDIF
ELSE
    pr_per=.F.
ENDIF
nz=RECNO()
DO WHILE .T.
    @ nstr,2 GET mat
    READ
    IF LASTKEY()=27
         IF pr_per
              prudalv=prudalv+1
              DELETE
         ENDIF
         RETURN
    ENDIF
    IF nastr_v=1
         fmat_=TRANSFORM(mat,'@J')
         REPLACE mat WITH fmat_
         @ nstr,2 SAY mat
    ENDIF
    fmat_=mat
    SET ORDER TO mat
    IF SEEK(fmat_)
         IF nz=RECNO()
              SKIP
              IF fmat_#mat
                   GO nz
                   IF !EMPTY(usl)
                        SET ORDER TO bs_mat
                   ENDIF
                   EXIT
              ENDIF
         ENDIF
         DO Net_n WITH 11,"����� ��� 㦥 ����. ������..."
    ELSE
         DO Net_n WITH 11,"�����-� ���p�� � ��⥬�. ������, p��p�襭 ������..."
         RETURN
    ENDIF
    IF !EMPTY(usl)
         SET ORDER TO bs_mat
    ENDIF
    GO nz
ENDDO
@ nstr,16 GET nam
@ nstr,37 GET izm
@ nstr,44 GET cen
IF EMPTY(usl)
    @ nstr,60 GET bs VALID Poisk_sc('matr.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H�� ⠪��� ���...'
ENDIF
READ
RETURN
*
PROCEDURE F2mt
PRIVATE fpoisk,nz
nz=RECNO()
SET COLOR TO &color13
@ 15,25 FILL TO 17,47 COLOR &color20
@ 14,24,16,46 BOX "�Ŀ����� "
SET COLOR TO &color14
fpoisk=SPACE(LEN(mat))
@ 15,25 SAY " H����" GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
IF nastr_v=1
    fpoisk=TRANSFORM(fpoisk,'@J')
ENDIF
SET ORDER TO mat
fpoisk=RTRIM(fpoisk)
SET EXACT OFF
SEEK fpoisk
SET EXACT ON
IF !EMPTY(usl)
	SET ORDER TO bs_mat
ENDIF
IF FOUND().AND.(EMPTY(usl).OR.!&usl)
    RETURN
ENDIF
DO Net_n WITH 17,"H�� ⠪��� ����. ������..."
IF RECCOUNT()#0
    GO nz
ENDIF
RETURN
*
PROCEDURE F3mt
PRIVATE fpoisk,nz
nz=RECNO()
SET COLOR TO &color13
@ 15,19 FILL TO 17,56 COLOR &color20
@ 14,18,16,55 BOX "�Ŀ����� "
SET COLOR TO &color14
fpoisk=SPACE(LEN(nam))
@ 15,19 SAY " H����������� " GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
fpoisk=RTRIM(fpoisk)
SET ORDER TO nam
SET EXACT OFF
SEEK fpoisk
SET EXACT ON
SCAN REST WHILE fpoisk=LEFT(nam,LEN(fpoisk)).AND.&usl
ENDSCAN
IF !EMPTY(usl)
	SET ORDER TO bs_mat
ENDIF
IF FOUND().AND.(EMPTY(usl).OR.!&usl)
    RETURN
ENDIF
DO Net_n WITH 17,"H�� ⠪��� ������������. ������..."
IF RECCOUNT()#0
    GO nz
ENDIF
RETURN
