IF RECCOUNT()=0
	RETURN
ENDIF
PRIVATE scr,nz
nz=RECNO()
SAVE SCREEN TO scr
ff=nastf_1
ffnsk=SPACE(LEN(sch.nsk))
ffkp=SPACE(7)
ffgodn='  '
ffmsn=0
ffgodk=nastf_b
ffmsk=ntmec
DEFINE WINDOW Zapros FROM 14,40 TO 21,68 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " H���� ���......" GET ff VALID Poisk_sc('ff',.T.,.F.,0,0,0,'45','.F.') ERROR 'H�� ⠪��� ���...'
@ 1,0 SAY " ��� �� ���p���.." GET ffgodn
@ 2,0 SAY " ����� �� ���p���" GET ffmsn PICTURE '99' VALID ffmsn=0.AND.EMPTY(ffgodn).OR.ffmsn>0.AND.ffmsn<13 ERROR '���祭�� ����୮...'
@ 3,0 SAY " ��� �� ���p���.." GET ffgodk
@ 4,0 SAY " ����� �� ���p���" GET ffmsk PICTURE '99' VALID ffmsk=0.AND.EMPTY(ffgodk).OR.ffmsk>0.AND.ffmsk<13 ERROR '���祭�� ����୮...'
@ 5,0 SAY " ��� �p������樨.." GET ffkp
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
     RETURN
ENDIF
chg12=0
*
fname="out.txt        "
nlist=1
pr_otks=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,pr_otks
IF pr_otks
     RETURN
ENDIF
*
ffmsn=IIF(ffmsn=0,'  ',STR(ffmsn,2))
ffmsk=IIF(ffmsk=0,'  ',STR(ffmsk,2))
SET DEVICE TO SCREEN
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '�'
SET COLOR TO &color13
@ 0,1 SAY "��������, ��������..."
@ 1,2 SAY ' �ᥣ� ����ᥩ:       '
@ 2,2 SAY ' ������ ������:      '
SET COLOR TO &color14
SELECT 0
USE avotrr EXCLUSIVE
ZAP
APPEND FROM atot_arc FOR bs=ff.AND.(EMPTY(ffgodn).AND.EMPTY(ffmsn).OR.(god+ms)>=(ffgodn+ffmsn)).AND.;
                         (EMPTY(ffgodk).AND.EMPTY(ffmsk).OR.(god+ms)<=(ffgodk+ffmsk)).AND.;
                         (EMPTY(ffkp).OR.ffkp=kp)
IF nastf_h=1
    SELECT 0
    USE tran_pos
    SET ORDER TO uni
    SELECT avotrr
ENDIF
INDEX ON kp+god+ms+nrd TAG rab
@ 1,18 SAY RECCOUNT() PICTURE '999999'
@ 2,18 SAY ' '
SET DEVICE TO PRINT
PRIVATE ii
DIMENSION mbs(100,3)
n1=1
n2=10
n3=17
n4=24
n5=32
n6=64
n7=83
n8=92
n9=99
mbs=0
nnstr=0
nstr=kolstr+1
ii=0
GO TOP
DO WHILE !EOF()
    fkp=kp
    fpr_spr=pr_spr
    fmbs=0
    ffsumop=0
    pr_nam=.T.
    DO WHILE kp=fkp.AND.!EOF()
         fdat=dat
         fgod=god
         fms=ms
         fnrd=nrd
         fsum=0
         fsumop=0
         fnvx=nvx
         mbs=0
         kolbs=0
         SCAN REST WHILE fkp=kp.AND.fnrd=nrd.AND.ms=fms.AND.god=god
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              fsum=fsum+smk
              IF nastf_h=1
                   SELECT tran_pos
                   SET EXACT OFF
                   SEEK STR(avotrr.uni,7)
                   SET EXACT ON
                   SCAN REST WHILE uni=avotrr.uni
                        FOR i=1 TO kolbs
                             IF mbs(i,1)=dat.AND.mbs(i,2)=nrd
                                  EXIT
                             ENDIF
                        ENDFOR
                        IF i>kolbs
                             kolbs=i
                             mbs(i,1)=dat
                             mbs(i,2)=nrd
                        ENDIF
                        mbs(i,3)=mbs(i,3)+summa
                        fsumop=fsumop+summa
                   ENDSCAN
              ENDIF
         ENDSCAN
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
              pr_nam=.T.
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fdat
              @ nstr,n2 SAY fnrd
              @ nstr,n3 SAY fnvx
              @ nstr,n4 SAY fkp
              IF pr_nam
                   @ nstr,n5 SAY Spr_nam(fpr_spr,fkp,30)
                   pr_nam=.F.
              ENDIF
              @ nstr,n6 SAY fsum PICTURE '999,999,999,999.99'
         ENDIF
         IF nastf_h=1
              FOR i=1 TO kolbs
                   IF i>1
                        IF nstr>kolstr
                             nnstr=nnstr+1
                             DO Chap1 WITH nnstr,nstr,nlist
                             pr_nam=.T.
                        ENDIF
                        nstr=nstr+1
                   ENDIF
                   IF nnstr>=nlist
                        @ nstr,n7 SAY mbs(i,1)
                        @ nstr,n8 SAY mbs(i,2)
                        @ nstr,n9 SAY mbs(i,3) PICTURE '999,999,999,999.99'
                   ENDIF
              ENDFOR
         ENDIF
         fmbs=fmbs+fsum
         ffsumop=ffsumop+fsumop
    ENDDO
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',IIF(nastf_h=1,117,82))
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "�⮣� �� �p������樨 "+fkp
         @ nstr,n5 SAY Spr_nam(fpr_spr,fkp,30)
         @ nstr,n6 SAY fmbs PICTURE '999,999,999,999.99'
         IF nastf_h=1
              @ nstr,n9 SAY ffsumop PICTURE '999,999,999,999.99'
         ENDIF
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('=',IIF(nastf_h=1,117,82))
    ENDIF
    IF !EMPTY(ffkp)
         EXIT
    ENDIF
ENDDO
IF EMPTY(ffkp)
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "�⮣� �� ���.���� N "+ff
         @ nstr,n6 SAY mbs PICTURE '999,999,999,999.99'
    ENDIF
ENDIF
EJECT
IF nastf_h=1
    SELECT tran_pos
    USE
    SELECT avotrr
ENDIF
DELETE TAG rab
ZAP
USE
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
HIDE WINDOW ALL
ACTIVATE SCREEN
SELECT atot_arc
SET RELATION TO
GO nz
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,0  SAY "���� "+STR(nst,2)+'. ��娢 ��p㧮� �� ���.���� '+ff+' �� ��p��� '+IIF(!EMPTY(ffgodn).AND.!EMPTY(ffmsn),'� '+ffmsn+'.'+ffgodn+' ','');
               +IIF(!EMPTY(ffgodk).AND.!EMPTY(ffmsk),'�� '+ffmsk+'.'+ffgodk,'')+SPACE(10)+DTOC(DATE())
    @ 1,0  SAY REPLICATE('-',IIF(nastf_h=1,118,83))
    @ 2,0  SAY '|  ���  |H���� |H���� |  ���  |        �����⥫�             |       �㬬�      |'+IIF(nastf_h=1,'  ���  | �����|       �㬬�      |','')
    @ 3,0  SAY '|        |����.| ���  |������|                               |                  |'+IIF(nastf_h=1,' ������ |����.|      ������      |','')
    @ 4,0  SAY REPLICATE('-',IIF(nastf_h=1,118,83))
ENDIF
nstr=4
RETURN
