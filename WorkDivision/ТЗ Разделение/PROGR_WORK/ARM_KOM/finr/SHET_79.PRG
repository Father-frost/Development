DIMENSION mbs(1000,4)
mbs=0
kolbs=0
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
                   IF mbs(i,1)=nzk.AND.mbs(i,2)=fnsk
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbs
                   kolbs=i
                   mbs(i,1)=nzk
                   mbs(i,2)=fnsk
              ENDIF
              IF vo='0'
                   mbs(i,4)=mbs(i,4)+sm
              ELSE
                   mbs(i,3)=mbs(i,3)+sm
              ENDIF
         ENDSCAN
         SELECT dv_79
         SET ORDER TO ko_kp
         SET EXACT OFF
         SEEK ff+fnsk
         SET EXACT ON
         SCAN REST WHILE ff=bs.AND.fnsk=ko
              FOR i=1 TO kolbs
                   IF mbs(i,1)=kor.AND.mbs(i,2)=fnsk
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbs
                   kolbs=i
                   mbs(i,1)=kor
                   mbs(i,2)=fnsk
              ENDIF
              mbs(i,4)=mbs(i,4)+summa
         ENDSCAN
         SET ORDER TO kp_ko
         SET EXACT OFF
         SEEK ff+fnsk
         SET EXACT ON
         SCAN REST WHILE ff=bs.AND.fnsk=kp
              FOR i=1 TO kolbs
                   IF mbs(i,1)=kor.AND.mbs(i,2)=fnsk
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbs
                   kolbs=i
                   mbs(i,1)=kor
                   mbs(i,2)=fnsk
              ENDIF
              mbs(i,3)=mbs(i,3)+summa
         ENDSCAN
         SELECT osdkomr
    ENDSCAN
ENDDO
n1=1
n2=8
n3=39
n4=45
n5=64
nnstr=0
nstr=kolstr+1
nlist=0
IF fdb#0.OR.fkr#0.OR.kolbs#0
    *   сортировка массива mbs
    DIMENSION mkorr(1000,4)
    mkorr=0
    FOR j=1 TO kolbs
         fmin='9999'
         imin=0
         FOR i=1 TO kolbs
              IF fmin>mbs(i,1)
                   fmin=mbs(i,1)
                   imin=i
              ENDIF
         ENDFOR
         mkorr(j,1)=mbs(imin,1)
         mkorr(j,2)=mbs(imin,2)
         mkorr(j,3)=mbs(imin,3)
         mkorr(j,4)=mbs(imin,4)
         mbs(imin,1)='9999'
         mbs(imin,2)='99999'
         mbs(imin,3)=0
         mbs(imin,4)=0
    ENDFOR
    FOR i=1 TO kolbs
         mbs(i,1)=mkorr(i,1)
         mbs(i,2)=mkorr(i,2)
         mbs(i,3)=mkorr(i,3)
         mbs(i,4)=mkorr(i,4)
    ENDFOR
    *   конец сортировки
    sald=fdb-fkr
    mbs1=0
    mbs2=0
    FOR j=1 TO kolbs
         fbs=mbs(j,1)
         sss1=0
         sss2=0
         FOR i=j TO kolbs
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              IF fbs#mbs(i,1)
                   EXIT
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY mbs(i,2)
                   @ nstr,n2 SAY Spr_nam('2',mbs(i,2),30)
                   @ nstr,n3 SAY mbs(i,1)
                   @ nstr,n4 SAY mbs(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n5 SAY mbs(i,4) PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
              sss1=sss1+mbs(i,3)
              sss2=sss2+mbs(i,4)
         ENDFOR
         j=i-1
         mbs1=mbs1+sss1
         mbs2=mbs2+sss2
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY REPLICATE('-',83)
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY 'Итого по счету'
              @ nstr,n3 SAY fbs
              @ nstr,n4 SAY sss1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n5 SAY sss2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY REPLICATE('-',83)
         ENDIF
    ENDFOR
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY 'Сальдо на начало'
         @ nstr,n4 SAY IIF(sald>0,sald,0)  PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n5 SAY IIF(sald<0,-sald,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY REPLICATE('=',83)
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY 'Оборот за месяц'
         @ nstr,n4 SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n5 SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY REPLICATE('=',83)
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY 'Сальдо на конец месяца'
         @ nstr,n4 SAY IIF(sald+mbs1-mbs2>0,sald+mbs1-mbs2,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n5 SAY IIF(sald+mbs1-mbs2<0,mbs2-sald-mbs1,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY REPLICATE('=',83)
    ENDIF
ENDIF
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
@ 0,2 SAY "Лист "+STR(nst,2)+". Информация по счетам в разрезе подразделений по бал.счету "+ff+' за месяц '+tmec+' 19'+nastf_b+' г.'
@ 1,0 SAY REPLICATE('-',83)
@ 2,0 SAY "|            Подразделение            |     |               Оборот                |"
@ 3,0 SAY "|-------------------------------------|Hомер|-------------------------------------|"
@ 4,0 SAY "| Код  |       Наименование           |cчета|      Дебет       |      Кредит      |"
@ 5,0 SAY REPLICATE('-',83)
ENDIF
nstr=5
RETURN
