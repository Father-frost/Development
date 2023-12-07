PRIVATE nz,pr_otk,fname,chg12,nlist,menu_d,fvo
IF RECCOUNT()=0
    RETURN
ENDIF
nz=RECNO()
*
chg12=0
fname="out.txt        "
nlist=1
m.pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,m.pr_otk
IF m.pr_otk
     RETURN
ENDIF
*
fsum1=0
fsum2=0
fsum3=0
fsum4=0
@ PROW(),0 SAY &sgat1
nnstr=0
nstr=kolstr+1
fkp='*'
SCAN FOR !DELETE()
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
              @ 0,30 SAY "Ведомость кредитов на "+DTOC(DATE())
              @ 1,0 SAY REPLICATE('-',164)
              @ 2,0 SAY "|  Код  |        Наименование          |   Номер  |   Дата   |   Дата   |  %   |% за проср.|      Сумма       |      Сумма       |      Сумма       |      Сумма       |"
              @ 3,0 SAY "|организ|        организации           | договора |  выдачи  | возврата |кредит|  кредит   |     кредита      |    процентов     |выплач-х процентов|долга по процентам|"
              @ 4,0 SAY REPLICATE('-',164)
         ENDIF
         nstr=4
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,  1 SAY kp
         IF fkp#kp
              @ nstr,9 SAY Spr_nam('1',kp,30)
              fkp=kp
         ENDIF
         @ nstr, 40 SAY dog
         @ nstr, 51 SAY datn
         @ nstr, 62 SAY dato
         @ nstr, 73 SAY pr_kred
         @ nstr, 80 SAY pr_pen
         @ nstr, 92 SAY summa PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,111 SAY sum_proc PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,130 SAY summap   PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,149 SAY sum_proc-summap PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    fsum1=fsum1+summa
    fsum2=fsum2+sum_proc
    fsum3=fsum3+summap
    fsum4=fsum4+sum_proc-summap
ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',164)
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,  0 SAY "Всего"
    @ nstr, 92 SAY fsum1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,111 SAY fsum2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,130 SAY fsum3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,149 SAY fsum4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
GO nz
EJECT
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN