PRIVATE n1,n2,n3,n4,ii
p_form=RIGHT('999999999999.99',FSIZE('sm','bk'))
n1=1
n2=9
n3=40
n4=56
nnstr=0
nstr=kolstr+1
ffkr=0
ffdb=0
fkp='*'
ii=0
SCAN FOR !DELETE()
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    IF pr_prib='*'
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Ведомость по пpибылям и убыткам за месяц "+tmec
@ 1,0 SAY REPLICATE('-',72)
@ 2,0 SAY "|Код оp.|   Hаименование оpганизации   |    Пpибыль    |    Убыток     |"
@ 3,0 SAY REPLICATE('-',72)
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
              IF kr#0
                   @ nstr,n3 SAY kr
              ENDIF
              IF db#0
                   @ nstr,n4 SAY db
              ENDIF
         ENDIF
	     ffkr=ffkr+kr
         ffdb=ffdb+db
    ENDIF
ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',72)
ENDIF
nstr=nstr+1
IF nnstr>=nlist
     @ nstr,n1 SAY "Всего"
     @ nstr,n3 SAY ffkr PICTURE p_form
     @ nstr,n4 SAY ffdb PICTURE p_form
ENDIF
EJECT
RETURN
