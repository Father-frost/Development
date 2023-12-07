PRIVATE fsum,ii
RESTORE FROM nsch ADDITIVE
GO TOP
n1=1
n2=10
n3=17
n4=36
n5=55
n6=74
n7=83
n8=114
nnstr=0
nstr=0
ii=0
nstr=kolstr+1
sum1=0
ffnds=0
ffsn=0
SCAN REST WHILE ffbs=kor
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
              @ 0,0 SAY nschn1
              @ 1,1  SAY "Лист "+STR(nnstr,2)+"."
              @ 1,10 SAY "Bедомость по ав.отчетам по балансовому счету "+ff+' по к/счету '+ffbs+' за месяц '+tmec+' 19'+nastf_b+' г.'
              @ 2,0 SAY REPLICATE('-',165)
              @ 3,0 SAY '|  Дата  | Номер|                  |                  |                  |Табельн.|                              |'
              @ 4,0 SAY '|документ|докум.|      Сумма       | Сумма НДС ('+fsnds+') |  Сумма СН ('+fssn+') | номер  |         Фамилия И.О.         |'+SPACE(15)+'Текст'
              @ 5,0 SAY REPLICATE('-',165)
         ENDIF
         nstr=5
    ENDIF
    SELECT avotr
    SET EXACT OFF
    SEEK ff+avotrr.tab+LEFT(avotrr.nvx,5)
    SET EXACT ON
    fnds=0
    fsn=0
    SCAN REST WHILE bs=ff.AND.tab=avotrr.tab.AND.nvx=LEFT(avotrr.nvx,5) FOR nzk=avotrr.nzk
         DO CASE
         CASE kor=fsnds
              fnds=fnds+smk
         CASE kor=fssn
              fsn=fsn+smk
         ENDCASE
    ENDSCAN
    SELECT kodzk
    SEEK avotrr.nzk
    SELECT avotrr
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY dat
         @ nstr,n2 SAY nvx
         @ nstr,n3 SAY smk  PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n4 SAY fnds PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n5 SAY fsn  PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n6 SAY tab
         @ nstr,n7 SAY LEFT(sprrab.fio,30)
         @ nstr,n8 SAY kodzk.nam
    ENDIF
    sum1=sum1+smk+Delta
    ffnds=ffnds+fnds
    ffsn=ffsn+fsn
ENDSCAN
IF sum1#0.OR.ffnds#0.OR.ffsn#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Итого"
         @ nstr,n3 SAY sum1  PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n4 SAY ffnds PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n5 SAY ffsn  PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',165)
    ENDIF
ENDIF
EJECT
RETURN
