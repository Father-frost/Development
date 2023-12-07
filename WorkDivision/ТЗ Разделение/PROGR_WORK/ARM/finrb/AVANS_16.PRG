PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii
n1=1
n2=9
n3=40
itog=0
nnstr=0
nstr=kolstr+1
ii=0
*set device to print
SCAN
ii=ii+1
?? ii PICTURE '999999' AT 18
fdt=dtoc(date())
*DO WHILE !EOF()
    fkp=kp
    fpr_spr=pr_spr
    sald=0
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,2 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Информация о предоплате на " + fdt+' г.'
@ 1,0 SAY REPLICATE('-',59)
@ 2,0 SAY "|       |                              |                   |"
@ 3,0 SAY "|Код оp.|   Hаименование оpганизации   |     Предоплата    |"
@ 4,0 SAY "|       |                              |                   |"
@ 5,0 SAY REPLICATE('-',59)
              ENDIF
              nstr=5
         ENDIF
         sald=kr+smk-db-smd
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fkp
              @ nstr,n2 SAY Spr_nam(fpr_spr,fkp,30)
*              @ nstr,n3 SAY sald PICTURE '999999999999.99' FUNCTION 'Z'
              @ nstr,n3 SAY transform(sald," 999 999 999 999.99")
         ENDIF
         itog=itog+sald
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',59)
         ENDIF
*    SELECT osdkomr
*ENDDO
ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "Итого"
    @ nstr,n3 SAY transform(itog,' 999 999 999 999.99')
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('=',59)
ENDIF
EJECT
RETURN