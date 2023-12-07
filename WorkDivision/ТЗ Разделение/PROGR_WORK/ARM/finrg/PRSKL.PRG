IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,nlist,fname,chg12,nstr,nnstr,nlist
skp=SPACE(3)
DEFINE WINDOW Zapros FROM 15,46 TO 17,64 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " Код региона" GET skp
READ
RELEASE WINDOW Zapros
ACTIVATE SCREEN
IF LASTKEY()=27
    RETURN
ENDIF
nz=RECNO()
nlist=1
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
*
@ PROW(),0 SAY &sgat2
SCAN FOR (EMPTY(skp).OR.skp=pr_reg).AND.!DELETE()
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+"       Справочник организаций"
@ 1,0 SAY REPLICATE('-',137)
@ 2,0 SAY "| Код   |   Hаименование  организации  |     Город     |  Расчетный  |            Отделение   банка           |   МФО   |  Город банка  |"
@ 3,0 SAY "|организ|                              |               |     счет    |                                        |         |               |"
@ 4,0 SAY REPLICATE('-',137)
         ENDIF
         nstr=4
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,1   SAY kkl
         @ nstr,9   SAY ikl
         @ nstr,40  SAY gor
         @ nstr,56  SAY sch
         @ nstr,70  SAY otd
         @ nstr,111 SAY mfo
         @ nstr,121 SAY gorb
    ENDIF
ENDSCAN
EJECT
GO nz
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN
