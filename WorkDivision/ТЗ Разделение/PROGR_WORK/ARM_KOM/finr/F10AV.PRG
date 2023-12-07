PRIVATE nz,nlist,fname,chg12,nstr,nnstr,nlist
nz=RECNO()
nnstr=0
nstr=kolstr+1
sym=0
*
chg12=0
fname="out.txt        "
nlist=1
pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,pr_otk
IF pr_otk
    RETURN
ENDIF
SELECT sprrab
SET ORDER TO tab
SELECT kas_71
*
SCAN FOR symk#0.AND.!DELETE()
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+" Список задолженности по pаботникам"
@ 1,0 SAY REPLICATE('-',66)
@ 2,0 SAY "|Табельный|            Фамилия И.О.           |       Сумма      |"
@ 3,0 SAY "|  номер  |                                   |                  |"
@ 4,0 SAY REPLICATE('-',66)
         ENDIF
         nstr=4
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,3 SAY tbn
         SELECT sprrab
         SEEK kas_71.tbn
         SELECT kas_71
         @ nstr,11 SAY sprrab.fio
         @ nstr,47 SAY symk PICTURE '999,999,999,999.99'
    ENDIF
    sym=sym+symk
ENDSCAN
nstr=nstr+1
@ nstr,0 SAY REPLICATE('-',66)
nstr=nstr+1
@ nstr,3 SAY "Итого"
@ nstr,47 SAY sym PICTURE '999,999,999,999.99'
EJECT
SET PRINTER TO
SET DEVICE TO SCREEN
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
SELECT ostrkr
RETURN