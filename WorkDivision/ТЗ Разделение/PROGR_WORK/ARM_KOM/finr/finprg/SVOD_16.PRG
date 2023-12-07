PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,mbs5,ii
DIMENSION mbs(100,2),mbss(100,2)
n1=1
n2=6
n3=32
n4=51
n5=70
n6=89
n7=108
mbs1=0
mbs2=0
mbs3=0
mbs4=0
mbs5=0
nnstr=0
kolbs=0
mbs=0
nstr=kolstr+1
GO TOP
ii=0
DO WHILE !EOF()
    fkor=kor
    ms1=0
    ms2=0
    ms4=0
    kolbss=0
    mbss=0
    SCAN REST WHILE fkor=kor
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         ms1=ms1+osdkomr.db
         ms4=ms4+smdo
         IF smdo#0
              FOR i=1 TO kolbs
                   IF mbs(i,1)=bs_op
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbs
                   kolbs=i
                   mbs(i,1)=bs_op
              ENDIF
              mbs(i,2)=mbs(i,2)+smdo
              FOR i=1 TO kolbss
                   IF mbss(i,1)=bs_op
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbss
                   kolbss=i
                   mbss(i,1)=bs_op
              ENDIF
              mbss(i,2)=mbss(i,2)+smdo
         ENDIF
    ENDSCAN
    SELECT avotrr
    SEEK fkor
    SCAN REST WHILE fkor=kor
         ms2=ms2+smd
         ms4=ms4+smdo
         IF smdo#0
              FOR i=1 TO kolbs
                   IF mbs(i,1)=bs_op
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbs
                   kolbs=i
                   mbs(i,1)=bs_op
              ENDIF
              mbs(i,2)=mbs(i,2)+smdo
              FOR i=1 TO kolbss
                   IF mbss(i,1)=bs_op
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolbss
                   kolbss=i
                   mbss(i,1)=bs_op
              ENDIF
              mbss(i,2)=mbss(i,2)+smdo
         ENDIF
    ENDSCAN
    IF ms1#0.OR.ms2#0.OR.ms4#0
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Ведомость по отгpузке и pеализации пpодукции по счету "+ffbs+' за месяц '+tmec
@ 1,0 SAY REPLICATE('-',127)
@ 2,0 SAY "|К/сч|    Hаименование счета   | Сальдо на начало |    Отгpужено     |  Итого с сальдо  |     Оплачено     | Сальдо на конец  |"
@ 3,0 SAY REPLICATE('-',127)
              ENDIF
              nstr=3
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fkor
              SELECT spr_bs
              SEEK fkor
              SELECT osdkomr
              @ nstr,n2 SAY spr_bs.nam
              @ nstr,n3 SAY ms1         PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n4 SAY ms2         PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n5 SAY ms1+ms2     PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n6 SAY ms4         PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n7 SAY ms1+ms2-ms4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         mbs1=mbs1+ms1
         mbs2=mbs2+ms2
         mbs3=mbs3+ms1+ms2
         mbs4=mbs4+ms4
         mbs5=mbs5+ms1+ms2-ms4
    ENDIF
    pr_per=.T.
    FOR i=1 TO kolbss
         nstr=nstr+1
         IF nnstr>=nlist
              IF pr_per
                   @ nstr,n1 SAY "в том числе"
                   pr_per=.F.
              ENDIF
              @ nstr,n5 SAY mbss(i,1)
              @ nstr,n6 SAY mbss(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
    ENDFOR
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',126)
    ENDIF
    SELECT osdkomr
ENDDO
nstr=nstr+1
IF nnstr>=nlist
     @ nstr,n1 SAY "Итог"
     @ nstr,n3 SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n4 SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n5 SAY mbs3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n6 SAY mbs4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n7 SAY mbs5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',126)
ENDIF
pr_per=.T.
FOR i=1 TO kolbs
    nstr=nstr+1
    IF nnstr>=nlist
         IF pr_per
              @ nstr,n1 SAY "в том числе"
              pr_per=.F.
         ENDIF
         @ nstr,n5 SAY mbs(i,1)
         @ nstr,n6 SAY mbs(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDFOR
EJECT
RETURN
