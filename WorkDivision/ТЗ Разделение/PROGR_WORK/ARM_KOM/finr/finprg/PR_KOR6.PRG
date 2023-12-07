DIMENSION mbs(100,3)
PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii
p_form=RIGHT('999999999999.99',FSIZE('sm','bk'))
n1=1
n2=9
n3=40
n3a=47
n4=56
n5=63
n6=68
n7=84
n8=99
nnstr=0
nstr=kolstr+1
ffsum=0
sfsum=0
ffsumo=0
fkp='*'
ii=0
SCAN
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+".  Ведомость по оплате матеpиалов в pазpезе счета "+ffbs+' за месяц '+tmec+SPACE(5)+DTOC(DATE())
@ 1,0 SAY REPLICATE('-',116)
@ 2,0 SAY "|Код оp.|   Hаименование оpганизации   |N тpеб|Дата док|N TTH |К/сч| Сальдо на нач.|   Получено    |    Оплачено   |"
@ 3,0 SAY REPLICATE('-',116)
         ENDIF
         nstr=3
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         IF fkp#kp
              @ nstr,n1 SAY kp
              @ nstr,n2 SAY Spr_nam(pr_spr,kp,30)
         ENDIF
         fkp=kp
         @ nstr,n3  SAY nrd
         @ nstr,n3a SAY dat
         @ nstr,n4  SAY nvx
         @ nstr,n5  SAY kor
         IF kr#0
              @ nstr,n6 SAY kr
         ENDIF
         IF smk#0
              @ nstr,n7 SAY smk
         ENDIF
         IF smko#0
              @ nstr,n8 SAY smko
         ENDIF
    ENDIF
    ffsum=ffsum+kr
    sfsum=sfsum+smk
    ffsumo=ffsumo+smko
ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "Всего"
    @ nstr,n6 SAY ffsum  PICTURE p_form
    @ nstr,n7 SAY sfsum  PICTURE p_form
    @ nstr,n8 SAY ffsumo PICTURE p_form
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',116)
ENDIF
EJECT
RETURN
