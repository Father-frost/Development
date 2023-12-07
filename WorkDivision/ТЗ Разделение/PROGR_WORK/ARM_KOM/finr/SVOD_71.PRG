SET PROCEDURE TO svod_71
DIMENSION mkor(100,2)
PRIVATE ii
n1=1
n2=9
n3=40
n4=45
klkor=0
mkor=0
nnstr=0
nstr=kolstr+1
fffsum=0
ii=0
DO WHILE !EOF()
    ffsum=0
    fnsk=nsk
    pr_per=.T.
    DO WHILE nsk=fnsk.AND.!EOF()
         fbs=LEFT(kor,2)
         fsum=0
         skol=0
         DO WHILE nsk=fnsk.AND.fbs=LEFT(kor,2).AND.!EOF()
              fkor=kor
              sfsum=0
              SCAN REST WHILE nsk=fnsk.AND.fkor=kor
                   ii=ii+1
                   ?? ii PICTURE '999999' AT 18
                   FOR i=1 TO klkor
                        IF mkor(i,1)=kor
                             EXIT
                        ENDIF
                   ENDFOR
                   IF i>klkor
                        klkor=i
                        mkor(i,1)=kor
                   ENDIF
                   mkor(i,2)=mkor(i,2)+smk+Delta
                   sfsum=sfsum+smk
              ENDSCAN
              skol=skol+1
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF pr_per
                        SELECT sch
                        SEEK fnsk
                        SELECT avotrr
                        @ nstr,n1 SAY fnsk
                        @ nstr,n2 SAY sch.icsk
                        pr_per=.F.
                   ENDIF
                   @ nstr,n3 SAY fkor
                   @ nstr,n4 SAY sfsum PICTURE '999999999999.99'
              ENDIF
              fsum=fsum+sfsum
         ENDDO
         IF skol>1
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY "Всего по "
                   @ nstr,n3 SAY fbs
                   @ nstr,n4 SAY fsum PICTURE '999999999999.99'
              ENDIF
         ENDIF
         ffsum=ffsum+fsum
    ENDDO
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Итого по подpазделению "+fnsk
         @ nstr,n4 SAY ffsum PICTURE '999999999999.99'
    ENDIF
    DO Chap2 WITH nnstr,nstr,nlist
    fffsum=fffsum+ffsum
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "Итого по бал.счету "+ff
    @ nstr,n4 SAY fffsum PICTURE '999999999999.99'
ENDIF
DO Chap2 WITH nnstr,nstr,nlist
* сортировка массива
DIMENSION mkorr(100,2)
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
    mkor(imin,1)='9999'
    mkor(imin,2)=0
ENDFOR
FOR i=1 TO klkor
    mkor(i,1)=mkorr(i,1)
    mkor(i,2)=mkorr(i,2)
ENDFOR
* конец сортировки
IF klkor>0
    fkr=LEFT(mkor(1,1),2)
ENDIF
fsumk=0
kol_kr=0
pr_per=.T.
FOR i=1 TO klkor
    IF fkr#LEFT(mkor(i,1),2)
         IF kol_kr>1
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n2+10 SAY 'всего по'
                   @ nstr,n3 SAY fkr
                   @ nstr,n4 SAY fsumk PICTURE '999999999999.99'
              ENDIF
         ENDIF
         fkr=LEFT(mkor(i,1),2)
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
         @ nstr,n4 SAY mkor(i,2) PICTURE '999999999999.99'
    ENDIF
    kol_kr=kol_kr+1
    fsumk=fsumk+mkor(i,2)
ENDFOR
IF kol_kr>1
    IF fsumk#0
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n2+10 SAY 'всего по'
              @ nstr,n3 SAY fkr
              @ nstr,n4 SAY fsumk PICTURE '999999999999.99'
         ENDIF
    ENDIF
ENDIF
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,0  SAY "Лист "+STR(nst,2)
    @ 0,12 SAY "Свод по подpазделениям по балансовому счету "+ff
    @ 1,0  SAY REPLICATE('-',61)
    @ 2,0  SAY '|       |                              |    |               |'
    @ 3,0  SAY '|  Код  |        Подpазделение         |Кор.|     Cумма     |'
    @ 4,0  SAY '|подpаз.|                              |счет|               |'
    @ 5,0  SAY REPLICATE('-',61)
ENDIF
nstr=5
RETURN
*
PROCEDURE Chap2
PARAMETERS nst,nstr,nlist
nstr=nstr+1
IF nst>=nlist
    @ nstr,0 SAY REPLICATE('-',60)
ENDIF
RETURN
