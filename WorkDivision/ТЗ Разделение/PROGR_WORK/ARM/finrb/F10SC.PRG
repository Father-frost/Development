IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,nlist,fname,chg12,nstr,nnstr,nlist
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
SET DEVICE TO PRINT
*
SCAN FOR !DELETE()
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+"   Справочник подразделений"
@ 1,0 SAY REPLICATE('-',38)
@ 2,0 SAY "| Код |       Hаименование           |"
@ 3,0 SAY "|подр.|                              |"
@ 4,0 SAY REPLICATE('-',38)
         ENDIF
         nstr=4
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,1 SAY nsk
         @ nstr,7 SAY icsk
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
