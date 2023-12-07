IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,nzz
key=2
DEFINE WINDOW Zapros FROM 10,18 TO 13,63 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "Выполняется автоматическая разноска оплаты."
@ 1,5 SAY "Вы уверены ?"
@ 1,25 PROMPT " Да  "
@ 1,35 PROMPT " Hет "
MENU TO key
RELEASE WINDOW Zapros
IF key=1
    ACTIVATE WINDOW Pogal
    SET COLOR TO &color15
    @ 0,0 SAY '░'
    SET COLOR TO &color13
    @ 0,1 SAY "Пожалуйста, подождите..."
    @ 1,2 SAY ' Всего записей:       '
    @ 2,2 SAY ' Текущая запись:      '
    SET COLOR TO &color14
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    nzz=RECNO()
    SELECT osdkom
    SET ORDER TO bs_kp
    SELECT avot
    SET ORDER TO bs_kp
    SELECT bk
    SET ORDER TO bk2
    SELECT osdkomr
    SET ORDER TO
    SET EXACT OFF
    SCAN FOR pr_prib='*'.AND.!DELETE()
         @ 2,18 SAY RECNO() PICTURE '999999'
         fkp=osdkomr.kp
         fople=0
         foplk=kr
*     определение сумм закрытия
         SELECT bk
         SEEK nastf_e+fkp
         SCAN REST WHILE kor=nastf_e.AND.kp=fkp FOR MONTH(dat)=ntmec.AND.!DELETE()
              fople=fople+IIF(vo='0',sm,-sm)
         ENDSCAN
         IF nastf_e#nastf_k
              SEEK nastf_k+fkp
              SCAN REST WHILE kor=nastf_k.AND.kp=fkp FOR MONTH(dat)=ntmec.AND.!DELETE()
                   foplk=foplk+IIF(vo='0',sm,-sm)
              ENDSCAN
         ENDIF
*     минус закрытые документы
         SELECT osdkom
         SEEK nastf_l+fkp
         SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR smdo#0.AND.(bs_op=nastf_e.OR.bs_op=nastf_k).AND.!DELETE()
              IF bs_op=nastf_e
                   fople=fople-smdo
              ELSE
                   foplk=foplk-smdo
              ENDIF
         ENDSCAN
         SELECT avot
         SEEK nastf_l+fkp
         SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR smdo#0.AND.(bs_op=nastf_e.OR.bs_op=nastf_k).AND.!DELETE()
              IF bs_op=nastf_e
                   fople=fople-smdo
              ELSE
                   foplk=foplk-smdo
              ENDIF
         ENDSCAN
*      автоматическое закрытие
*            по nastf_e
         SELECT osdkom
         SEEK nastf_l+fkp
         SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR fople>0.AND.db#smdo.AND.db#0.AND.!DELETE()
              IF smdo=0.OR.bs_op=nastf_e
                   sss=db-smdo
                   IF fople>sss
                        fople=fople-sss
                        REPLACE smdo WITH sss,bs_op WITH nastf_e
                        REPLACE osdkomr.smdo WITH osdkomr.smdo+sss
                   ELSE
                        REPLACE smdo WITH smdo+fople,bs_op WITH nastf_e
                        REPLACE osdkomr.smdo WITH osdkomr.smdo+fople
                        fople=0
                   ENDIF
              ELSE
                   nz=RECNO()
                   ffbs=bs
                   fdat=dat
                   fkor=kor
                   fnvx=nvx
                   fnrd=nrd
                   fnsk=nsk
                   fnzk=nzk
                   fpr_spr=pr_spr
                   funi=uni
                   fdat_op=dat_op
                   fnrd_op=nrd_op
                   IF fople>db-smdo
                        REPLACE db WITH smdo
                        fsmd=db-smdo
                   ELSE
                        REPLACE db WITH db-fople
                        fsmd=fople
                   ENDIF
                   APPEND BLANK
                   REPLACE kp WITH fkp,nvx WITH fnvx,nrd WITH fnrd,nsk WITH fnsk,;
                          nzk WITH fnzk,pr_spr WITH fpr_spr,bs WITH ffbs,dat WITH fdat,kor WITH fkor,;
                           db WITH fsmd,uni WITH funi
                   REPLACE smdo WITH db,bs_op WITH nastf_e
                   REPLACE osdkomr.smdo WITH osdkomr.smdo+db
                   fople=fople-smdo
                   GO nz
              ENDIF
         ENDSCAN
         SELECT avot
         SEEK nastf_l+fkp
         SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR fople>0.AND.smd#smdo.AND.smd#0.AND.!DELETE()
              IF smdo=0.OR.bs_op=nastf_e
                   sss=smd-smdo
                   IF fople>sss
                        fople=fople-sss
                        REPLACE smdo WITH sss,bs_op WITH nastf_e
                        REPLACE osdkomr.smdo WITH osdkomr.smdo+sss
                   ELSE
                        REPLACE smdo WITH smdo+fople,bs_op WITH nastf_e
                        REPLACE osdkomr.smdo WITH osdkomr.smdo+fople
                        fople=0
                   ENDIF
              ELSE
                   nz=RECNO()
                   ffbs=bs
                   fdat=dat
                   fkor=kor
                   fnvx=nvx
                   fnrd=nrd
                   fnsk=nsk
                   fnzk=nzk
                   fpr_spr=pr_spr
                   fsmd=smd-smdo
                   funi=uni
                   fdat_op=dat_op
                   fnrd_op=nrd_op
                   IF fople>smd-smdo
                        REPLACE smd WITH smdo
                        fsmd=smd-smdo
                   ELSE
                        REPLACE smd WITH smd-fople
                        fsmd=fople
                   ENDIF
                   APPEND BLANK
                   REPLACE kp WITH fkp,nvx WITH fnvx,nrd WITH fnrd,nsk WITH fnsk,;
                          nzk WITH fnzk,pr_spr WITH fpr_spr,bs WITH ffbs,dat WITH fdat,kor WITH fkor,;
                          smd WITH fsmd,uni WITH funi
                   REPLACE smdo WITH smd,bs_op WITH nastf_e
                   REPLACE osdkomr.smdo WITH osdkomr.smdo+smd
                   fople=fople-smdo
                   GO nz
              ENDIF
         ENDSCAN
*            по nastf_k
         SELECT osdkom
         SEEK nastf_l+fkp
         SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR foplk>0.AND.db#smdo.AND.db#0.AND.!DELETE()
              IF smdo=0.OR.bs_op=nastf_k
                   sss=db-smdo
                   IF foplk>sss
                        foplk=foplk-sss
                        REPLACE smdo WITH sss,bs_op WITH nastf_k
                        REPLACE osdkomr.smdo WITH osdkomr.smdo+sss
                   ELSE
                        REPLACE smdo WITH smdo+foplk,bs_op WITH nastf_k
                        REPLACE osdkomr.smdo WITH osdkomr.smdo+foplk
                        foplk=0
                   ENDIF
              ELSE
                   nz=RECNO()
                   ffbs=bs
                   fdat=dat
                   fkor=kor
                   fnvx=nvx
                   fnrd=nrd
                   fnsk=nsk
                   fnzk=nzk
                   fpr_spr=pr_spr
                   funi=uni
                   fdat_op=dat_op
                   fnrd_op=nrd_op
                   IF foplk>db-smdo
                        REPLACE db WITH smdo
                        fsmd=db-smdo
                   ELSE
                        REPLACE db WITH db-foplk
                        fsmd=foplk
                   ENDIF
                   APPEND BLANK
                   REPLACE kp WITH fkp,nvx WITH fnvx,nrd WITH fnrd,nsk WITH fnsk,;
                          nzk WITH fnzk,pr_spr WITH fpr_spr,bs WITH ffbs,dat WITH fdat,kor WITH fkor,;
                           db WITH fsmd,uni WITH funi
                   REPLACE smdo WITH db,bs_op WITH nastf_k
                   REPLACE osdkomr.smdo WITH osdkomr.smdo+db
                   foplk=foplk-smdo
                   GO nz
              ENDIF
         ENDSCAN
         SELECT avot
         SEEK nastf_l+fkp
         SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR foplk>0.AND.smd#smdo.AND.smd#0.AND.!DELETE()
              IF smdo=0.OR.bs_op=nastf_k
                   sss=smd-smdo
                   IF foplk>sss
                        foplk=foplk-sss
                        REPLACE smdo WITH sss,bs_op WITH nastf_k
                        REPLACE osdkomr.smdo WITH osdkomr.smdo+sss
                   ELSE
                        REPLACE smdo WITH smdo+foplk,bs_op WITH nastf_k
                        REPLACE osdkomr.smdo WITH osdkomr.smdo+foplk
                        foplk=0
                   ENDIF
              ELSE
                   nz=RECNO()
                   ffbs=bs
                   fdat=dat
                   fkor=kor
                   fnvx=nvx
                   fnrd=nrd
                   fnsk=nsk
                   fnzk=nzk
                   fpr_spr=pr_spr
                   fsmd=smd-smdo
                   funi=uni
                   fdat_op=dat_op
                   fnrd_op=nrd_op
                   IF foplk>smd-smdo
                        REPLACE smd WITH smdo
                        fsmd=smd-smdo
                   ELSE
                        REPLACE smd WITH smd-foplk
                        fsmd=foplk
                   ENDIF
                   APPEND BLANK
                   REPLACE kp WITH fkp,nvx WITH fnvx,nrd WITH fnrd,nsk WITH fnsk,;
                          nzk WITH fnzk,pr_spr WITH fpr_spr,bs WITH ffbs,dat WITH fdat,kor WITH fkor,;
                          smd WITH fsmd,uni WITH funi
                   REPLACE smdo WITH smd,bs_op WITH nastf_k
                   REPLACE osdkomr.smdo WITH osdkomr.smdo+smd
                   foplk=foplk-smdo
                   GO nz
              ENDIF
         ENDSCAN
*
         SELECT osdkomr
    ENDSCAN
    SET EXACT ON
    REPLACE ALL pr_prib WITH ' '
	REPLACE pr_prib WITH '*' FOR smdo<(kr+smk).AND.(db+smd)#smdo
    GO nzz
ENDIF
HIDE WINDOW Pogal
ACTIVATE SCREEN
SET ORDER TO bs_kp
RETURN
