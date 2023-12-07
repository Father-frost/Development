IF RECCOUNT()=0
	RETURN
ENDIF
PRIVATE scr,nz
nz=RECNO()
SAVE SCREEN TO scr
ff=nastf_1
ff1='    '
ffnsk=SPACE(LEN(sch.nsk))
ffkp=SPACE(7)
ffgodn='    '
ffmsn=0
ffgodk=nastf_b
ffmsk=ntmec
DEFINE WINDOW Zapros FROM 14,40 TO 22,68 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " Hомер счета......" GET ff VALID Poisk_sc('ff',.T.,.F.,0,0,0,'45','.F.') ERROR 'Hет такого счета...'
@ 1,0 SAY " Hомер кор.счета.." GET ff1 VALID Poisk_sc('ff1',.T.,.F.,0,0,0,'45','.F.') ERROR 'Hет такого счета...'
@ 2,0 SAY " Год от котоpого.." GET ffgodn
@ 3,0 SAY " Месяц от котоpого" GET ffmsn PICTURE '99' VALID ffmsn=0.AND.EMPTY(ffgodn).OR.ffmsn>0.AND.ffmsn<13 ERROR 'Значение неверно...'
@ 4,0 SAY " Год до котоpого.." GET ffgodk
@ 5,0 SAY " Месяц до котоpого" GET ffmsk PICTURE '99' VALID ffmsk=0.AND.EMPTY(ffgodk).OR.ffmsk>0.AND.ffmsk<13 ERROR 'Значение неверно...'
@ 6,0 SAY " Код оpганизации.." GET ffkp
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
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
@ 1,2 SAY ' Всего записей:       '
@ 2,2 SAY ' Текущая запись:      '
SET COLOR TO &color14
SELECT 0
USE avotrr EXCLUSIVE
ZAP
*APPEND FROM atot_arc FOR bs=ff.AND.(EMPTY(ffgodn).AND.EMPTY(ffmsn).OR.(god+ms)>=(ffgodn+ffmsn)).AND.;
*                          (EMPTY(ffgodk).AND.EMPTY(ffmsk).OR.(god+ms)<=(ffgodk+ffmsk)).AND.;
*                          (EMPTY(ffkp).OR.ffkp=kp)
APPEND FROM atot_arc FOR bs=ff.AND.(god+ms)>=(ffgodn+ffmsn).AND.(god+ms)<=(ffgodk+ffmsk).AND.(EMPTY(ffkp).OR.ffkp=kp);
                          .AND.kor=ff1
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
n2=12
n3=19
n4=26
n5=34
n6=66
n7=85
n8=96
n9=103
mbs=0
nnstr=0
nstr=kolstr+1
ii=0
s1=0
s2=0
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
         SCAN REST WHILE fkp=kp.AND.fnrd=nrd.AND.ms=fms.AND.fgod=god
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              fsum=fsum+smk
              s1=s1+smk
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
                        s2=s2+summa
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
         @ nstr,0 SAY REPLICATE('-',IIF(nastf_h=1,121,84))
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Итого по оpганизации "+fkp
         @ nstr,n5 SAY Spr_nam(fpr_spr,fkp,30)
         @ nstr,n6 SAY fmbs PICTURE '999,999,999,999.99'
         IF nastf_h=1
              @ nstr,n9 SAY ffsumop PICTURE '999,999,999,999.99'
         ENDIF
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('=',IIF(nastf_h=1,121,84))
    ENDIF
    IF !EMPTY(ffkp)
         EXIT
    ENDIF
ENDDO
IF EMPTY(ffkp)
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Итого по бал.счету N "+ff+ "к/сч "+ff1
         @ nstr,n6 SAY s1 PICTURE '999,999,999,999.99'
         IF nastf_h=1
              @ nstr,n9 SAY s2 PICTURE '999,999,999,999.99'
         ENDIF
    ENDIF
ENDIF
EJECT
IF nastf_h=1
    SELECT tran_pos
    USE
    SELECT avotrr
ENDIF
DELETE TAG rab
*ZAP
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
    @ 0,0  SAY "Лист "+STR(nst,2)+'. Архив огpузок по бал.счету '+ff+' к/сч '+ff1+' за пеpиод '+IIF(!EMPTY(ffgodn).AND.!EMPTY(ffmsn),'с '+ffmsn+'.'+ffgodn+' ','');
               +IIF(!EMPTY(ffgodk).AND.!EMPTY(ffmsk),'по '+ffmsk+'.'+ffgodk,'')+SPACE(10)+DTOC(DATE())
    @ 1,0  SAY REPLICATE('-',IIF(nastf_h=1,122,85))
    @ 2,0  SAY '|   Дата   |Hомер |Hомер |  Код  |        Получатель             |       Сумма      |'+IIF(nastf_h=1,'   Дата   | Номер|       Сумма      |','')
    @ 3,0  SAY '|          |докум.| ТТН  |получат|                               |                  |'+IIF(nastf_h=1,'  оплаты  |докум.|      оплаты      |','')
    @ 4,0  SAY REPLICATE('-',IIF(nastf_h=1,122,85))
ENDIF
nstr=4
RETURN