PRIVATE fsum,ii
DIMENSION mdat(100,31),mkor(100),n(16)
kolkor=0
fsum=0
IF fvo='1'
    nam_wed='        Ж У Р Н А Л    -    О Р Д Е Р   ( Кредит счета '+gfbs+' )'
ELSE
    nam_wed='         В Е Д О М О С Т Ь    ( Дебет счета '+gfbs+' )'
ENDIF
nnstr=0
n1=1
n(1)=6
n(2)=19
n(3)=32
n(4)=45
n(5)=58
n(6)=71
n(7)=84
n(8)=97
n(9)=110
n(10)=123
n(11)=136
n(12)=149
n(13)=162
n(14)=175
n(15)=188
n(16)=201
mdat=0
ii=0
SCAN FOR fvo=vo.AND.nzk=gfbs.AND.sm#0.AND.!DELETE()
  ii=ii+1
  ?? ii PICTURE '999999' AT 18
  FOR i=1 TO kolkor
       IF mkor(i)=kor
            mdat(i,DAY(dat))=mdat(i,DAY(dat))+sm
            EXIT
       ENDIF
  ENDFOR
  IF i>kolkor
    IF i>100
         SET DEVICE TO SCREEN
         @ 9,19 FILL TO 14,66 COLOR &color20
         SET COLOR TO &color13
         @ 8,18,13,65 BOX "╔═╗║╝═╚║░"
         SET COLOR TO &color14
         @ 10,20 SAY "Количество коpp. счетов  пpевысило 100."
         @ 11,25 SAY "Пpодолжение - любая клавиша..."
         READ
         RETURN
    ENDIF
    kolkor=i
    mkor(i)=kor
    mdat(i,DAY(dat))=sm
  ENDIF
ENDSCAN
FOR n_str=1 TO 2
  pr_str=.F.
  IF n_str=2.AND.nstr<kolstr/2                && если вторая сторона и поллиста
     nstr=PROW()+1
     pr_str=.T.
  ELSE
     nstr=kolstr+1
     nnstr=0
  ENDIF
  FOR i=1 TO kolkor
    IF n_str=1
     IF nstr>kolstr
       nnstr=nnstr+1
       IF nnstr>=nlist
         sss=0

         IF ch1=3.AND.fvo='0'
           sss=sss+3
           @ 2,0 SAY 'Сальдо на начало месяца '+TRANSFORM(spr_bs.saldm,'999,999,999,999,999')
         ENDIF
         @ 1+sss,0 SAY REPLICATE('-',214)
         @ 2+sss,0 SAY "|    |                                                 Д Н И     М Е С Я Ц А"+SPACE(137)+"|"
         @ 3+sss,0 SAY "|Коpp|"+REPLICATE('-',207)+"|"
         @ 4+sss,0 SAY "|счет|      1     |      2     |      3     |      4     |      5     |      6     |      7     |      8     |      9     |     10     |     11     |     12     |     13     |     14     |     15     |     16     |"
         @ 5+sss,0 SAY REPLICATE('-',214)
         nstr=5+sss
       ENDIF
     ENDIF
     nstr=nstr+2
     IF nnstr>=nlist
       @ nstr,n1 SAY mkor(i)
       FOR j=1 TO 16
        IF mdat(i,j)=0
          @ nstr,n(j)-1 SAY REPLICATE('.',13)
        ELSE
          @ nstr,n(j)-1 SAY mdat(i,j) PICTURE '9999999999999'
        ENDIF
       ENDFOR
     ENDIF
     IF i=kolkor
          nstr=nstr+1
          IF nnstr>=nlist
               @ nstr,0 SAY REPLICATE('-',214)
          ENDIF
          nstr=nstr+1
          FOR j=1 TO 16
               fsum=0
               FOR i=1 TO kolkor
                    fsum=fsum+mdat(i,j)
               ENDFOR
               IF nnstr>=nlist
                    @ nstr,n(j)-1 SAY fsum PICTURE '9999999999999' FUNCTION 'Z'
               ENDIF
          ENDFOR
          IF nstr>kolstr/2                && если занято > половины
            eject
          else
            nstr=nstr+4	
         ENDIF
     ENDIF
    ELSE
     IF nstr>kolstr.OR.pr_str
          IF !pr_str
               nstr=0
          ENDIF
          pr_str=.F.
          nnstr=nnstr+1
          IF nnstr>=nlist
@ nstr  ,0  SAY "Лист "+STR(nnstr,2)+"."+SPACE(10)+nam_wed+' по счету '+gfbs+"      за месяц "+tmec+' '+nastf_b+' г.'
@ nstr+1,0 SAY REPLICATE('-',217)
@ nstr+2,0 SAY "|    |                                                 Д Н И     М Е С Я Ц А"+SPACE(140)+"|"
@ nstr+3,0 SAY "|Коpp|"+REPLICATE('-',210)+"|"
@ nstr+4,0 SAY "|счет|     17     |     18     |     19     |     20     |     21     |     22     |     23     |     24     |     25     |     26     |     27     |     28     |     29     |     30     |     31     |     Всего     |"
@ nstr+5,0 SAY REPLICATE('-',217)
                        nstr=nstr+5
          ENDIF
     ENDIF
     nstr=nstr+2
     IF nnstr>=nlist
          @ nstr,n1 SAY mkor(i)
          FOR j=17 TO 31
               IF mdat(i,j)=0
                    @ nstr,n(j-16)-1 SAY REPLICATE('.',13)
               ELSE
                    @ nstr,n(j-16)-1 SAY mdat(i,j) PICTURE '9999999999999'
               ENDIF
          ENDFOR
          fsum=0
          FOR j=1 TO 31
               fsum=fsum+mdat(i,j)
          ENDFOR
          @ nstr,n(16) SAY fsum PICTURE '999999999999999' FUNCTION 'Z'
     ENDIF
     IF i=kolkor
          nstr=nstr+1
          IF nnstr>=nlist
               @ nstr,0 SAY REPLICATE('-',217)
          ENDIF
          nstr=nstr+1
          FOR j=17 TO 31
               fsum=0
               FOR i=1 TO kolkor
                    fsum=fsum+mdat(i,j)
               ENDFOR
               IF nnstr>=nlist
                    @ nstr,n(j-16)-1 SAY fsum PICTURE '9999999999999' FUNCTION 'Z'
               ENDIF
          ENDFOR
          fsum=0
          FOR j=1 TO 31
               FOR i=1 TO kolkor
                    fsum=fsum+mdat(i,j)
               ENDFOR
          ENDFOR
          IF nnstr>=nlist
               @ nstr,n(16) SAY fsum PICTURE '999999999999999' FUNCTION 'Z'
          ENDIF
     ENDIF
    ENDIF
    ENDFOR
    *eject
ENDFOR
IF ch1=3
    fsmd=fsmd+IIF(fvo='0',fsum,-fsum)
ENDIF
IF ch1=3.AND.fvo='1'
  nstr=nstr+2
  IF nnstr>=nlist
     @ nstr,0 SAY 'Сальдо на конец месяца '+TRANSFORM(spr_bs.saldm+fsmd,'999,999,999,999,999')
  ENDIF
ENDIF
   eject
RETURN