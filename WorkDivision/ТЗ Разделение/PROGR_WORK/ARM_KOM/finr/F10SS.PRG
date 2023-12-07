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
*
SET ORDER TO bs
SCAN FOR !DELETE()
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+"   Справочник счетов"
@ 1,0 SAY REPLICATE('-',32)
@ 2,0 SAY "|Счет|       Hаименование      |"
@ 3,0 SAY REPLICATE('-',32)
         ENDIF
         nstr=3
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,1 SAY bs
         @ nstr,6 SAY nam
    ENDIF
ENDSCAN
EJECT
IF RECCOUNT()#0
    GO nz
ENDIF
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN
