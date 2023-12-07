DIMENSION mbs(100,3)
n1=1
n2=20
n3=39
n4=45
n5=64
n6=83
n7=102
mbs=0
kolbs=0
nnstr=0
nstr=kolstr+1
nlist=0
fdb=0
fkr=0
DO WHILE bs=ff.AND.!EOF()
    fdb=fdb+db
    fkr=fkr+kr
    fnsk=nsk
    SCAN REST WHILE fnsk=nsk.AND.bs=ff FOR !DELETE().AND.tek_b_37#fnsk
         SELECT bkr
         SEEK ff+fnsk
         SCAN REST WHILE ff=kor.AND.fnsk=nsk
              FOR i=1 TO kolbs
                   IF mbs(i,1)=nzk
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbs
                   kolbs=i
                   mbs(i,1)=nzk
              ENDIF
              IF vo='0'
                   mbs(i,3)=mbs(i,3)+sm
              ELSE
                   mbs(i,2)=mbs(i,2)+sm
              ENDIF
         ENDSCAN
         SELECT dv_79
         SET ORDER TO ko_kp
         SET EXACT OFF
         SEEK ff+fnsk
         SET EXACT ON
         SCAN REST WHILE ff=bs.AND.fnsk=ko
              FOR i=1 TO kolbs
                   IF mbs(i,1)=kor
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbs
                   kolbs=i
                   mbs(i,1)=kor
              ENDIF
              mbs(i,3)=mbs(i,3)+summa
         ENDSCAN
         SET ORDER TO kp_ko
         SET EXACT OFF
         SEEK ff+fnsk
         SET EXACT ON
         SCAN REST WHILE ff=bs.AND.fnsk=kp
              FOR i=1 TO kolbs
                   IF mbs(i,1)=kor
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbs
                   kolbs=i
                   mbs(i,1)=kor
              ENDIF
              mbs(i,2)=mbs(i,2)+summa
         ENDSCAN
         SELECT osdkomr
    ENDSCAN
ENDDO
IF fdb#0.OR.fkr#0.OR.kolbs#0
    sald=fdb-fkr
    mbs1=0
    mbs2=0
    FOR i=1 TO kolbs
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n3 SAY mbs(i,1)
              @ nstr,n4 SAY mbs(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n5 SAY mbs(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         mbs1=mbs1+mbs(i,2)
         mbs2=mbs2+mbs(i,3)
    ENDFOR
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY REPLICATE('-',121)
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY IIF(sald>0,sald,0)  PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n2 SAY IIF(sald<0,-sald,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n4 SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n5 SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n6 SAY IIF(sald+mbs1-mbs2>0,sald+mbs1-mbs2,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n7 SAY IIF(sald+mbs1-mbs2<0,mbs2-sald-mbs1,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDIF
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
@ 0,2 SAY "Лист "+STR(nst,2)+". Сводная ведомость движения денежных средств по бал.счету "+ff+' за месяц '+tmec+' 19'+nastf_b+' г.'
@ 1,0 SAY REPLICATE('-',121)
@ 2,0 SAY "|         Сальдо  на  начало          |     |               Оборот                |          Сальдо  на  конец          |"
@ 3,0 SAY "|-------------------------------------|Hомер|-------------------------------------|-------------------------------------|"
@ 4,0 SAY "|      Дебет       |      Кредит      |cчета|      Дебет       |      Кредит      |       Дебет      |      Кредит      |"
@ 5,0 SAY REPLICATE('-',121)
ENDIF
nstr=5
RETURN
