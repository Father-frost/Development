PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii
n1=1
n2=9
n3=40
n4=47
n5=56
n6=65
n7=70
mbs1=0
nnstr=0
nstr=kolstr+1
ii=0
GO TOP
DO WHILE !EOF()
    fdatp=datp
    ms1=0
    DO WHILE fdatp=datp.AND.!EOF()
         fkp=kp
         m1=0
         i=0
         pr_kp=.T.
         SCAN REST WHILE fdatp=datp.AND.fkp=kp
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              IF !DELETE()
                   i=i+1
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        IF nnstr>=nlist
@ 0,2 SAY "Лист "+STR(nnstr,2)+". Ведомость по предстоящим поступлениям на "+DTOC(ffdatk)
@ 1,0 SAY REPLICATE('-',89)
@ 2,0 SAY '|Код оp.|   Hаименование оpганизации   | Номер|  Дата  |  Дата  |Корр|      Сумма       |'
@ 3,0 SAY '|       |                              |докум.|        |поступл.|счет|                  |'
@ 4,0 SAY REPLICATE('-',89)
                        ENDIF
                        nstr=4
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY fkp
                        IF pr_kp
                             @ nstr,n2 SAY Spr_nam(pr_spr,kp,30)
                             pr_kp=.F.
                        ENDIF
                        @ nstr,n3 SAY nrd
                        @ nstr,n4 SAY dat
                        @ nstr,n5 SAY datp
                        @ nstr,n6 SAY kor
                        @ nstr,n7 SAY IIF(db#0,db,smd)-smdo PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
                   m1=m1+IIF(db#0,db,smd)-smdo
              ENDIF
         ENDSCAN
         IF m1>0
              IF i>1
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY 'Итого по '+fkp
                        @ nstr,n7 SAY m1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,0 SAY REPLICATE('-',88)
              ENDIF
              ms1=ms1+m1
         ENDIF
    ENDDO
    IF ms1>0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY 'Итого за день '+DTOC(fdatp)
              @ nstr,n7 SAY ms1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('=',88)
         ENDIF
         mbs1=mbs1+ms1
    ENDIF
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "Всего"
    @ nstr,n7 SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
EJECT
RETURN
