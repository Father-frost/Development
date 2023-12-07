PRIVATE n1,n2,n3,n4,n5,n6,n7,n8,n9,ii
p_form=RIGHT('999999999999.99',FSIZE('sm','bk'))
n1=1
n2=9
n3=40
n3a=47
n4=58
n5=65
n6=70
n7=86
n8=101
n9=116
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
@ 0,0 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Ведомость по pеализации в pазpезе счета "+ffbs
@ 1,0 SAY REPLICATE('-',131)
@ 2,0 SAY "|Код оp.|   Hаименование оpганизации   |N тpеб| Дата док.|N TTH |К/сч| Сальдо на нач.|    Отгpузка   |    Оплачено  |Сальдо на конец|"
@ 3,0 SAY REPLICATE('-',131)
         ENDIF
         nstr=3
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         IF fkp#kp
              @ nstr,n1 SAY kp
              @ nstr,n2 SAY Spr_nam(pr_spr,kp,30)
              fkp=kp
         ENDIF
         @ nstr,n3  SAY nrd
         @ nstr,n3a SAY dat
         @ nstr,n4  SAY nvx
         @ nstr,n5  SAY kor
         IF db#0
              @ nstr,n6 SAY db
         ENDIF
         IF smd#0
              @ nstr,n7 SAY smd
         ENDIF
         @ nstr,n8 SAY smdo
         @ nstr,n9 SAY db+smd-smdo
    ENDIF
    ffsum=ffsum+db
    sfsum=sfsum+smd
    ffsumo=ffsumo+smdo
ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
     @ nstr,n1 SAY "Всего"
     @ nstr,n6 SAY ffsum  PICTURE p_form
     @ nstr,n7 SAY sfsum  PICTURE p_form
     @ nstr,n8 SAY ffsumo PICTURE p_form
     @ nstr,n9 SAY ffsum+sfsum-ffsumo PICTURE '99999999999999.99'
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',131)
ENDIF
EJECT
RETURN