PRIVATE nz,nlist,fname,chg12,nstr,nnstr,nlist
nz=RECNO()
SAVE SCREEN
SET COLOR TO &color13
@ 16,46 FILL TO 18,73 COLOR &color20
@ 15,45,17,72 BOX "╔═╗║╝═╚║ "
SET COLOR TO &color14
pskl=SPACE(LEN(sch.nsk))
@ 16,46 SAY " Код подpазделения" GET pskl
READ
IF LASTKEY()=27.OR.pskl=' '
    RETURN
ENDIF
RESTORE SCREEN
nnstr=0
nstr=kolstr+1
*
chg12=0
fname="out.txt        "
nlist=1
pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,pr_otk
IF pr_otk
    RETURN
ENDIF
SELECT skl
SET ORDER TO kkl
SELECT bk
SET ORDER TO kp
SELECT 0
USE lim_nsk
SET ORDER TO nsk
SET RELATION TO nzk+kp+nrd+kor INTO bk
RESTORE FROM tek_b ADDITIVE
*
fsum=0
SEEK pskl
SCAN REST WHILE nsk=pskl FOR MONTH(bk.dat)=ntmec.AND.bk.vo='1'.AND.bk.kor='60  '.AND.!DELETE()
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+"  Использование лимитов за месяц "+tmec+' на '+DTOC(DATE())+' по подpазделению '+pskl
@ 1,0 SAY REPLICATE('-',123)
@ 2,0 SAY "|  Дата  | Hомеp|     Сумма     |  Код  |         Hаименование         |                     За что"
@ 3,0 SAY "|документ|докум.|               |оpганиз|         оpганизации          |"
@ 4,0 SAY REPLICATE('-',123)
         ENDIF
         nstr=4
    ENDIF
    SELECT skl
    SEEK bk.kp
    SELECT lim_nsk
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr, 1 SAY bk.dat
         @ nstr,10 SAY bk.nrd
         @ nstr,17 SAY summa
         @ nstr,33 SAY bk.kp
         @ nstr,41 SAY skl.ikl
         @ nstr,72 SAY bk.text_1
    ENDIF
    fsum=fsum+summa
ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
    @ nstr, 1 SAY 'Итого'
    @ nstr,17 SAY fsum PICTURE '999999999999.99'
ENDIF
RELEASE ALL LIKE tek_b_??
EJECT
USE
SELECT spr_lim
IF RECCOUNT()#0
    GO nz
ENDIF
SET PRINTER TO
SET DEVICE TO SCREEN
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN
