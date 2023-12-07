PRIVATE n1,n2,n3,n4,n5,n6,ii
p_form=RIGHT('999999999999.99',FSIZE('sm','bk'))
n1=1
n2=7
n3=38
n4=54
n5=70
n6=86
n7=102
n8=118
n9=134
nnstr=0
IF ffvid_pr=' '
    GO TOP
ELSE
    SET EXACT OFF
    SEEK ffvid_pr
    SET EXACT ON
ENDIF
fff1=0
fff2=0
fff3=0
fff4=0
fff5=0
fff6=0
fff7=0
nstr=kolstr+1
ii=0
DO WHILE !EOF()
    ff1=0
    ff2=0
    ff3=0
    ff4=0
    ff5=0
    ff6=0
    ff7=0
    fvid_pr=sch.vid_pr
    DO WHILE fvid_pr=sch.vid_pr.AND.!EOF()
         f1=0
         f2=0
         f3=0
         f4=0
         f5=0
         f6=0
         f7=0
         fnsk=nsk
         ficsk=sch.icsk
         SCAN REST WHILE fvid_pr=sch.vid_pr.AND.nsk=fnsk
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              SELECT skl
              SEEK osdkomr.kp
              SELECT osdkomr
              IF (db#0.OR.smd#0.OR.smdo#0).AND.(ch1=5.OR.ch1=8.AND.((DATE()-dat)>=skl.kol_dn.OR.EMPTY(dat)))
                   f1=f1+db
                   f4=f4+smd
                   IF db#0
                        f2=f2+smdo
                   ELSE
                        f5=f5+smdo
                   ENDIF
              ENDIF
         ENDSCAN
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Ведомость pеализации по подpазделениям "+' за месяц '+tmec+IIF(ch1=8,'с учетом документообоpота ','')+SPACE(15)+DTOC(DATE())
@ 1,0 SAY "------------------------------------------------------------------------------------------------------------------------------------------------------"
@ 2,0 SAY "|Подp.|  Hаименование подpазделения  |   Сальдо на   |    Оплачено   |   Hеоплачено  |   Отгpузка    |    Оплачено   |   Hеоплачено  |     Всего     |"
@ 3,0 SAY "|     |                              | начало месяца |    остатков   |    остатков   |   за месяц    |   по отгpузке |  по отгpузке  |   неоплачено  |"
@ 4,0 SAY "------------------------------------------------------------------------------------------------------------------------------------------------------"
              ENDIF
              nstr=4
         ENDIF
         IF f1#0.OR.f2#0.OR.f4#0.OR.f5#0
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY fnsk
                   @ nstr,n2 SAY ficsk
                   @ nstr,n3 SAY f1    PICTURE p_form
                   @ nstr,n4 SAY f2    PICTURE p_form
                   @ nstr,n5 SAY f1-f2 PICTURE p_form
                   @ nstr,n6 SAY f4    PICTURE p_form
                   @ nstr,n7 SAY f5          PICTURE p_form
                   @ nstr,n8 SAY f4-f5       PICTURE p_form
                   @ nstr,n9 SAY f1-f2+f4-f5 PICTURE p_form
              ENDIF
              ff1=ff1+f1
              ff2=ff2+f2
              ff3=ff3+f1-f2
              ff4=ff4+f4
              ff5=ff5+f5
              ff6=ff6+f4-f5
              ff7=ff7+f1-f2+f4-f5
         ENDIF
    ENDDO
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',150)
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY 'Итого по '+fvid_pr
         @ nstr,n3 SAY ff1 PICTURE p_form
         @ nstr,n4 SAY ff2 PICTURE p_form
         @ nstr,n5 SAY ff3 PICTURE p_form
         @ nstr,n6 SAY ff4 PICTURE p_form
         @ nstr,n7 SAY ff5 PICTURE p_form
         @ nstr,n8 SAY ff6 PICTURE p_form
         @ nstr,n9 SAY ff7 PICTURE p_form
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',150)
    ENDIF
    IF ffvid_pr#' '
         EXIT
    ENDIF
    fff1=fff1+ff1
    fff2=fff2+ff2
    fff3=fff3+ff3
    fff4=fff4+ff4
    fff5=fff5+ff5
    fff6=fff6+ff6
    fff7=fff7+ff7
ENDDO
IF ffvid_pr=' '
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Всего"
         @ nstr,n3 SAY fff1 PICTURE p_form
         @ nstr,n4 SAY fff2 PICTURE p_form
         @ nstr,n5 SAY fff3 PICTURE p_form
         @ nstr,n6 SAY fff4 PICTURE p_form
         @ nstr,n7 SAY fff5 PICTURE p_form
         @ nstr,n8 SAY fff6 PICTURE p_form
         @ nstr,n9 SAY fff7 PICTURE p_form
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('=',150)
    ENDIF
ENDIF
EJECT
RETURN
