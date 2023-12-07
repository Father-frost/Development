IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,nlist,fname,chg12,nstr,nnstr,nlist
nz=RECNO()
nlist=1
nnstr=0
nstr=kolstr+1
ffbs=SPACE(4)
fdat1=CTOD('  /  /  ')
fdat2=CTOD('  /  /  ')
fnsk=SPACE(5)
SAVE SCREEN
SET COLOR TO &color13
@ 16,41 FILL TO 21,66 COLOR &color20
@ 15,40,20,65 BOX "╔═╗║╝═╚║ "
SET COLOR TO &color14
@ 16,41 SAY " Коppесп. счет" GET ffbs
@ 17,41 SAY " За период с.." GET fdat1
@ 18,41 SAY "           по." GET fdat2
@ 19,41 SAY " Код организ. " GET fnsk
READ
RESTORE SCREEN
IF LASTKEY()=27
    RETURN
ENDIF
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
RESTORE FROM tek_b ADDITIVE
@ PROW(),0 SAY &sgat2
fsumma=0
SCAN FOR (EMPTY(ffbs).OR.kor=ffbs).AND.(EMPTY(fdat1).AND.EMPTY(fdat2).OR.EMPTY(fdat1).AND.dat<=fdat2.OR.EMPTY(fdat2).AND.dat>=fdat1.OR.dat>=fdat1.AND.dat<=fdat2).AND.(EMPTY(fnsk).OR.kp=fnsk)
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+"  Инфоpмация по отгpузке "+IIF(EMPTY(ffbs),'',"по коpp.счету "+ffbs)+' за '+;
              IIF(EMPTY(fdat1).AND.EMPTY(fdat2),'месяц '+tmec+' 19'+nastf_b+' г.',' период с '+DTOC(fdat1)+' по '+DTOC(fdat2))+IIF(EMPTY(fnsk),'',' по организации   '+fnsk)
@ 1,0 SAY REPLICATE('-',82)
@ 2,0 SAY '| Код   |   Hаименование организации   | Hомеp|  Дата  |'+tek_b_7+'|       Сумма      |'
@ 3,0 SAY '|организ|                              |платеж|        |'+tek_b_8+'|     отгpужено    |'
@ 4,0 SAY REPLICATE('-',82)
         ENDIF
         nstr=4
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,1  SAY kp
         @ nstr,9  SAY Spr_nam(pr_spr,kp,30)
         @ nstr,40 SAY nrd
         @ nstr,47 SAY dat
         @ nstr,56 SAY nvx
         @ nstr,63 SAY smd PICTURE '999,999,999,999.99'
    ENDIF
    fsumma=fsumma+smd
ENDSCAN
IF fsumma#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('=',82)
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr, 1 SAY 'Итого'
         @ nstr,63 SAY fsumma PICTURE '999,999,999,999.99'
    ENDIF
ENDIF
EJECT
RELEASE ALL LIKE tek_b_??
GO nz
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN