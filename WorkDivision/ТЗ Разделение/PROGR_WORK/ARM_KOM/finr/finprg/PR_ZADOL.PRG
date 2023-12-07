PRIVATE n1,n2,n3,n4,n5,n6,ii
p_form=RIGHT('999999999999.99',FSIZE('sm','bk'))
n1=1
n2=9
n3=40
n4=47
n5=56
n6=63
n7=79
n8=95
nnstr=0
GO TOP
sssums=0
sssumd=0
sssumo=0
ii=0
DO WHILE !EOF()
    ssums=0
    ssumd=0
    ssumo=0
    fnsk=nsk
    SELECT sch
    SEEK fnsk
    SELECT osdkomr
    ficsk=sch.icsk
    nstr=kolstr+1
    DO WHILE fnsk=nsk.AND.!EOF()
         ffffsums=0
         ffffsumd=0
         ffffsumo=0
         fpr_reg=skl.pr_reg
         DO WHILE fpr_reg=skl.pr_reg.AND.fnsk=nsk.AND.!EOF()
              fffsums=0
              fffsumd=0
              fffsumo=0
              fkp=kp
              fikl=skl.ikl
              pr_per=.T.
              DO WHILE fkp=kp.AND.fpr_reg=skl.pr_reg.AND.fnsk=nsk.AND.!EOF()
                   pr_od=0
                   fnrd=nrd
                   ffsums=0
                   ffsumd=0
                   ffsumo=0
                   DO WHILE fnrd=nrd.AND.fkp=kp.AND.fpr_reg=skl.pr_reg.AND.fnsk=nsk.AND.!EOF()
                        fnvx=nvx
                        fdat=dat
                        fsums=0
                        fsumd=0
                        fsumo=0
                        SCAN REST WHILE fnrd=nrd.AND.fnvx=nvx.AND.fkp=kp.AND.fpr_reg=skl.pr_reg.AND.fnsk=nsk
                             ii=ii+1
                             ?? ii PICTURE '999999' AT 18
                             IF db#0.AND.smdo<db.OR.smd#0.AND.smdo<smd
                                  fsums=fsums+db
                                  fsumd=fsumd+smd
                                  fsumo=fsumo+smdo
                             ENDIF
                        ENDSCAN
                        IF fsums#0.OR.fsumd#0.OR.fsumo#0
                             IF nstr>kolstr
                                  nnstr=nnstr+1
                                  IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Ведомость по pеализации по подpазделению "+fnsk+' '+ficsk
@ 1,0 SAY REPLICATE('-',111)
@ 2,0 SAY "|Код оp.|   Hаименование оpганизации   |N тpеб|Дата док|N TTH | Сальдо на нач.|   Отгpужено   |    Оплачено   |"
@ 3,0 SAY REPLICATE('-',111)
                                  ENDIF
                                  nstr=3
                                  pr_per=.T.
                             ENDIF
                             nstr=nstr+1
                             IF nnstr>=nlist
                                  IF pr_per
                                       pr_per=.F.
                                       @ nstr,n1 SAY fkp
                                       @ nstr,n2 SAY fikl
                                  ENDIF
                                  @ nstr,n3 SAY fnrd
                                  @ nstr,n4 SAY fdat
                                  @ nstr,n5 SAY fnvx
                                  IF fsums#0
                                       @ nstr,n6 SAY fsums PICTURE p_form
                                  ENDIF
                                  IF fsumd#0
                                       @ nstr,n7 SAY fsumd PICTURE p_form
                                  ENDIF
                                  IF fsumo#0
                                       @ nstr,n8 SAY fsumo PICTURE p_form
                                  ENDIF
                             ENDIF
                             ffsums=ffsums+fsums
                             ffsumd=ffsumd+fsumd
                             ffsumo=ffsumo+fsumo
                             pr_od=pr_od+1
                        ENDIF
                   ENDDO
                   IF pr_od>1.AND.(ffsums#0.OR.ffsumd#0.OR.ffsumo#0)
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n1 SAY "Итого по тpебованию "+fnrd
                             IF ffsums#0
                                  @ nstr,n6 SAY ffsums PICTURE p_form
                             ENDIF
                             IF ffsumd#0
                                  @ nstr,n7 SAY ffsumd PICTURE p_form
                             ENDIF
                             IF ffsumo#0
                                  @ nstr,n8 SAY ffsumo PICTURE p_form
                             ENDIF
                        ENDIF
                   ENDIF
                   fffsums=fffsums+ffsums
                   fffsumd=fffsumd+ffsumd
                   fffsumo=fffsumo+ffsumo
              ENDDO
              IF fffsums#0.OR.fffsumd#0.OR.fffsumo#0
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY "Итого по оpганизации "+fkp+' '+fikl
                        IF fffsums#0
                             @ nstr,n6 SAY fffsums PICTURE p_form
                        ENDIF
                        IF fffsumd#0
                             @ nstr,n7 SAY fffsumd PICTURE p_form
                        ENDIF
                        IF fffsumo#0
                             @ nstr,n8 SAY fffsumo PICTURE p_form
                        ENDIF
                   ENDIF
                   ffffsums=ffffsums+fffsums
                   ffffsumd=ffffsumd+fffsumd
                   ffffsumo=ffffsumo+fffsumo
              ENDIF
         ENDDO
         IF ffffsums#0.OR.ffffsumd#0.OR.ffffsumo#0
              SELECT spr_reg
              SEEK fpr_reg
              SELECT osdkomr
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY "Итого по "+fpr_reg+' '+spr_reg.nam
                   IF ffffsums#0
                        @ nstr,n6 SAY ffffsums PICTURE p_form
                   ENDIF
                   IF ffffsumd#0
                        @ nstr,n7 SAY ffffsumd PICTURE p_form
                   ENDIF
                   IF ffffsumo#0
                        @ nstr,n8 SAY ffffsumo PICTURE p_form
                   ENDIF
              ENDIF
              ssums=ssums+fffsums
              ssumd=ssumd+fffsumd
              ssumo=ssumo+fffsumo
         ENDIF
    ENDDO
    IF ssums#0.OR.ssumd#0.OR.ssumo#0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY "Итого по подpазделению "+fnsk+' '+ficsk
              IF ssums#0
              @ nstr,n6 SAY ssums PICTURE p_form
              ENDIF
              IF ssumd#0
                   @ nstr,n7 SAY ssumd PICTURE p_form
              ENDIF
              IF ssumo#0
                   @ nstr,n8 SAY ssumo PICTURE p_form
              ENDIF
         ENDIF
         sssums=sssums+ssums
         sssumd=sssumd+ssumd
         sssumo=sssumo+ssumo
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',111)
         ENDIF
    ENDIF
ENDDO
IF pskl=' '
    nstr=PROW()
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Всего"
         IF sssums#0
              @ nstr,n6 SAY sssums PICTURE p_form
         ENDIF
         IF sssumd#0
         @ nstr,n7 SAY sssumd PICTURE p_form
         ENDIF
         IF sssumo#0
              @ nstr,n8 SAY sssumo PICTURE p_form
         ENDIF
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('=',111)
    ENDIF
ENDIF
EJECT
RETURN
