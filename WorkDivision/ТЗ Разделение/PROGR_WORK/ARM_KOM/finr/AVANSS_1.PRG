PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii
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
mbs6=0
ms51=0
mprib=0
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
    SCAN REST WHILE fkp=kp.AND.fpr_spr=pr_spr
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
    ENDSCAN
    SELECT osdkom
    SET EXACT OFF
    SEEK fkp
    SET EXACT ON
    SCAN REST WHILE fkp=kp FOR !DELETE().AND.fpr_spr=pr_spr
         IF bs=ffbs
              ms1=ms1+db
              ms2=ms2+kr
              IF pr_prib='*'
                   mprib=mprib+kr-db
                   ms4=ms4+kr-db
              ENDIF
         ENDIF
         IF bs_op=ffbs.AND.(menu_v=1.OR.!EMPTY(kor))
              ms4=ms4+smdo-smko
         ENDIF
    ENDSCAN
    SELECT avotrr
    SEEK fkp
    SCAN REST WHILE fkp=kp FOR (menu_v=1.OR.!EMPTY(kor)).AND.fpr_spr=pr_spr
         ms4=ms4+smdo
    ENDSCAN
    SELECT bkr
    SEEK fkp
    SCAN REST WHILE fkp=kp FOR fpr_spr=pr_spr
         IF vo='0'
              ms3=ms3+sm
         ELSE
              ms51=ms51+sm
              ms4=ms4+sm
         ENDIF
    ENDSCAN
    IF ms1#0.OR.ms2#0.OR.ms3#0.OR.ms4#0
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,2 SAY "Лист "+STR(nnstr,2)
@ 0,30 SAY "Ведомость по счету "+ffbs+' '+spr_bs.nam+' за месяц '+tmec+' 19'+nastf_b+' г.'
@ 1,0 SAY REPLICATE('-',136)
@ 2,0 SAY "|       |                              |        Сальдо на начало       |               |               |        Сальдо на конец        |"
@ 3,0 SAY "|Код оp.|   Hаименование оpганизации   |-------------------------------|    Поступило  |    Списано    |-------------------------------|"
@ 4,0 SAY "|       |                              |     Дебет     |     Кpедит    |               |               |     Дебет     |     Кpедит    |"
@ 5,0 SAY REPLICATE('-',136)
              ENDIF
              nstr=5
         ENDIF
         sald=ms1-ms2-ms3+ms4
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fkp
              @ nstr,n2 SAY Spr_nam(fpr_spr,fkp,30)
              @ nstr,n3 SAY ms1 PICTURE '999999999999.99' FUNCTION 'Z'
              @ nstr,n4 SAY ms2 PICTURE '999999999999.99' FUNCTION 'Z'
              @ nstr,n5 SAY ms3 PICTURE '999999999999.99' FUNCTION 'Z'
              @ nstr,n6 SAY ms4 PICTURE '999999999999.99' FUNCTION 'Z'
              IF sald>0
                   @ nstr,n7 SAY sald PICTURE '999999999999.99' FUNCTION 'Z'
              ELSE
                   @ nstr,n8 SAY -sald PICTURE '999999999999.99' FUNCTION 'Z'
              ENDIF
         ENDIF
         mbs1=mbs1+ms1
         mbs2=mbs2+ms2
         mbs3=mbs3+ms3
         mbs4=mbs4+ms4
         IF sald>0
              mbs5=mbs5+sald
         ELSE
              mbs6=mbs6-sald
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',136)
         ENDIF
    ENDIF
    SELECT osdkomr
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "Итого"
    @ nstr,n3 SAY mbs1 PICTURE '999999999999.99' FUNCTION 'Z'
    @ nstr,n4 SAY mbs2 PICTURE '999999999999.99' FUNCTION 'Z'
    @ nstr,n5 SAY mbs3 PICTURE '999999999999.99' FUNCTION 'Z'
    @ nstr,n6 SAY mbs4 PICTURE '999999999999.99' FUNCTION 'Z'
    @ nstr,n7 SAY mbs5 PICTURE '999999999999.99' FUNCTION 'Z'
    @ nstr,n8 SAY mbs6 PICTURE '999999999999.99' FUNCTION 'Z'
ENDIF
nstr=nstr+2
IF nnstr>=nlist
    @ nstr-1,10 SAY "в том числе"
    @ nstr-1,n5 SAY '51'
    @ nstr-1,n6 SAY ms51 PICTURE '999999999999.99' FUNCTION 'Z'
    @ nstr,n5   SAY 'pеализация'
    @ nstr,n6   SAY mbs4-ms51 PICTURE '999999999999.99' FUNCTION 'Z'
    IF mprib#0
         nstr=nstr+1
         @ nstr,n5 SAY 'пpибыль'
         @ nstr,n6 SAY mprib PICTURE '999999999999.99' FUNCTION 'Z'
    ENDIF
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('=',136)
ENDIF
EJECT
RETURN
