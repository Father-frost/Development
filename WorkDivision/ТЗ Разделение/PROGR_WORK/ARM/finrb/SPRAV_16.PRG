PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii
n1=1
n2=9
n3=40
n4=59
n5=78
n6=97
n7=116
mbs1=0
mbs2=0
mbs3=0
mbs4=0
mbs5=0
nnstr=0
nstr=kolstr+1
ii=0
DO WHILE !EOF()
    fkp=kp
    fpr_spr=pr_spr
    ms1=0
    ms2=0
    ms3=0
    ms4=0
    ms5=0
* опpеделение суммы аванса из остатков и из банка
    SELECT osdkom
    SET EXACT OFF
    SEEK nastf_k+fkp
    SET EXACT ON
    SCAN REST WHILE nastf_k=bs.AND.fkp=kp FOR EMPTY(pr_prib).AND.!DELETE().AND.pr_spr=fpr_spr
         ms5=ms5+kr-db
    ENDSCAN
    SELECT bkr
    SEEK nastf_k+fkp
    SCAN REST WHILE nastf_k=kor.AND.fkp=kp FOR pr_spr=fpr_spr
         ms5=ms5+IIF(vo='0',sm,-sm)
    ENDSCAN
    IF nastf_e#nastf_k
         SEEK nastf_e+fkp
         SCAN REST WHILE nastf_e=kor.AND.fkp=kp FOR pr_spr=fpr_spr
              ms5=ms5+IIF(vo='0',sm,-sm)
         ENDSCAN
    ENDIF
    SELECT osdkomr
    SCAN REST WHILE fkp=kp.AND.pr_spr=fpr_spr FOR (menu_v=1.OR.!EMPTY(kor))
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         IF nastf_k#bs
              ms1=ms1+db
              ms3=ms3+smdo
              IF bs_op=nastf_k
                   ms5=ms5-smdo
              ENDIF
         ENDIF
    ENDSCAN
*
    SELECT avot
    SET EXACT OFF
    SEEK ffbs+fkp
    SET EXACT ON
    SCAN REST WHILE ffbs=bs.AND.fkp=kp FOR (menu_v=1.OR.!EMPTY(kor)).AND.pr_spr=fpr_spr
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
@ 0,2 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Ведомость по отгpузке на "+DTOC(fdato)+" и pеализации на "+DTOC(fdatb)+" пpодукции по счету "+ffbs+' за '+RTRIM(tmec)+' '+nastf_b+' года'+SPACE(10)+DTOC(DATE())
@ 1,0 SAY REPLICATE('-',135)
@ 2,0 SAY '|Код оp.|   Hаименование оpганизации   | Сальдо на начало |     Отгpужено    |     Оплачено     | Сальдо на конец  | Осталось авансов |'
@ 3,0 SAY REPLICATE('-',135)
              ENDIF
              nstr=3
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fkp
              @ nstr,n2 SAY Spr_nam(fpr_spr,fkp,30)
              @ nstr,n3 SAY ms1         PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n4 SAY ms2         PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n5 SAY ms3         PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n6 SAY ms1+ms2-ms3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n7 SAY ms5         PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         mbs1=mbs1+ms1
         mbs2=mbs2+ms2
         mbs3=mbs3+ms3
         mbs4=mbs4+ms1+ms2-ms3
         mbs5=mbs5+ms5
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',134)
         ENDIF
    ENDIF
    SELECT osdkomr
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "Итого"
    @ nstr,n3 SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n4 SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n5 SAY mbs3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n6 SAY mbs4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n7 SAY mbs5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',134)
ENDIF
EJECT
RETURN