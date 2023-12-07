PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii,f
DIMENSION mas(50,2),masi(50,2)
DIMENSION mas_op(50,4),masi_op(50,2)
n1=1
n2=9
n3=40
n4=48
n5=59
n6=78
n7=83
n7a=102
n8a=103
n8=123
n9=131
n10=142
n11=147
n12a=165
n12=166
n13=185
mbs1=0
mbs2=0
mbs3=0
mbs4=0
mbs1i=0
mbs2i=0
mbs3i=0
mbs4i=0
b1=0
b2=0
b3=0
b4=0
b5=0
s1=0
s2=0
s3=0
k=0
ii=0
uu:=1
for uu:=1 to 2
nstr=0
nnstr=0
nstr=kolstr+1
f=0
 FOR l=1 TO 2
 IF l=1
   select osdkom1
 *  SET FILTER TO kr#0
 *  SET ORDER TO kp_nvx
*   go top
 ELSE
   select atot
   SET ORDER TO kp_nvx
   go top
 ENDIF
 DO WHILE !EOF()
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    mas=0
    mas_op=0
    i=0
    fkp=kp
    fnam=Spr_nam(pr_spr,fkp,30)
      f_pr_reg=skl.pr_reg
      if f_pr_reg='001'.or.(val(kp)>=800.and.val(kp)<=899).or.(val(kp)>=1200.and.val(kp)<=1299).or.(val(kp)>=6500.and.val(kp)<=6699)
         priz=1
      else
         priz=2
      endif
    fnvx=nvx
    fnrd=nrd
    fdat=dat
    SCAN REST WHILE bs=nastf_1.AND.kp=fkp.AND.nvx=fnvx FOR !DELETE()
    funi=uni
    fkor=kor
    b5=b5+iif((kor='1801'.or.kor='1802'.or.kor='1803').and.l=1,smko,0)
       *if bs_op=nastf_1
          select tran_pos
          SET FILTER TO god=nastf_b.and.ms=ntmec
          if l=1
           seek osdkom1.uni
          else
           seek atot.uni
          endif
          do while funi=uni
             s2=s2+summa
             s3=s3+iif(fkor='1801'.or.fkor='1802'.or.fkor='1803',summa,0)
             mbs2=mbs2+summa
           if ascan(mas_op,nrd,1,50)=0
             k=k+1
             mas_op[k,1]=nrd
             mas_op[k,2]=dat
             mas_op[k,3]=nzk
             mas_op[k,4]=summa
           else
             if val(kp)=3132
               f=f+1
             endif
             for m=1 to k
              if nrd=mas_op[m,1]
                 f=m
              endif
              *ffnrd=mas_op[m,1]
             endfor
             mas_op[f,4]=mas_op[f,4]+summa
           endif
             skip
          enddo
       *else
*          k=0
*       endif
      IF l=1
       select osdkom1
       if kr#0
         s1=s1+kr
         mbs1=mbs1+kr
         i=i+1
         mas[i,1]=kor
         mas[i,2]=kr
       *else
         *s2=s2+db
         *mbs2=mbs2+db
         *k=k+1
        * mas_op[k,1]=nrd
        * mas_op[k,2]=dat
        * mas_op[k,3]=nzk
        * mas_op[k,4]=summa
       endif
      ELSE
       select atot
             if f_pr_reg='001'.or.(val(kp)>=800.and.val(kp)<=899).or.(val(kp)>=1200.and.val(kp)<=1299).or.(val(kp)>=6500.and.val(kp)<=6699)
               if fkor='1801'.or.fkor='1802'.or.fkor='1803'
                  b1=b1+smk
               else
                  b3=b3+smk
               endif
             else
               if fkor='1801'.or.fkor='1802'.or.fkor='1803'
                  b2=b2+smk
               else
                  b4=b4+smk
               endif
            endif
       if smk#0
         s1=s1+smk
         mbs1=mbs1+smk
         i=i+1
         mas[i,1]=kor
         mas[i,2]=smk
       endif
     ENDIF
    nz1=recno()
    funi=uni
    ENDSCAN
    IF nstr>kolstr
       nnstr=nnstr+1
       IF nnstr>=nlist
          @ 0,0 SAY 'Лист '+STR(nnstr,2)+'.   6-й  журнал  " Расчеты с поставщиками и подрядчиками "    за месяц '+RTRIM(tmec)+' '+nastf_b+' года'+SPACE(15)+DTOC(DATE())
          @ 1,0 SAY REPLICATE('-',185)
          @ 2,0 SAY '|       |                              |       |          |                  |   в  т. ч.по счетам    |                  |                закрытие                   |  На конец месяца |'
          @ 3,0 SAY '|  Код  |   Hаименование оpганизации   | Номер |   Дата   |     Поступило    |------------------------|     Оплачено     |-------------------------------------------|------------------|'
          @ 4,0 SAY '|оpгани-|                              |  ТТН  |          |    материалов    | к/с|      Сумма        |                  | N док. |   Дата   |Счет|      Сумма       |    Неоплачено    |'
          @ 5,0 SAY '| зации |                              |       |          |                  |    |                   |                  |        |          |    |                  |    матеpиалов    |'
          @ 6,0 SAY REPLICATE('-',185)
       ENDIF
       nstr=6
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
       @ nstr,n1 SAY fkp
       @ nstr,n2 SAY fnam
       @ nstr,n3 SAY fnvx
       @ nstr,n4 SAY fdat
       @ nstr,n5 SAY s1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
       r=iif(k>i,k,i)
       for j=1 to r
        nstr=iif(j>1,nstr+1,nstr)
        a1=iif(empty(mas[j,1]),'    ',mas[j,1])
        @ nstr,n6 SAY a1
        @ nstr,n7 SAY mas[j,2] PICTURE '999,999,999,999.99' FUNCTION 'Z'
        @ nstr,n7a SAY '|'
        a1=iif(empty(mas_op[j,1]),'       ',mas_op[j,1])
        if j=1
         @ nstr,n8a SAY s2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
        endif
        @ nstr,n8 SAY a1
        a1=iif(empty(mas_op[j,2]),'          ',mas_op[j,2])
        @ nstr,n9 SAY a1
        a1=iif(empty(mas_op[j,3]),'    ',mas_op[j,3])
        @ nstr,n10 SAY a1
        *@ nstr,n10 SAY mas_op[j,3]
        @ nstr,n11 SAY mas_op[j,4]  PICTURE '999,999,999,999.99' FUNCTION 'Z'
        @ nstr,n12a SAY '|'
        if j=1
           if s1>s2.or.s1<0
             mbs3=mbs3+(s1-s2)
             @ nstr,n12 SAY s1-s2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
           else
             if s1=s2
               *mbs4=mbs4+(s2-s1)
               @ nstr,n12 SAY '           ЗАКРЫТА'
             endif
           endif
        endif
       endfor
        nstr=nstr+1
        IF nnstr>=nlist
           @ nstr,0 SAY REPLICATE('-',185)
        ENDIF
    ENDIF
 j=0
 k=0
 s1=0
 s2=0
 go nz1
  skip
 ENDDO
*nstr=nstr+1
*IF nnstr>=nlist
*    @ nstr,n1  SAY "Итого"
*    @ nstr,n5  SAY  mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
*    @ nstr,n8a SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
   *@ nstr,n9  SAY  'в т.ч. НДС'
   *@ nstr,n11 SAY s3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
*    @ nstr,n12 SAY  mbs3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
*    @ nstr,n13 SAY mbs4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
*    nstr=nstr+1
*    IF nnstr>=nlist
*       @ nstr,0 SAY REPLICATE('-',204)
*    ENDIF
*ENDIF
*mbs1i=mbs1i+mbs1
mbs2i=mbs2i+mbs2
mbs3i=mbs3i+mbs3
mbs4i=mbs4i+mbs4
mbs1i=mbs1
mbs1=0
mbs2=0
mbs3=0
mbs4=0
ENDFOR
endfor   * uu
*SELECT bkr
*fkp=kp
*SCAN
*    fnam=Spr_nam(pr_spr,kp,30)
*    IF nstr>kolstr
*       nnstr=nnstr+1
*       IF nnstr>=nlist
*         @ 0,0 SAY 'Лист '+STR(nnstr,2)+'.              6-й  журнал          за месяц '+RTRIM(tmec)+' '+nastf_b+' года'+SPACE(15)+DTOC(DATE())
*          @ 1,0 SAY REPLICATE('-',204)
*          @ 2,0 SAY '|       |                              |       |          |                  |   в  т. ч.по счетам    |                  |                в  т. ч.по счетам          |           На конец месяца           |'
*          @ 3,0 SAY '|  Код  |   Hаименование оpганизации   | Номер |   Дата   |     Поступило    |------------------------|     Оплачено     |-------------------------------------------|-------------------------------------|'
*          @ 4,0 SAY '|оpгани-|                              |  ТТН  |          |    материалов    | к/с|      Сумма        |    материалов    | N док. |   Дата   |Счет|      Сумма       |    Неоплачено    |     Осталось     |'
*          @ 5,0 SAY '| зации |                              |       |          |                  |    |                   |                  |        |          |    |                  |    матеpиалов    |      авансов     |'
*          @ 6,0 SAY REPLICATE('-',204)
*       ENDIF
*       nstr=6
*    ENDIF
*    nstr=nstr+1
*    IF nnstr>=nlist
*       @ nstr,n1 SAY kp
*       @ nstr,n2 SAY fnam
*        @ nstr,n7a SAY '|'
*        @ nstr,n8a SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
*        @ nstr,n8 SAY nrd
*        @ nstr,n9 SAY dat
*        @ nstr,n10 SAY nzk
*        @ nstr,n11 SAY sm  PICTURE '999,999,999,999.99' FUNCTION 'Z'
*        @ nstr,n12a SAY '|'
*        mbs4i=mbs4i+sm
*        @ nstr,n13 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
*    ENDIF
*        nstr=nstr+1
*        IF nnstr>=nlist
*           @ nstr,0 SAY REPLICATE('-',204)
*        ENDIF
*ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1  SAY "Всего"
    @ nstr,n5  SAY  mbs1i PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n8a SAY mbs2i PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n9  SAY  'в т.ч. НДС'
    @ nstr,n11 SAY s3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n12 SAY  mbs3i PICTURE '999,999,999,999.99' FUNCTION 'Z'
*    @ nstr,n13 SAY mbs4i PICTURE '999,999,999,999.99' FUNCTION 'Z'
    nstr=nstr+1
    IF nnstr>=nlist
       @ nstr,0 SAY REPLICATE('-',185)
    ENDIF
ENDIF
mas=0
mas_op=0
i=0
k=0
SELECT ATOT
INDEX ON kor TAG rab
GO TOP
fkor=kor
DO WHILE !EOF()
  i=i+1
  mas[i,1]=kor
  SCAN WHILE fkor=kor
    mas[i,2]=mas[i,2]+smk
  ENDSCAN
  fkor=kor
ENDDO
SELECT TRAN_POS
SET FILTER TO god=nastf_b.and.ms=ntmec
INDEX ON nzk TO l1
GO TOP
fnzk=nzk
DO WHILE !EOF()
  k=k+1
  mas_op[k,3]=nzk
  SCAN WHILE fnzk=nzk
    mas_op[k,4]=mas_op[k,4]+summa
  ENDSCAN
  fnzk=nzk
ENDDO
    nstr=nstr+1
    IF nnstr>=nlist
       r=iif(k>i,k,i)
       for j=1 to r
        a1=iif(empty(mas[j,1]),'    ',mas[j,1])
        @ nstr,n6 SAY a1
        @ nstr,n7 SAY mas[j,2] PICTURE '999,999,999,999.99' FUNCTION 'Z'
        a1=iif(empty(mas_op[j,3]),'    ',mas_op[j,3])
        @ nstr,n10 SAY a1
        @ nstr,n11 SAY mas_op[j,4]  PICTURE '999,999,999,999.99' FUNCTION 'Z'
        nstr=nstr+1
      * endif
       endfor
    ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',185)
        @ nstr+1,0 SAY b1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
        @ nstr+1,21 SAY '-Сумма НДС на товары производства  России'
        @ nstr+2,0 SAY b3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
        @ nstr+2,21 SAY '-Сумма товаров произведенных в  России'
        @ nstr+3,0 SAY b2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
        @ nstr+3,21 SAY '-Сумма НДС на товары производства РБ'
        @ nstr+4,0 SAY b4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
        @ nstr+4,21 SAY '-Сумма товаров произведенных в  РБ'
        @ nstr+5,0 SAY b5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
        @ nstr+5,21 SAY '-Сумма НДС на товары,полученные до расчетного месяца'
ENDIF
EJECT
RETURN
*