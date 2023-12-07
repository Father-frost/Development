DIMENSION mbs(100,3)
n1=1
n2=10
n3=20
n4=26
n5=34
n6=65
n7=84
n8=103
mbs1=0
mbs2=0
nnstr=0
nstr=kolstr+1
nlist=0
pr_per=.T.
SEEK ff+ff2
fnsk=nsk
fdb=db
fkr=kr
mbs=0
kolbs=0
SCAN REST WHILE fnsk=nsk.AND.bs=ff FOR !DELETE()
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n4 SAY 'Сальдо на начало месяца'
         @ nstr,n6 SAY db PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n7 SAY kr PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n4 SAY REPLICATE('-',76)
    ENDIF
    SELECT bkr
    SEEK ff+fnsk
    SCAN REST WHILE ff=kor.AND.fnsk=nsk
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY dat
              @ nstr,n2 SAY nrd
              @ nstr,n3 SAY nzk
              @ nstr,n4 SAY kp
              @ nstr,n5 SAY Spr_nam(pr_spr,kp,30)
              IF vo='0'
                   @ nstr,n7 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ELSE
                   @ nstr,n6 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
              @ nstr,n8 SAY text_1
         ENDIF
         IF vo='0'
              mbs2=mbs2+sm
         ELSE
              mbs1=mbs1+sm
         ENDIF
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
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY dat
              @ nstr,n2 SAY nrd
              @ nstr,n3 SAY kor
              @ nstr,n4 SAY kp
              @ nstr,n5 SAY Spr_nam('2',kp,30)
              @ nstr,n7 SAY summa PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n8 SAY text
         ENDIF
         mbs2=mbs2+summa
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
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY dat
              @ nstr,n2 SAY nrd
              @ nstr,n3 SAY kor
              @ nstr,n4 SAY ko
              @ nstr,n5 SAY Spr_nam('2',ko,30)
              @ nstr,n6 SAY summa PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n8 SAY text
         ENDIF
         mbs1=mbs1+summa
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
IF mbs1#0.OR.mbs2#0
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n4 SAY REPLICATE('=',76)
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n4 SAY 'Обороты за месяц'
         @ nstr,n6 SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n7 SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n4 SAY REPLICATE('-',76)
    ENDIF
    FOR i=1 TO kolbs
         nstr=nstr+1
         IF nnstr>=nlist
              IF i=1
                   @ nstr,n1 SAY 'в том числе по'
              ENDIF
              @ nstr,n3 SAY mbs(i,1)
              @ nstr,n6 SAY mbs(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n7 SAY mbs(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
    ENDFOR
    IF kolbs>0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n4 SAY REPLICATE('=',76)
         ENDIF
    ENDIF
ENDIF
IF fdb#0.OR.fkr#0.OR.mbs1#0.OR.mbs2#0
    sald=fdb-fkr+mbs1-mbs2
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n4 SAY 'Сальдо на конец месяца'
         @ nstr,n6 SAY IIF(sald>0,sald,0)  PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n7 SAY IIF(sald<0,-sald,0) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n4 SAY REPLICATE('=',76)
    ENDIF
ENDIF
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
@ 0,2 SAY "Лист "+STR(nst,2)
@ 0,20 SAY "Карточка подразделения "+ff2+RTRIM(Spr_nam('2',ff2,30))+" по бал.счету "+ff+' за месяц '+tmec+' '+nastf_b+' г.'
@ 1,0 SAY REPLICATE('-',154)
@ 2,0 SAY "|  Дата  | Hомер   |Hомер|  Код  |         Наименование         |      Дебет       |      Кредит      |               Наименование услуг                 |"
@ 3,0 SAY "|        |документа|cчета| кому  |                              |                  |                  |                                                  |"
@ 4,0 SAY REPLICATE('-',154)
ENDIF
nstr=4
RETURN