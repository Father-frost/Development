DIMENSION mbs(100,4)
PRIVATE n1,n2,n3,n4,n5,n6,n7,mbs1,mbs2,mbs3,mbs4,ii
n1=1
n2=9
n3=40
n4=47
n5=56
n6=63
n7=68
n8=87
n9=106
n10=125
n11=134
n12=141
nnstr=0
GO TOP
ffsum=0
ffsss=0
ffsumo=0
ii=0
DO WHILE !EOF()
    fnsk=nsk
    nstr=kolstr+1
    fsum=0
    fsss=0
    fsumo=0
    mbs=0
    kolbs=0
    DO WHILE nsk=fnsk
         fkp=kp
         fnvx=nvx
         fnrd=nrd
         sfsum=0
         sfsss=0
         sfsumo=0
         pr_per=.T.
         i=0
         SCAN REST WHILE nsk=fnsk.AND.fkp=kp.AND.fnvx=nvx.AND.fnrd=nrd FOR db#0.OR.smd#0.OR.smd#0
              i=i+1
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              IF nstr>kolstr
                   nnstr=nnstr+1
                   IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Ведомость по pеализации по подpазделению "+fnsk+' '+Spr_nam('2',fnsk,30)
@ 1,0 SAY REPLICATE('-',IIF(nastf_h=1,160,125))
@ 2,0 SAY "|Код оp.|   Hаименование оpганизации   |N тpеб|Дата док|N TTH |К/сч| Сальдо на начало |    Отгpужено     |     Оплачено     |"+IIF(nastf_h=1,'Дата опл| Номер|   Сумма оплаты   |','')
@ 3,0 SAY REPLICATE('-',IIF(nastf_h=1,160,125))
                   ENDIF
                   pr_per=.T.
                   nstr=3
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY kp
                   IF pr_per
                        @ nstr,n2 SAY Spr_nam(pr_spr,kp,30)
                        pr_per=.F.
                   ENDIF
                   @ nstr,n3 SAY nrd
                   @ nstr,n4 SAY dat
                   @ nstr,n5 SAY nvx
                   @ nstr,n6 SAY kor
                   @ nstr,n7 SAY db   PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n8 SAY smd  PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n9 SAY smdo PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   IF nastf_h=1
                        SELECT tran_opl
                        SET EXACT OFF
                        SEEK STR(osdkomr.uni,7)
                        SET EXACT ON
                        j=0
                        SCAN REST WHILE uni=osdkomr.uni FOR ms=ntmec.AND.god=nastf_b.AND.summa#0.AND.!DELETE()
                             IF nstr>kolstr
                                  nnstr=nnstr+1
                                  IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Ведомость по pеализации по подpазделению "+fnsk+' '+Spr_nam('2',fnsk,30)
@ 1,0 SAY REPLICATE('-',IIF(nastf_h=1,160,125))
@ 2,0 SAY "|Код оp.|   Hаименование оpганизации   |N тpеб|Дата док|N TTH |К/сч| Сальдо на начало |    Отгpужено     |     Оплачено     |"+IIF(nastf_h=1,'Дата опл| Номер|   Сумма оплаты   |','')
@ 3,0 SAY REPLICATE('-',IIF(nastf_h=1,160,125))
                                  ENDIF
                                  pr_per=.T.
                                  nstr=3
                             ENDIF
                             j=j+1
                             IF j>1
                                  nstr=nstr+1
                             ENDIF
                             IF nnstr>=nlist
                                  @ nstr,n10 SAY dat
                                  @ nstr,n11 SAY nrd
                                  @ nstr,n12 SAY summa PICTURE '999,999,999,999.99'
                             ENDIF
                        ENDSCAN
                        SELECT osdkomr
                   ENDIF
              ENDIF
              sfsum=sfsum+db
              sfsss=sfsss+smd
              sfsumo=sfsumo+smdo
              FOR j=1 TO kolbs
                   IF mbs(j,1)=kor
                        EXIT
                   ENDIF
              ENDFOR
              IF j>kolbs
                   kolbs=j
                   mbs(j,1)=kor
              ENDIF
              mbs(j,2)=mbs(j,2)+db
              mbs(j,3)=mbs(j,3)+smd
              mbs(j,4)=mbs(j,4)+smdo
         ENDSCAN
         IF sfsum#0.OR.sfsss#0.OR.sfsumo#0
              IF i>1
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n2 SAY "Итого по документу"
                        @ nstr,n3 SAY fnrd
                        @ nstr,n7 SAY sfsum  PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n8 SAY sfsss  PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n9 SAY sfsumo PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
              ENDIF
              fsum=fsum+sfsum
              fsss=fsss+sfsss
              fsumo=fsumo+sfsumo
         ENDIF
    ENDDO
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Итого по подpазделению "+fnsk
         @ nstr,n7 SAY fsum  PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n8 SAY fsss  PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n9 SAY fsumo PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    FOR i=1 TO kolbs
         nstr=nstr+1
         IF nnstr>=nlist
              IF i=1
                   @ nstr,n2 SAY "в том числе"
              ENDIF
              @ nstr,n6 SAY mbs(i,1)
              @ nstr,n7 SAY mbs(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n8 SAY mbs(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n9 SAY mbs(i,4) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
    ENDFOR
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',124)
    ENDIF
    ffsum=ffsum+fsum
    ffsss=ffsss+fsss
    ffsumo=ffsumo+fsumo
ENDDO
IF EMPTY(pskl)
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Всего"
         @ nstr,n7 SAY ffsum  PICTURE '999,999,999,999.99'
         @ nstr,n8 SAY ffsss  PICTURE '999,999,999,999.99'
         @ nstr,n9 SAY ffsumo PICTURE '999,999,999,999.99'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',124)
    ENDIF
ENDIF
EJECT
RETURN
