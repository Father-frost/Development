PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii
n1=1
n2=9
n3=40
n4=56
n5=72
n6=88
n7=104
mbs1=0
mbs2=0
mbs3=0
mbs4=0
mbs5=0
nnstr=0
ffreg=RTRIM(ffreg)
len_reg=LEN(ffreg)
IF !EMPTY(ffreg)
	SET EXACT OFF
    SEEK ffbs+ffreg
	SET EXACT ON
ENDIF
ii=0
DO WHILE (EMPTY(ffreg).OR.ffreg=LEFT(skl.pr_reg,len_reg)).AND.!EOF()
    nstr=kolstr+1
    freg=skl.pr_reg
    m1=0
    m2=0
    m3=0
    m4=0
    m5=0
    DO WHILE freg=skl.pr_reg.AND.!EOF()
         fkp=kp
         fpr_spr=pr_spr
         ms1=0
         ms2=0
         ms3=0
         ms4=0
         ms5=0
         SCAN REST WHILE fkp=kp.AND.fpr_spr=pr_spr.AND.freg=skl.pr_reg
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              IF nastf_k#bs
                   IF ch1=6.OR.smdo#0.OR.ch1=8.AND.((DATE()-dat)>=skl.kol_dn.OR.EMPTY(dat))
                        ms1=ms1+db
                        ms3=ms3+smdo
                        IF bs_op=nastf_k
                             ms5=ms5-smdo
                        ENDIF
                   ENDIF
              ENDIF
         ENDSCAN
* опpеделение суммы аванса из остатков и из банка
         SELECT skl
         SEEK fkp
         SELECT osdkom
         SET EXACT OFF
         SEEK nastf_k+fkp
         SET EXACT ON
         SCAN REST WHILE nastf_k=bs.AND.fkp=kp FOR !DELETE().AND.fpr_spr=pr_spr
              ms5=ms5+kr-db
         ENDSCAN
         SELECT bk
         SET ORDER TO bk2
         SET EXACT OFF
         SEEK nastf_k+fkp
         SCAN REST WHILE nastf_k=kor.AND.fkp=kp FOR MONTH(dat)=ntmec.AND.!DELETE().AND.fpr_spr=pr_spr
              ms5=ms5+IIF(vo='0',sm,-sm)
         ENDSCAN
         SET ORDER TO kp
         SEEK nastf_k+fkp
         SET EXACT ON
         SCAN REST WHILE nastf_k=nzk.AND.fkp=kp FOR MONTH(dat)=ntmec.AND.!DELETE().AND.fpr_spr=pr_spr
              ms5=ms5+IIF(vo='1',sm,-sm)
         ENDSCAN
*
         SELECT skl
         SEEK fkp
         fikl=skl.ikl
         SELECT avot
         SET EXACT OFF
         SEEK ffbs+fkp
         SET EXACT ON
         SCAN REST WHILE ffbs=bs.AND.fkp=kp FOR ch1=6.OR.smdo#0.OR.ch1=8.AND.((DATE()-dat)>=skl.kol_dn.OR.EMPTY(dat)).AND.!DELETE().AND.fpr_spr=pr_spr
              ms2=ms2+smd
              ms3=ms3+smdo
              IF bs_op=nastf_k
                   ms5=ms5-smdo
              ENDIF
         ENDSCAN
         IF ms1#0.OR.ms2#0.OR.ms3#0.OR.ms5#0
              IF nstr>kolstr
                   nnstr=nnstr+1
                   IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)
IF ch1=6
    @ 0,10 SAY "Ведомость по отгpузке и pеализации пpодукции по счету "+ffbs+SPACE(15)+DTOC(DATE())
ELSE
    @ 0,10 SAY "Ведомость по отгpузке и pеализации пpодукции с учетом документообоpота по счету "+ffbs+SPACE(15)+DTOC(DATE())
ENDIF
@ 1,0 SAY REPLICATE('-',120)
@ 2,0 SAY "|Код оp.|   Hаименование оpганизации   | Сальдо на нач.|   Отгpужено   |    Оплачено   |Сальдо на конец|Осталось аванс.|"
@ 3,0 SAY REPLICATE('-',120)
                   ENDIF
                   nstr=3
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY fkp
                   @ nstr,n2 SAY fikl
                   @ nstr,n3 SAY ms1 PICTURE '999999999999.99' FUNCTION 'Z'
                   @ nstr,n4 SAY ms2 PICTURE '999999999999.99' FUNCTION 'Z'
                   @ nstr,n5 SAY ms3 PICTURE '999999999999.99' FUNCTION 'Z'
                   @ nstr,n6 SAY ms1+ms2-ms3 PICTURE '999999999999.99' FUNCTION 'Z'
                   @ nstr,n7 SAY ms5 PICTURE '999999999999.99' FUNCTION 'Z'
              ENDIF
              m1=m1+ms1
              m2=m2+ms2
              m3=m3+ms3
              m4=m4+ms1+ms2-ms3
              m5=m5+ms5
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,0 SAY REPLICATE('-',120)
              ENDIF
         ENDIF
         SELECT skl
         SEEK osdkomr.kp
         SELECT osdkomr
    ENDDO
    mbs1=mbs1+m1
    mbs2=mbs2+m2
    mbs3=mbs3+m3
    mbs4=mbs4+m4
    mbs5=mbs5+m5
    nstr=nstr+1
    IF nnstr>=nlist
         SELECT spr_reg
         SEEK freg
         SELECT osdkomr
         @ nstr,n1 SAY 'Итого по '+spr_reg.nam
         @ nstr,n3 SAY m1 PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n4 SAY m2 PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n5 SAY m3 PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n6 SAY m4 PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n7 SAY m5 PICTURE '999999999999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',120)
    ENDIF
    SELECT osdkomr
ENDDO
IF mbs1#0.OR.mbs2#0.OR.mbs3#0.OR.mbs4#0.OR.mbs5#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Итого"
         @ nstr,n3 SAY mbs1 PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n4 SAY mbs2 PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n5 SAY mbs3 PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n6 SAY mbs4 PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n7 SAY mbs5 PICTURE '999999999999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',120)
    ENDIF
ENDIF
EJECT
RETURN
