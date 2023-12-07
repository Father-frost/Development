IF RECCOUNT()=0
	RETURN
ENDIF
PRIVATE scr,nz
nz=RECNO()
SAVE SCREEN TO scr
chg12=0
*
fname="out.txt        "
nlist=1
pr_otks=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,pr_otks
IF pr_otks
     RETURN
ENDIF
SET DEVICE TO SCREEN
*
ff='    '
ffnsk=SPACE(LEN(sch.nsk))
ffkor='    '
ffgod='  '
ffms=0
DEFINE WINDOW Zapros FROM 13,40 TO 19,65 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " Hомер счета......" GET ff VALID Poisk_sc('ff',.T.,.F.,0,0,0,'71','.F.') ERROR 'Hет такого счета...'
@ 1,0 SAY " Корреспондир.счет" GET ffkor
@ 2,0 SAY " Год.............." GET ffgod
@ 3,0 SAY " Месяц............" GET ffms PICTURE '99' VALID ffms>0.AND.ffms<13 ERROR 'Значение неверно...'
@ 4,0 SAY " Код подразделения" GET ffnsk
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
     RETURN
ENDIF
ffms=STR(ffms,2)
SET DEVICE TO SCREEN
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
@ 1,2 SAY ' Всего записей:       '
@ 2,2 SAY ' Текущая запись:      '
SET COLOR TO &color14
SELECT sprrab
SET ORDER TO tab
SELECT 0
USE avotrr EXCLUSIVE
ZAP
IF EMPTY(ffkor)
    APPEND FROM avtr_arc FOR bs=ff.AND.god=ffgod.AND.ms=ffms
ELSE
    APPEND FROM avtr_arc FOR bs=ff.AND.kor=ffkor.AND.god=ffgod.AND.ms=ffms
ENDIF
SET RELATION TO tab INTO sprrab
REPLACE ALL nsk WITH sprrab.cex
INDEX ON nsk+tab TAG rab
@ 1,18 SAY RECCOUNT() PICTURE '999999'
@ 2,18 SAY ' '
SET DEVICE TO PRINT
RESTORE FROM tek_b ADDITIVE
DIMENSION mkor(100),msald(100)
PRIVATE ii
n1=1
n2=12
n3=18
n4=26
n5=57
n6=64
n7=77
n8=88
n9=99
n10=110
n11=IIF(tek_b_9=1,122,77)
fsut=0
fproezd=0
fkvart=0
fproch=0
klkor=0
mbs=0
msald=0
mkor=0
nnstr=0
nstr=kolstr+1
ii=0
GO TOP
DO WHILE !EOF()
    fcex=nsk
    fmbs=0
    ffsut=0
    ffproezd=0
    ffkvart=0
    ffproch=0
    SCAN REST WHILE nsk=fcex
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY dat
              @ nstr,n2 SAY nvx
              @ nstr,n3 SAY tab
              @ nstr,n4 SAY LEFT(sprrab.fio,30)
              @ nstr,n5 SAY kor
              @ nstr,n6 SAY smk PICTURE '999999999.99'
              IF tek_b_9=1
                   @ nstr,n7  SAY ssut
                   @ nstr,n8  SAY sproezd
                   @ nstr,n9  SAY skvart
                   @ nstr,n10 SAY sproch
              ENDIF
              IF tek_b_26=1
                   SELECT kodzk
                   SEEK avotrr.nzk
                   SELECT avotrr
                   @ nstr,n11 SAY kodzk.nam
              ENDIF
         ENDIF
         fmbs=fmbs+smk+Delta
         IF tek_b_9=1
              ffsut=ffsut+ssut+Delta
              ffproezd=ffproezd+sproezd
              ffkvart=ffkvart+skvart
              ffproch=ffproch+sproch
         ENDIF
         FOR i=1 TO klkor
              IF mkor(i)=kor
                   EXIT
              ENDIF
         ENDFOR
         IF i>klkor
              klkor=i
              mkor(i)=kor
         ENDIF
         msald(i)=msald(i)+smk+Delta
    ENDSCAN
    mbs=mbs+fmbs
    fsut=fsut+ffsut
    fproezd=fproezd+ffproezd
    fkvart=fkvart+ffkvart
    fproch=fproch+ffproch
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Итого по цеху "+fcex
         @ nstr,n6 SAY fmbs PICTURE '999999999.99'
         IF tek_b_9=1
              @ nstr,n7  SAY ffsut    PICTURE '9999999.99'
              @ nstr,n8  SAY ffproezd PICTURE '9999999.99'
              @ nstr,n9  SAY ffkvart  PICTURE '9999999.99'
              @ nstr,n10 SAY ffproch  PICTURE '9999999.99'
         ENDIF
    ENDIF
    DO Chap2 WITH nnstr,nstr,nlist
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "Итого по бал.счету N "+ff
    @ nstr,n6 SAY mbs PICTURE '999999999.99'
    IF tek_b_9=1
         @ nstr,n7  SAY fsut    PICTURE '9999999.99'
         @ nstr,n8  SAY fproezd PICTURE '9999999.99'
         @ nstr,n9  SAY fkvart  PICTURE '9999999.99'
         @ nstr,n10 SAY fproch  PICTURE '9999999.99'
    ENDIF
ENDIF
DO Chap2 WITH nnstr,nstr,nlist
pr_per=.T.
FOR i=1 TO klkor
     nstr=nstr+1
     IF nnstr>=nlist
          IF pr_per
              @ nstr,n1+10 SAY "в т.ч. по кор.счету"
              pr_per=.F.
          ENDIF
          @ nstr,n4+16 SAY mkor(i)
          @ nstr,n6 SAY msald(i) PICTURE '999999999.99'
     ENDIF
     IF nstr>kolstr
          nnstr=nnstr+1
          DO Chap1 WITH nnstr,nstr,nlist
     ENDIF
ENDFOR
EJECT
DELETE TAG rab
ZAP
USE
RELEASE ALL LIKE tek_b_??
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
HIDE WINDOW ALL
ACTIVATE SCREEN
SELECT avtr_arc
SET RELATION TO
GO nz
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,0  SAY "Лист "+STR(nst,2)
    @ 0,12 SAY " Архив авансовых отчетов по бал.счету "+ff+" за "+name_mec(VAL(ffms))+' 19'+nastf_b+' г.'
    @ 1,0  SAY IIF(tek_b_9=0,REPLICATE('-',77),REPLICATE('-',121))+IIF(tek_b_26=1,REPLICATE('-',31),'')
    @ 2,0  SAY '|          |     |      |                               |      |'+IIF(tek_b_9=1,SPACE(22),'')+'   Сумма    '+IIF(tek_b_9=1,SPACE(22),'')+'|'+IIF(tek_b_26=1,SPACE(30)+'|','')
    @ 3,0  SAY '|  Дата    |Hомер|  Код |        Получатель             | Кор. |------------'+IIF(tek_b_9=1,REPLICATE('-',44),'')+'|'+IIF(tek_b_26=1,'      Наименование заказа     |','')
    @ 4,0  SAY '|          |докум|получ.|                               | счет | Кредит '+ff+IIF(tek_b_9=1,'| Суточные |  Пpоезд  |Кваpтиpные|  Пpочие  ','')+'|'+IIF(tek_b_26=1,SPACE(30)+'|','')
    @ 5,0  SAY IIF(tek_b_9=0,REPLICATE('-',77),REPLICATE('-',121))+IIF(tek_b_26=1,REPLICATE('-',31),'')
ENDIF
nstr=5
RETURN
*
PROCEDURE Chap2
PARAMETERS nst,nstr,nlist
nstr=nstr+1
IF nst>=nlist
    @ nstr,0  SAY IIF(tek_b_9=0,REPLICATE('-',77),REPLICATE('-',121))
ENDIF
RETURN