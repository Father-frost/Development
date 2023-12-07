PRIVATE nz
IF RECCOUNT()=0
    RETURN
ENDIF
fbs=SPACE(4)
fkor=SPACE(4)
fdat1=DATE()
fdat2=DATE()
fkp=SPACE(7)
DEFINE WINDOW Zapros FROM 13,40 TO 19,65 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " Балансовый счет" GET fbs
@ 1,0 SAY " Корреспонд.счет" GET fkor
@ 2,0 SAY " С какого числа" GET fdat1
@ 3,0 SAY " По какое число" GET fdat2
@ 4,0 SAY " Код организации" GET fkp
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    ACTIVATE SCREEN
    RETURN
ENDIF
*
chg12=0
fname="out.txt        "
nlist=1
pr_otks=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,pr_otks
IF pr_otks
     RETURN
ENDIF
*
nz=RECNO()
SELECT 0
USE bkr EXCLUSIVE
ZAP
INDEX ON DTOC(dat,1) TAG rab
SET DELETED ON
APPEND FROM bk_arc FOR (EMPTY(fbs).OR.nzk=fbs).AND.(EMPTY(fkor).OR.kor=fkor).AND.;
                       (EMPTY(fdat1).OR.dat>=fdat1).AND.(EMPTY(fdat2).OR.dat<=fdat2).AND.;
                       (EMPTY(fkp).OR.fkp=kp)
APPEND FROM bk FOR (EMPTY(fbs).OR.nzk=fbs).AND.(EMPTY(fkor).OR.kor=fkor).AND.;
                   (EMPTY(fdat1).OR.dat>=fdat1).AND.(EMPTY(fdat2).OR.dat<=fdat2).AND.;
                   (EMPTY(fkp).OR.fkp=kp).AND.!EMPTY(dat)
SET DELETED OFF
n1=1
n2=10
n3=17
n4=22
n5=27
n6=46
n7=65
n8=73
n9=104
nnstr=0
nstr=kolstr+1
SET DEVICE TO SCREEN
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
@ 1,2 SAY ' Всего записей:       '
@ 2,2 SAY ' Текущая запись:      '
SET COLOR TO &color14
@ 1,18 SAY RECCOUNT() PICTURE '999999'
@ 2,18 SAY ' '
SET DEVICE TO PRINT
@ PROW(),0 SAY &sgat1
ii=0
fsum1=0
fsum2=0
fkp='*******'
fpr_spr=pr_spr
SCAN
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
              @ 0,0 SAY 'Лист '+STR(nnstr,3)+'.'+"    Архивная ведомость движения денежных средств "+IIF(EMPTY(fdat1).AND.EMPTY(fdat2),'',"с "+DTOC(fdat1)+" по "+DTOC(fdat2))
              @ 1,0 SAY REPLICATE('-',155)
              @ 2,0 SAY '|        |      |    |    |                  |                  | Код   |                              |                                                  |'
              @ 3,0 SAY '|  Дата  | Номер|Бал.|Корр|      Сумма       |      Сумма       |организ|    Hазвание оpганизации      |                      Текст                       |'
              @ 4,0 SAY "|документ|докум.|счет|счет|     пpихода      |     pасхода      |(работ)|    (Ф.И.О. pаботника)        |                                                  |"
              @ 5,0 SAY REPLICATE('-',155)
         ENDIF
         nstr=5
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY dat
         @ nstr,n2 SAY nrd
         @ nstr,n3 SAY nzk
         @ nstr,n4 SAY kor
         @ nstr,IIF(vo='0',n5,n6) SAY sm PICTURE "999,999,999,999.99" FUNCTION 'Z'
         @ nstr,n7 SAY kp
         IF fkp#kp.OR.fpr_spr#pr_spr
              fkp=kp
              fpr_spr=pr_spr
              @ nstr,n8 SAY Spr_nam(pr_spr,kp,30)
         ENDIF
         @ nstr,n9 SAY text_1
    ENDIF
    IF sm_val#0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n4-2 SAY vid_val
              @ nstr,IIF(vo='0',n5,n6) SAY sm_val PICTURE "999,999,999,999.99" FUNCTION 'Z'
         ENDIF
    ENDIF
    IF !EMPTY(text_2)
         IF sm_val=0
              nstr=nstr+1
         ENDIF
         IF nnstr>=nlist
              @ nstr,n9 SAY text_2
         ENDIF
    ENDIF
    IF !EMPTY(text_3)
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n9 SAY text_3
         ENDIF
    ENDIF
    IF !EMPTY(text_4)
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n9 SAY text_4
         ENDIF
    ENDIF
    IF vo='0'
         fsum1=fsum1+sm
    ELSE
         fsum2=fsum2+sm
    ENDIF
ENDSCAN
nstr=nstr+2
IF nnstr>=nlist
    @ nstr-1,0 SAY REPLICATE('-',104)
    @ nstr,n1 SAY 'Итого'
    @ nstr,n5 SAY fsum1 PICTURE "999,999,999,999.99" FUNCTION 'Z'
    @ nstr,n6 SAY fsum2 PICTURE "999,999,999,999.99" FUNCTION 'Z'
ENDIF
EJECT
HIDE WINDOW Pogal
SET DEVICE TO SCREEN
ACTIVATE SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
ZAP
DELETE TAG rab
USE
SELECT bk_arc
GO nz
RETURN
