PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii
DIMENSION mas(25,2),mas1(25,2)
n1=1
n1a=12
n2=19
n2a=30
n3=37
n3a=44
n4=77
n5=88
n6=107
n7=124
n8=139
n9=156
n10=171
n11=188
s1=0
s2=0
s3=0
s4=0
s5=0
s6=0
s7=0
is1=0
is2=0
is3=0
is4=0
is5=0
is6=0
is7=0
ii=0
nstr=0
nnstr=0
nstr=kolstr+1
k=0
vgg=val(nastf_b)
vmm=ntmec
do case
  case vmm=2
   if mod(vgg,4)==0
      ll=29
   else
      ll=28
   endif
 case (str(vmm,2)+",") $ " 1, 3, 5, 7, 8,10,12,"
     ll=31
 otherwise
     ll=30
endcase
          @ 0,0 SAY REPLICATE('-',202)
          for i=1 to 20
            @ 0+i,0 SAY ' '
          next
          @ 21,0 SAY REPLICATE(' ',55)+'К Н И Г А   П О К У П О К'
          @ 22,0 SAY ' '
          @ 23,0 SAY ' '
          @ 24,0 SAY ' '
          @ 25,0 SAY REPLICATE(' ',35)+'Налогоплательщик-покупатель  РУПП КПТФ "Ручайка"'
          @ 26,0 SAY ' '
          @ 27,0 SAY ' '
          @ 28,0 SAY REPLICATE(' ',35)+'УНН покупателя  200048573'
          @ 29,0 SAY ' '
          @ 30,0 SAY ' '
          @ 31,0 SAY REPLICATE(' ',35)+'Покупка за период с 01.'+str(ntmec,2)+'.'+nastf_b+'  по  '+str(ll,2)+'.'+str(ntmec,2)+'.'+nastf_b+' года'
          for i=1 to 39
            @ 31+i,0 SAY ' '
          next
 FOR l=1 TO 2
   nstr=nstr+1
   IF l=1
     select osdkom1
   ELSE
     select atot
   ENDIF
   DO WHILE !EOF()
      ii=ii+1
      ?? ii PICTURE '999999' AT 18
      fkp=kp
      fnam=Spr_nam(pr_spr,fkp,30)
      f_pr_reg=skl.pr_reg
      fnvx=nvx
      fnrd=nrd
      fdat=dat
      funn=iif(empty(skl.unn)=.f.,skl.unn,skl.inn)
      SCAN REST WHILE bs=nastf_1.AND.kp=fkp.AND.nvx=fnvx FOR !DELETE()
         funi=uni
         fpriz=priz
         fkor=kor
          select tran_pos
          if l=1
           seek osdkom1.uni
          else
           seek atot.uni
          endif
          do while funi=uni
            if ascan(mas,nrd,1,25)=0
               k=k+1
               mas[k,1]=dat
               mas[k,2]=nrd
            endif
             skip
          enddo
          if l=1
           select osdkom1
          else
           select atot
          endif
             if f_pr_reg='001'.or.(val(kp)>=800.and.val(kp)<=899).or.(val(kp)>=1200.and.val(kp)<=1299).or.(val(kp)>=6500.and.val(kp)<=6699)
               if fkor='1801'.or.fkor='1802'.or.fkor='1803'
                  s7=s7+smko
                else
                  s6=s6+smko
               endif
             else
               if fpriz='1'
                if fkor='1801'
                  s5=s5+smko
                else
                  s4=s4+smko
                endif
               endif
               if fpriz='2' .or.fpriz='3'
                if fkor='1802'.or.fkor='1803'
                  s3=s3+smko
                else
                  s2=s2+smko
                endif
               endif
             endif
            s1=s1+smko
         nz1=recno()
         *funi=uni
      ENDSCAN
      IF nstr>kolstr
        nnstr=nnstr+1
        DO Chap1 WITH nnstr,nstr,nlist
      ENDIF
      nstr=nstr+1
      IF nnstr>=nlist
        @ nstr,n1 SAY fdat
        @ nstr,n1a SAY fnvx
       for j=1 to k
        nstr=iif(j>1,nstr+1,nstr)
        a1=iif(empty(mas[j,1]),'          ',mas[j,1])
        @ nstr,n2 SAY a1
        a1=iif(empty(mas[j,2]),'      ',mas[j,2])
        @ nstr,n2a SAY a1
        if j=1
        @ nstr,n3 SAY fkp
        @ nstr,n3a SAY fnam
        @ nstr,n4 SAY funn
        @ nstr,n5 SAY s1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
        @ nstr,n6 SAY s2 PICTURE   '9,999,999,999.99' FUNCTION 'Z'
        @ nstr,n7 SAY s3 PICTURE     '999,999,999.99' FUNCTION 'Z'
        @ nstr,n8 SAY s4 PICTURE   '9,999,999,999.99' FUNCTION 'Z'
        @ nstr,n9 SAY s5 PICTURE     '999,999,999.99' FUNCTION 'Z'
        @ nstr,n10 SAY s6 PICTURE   '9,999,999,999.99' FUNCTION 'Z'
        @ nstr,n11 SAY s7 PICTURE     '999,999,999.99' FUNCTION 'Z'
        endif
       endfor
        nstr=nstr+1
        IF nnstr>=nlist
           @ nstr,0 SAY REPLICATE('-',202)
        ENDIF
      ENDIF
      is1=is1+s1
      is2=is2+s2
      is3=is3+s3
      is4=is4+s4
      is5=is5+s5
      is6=is6+s6
      is7=is7+s7
      s1=0
      s2=0
      s3=0
      s4=0
      s5=0
      s6=0
      s7=0
      k=0
      mas=0
      go nz1
      skip
   ENDDO
ENDFOR
select spr_osn
*use spr_osn
*index on kp+nvx
   DO WHILE !EOF()
      fkp=kp
      fnam=Spr_nam(pr_spr,fkp,30)
      f_pr_reg=skl.pr_reg
      fnvx=nvx
      fnrd=nrd
      fdat=dat
      fdat1=dat_op
      fpriz=priz
      funn=iif(empty(skl.unn)=.f.,skl.unn,skl.inn)
      SCAN REST WHILE bs=nastf_1.AND.kp=fkp.AND.nvx=fnvx FOR !DELETE()
         fkor=kor
             if f_pr_reg='001'.or.(val(kp)>=800.and.val(kp)<=899).or.(val(kp)>=1200.and.val(kp)<=1299).or.(val(kp)>=6500.and.val(kp)<=6699)
               if fkor='1801'.or.fkor='1802'.or.fkor='1803'
                  s7=s7+smk
                else
                  s6=s6+smk
               endif
             else
               if fpriz='1'
                if fkor='6801'
                  s5=s5+smk
                else
                  s4=s4+smk
                endif
               endif
               if fpriz='2' .or.fpriz='3'
                if fkor='1802'.or.fkor='1803'
                  s3=s3+smk
                else
                  s2=s2+smk
                endif
               endif
             endif
            s1=s1+smk
         nz1=recno()
      ENDSCAN
      IF nstr>kolstr
        nnstr=nnstr+1
        DO Chap1 WITH nnstr,nstr,nlist
      ENDIF
      nstr=nstr+1
      IF nnstr>=nlist
        @ nstr,n1 SAY fdat
        @ nstr,n1a SAY fnvx
        @ nstr,n2 SAY fdat1
        @ nstr,n2a SAY fnrd
        @ nstr,n3 SAY fkp
        @ nstr,n3a SAY fnam
        @ nstr,n4 SAY funn
        @ nstr,n5 SAY s1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
        @ nstr,n6 SAY s2 PICTURE   '9,999,999,999.99' FUNCTION 'Z'
        @ nstr,n7 SAY s3 PICTURE     '999,999,999.99' FUNCTION 'Z'
        @ nstr,n8 SAY s4 PICTURE   '9,999,999,999.99' FUNCTION 'Z'
        @ nstr,n9 SAY s5 PICTURE     '999,999,999.99' FUNCTION 'Z'
        @ nstr,n10 SAY s6 PICTURE   '9,999,999,999.99' FUNCTION 'Z'
        @ nstr,n11 SAY s7 PICTURE     '999,999,999.99' FUNCTION 'Z'
        nstr=nstr+1
        IF nnstr>=nlist
           @ nstr,0 SAY REPLICATE('-',202)
        ENDIF
      ENDIF
      is1=is1+s1
      is2=is2+s2
      is3=is3+s3
      is4=is4+s4
      is5=is5+s5
      is6=is6+s6
      is7=is7+s7
      s1=0
      s2=0
      s3=0
      s4=0
      s5=0
      s6=0
      s7=0
      k=0
      mas=0
      go nz1
      skip
   ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1  SAY "Всего"
    @ nstr,n5  SAY  is1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
   * @ nstr,n6 SAY is2 PICTURE     '9,999,999,999.99' FUNCTION 'Z'
    @ nstr,n7 SAY  is3 PICTURE      '999,999,999.99' FUNCTION 'Z'
   * @ nstr,n8 SAY is4 PICTURE     '9,999,999,999.99' FUNCTION 'Z'
    @ nstr,n9 SAY is5 PICTURE       '999,999,999.99' FUNCTION 'Z'
   * @ nstr,n10 SAY is6 PICTURE     '9,999,999,999.99' FUNCTION 'Z'
    @ nstr,n11 SAY is7 PICTURE       '999,999,999.99' FUNCTION 'Z'
    nstr=nstr+1
    IF nnstr>=nlist
       @ nstr,0 SAY REPLICATE('-',202)
    ENDIF
ENDIF
nstr=nstr+2
IF nnstr>=nlist
    @ nstr,n3  SAY "Руководитель      ________________________                      ___________________________________________________"
    nstr=nstr+1
    IF nnstr>=nlist
      @ nstr,n3 SAY ' '
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
      @ nstr,n3 SAY "Главный бухгалтер ________________________                      __________________________________________________"
    ENDIF
ENDIF
EJECT
RETURN

*
PROCEDURE Chap1
PARAMETERS nnstr,nstr,nlist
 IF nstr>kolstr
        IF nnstr>=nlist
          @ 0,0 SAY REPLICATE('-',202)
          @ 1,0 SAY 'Лист '+STR(nnstr,2)
          @ 2,0 SAY '┌─────────────────┬─────────────────┬─────────────────────────────────────┬────────────┬──────────────────┬───────────────────────────────────────────────────────────────────────────────────────────────┐'
          @ 3,0 SAY '│                 │                 │                                     │            │                  │                                               в том   числе                                   │'
          @ 4,0 SAY '│      Дата       │      Дата       │                                     │            │     В С Е Г О    ├───────────────────────────────────────────────────────────────┬───────────────────────────────┤'
          @ 5,0 SAY '│  приобретения   │     оплаты      │                                     │     УНН    │      покупок,    │     покупки ,  облагаемые   налогом по ставке , без  РФ       │                               │'
          @ 6,0 SAY '│     и номер     │     и номер     │       Наименование продавца         │   продавца │      включая     ├───────────────────────────────┬───────────────────────────────┤        покупки  в  РФ         │'
          @ 7,0 SAY '│    документа    │    документа    │                                     │            │        НДС       │            20     %           │              10   %           │                               │'
          @ 8,0 SAY '│                 │                 │                                     │            │                  ├────────────────┬──────────────┼────────────────┬──────────────┼────────────────┬──────────────┤'
          @ 9,0 SAY '│                 │                 │                                     │            │                  │     без НДС    │    НДС       │     без НДС    │    НДС       │     без НДС    │    НДС       │'
          @10,0 SAY '└─────────────────┴─────────────────┴─────────────────────────────────────┴────────────┴──────────────────┴────────────────┴──────────────┴────────────────┴──────────────┴────────────────┴──────────────┘'
          *@12,0 SAY REPLICATE('-',150)
        ENDIF
        nstr=10
  ENDIF
RETURN
*