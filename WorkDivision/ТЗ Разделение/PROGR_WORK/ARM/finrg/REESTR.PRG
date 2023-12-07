DIMENSION mkor(100),msald(100)
PRIVATE ii
n1=1
n2=10
n3=17
n4=25
n5=57
n6=64
n7=83
n8=94
n9=105
n10=116
n11=IIF(tek_b_9=1,128,83)
fsut=0
fproezd=0
fkvart=0
fproch=0
klkor=0
mbs=0
msald=0
mkor=0
nnstr=0
nstr=kolstr+1
ii=0
DO WHILE !EOF()
    fcex=nsk
    fmbs=0
    ffsut=0
    ffproezd=0
    ffkvart=0
    ffproch=0
    fkp='******'
    SCAN REST WHILE nsk=fcex
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
              fkp='******'
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY dat
              @ nstr,n2 SAY nvx
              @ nstr,n3 SAY tab
              IF fkp#tab
                   @ nstr,n4 SAY LEFT(sprrab.fio,30)
                   fkp=tab
              ENDIF
              @ nstr,n5 SAY kor
              @ nstr,n6 SAY smk PICTURE '999,999,999,999.99'
              IF tek_b_9=1
                   @ nstr,n7  SAY ssut
                   @ nstr,n8  SAY sproezd
                   @ nstr,n9  SAY skvart
                   @ nstr,n10 SAY sproch
              ENDIF
              IF tek_b_26=1
                   SELECT kodzk
                   SEEK avotrr.nzk
                   SELECT avotrr
                   @ nstr,n11 SAY kodzk.nam
              ENDIF
         ENDIF
         fmbs=fmbs+smk+Delta
         IF tek_b_9=1
              ffsut=ffsut+ssut+Delta
              ffproezd=ffproezd+sproezd
              ffkvart=ffkvart+skvart
              ffproch=ffproch+sproch
         ENDIF
         FOR i=1 TO klkor
              IF mkor(i)=kor
                   EXIT
              ENDIF
         ENDFOR
         IF i>klkor
              klkor=i
              mkor(i)=kor
         ENDIF
         msald(i)=msald(i)+smk+Delta
    ENDSCAN
    mbs=mbs+fmbs
    fsut=fsut+ffsut
    fproezd=fproezd+ffproezd
    fkvart=fkvart+ffkvart
    fproch=fproch+ffproch
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Итого по цеху "+fcex
         @ nstr,n6 SAY fmbs PICTURE '999,999,999,999.99'
         IF tek_b_9=1
              @ nstr,n7  SAY ffsut    PICTURE '99999999.99'
              @ nstr,n8  SAY ffproezd PICTURE '99999999.99'
              @ nstr,n9  SAY ffkvart  PICTURE '99999999.99'
              @ nstr,n10 SAY ffproch  PICTURE '99999999.99'
         ENDIF
    ENDIF
    DO Chap2 WITH nnstr,nstr,nlist
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "Итого по бал.счету N "+ff
    @ nstr,n6 SAY mbs PICTURE '999,999,999,999.99'
    IF tek_b_9=1
         @ nstr,n7  SAY fsut    PICTURE '99999999.99'
         @ nstr,n8  SAY fproezd PICTURE '99999999.99'
         @ nstr,n9  SAY fkvart  PICTURE '99999999.99'
         @ nstr,n10 SAY fproch  PICTURE '99999999.99'
    ENDIF
ENDIF
DO Chap2 WITH nnstr,nstr,nlist
pr_per=.T.
FOR i=1 TO klkor
    nstr=nstr+1
    IF nnstr>=nlist
         IF pr_per
              @ nstr,n1+10 SAY "в т.ч. по кор.счету"
              pr_per=.F.
         ENDIF
         @ nstr,n4+16 SAY mkor(i)
         @ nstr,n6 SAY msald(i) PICTURE '999,999,999,999.99'
    ENDIF
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
ENDFOR
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,0  SAY "Лист "+STR(nst,2)
    @ 0,12 SAY "Реестр документов средств по командировкам по бал.счету "+ff+' за месяц '+RTRIM(tmec)+' '+nastf_b+' г.'
    @ 1,0  SAY REPLICATE('-',IIF(tek_b_9=0,83,127))+IIF(tek_b_26=1,REPLICATE('-',31),'')
    @ 2,0  SAY '|        |      |       |                               |      |'+IIF(tek_b_9=1,SPACE(22),'')+'      Сумма       '+IIF(tek_b_9=1,SPACE(22),'')+'|'+IIF(tek_b_26=1,SPACE(30)+'|','')
    @ 3,0  SAY '|  Дата  |Hомер |  Код  |        Получатель             | Кор. |------------------'+IIF(tek_b_9=1,REPLICATE('-',44),'')+'|'+IIF(tek_b_26=1,'      Наименование заказа     |','')
    @ 4,0  SAY '|        |докум.|получат|                               | счет |     Кредит '+ff+IIF(tek_b_9=1,'  | Суточные |  Пpоезд  |Кваpтиpные|  Пpочие  ','  ')+'|'+IIF(tek_b_26=1,SPACE(30)+'|','')
    @ 5,0  SAY REPLICATE('-',IIF(tek_b_9=0,83,127))+IIF(tek_b_26=1,REPLICATE('-',31),'')
ENDIF
nstr=5
RETURN
*
PROCEDURE Chap2
PARAMETERS nst,nstr,nlist
nstr=nstr+1
IF nst>=nlist
    @ nstr,0 SAY REPLICATE('-',IIF(tek_b_9=0,83,127))
ENDIF
RETURN