DIMENSION mbs(100,3)
PRIVATE n1,n2,n3,n4,n5,n6,m1,m2,ii
n1=1
n2=8
n3=17
n4=36
n5=55
nnstr=0
ii=0
GO TOP
nstr=kolstr+1
SCAN FOR !DELETE()
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    SELECT lim_nsk
    fsum=0
    IF SEEK(bkr.kp+bkr.nrd+bkr.kor+bkr.nzk+bkr.vo+DTOC(bkr.dat,1))
         SCAN REST WHILE kp=bkr.kp.AND.bkr.nrd=nrd.AND.kor=bkr.kor.AND.nzk=bkr.nzk.AND.vo=bkr.vo.AND.dat=bkr.dat
              fsum=fsum+summa
         ENDSCAN
    ENDIF
    SELECT bkr
    IF sm#fsum
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+'.'+" Сводная ведомость по подразделениям за месяц "+RTRIM(tmec)+' по счету '+gfbs
@ 1,0 SAY REPLICATE('-',74)
@ 2,0 SAY "| Номер|  Дата  |    Поступление   |      Расход      |   Разбиение      |"
@ 3,0 SAY "|докум.|        |                  |                  |                  |"
@ 4,0 SAY REPLICATE('-',74)
              ENDIF
              nstr=4
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY nrd
              @ nstr,n2 SAY dat
              IF vo='0'
                   @ nstr,n3 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ELSE
                   @ nstr,n4 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
              @ nstr,n5 SAY fsum PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
    ENDIF
ENDSCAN
EJECT
RETURN
