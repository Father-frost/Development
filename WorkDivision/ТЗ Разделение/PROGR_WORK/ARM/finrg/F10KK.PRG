IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,nlist,fname,chg12,nstr,nnstr
DIMENSION mval(100,3),mbs(100,3)
fkp=kp
skp=SPACE(7)
IF nastf_11=1
    DEFINE WINDOW Zapros FROM 15,40 TO 17,70 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " Код организации кому" GET skp
    READ
    RELEASE WINDOW Zapros
    ACTIVATE SCREEN
    IF LASTKEY()=27
         RETURN
    ENDIF
ENDIF
kolval=0
mval=0
mbs=0
kolbs=0
nz=RECNO()
nlist=1
nnstr=0
nstr=kolstr+1
*
chg12=0
fname="out.txt        "
nlist=1
m.pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,m.pr_otk
IF m.pr_otk
    RETURN
ENDIF
fsum1=0
fsum2=0
*
SCAN FOR EMPTY(skp).OR.skp=kpp
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+". Каpточка оpганизации "+fkp+' '+Spr_nam('1',fkp,30)
@ 1,0 SAY REPLICATE('-',IIF(nastf_11=0,74,113))
@ 2,0 SAY "|Бал.|   Дата   |   Дата   | Hомеp|      Сумма       |      Сумма       |Коpp|"+IIF(nastf_11=0,'','  Код  |    Наименование организации  |')
@ 3,0 SAY "|счет| докумен. |  оплаты  |докум.|     пpихода      |     pасхода      |счет|"+IIF(nastf_11=0,'',' кому  |        кому перечислено      |')
@ 4,0 SAY REPLICATE('-',IIF(nastf_11=0,74,113))
         ENDIF
         nstr=4
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,1  SAY nzk
         @ nstr,6  SAY dati
         @ nstr,17 SAY dat
         @ nstr,28 SAY nrd
         IF vo='0'
              @ nstr,35 SAY sm PICTURE '999,999,999,999.99'
         ELSE
              @ nstr,54 SAY sm PICTURE '999,999,999,999.99'
         ENDIF
         @ nstr,73 SAY kor
         IF nastf_11=1.AND.kp#kpp.AND.!EMPTY(kpp)
              @ nstr,78 SAY kpp
              @ nstr,86 SAY Spr_nam('1',kpp,30)
              FOR i=1 TO kolbs
                   IF mbs(i,1)=kpp
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbs
                   kolbs=i
                   mbs(i,1)=kpp
              ENDIF
              IF vo='0'
                   mbs(i,2)=mbs(i,2)+sm
              ELSE
                   mbs(i,3)=mbs(i,3)+sm
              ENDIF
         ENDIF
    ENDIF
    SELECT spr_bs
    SET ORDER TO bs
    SEEK bkr.nzk
    SELECT bkr
    IF spr_bs.pr_val='1'
         IF sm_val#0
              FOR i=1 TO kolval
                   IF mval(i,1)=vid_val
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolval
                   kolval=i
                   mval(i,1)=vid_val
              ENDIF
              IF vo='0'
                   mval(i,2)=mval(i,2)+sm_val
              ELSE
                   mval(i,3)=mval(i,3)+sm_val
              ENDIF
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,13 SAY 'Вид валюты '+vid_val
              IF vo='0'
                   @ nstr,31 SAY sm_val PICTURE '999,999,999,999.99'
              ELSE
                   @ nstr,50 SAY sm_val PICTURE '999,999,999,999.99'
              ENDIF
         ENDIF
    ENDIF
    IF vo='0'
         fsum1=fsum1+sm
    ELSE
         fsum2=fsum2+sm
    ENDIF
ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,1 SAY REPLICATE('-',72)
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,1  SAY 'Итого'
    @ nstr,35 SAY fsum1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,54 SAY fsum2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
pr_per=.T.
FOR i=1 TO kolval
    nstr=nstr+1
    IF nnstr>=nlist
         IF pr_per
              pr_per=.F.
              @ nstr,13 SAY 'Вид валюты '
         ENDIF
         @ nstr,24 SAY mval(i,1)
         @ nstr,31 SAY mval(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,50 SAY mval(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDFOR
pr_per=.T.
FOR i=1 TO  kolbs
    nstr=nstr+1
    IF nnstr>=nlist
         IF pr_per
              pr_per=.F.
              @ nstr,1 SAY 'в том числе'
         ENDIF
         @ nstr,31 SAY mbs(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,50 SAY mbs(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,74 SAY mbs(i,1)
         @ nstr,82 SAY Spr_nam('1',mbs(i,1),30)
    ENDIF
ENDFOR
IF fsumprn#0.OR.fsumrxn#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,1  SAY 'в том числе неоплачено'
         @ nstr,31 SAY fsumprn PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,50 SAY fsumrxn PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDIF
EJECT
GO nz
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN