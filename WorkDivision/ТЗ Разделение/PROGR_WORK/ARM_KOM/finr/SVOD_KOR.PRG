* Сводная ведомость по командировочным расходам по корреспондирующим счетам
DIMENSION mnzk(20),msald(20)
PRIVATE ii
n1=0
n2=8
n3=39
n4=56
nnstr=0
nstr=kolstr+1
ii=0
fsmk=0
klnzk=0
mnzk=0
msald=0
DO WHILE !EOF()
   smk1=0
   ftab=tab
   ffio=LEFT(sprrab.fio,30)
   fnzk=nzk
   SCAN REST WHILE ftab=tab.AND.fnzk=nzk
        ii=ii+1
        ?? ii PICTURE '999999' AT 18
        smk1=smk1+smk
    ENDSCAN
    IF smk1#0
       IF nstr>kolstr
          nnstr=nnstr+1
          DO Chap1 WITH nnstr,nstr,nlist
       ENDIF
       nstr=nstr+1
       IF nnstr>=nlist
          @ nstr,n1 SAY '|'+ftab+'|'
          @ nstr,n2 SAY ffio+'|'
          @ nstr,n3 SAY smk1 PICTURE '999,999,999.99'+'|'
            SELECT kodzk
            SEEK fnzk
            SELECT avotrr
          @ nstr,n4 SAY LEFT(kodzk.nam,20)+'|'
       ENDIF
       DO Chap2 WITH nnstr,nstr,nlist
          fsmk=fsmk+smk1
       FOR i=1 TO klnzk
           IF mnzk(i)=fnzk
              EXIT
           ENDIF
       ENDFOR
       IF i>klnzk
          klnzk=i
          mnzk(i)=fnzk
       ENDIF
       msald(i)=msald(i)+smk1+Delta
    ENDIF
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "|Итого:                               |"
    @ nstr,n3 SAY fsmk PICTURE '999,999,999.99'+'|'
ENDIF
DO Chap2 WITH nnstr,nstr,nlist
pr_per=.T.
FOR i=1 TO klnzk
    nstr=nstr+1
    IF nnstr>=nlist
         IF pr_per
              @ nstr,n1+3 SAY "в т.ч.  "
              pr_per=.F.
         ENDIF
            SELECT kodzk
            SEEK mnzk(i)
            SELECT avotrr
         @ nstr,n2+4 SAY LEFT(kodzk.nam,20)+REPLICATE('.',6)
         @ nstr,n3 SAY msald(i) PICTURE '999,999,999.99'
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
      *@ 0,12 SAY "Сводная ведомость по кор.счету " +ffkor+' за '+RTRIM(tmec)+' месяц  '+nastf_b+' г.'
    @ 0,12 SAY "Листок - расшифровка по кредиту счета " + ff
    @ 1,12 SAY "в дебет счета " +ffkor+' за '+RTRIM(tmec)+' месяц  '+nastf_b+' г.'
    @ 2,0  SAY REPLICATE('-',73)
    @ 3,0  SAY '|Табел |   Фамилия, имя, отчество     |    Сумма     |      Наименование  |'
    @ 4,0  SAY '|номер |                              |              |        расходов    |'
    @ 5,0  SAY REPLICATE('-',73)
ENDIF
nstr=6
RETURN
*
PROCEDURE Chap2
PARAMETERS nst,nstr,nlist
nstr=nstr+1
IF nst>=nlist
    @ nstr,0 SAY REPLICATE('-',73)
ENDIF
RETURN
*