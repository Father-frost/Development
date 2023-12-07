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
              @ 1,10 SAY "Bедомость по расходу по балансовому счету "+gfbs+' по к/счету '+ffbs+' за месяц '+tmec+' 19'+nastf_b+' г.'
              @ 2,0 SAY REPLICATE('-',165)
              @ 3,0 SAY '|  Дата  | Номер|                  |                  |                  |        |                              |'
              @ 4,0 SAY '|документ|докум.|      Сумма       | Сумма НДС ('+fsnds+') |  Сумма СН ('+fssn+') |  Код   |   Hаименование  организации  |'+SPACE(20)+'Текст'
              @ 5,0 SAY REPLICATE('-',165)
         ENDIF
         nstr=5
    ENDIF
    SELECT bk
    SET EXACT OFF
    SEEK gfbs+bkr.kp+bkr.nrd
    SET EXACT ON
    fnds=0
    fsn=0
    SCAN REST WHILE nzk=gfbs.AND.kp=bkr.kp.AND.nrd=bkr.nrd
         DO CASE
         CASE kor=fsnds.AND.text_1=bkr.text_1.AND.text_2=bkr.text_2.AND.text_3=bkr.text_3.AND.text_4=bkr.text_4
              fnds=fnds+sm
         CASE kor=fssn.AND.text_1=bkr.text_1.AND.text_2=bkr.text_2.AND.text_3=bkr.text_3.AND.text_4=bkr.text_4
              fsn=fsn+sm
         ENDCASE
    ENDSCAN
    SELECT bkr
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY dat
         @ nstr,n2 SAY nrd
         @ nstr,n3 SAY sm   PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n4 SAY fnds PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n5 SAY fsn  PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n6 SAY kp
         @ nstr,n7 SAY Spr_nam(pr_spr,kp,30)
         @ nstr,n8 SAY text_1
    ENDIF
    sum1=sum1+sm+Delta
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
RETURN
