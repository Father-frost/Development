DIMENSION mkor(100,3)
PRIVATE ii
n1=0
n2=8
n3=39
n4=44
n5=63
klkor=0
mkor=0
nnstr=0
fffsumd=0
fffsumk=0
nstr=kolstr+1
ii=0
DO WHILE !EOF()
    ffsumd=0
    ffsumk=0
    fnsk=nsk
    pr_per=.T.
    pr_kp=.T.
    DO WHILE fnsk=nsk.AND.!EOF()
         sfsumd=0
         sfsumk=0
         fkr=LEFT(kor,2)
         kol_kr=0
         DO WHILE fnsk=nsk.AND.fkr=LEFT(kor,2).AND.!EOF()
              fkor=kor
              kol_kr=kol_kr+1
              fsumd=0
              fsumk=0
              SCAN REST WHILE fnsk=nsk.AND.fkr=LEFT(kor,2).AND.fkor=kor
                   ii=ii+1
                   ?? ii PICTURE '999999' AT 18
                   fsumd=fsumd+smd
                   fsumk=fsumk+smk
              ENDSCAN
              IF fsumd#0.OR.fsumk#0
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        IF pr_per
                             @ nstr,n1 SAY fnsk
                             @ nstr,n2 SAY Spr_nam('2',fnsk,30)
                             pr_per=.F.
                        ENDIF
                        @ nstr,n3 SAY fkor
                        @ nstr,n4 SAY fsumd PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n5 SAY fsumk PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
                   FOR i=1 TO klkor
                        IF mkor(i,1)=fkor
                             EXIT
                        ENDIF
                   ENDFOR
                   IF i>klkor
                        klkor=i
                        mkor(i,1)=fkor
                   ENDIF
                   mkor(i,2)=mkor(i,2)+fsumd+Delta
                   mkor(i,3)=mkor(i,3)+fsumk+Delta
              ENDIF
              sfsumd=sfsumd+fsumd
              sfsumk=sfsumk+fsumk
         ENDDO
         IF kol_kr>1.AND.(sfsumd#0.OR.sfsumk#0)
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n2+15 SAY 'всего по'
                   @ nstr,n3 SAY fkr
                   @ nstr,n4 SAY sfsumd PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n5 SAY sfsumk PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
         ENDIF
         ffsumd=ffsumd+sfsumd
         ffsumk=ffsumk+sfsumk
    ENDDO
    IF ffsumd#0.OR.ffsumk#0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY "Итого по подpазделению "+fnsk
              @ nstr,n4 SAY ffsumd PICTURE '999,999,999,999.99'
              @ nstr,n5 SAY ffsumk PICTURE '999,999,999,999.99'
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',75)
         ENDIF
    ENDIF
    fffsumd=fffsumd+ffsumd
    fffsumk=fffsumk+ffsumk
ENDDO
* сортировка массива
DIMENSION mkorr(100,3)
mkorr=0
FOR j=1 TO klkor
    fmin='9999'
    imin=0
    FOR i=1 TO klkor
         IF fmin>mkor(i,1)
              fmin=mkor(i,1)
              imin=i
         ENDIF
    ENDFOR
    mkorr(j,1)=mkor(imin,1)
    mkorr(j,2)=mkor(imin,2)
    mkorr(j,3)=mkor(imin,3)
    mkor(imin,1)='9999'
    mkor(imin,2)=0
    mkor(imin,3)=0
ENDFOR
FOR i=1 TO klkor
    mkor(i,1)=mkorr(i,1)
    mkor(i,2)=mkorr(i,2)
    mkor(i,3)=mkorr(i,3)
ENDFOR
* конец сортировки
nstr=nstr+1
IF nnstr>=nlist
     @ nstr,n1  SAY "Всего по "+ff
     @ nstr,n4 SAY fffsumd PICTURE '999,999,999,999.99'
     @ nstr,n5 SAY fffsumk PICTURE '999,999,999,999.99'
ENDIF
pr_per=.T.
IF klkor>0
    fkr=LEFT(mkor(1,1),2)
ENDIF
fsumd=0
fsumk=0
kol_kr=0
FOR i=1 TO klkor
    IF fkr#LEFT(mkor(i,1),2)
         IF kol_kr>1
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n2+15 SAY 'всего по'
                   @ nstr,n3 SAY fkr
                   @ nstr,n4 SAY fsumd PICTURE '999,999,999,999.99'
                   @ nstr,n5 SAY fsumk PICTURE '999,999,999,999.99'
              ENDIF
         ENDIF
         fkr=LEFT(mkor(i,1),2)
         fsumd=0
         fsumk=0
         kol_kr=0
    ENDIF
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         IF pr_per
              @ nstr,n1+9 SAY "в т.ч. по кор.счету "
              pr_per=.F.
         ENDIF
         @ nstr,n3 SAY mkor(i,1)
         @ nstr,n4 SAY mkor(i,2) PICTURE '999,999,999,999.99'
         @ nstr,n5 SAY mkor(i,3) PICTURE '999,999,999,999.99'
    ENDIF
    kol_kr=kol_kr+1
    fsumd=fsumd+mkor(i,2)
    fsumk=fsumk+mkor(i,3)
ENDFOR
IF kol_kr>1
    IF fsumk#0.OR.fsumd#0
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n2+15 SAY 'всего по'
              @ nstr,n3 SAY fkr
              @ nstr,n4 SAY fsumd PICTURE '999,999,999,999.99'
              @ nstr,n5 SAY fsumk PICTURE '999,999,999,999.99'
         ENDIF
    ENDIF
ENDIF
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,0 SAY "Лист "+STR(nst,2)+'.'
    @ 0,9 SAY "Сводная ведомость по подpазделениям по бал.счету "+ff+' за месяц '+tmec+' '+nastf_b+' г.'
    @ 1,0 SAY REPLICATE('-',82)
    @ 2,0 SAY "       |                              |    |              Сумма                  |"
    @ 3,0 SAY "  Код  |  Hаименование подpазделения  |Коpp|-------------------------------------|"
    @ 4,0 SAY "подpазд|                              |счет|       Дебет      |      Кредит      |"
    @ 5,0 SAY REPLICATE('-',82)
ENDIF
nstr=5
RETURN