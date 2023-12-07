PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii
n1=1
n2=9
n3=40
n4=59
n5=78
n6=97
n7=116
n8=135
n9=154
mbs1=0
mbs2=0
mbs3=0
mbs4=0
mbs5=0
mbs6=0
mbs7=0
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
    ms6=0
    ms7=0
* опpеделение суммы аванса из остатков и из банка
    SELECT osdkom1
    SET EXACT OFF
    SEEK nastf_2+fkp
    SET EXACT ON
    SCAN REST WHILE nastf_2=bs.AND.fkp=kp FOR db#0.AND.!DELETE()
         ms2=ms2+db
         ms7=ms7+db
    ENDSCAN
    SELECT bkr
    SEEK nastf_2+fkp
    SCAN REST WHILE nastf_2=kor.AND.fkp=kp
         IF vo='1'
              ms4=ms4+sm
              ms7=ms7+sm
         ELSE
              ms3=ms3+sm
              ms5=ms5+sm
              ms7=ms7-sm
         ENDIF
    ENDSCAN
    SELECT osdkomr
    SCAN REST WHILE ffbs=bs.AND.fkp=kp FOR menu_v=1.OR.!EMPTY(kor)
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         ms1=ms1+kr
         ms5=ms5+smko
         IF bs_op=nastf_2
              ms7=ms7-smko
         ENDIF
    ENDSCAN
*
    SELECT atot
    SET EXACT OFF
    SEEK ffbs+fkp
    SET EXACT ON
    SCAN REST WHILE ffbs=bs.AND.fkp=kp FOR (menu_v=1.OR.!EMPTY(kor)).AND.!DELETE()
         ms3=ms3+smk
         ms5=ms5+smko
         IF bs_op=nastf_2
              ms7=ms7-smko
         ENDIF
    ENDSCAN
    IF ms1#0.OR.ms2#0.OR.ms3#0.OR.ms5#0.OR.ms6#0.OR.ms7#0
         ms6=ms1+ms3-ms5
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,2 SAY 'Лист '+STR(nnstr,2)+'.  Ведомость поступления матеpиалов за месяц '+RTRIM(tmec)+nastf_b+' года'+SPACE(15)+DTOC(DATE())
@ 1,0 SAY REPLICATE('-',173)
@ 2,0 SAY '|       |                              |        На начало месяца             |                  |    Пеpечислено   |                  |           На конец месяца           |'
@ 3,0 SAY '|  Код  |   Hаименование оpганизации   |-------------------------------------|     Поступило    |     авансов в    |      Оплачено    |-------------------------------------|'
@ 4,0 SAY '|оpгани-|                              |     Неоплачено   |    Пеpечислено   |    матеpиалов    |     текущем      |     матеpиалов   |    Неоплачено    |     Осталось     |'
@ 5,0 SAY '| зации |                              |     матеpиалов   |      авансов     |                  |      месяце      |                  |    матеpиалов    |      авансов     |'
@ 6,0 SAY REPLICATE('-',173)
              ENDIF
              nstr=6
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fkp
              @ nstr,n2 SAY Spr_nam(fpr_spr,fkp,30)
              @ nstr,n3 SAY ms1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n4 SAY ms2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n5 SAY ms3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n6 SAY ms4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n7 SAY ms5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n8 SAY ms6 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n9 SAY ms7 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         mbs1=mbs1+ms1
         mbs2=mbs2+ms2
         mbs3=mbs3+ms3
         mbs4=mbs4+ms4
         mbs5=mbs5+ms5
         mbs6=mbs6+ms6
         mbs7=mbs7+ms7
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',172)
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
    @ nstr,n8 SAY mbs6 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n9 SAY mbs7 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',172)
ENDIF
EJECT
RETURN