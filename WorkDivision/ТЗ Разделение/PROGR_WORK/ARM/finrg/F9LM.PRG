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
SELECT 0
USE schr EXCLUSIVE
SET DELETED ON
APPEND FROM sch
SET DELETED OFF
INDEX ON vid_lim TAG rab
SELECT bk
SET ORDER TO kp
SELECT 0
USE lim_nsk
SET ORDER TO nsk
SET RELATION TO nzk+kp+nrd+kor INTO bk
SELECT spr_lim
RESTORE FROM tek_b ADDITIVE
*
ffsum=0
flsum=0
fpsum=0
SCAN FOR !DELETE()
    SELECT schr
    fsum=0
    IF SEEK(spr_lim.kod)
         SCAN REST WHILE vid_lim=spr_lim.kod
              SELECT lim_nsk
              IF SEEK(schr.nsk)
                   SCAN REST WHILE nsk=schr.nsk FOR MONTH(bk.dat)=ntmec.AND.bk.vo='1'.AND.kor=tek_b_48.AND.!DELETE()
                        fsum=fsum+summa
                   ENDSCAN
              ENDIF
         ENDSCAN
    ENDIF
    SELECT spr_lim
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+"  Использование лимитов за месяц "+tmec+' на '+DTOC(DATE())
@ 1,0 SAY REPLICATE('-',85)
@ 2,0 SAY "| Код |    Hаименование    |       Сумма      |   Использовано   |    Пpевышение    |"
@ 3,0 SAY "|подp.|                    |      лимита      |      сpедств     |      лимита      |"
@ 4,0 SAY REPLICATE('-',85)
         ENDIF
         nstr=4
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr, 1 SAY kod
         @ nstr, 7 SAY nam
         @ nstr,28 SAY summa PICTURE '999,999,999,999.99'
         @ nstr,47 SAY fsum PICTURE '999,999,999,999.99'
         IF fsum>summa
              @ nstr,66 SAY fsum-summa PICTURE '999,999,999,999.99'
         ENDIF
    ENDIF
    flsum=flsum+summa
    ffsum=ffsum+fsum
    IF fsum>summa
         fpsum=fpsum+fsum-summa
    ENDIF
ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
    @ nstr, 1 SAY 'Всего'
    @ nstr,28 SAY flsum PICTURE '999,999,999,999.99'
    @ nstr,47 SAY ffsum PICTURE '999,999,999,999.99'
    @ nstr,66 SAY fpsum PICTURE '999,999,999,999.99'
ENDIF
RELEASE ALL LIKE tek_b_??
EJECT
SELECT lim_nsk
USE
SELECT schr
DELETE TAG rab
ZAP
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
