IF ch1=1
    n1=1
    n2=10
    n3=20
    n4=26
    n5=45
    n6=64
    n7=83
ELSE
    n1=1
    n2=32
    n3=51
    n4=70
    n5=89
    n6=108
    n7=127
ENDIF
n8=102
n9=121
n10=140
n11=148
mbs1=0
mbs2=0
mbs3=0
mbs4=0
mbs5=0
mbs6=0
nnstr=0
nstr=kolstr+1
nlist=0
DO WHILE bs=ff.AND.!EOF()
    fnsk=nsk
    pr_per=.T.
    fdb=db
    fkr=kr
    sumprs=0
    sumrxs=0
    SCAN REST WHILE fnsk=nsk.AND.bs=ff FOR !DELETE().AND.(ch1#2.OR.ch1=2.AND.tek_b_37#fnsk)
         SELECT bkr
         SEEK ff+fnsk
         SCAN REST WHILE ff=kor.AND.fnsk=nsk
              IF ch1=1
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY dat
                        @ nstr,n2 SAY nrd
                        @ nstr,n3 SAY nzk
                        IF vo='0'
                             @ nstr,n7 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        ELSE
                             @ nstr,n6 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        ENDIF
                        @ nstr,n10 SAY kp
                        @ nstr,n11 SAY Spr_nam(pr_spr,kp,30)
                   ENDIF
              ENDIF
              IF vo='0'
                   sumrxs=sumrxs+sm
              ELSE
                   sumprs=sumprs+sm
              ENDIF
         ENDSCAN
         SELECT dv_79
         SET ORDER TO ko_kp
         SET EXACT OFF
         SEEK ff+fnsk
         SET EXACT ON
         SCAN REST WHILE ff=bs.AND.fnsk=ko
              IF ch1=1
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1  SAY dat
                        @ nstr,n2  SAY nrd
                        @ nstr,n3  SAY kor
                        @ nstr,n7  SAY summa PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n10 SAY kp
                        @ nstr,n11 SAY Spr_nam('2',kp,30)
                   ENDIF
              ENDIF
              sumrxs=sumrxs+summa
         ENDSCAN
         SET ORDER TO kp_ko
         SET EXACT OFF
         SEEK ff+fnsk
         SET EXACT ON
         SCAN REST WHILE ff=bs.AND.fnsk=kp
              IF ch1=1
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1  SAY dat
                        @ nstr,n2  SAY nrd
                        @ nstr,n3  SAY kor
                        @ nstr,n6  SAY summa PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n10 SAY ko
                        @ nstr,n11 SAY Spr_nam('2',ko,30)
                   ENDIF
              ENDIF
              sumprs=sumprs+summa
         ENDSCAN
         SELECT osdkomr
    ENDSCAN
    IF fdb#0.OR.fkr#0.OR.sumprs#0.OR.sumrxs#0
         sald=fdb-fkr+sumprs-sumrxs
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY IIF(ch1=1,fnsk+' ','')+Spr_nam('2',fnsk,16)
              @ nstr,IIF(ch1=1,n4,n2) SAY fdb PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,IIF(ch1=1,n5,n3) SAY fkr PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,IIF(ch1=1,n6,n4) SAY sumprs PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,IIF(ch1=1,n7,n5) SAY sumrxs PICTURE '999,999,999,999.99' FUNCTION 'Z'
              IF sald>0
                   @ nstr,IIF(ch1=1,n8,n6) SAY  sald PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ELSE
                   @ nstr,IIF(ch1=1,n9,n7) SAY -sald PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY REPLICATE('-',IIF(ch1=1,179,146))
         ENDIF
         mbs1=mbs1+fdb
         mbs2=mbs2+fkr
         mbs3=mbs3+sumprs
         mbs4=mbs4+sumrxs
         IF sald>=0
              mbs5=mbs5+sald
         ELSE
              mbs6=mbs6-sald
         ENDIF
    ENDIF
ENDDO
IF nstr>kolstr
    nnstr=nnstr+1
    DO Chap1 WITH nnstr,nstr,nlist
ENDIF
IF EMPTY(ff2)
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Всего по "+ff
         @ nstr,IIF(ch1=1,n4,n2) SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,IIF(ch1=1,n5,n3) SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,IIF(ch1=1,n6,n4) SAY mbs3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,IIF(ch1=1,n7,n5) SAY mbs4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,IIF(ch1=1,n8,n6) SAY mbs5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,IIF(ch1=1,n9,n7) SAY mbs6 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Свернутое сальдо "
         @ nstr,IIF(ch1=1,n4,n2) SAY IIF(mbs1>mbs2,mbs1-mbs2,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,IIF(ch1=1,n5,n3) SAY IIF(mbs2>mbs1,mbs2-mbs1,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,IIF(ch1=1,n8,n6) SAY IIF(mbs5>mbs6,mbs5-mbs6,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,IIF(ch1=1,n9,n7) SAY IIF(mbs6>mbs5,mbs6-mbs5,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDIF
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,2 SAY "Лист "+STR(nst,2)
    IF ch1=1
@ 0,20 SAY "Оборотная ведомость движения денежных средств по бал.счету "+ff+' за месяц '+tmec+' 19'+nastf_b+' г.'
@ 1,0 SAY REPLICATE('-',179)
@ 2,0 SAY "|        |         |     |         Сальдо  на  начало          |               Оборот                |          Сальдо  на  конец          |       |                              |"
@ 3,0 SAY "|  Дата  | Hомер   |Hомер|-------------------------------------|-------------------------------------|-------------------------------------|  Код  |         Hаименование         |"
@ 4,0 SAY "|        |документа|cчета|      Дебет       |      Кредит      |      Дебет       |      Кредит      |       Дебет      |      Кредит      |организ|          организации         |"
@ 5,0 SAY REPLICATE('-',179)
    ELSE
@ 0,30 SAY "Сводная ведомость движения денежных средств по бал.счету "+ff+' за месяц '+tmec+' 19'+nastf_b+' г.'
@ 1,0 SAY REPLICATE('-',146)
@ 2,0 SAY "|                              |         Сальдо на начало            |               Оборот                |           Сальдо на конец           |"
@ 3,0 SAY "|    Наименование филиала      |-------------------------------------|-------------------------------------|-------------------------------------|"
@ 4,0 SAY "|                              |      Дебет       |      Кредит      |      Дебет       |      Кредит      |      Дебет       |      Кредит      |"
@ 5,0 SAY REPLICATE('-',146)
	ENDIF
ENDIF
nstr=5
RETURN
