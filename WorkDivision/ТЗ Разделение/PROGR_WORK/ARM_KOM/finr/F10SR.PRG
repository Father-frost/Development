IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,nlist,fname,chg12,nstr,nnstr,nlist
nz=RECNO()
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
SCAN FOR !DELETE()
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "���� "+STR(nnstr,2)+"      ��ࠢ�筨� ࠡ�⭨���"
@ 1,0 SAY REPLICATE('-',53)
@ 2,0 SAY "|�������| ��� |           ������� �.�.            |"
@ 3,0 SAY "|  �����  | ��|                                   |"
@ 4,0 SAY REPLICATE('-',53)
         ENDIF
         nstr=4
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,3  SAY tab
         @ nstr,11 SAY cex
         @ nstr,17 SAY fio
    ENDIF
ENDSCAN
EJECT
GO nz
SET DEVICE TO SCREEN
RETURN
