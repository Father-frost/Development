PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4
p_form=RIGHT('999999999999.99',FSIZE('sm','bk'))
n1=1
n2=9
n3=40
n4=56
n5=72
n6=88
n7=104
n8=120
mbs1=0
mbs2=0
mbs3=0
mbs4=0
mbs5=0
nnstr=0
nstr=kolstr+1
DO WHILE bs=ffbs.AND.!EOF()
    fkp=kp
    ms1=0
    ms2=0
    ms3=0
    ms4=0
    ms5=0
    SCAN REST WHILE ffbs=bs.AND.fkp=kp FOR nastf_k#bs
         ms1=ms1+db
         ms3=ms3+smdo
         IF bs_op=nastf_k
              ms5=ms5-smdo
         ENDIF
    ENDSCAN
* опpеделение суммы аванса из остатков и из банка
    SELECT osdkom
    SET EXACT OFF
    SEEK nastf_k+fkp
    SET EXACT ON
    SCAN REST WHILE nastf_k=bs.AND.fkp=kp FOR !DELETE()
         ms5=ms5+kr-db
    ENDSCAN
    SELECT bk
    SET EXACT OFF
    SEEK nastf_k+fkp
    SET EXACT ON
    SCAN REST WHILE nastf_k=kor.AND.fkp=kp FOR !DELETE()
         ms5=ms5+IIF(vo='0',sm,-sm)
    ENDSCAN
*
    SELECT avot
    SET EXACT OFF
    SEEK ffbs+fkp
    SET EXACT ON
    SCAN REST WHILE ffbs=bs.AND.fkp=kp FOR !DELETE()
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
@ 0,30 SAY "Ведомость по отгpузке, pеализации пpодукции и pазмеpу пени по счету "+ffbs+SPACE(12)+DTOC(DATE())
@ 1,0 SAY "----------------------------------------------------------------------------------------------------------------------------------------"
@ 2,0 SAY "|Код оp.|   Hаименование оpганизации   | Сальдо на нач.|   Отгpужено   |    Оплачено   |Сальдо на конец|Осталось аванс.|     Пеня      |"
@ 3,0 SAY "----------------------------------------------------------------------------------------------------------------------------------------"
              ENDIF
              nstr=3
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fkp
              SELECT skl
              SEEK fkp
              @ nstr,n2 SAY skl.ikl
              @ nstr,n3 SAY ms1         PICTURE p_form
              @ nstr,n4 SAY ms2         PICTURE p_form
              @ nstr,n5 SAY ms3         PICTURE p_form
              @ nstr,n6 SAY ms1+ms2-ms3 PICTURE p_form
              @ nstr,n7 SAY ms5         PICTURE p_form
         ENDIF
         mbs1=mbs1+ms1
         mbs2=mbs2+ms2
         mbs3=mbs3+ms3
         mbs4=mbs4+ms1+ms2-ms3
         mbs5=mbs5+ms5
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY "------------------------------------------------------------------------------------------------------------------------"
         ENDIF
    ENDIF
    SELECT osdkomr
ENDDO
nstr=nstr+1
IF nnstr>=nlist
     @ nstr,n1 SAY "Итого"
     @ nstr,n3 SAY mbs1 PICTURE p_form
     @ nstr,n4 SAY mbs2 PICTURE p_form
     @ nstr,n5 SAY mbs3 PICTURE p_form
     @ nstr,n6 SAY mbs4 PICTURE p_form
     @ nstr,n7 SAY mbs5 PICTURE p_form
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY "--------------------------------------------------------------------------------------------------------"
ENDIF
EJECT
RETURN
