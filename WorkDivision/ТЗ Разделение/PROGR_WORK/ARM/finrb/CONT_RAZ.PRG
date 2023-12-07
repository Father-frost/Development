DIMENSION mbs(100,3)
PRIVATE n1,n2,n3,n4,n5,n6,m1,m2,ii
n1=1
n2=8
n3=17
n4=25
n5=56
n6=75
n7=80
n8=99
nnstr=0
ii=0
GO TOP
nstr=kolstr+1
fkp='*******'
SCAN FOR nzk=gfbs.AND.kor=ffbs.AND.!DELETE().AND.MONTH(dat)=ntmec
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    SELECT bkr
    IF !SEEK(bk.kp+bk.nrd+DTOC(bk.dat,1)).AND.bk.sm#bkr.sm
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+'.'+" Контрольная ведомость по счету "+gfbs+" по кор.счету "+ffbs+" за месяц "+RTRIM(tmec)+' '+nastf_b+' г.'
@ 1,0 SAY REPLICATE('-',104)
@ 2,0 SAY "| Номер|  Дата  |  Код  |    Наименование организации  |      Сумма       |Корр|   Разбиение      |Корр|"
@ 3,0 SAY "|докум.|        |       |                              |                  |счет|                  |счет|"
@ 4,0 SAY REPLICATE('-',104)
              ENDIF
              nstr=4
              fkp='*******'
         ENDIF
         SELECT bk
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY nrd
              @ nstr,n2 SAY dat
              @ nstr,n3 SAY kp
              IF fkp#kp
                   @ nstr,n4 SAY Spr_nam(pr_spr,kp,30)
                   fkp=kp
              ENDIF
              @ nstr,n5 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n6 SAY kor
              @ nstr,n7 SAY bkr.sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n8 SAY bkr.kor
         ENDIF
    ENDIF
ENDSCAN
RETURN