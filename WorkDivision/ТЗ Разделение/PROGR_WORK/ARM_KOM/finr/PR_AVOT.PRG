PARAMETERS fkp,fbs
PRIVATE fnvx,fnrd,nz
*  pазбиение
SELECT avot
SET ORDER TO avot1
SET EXACT OFF
SEEK fkp
SCAN REST WHILE fkp=kp FOR smd#0.AND.smdo#0.AND.smdo<smd.AND.bs_op#fbs.AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
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
    fdat_op=dat_op
    fnrd_op=nrd_op
    REPLACE smd WITH smdo
    APPEND BLANK
    REPLACE kp WITH fkp,nvx WITH fnvx,nrd WITH fnrd,nsk WITH fnsk,;
           nzk WITH fnzk,pr_spr WITH fpr_spr,bs WITH ffbs,dat WITH fdat,kor WITH fkor,;
           smd WITH fsmd
    IF nastf_h=1
         sss=FULLPATH('unin.mem')
         RESTORE FROM unin ADDITIVE
         unin=unin+1
         SAVE TO &sss ALL LIKE unin
         REPLACE uni WITH unin
         RELEASE unin
         REPLACE nrd_op WITH fnrd_op,dat_op WITH fdat_op
    ENDIF
    GO nz
ENDSCAN
SEEK fkp
SELECT osdkom
SET ORDER TO kp_nrd
SEEK fkp
SCAN REST WHILE fkp=kp FOR db#0.AND.smdo#0.AND.smdo<db.AND.bs_op#fbs.AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
    nz=RECNO()
    ffbs=bs
    fdat=dat
    fkor=kor
    fnvx=nvx
    fnrd=nrd
    fnsk=nsk
    fnzk=nzk
    fpr_spr=pr_spr
    fsmd=db-smdo
    fdat_op=dat_op
    fnrd_op=nrd_op
    REPLACE db WITH smdo
    APPEND BLANK
    REPLACE kp WITH fkp,nvx WITH fnvx,nrd WITH fnrd,nsk WITH fnsk,;
           nzk WITH fnzk,pr_spr WITH fpr_spr,bs WITH ffbs,dat WITH fdat,kor WITH fkor,;
            db WITH fsmd
    IF nastf_h=1
         sss=FULLPATH('unin.mem')
         RESTORE FROM unin ADDITIVE
         unin=unin+1
         SAVE TO &sss ALL LIKE unin
         REPLACE uni WITH unin
         RELEASE unin
         REPLACE nrd_op WITH fnrd_op,dat_op WITH fdat_op
    ENDIF
    GO nz
ENDSCAN
* гpуппиpовка
prudl=.F.
SELECT avot
SET ORDER TO bs_kp
SET EXACT OFF
SEEK f_l+fkp
SCAN REST WHILE bs=f_l.AND.fkp=kp FOR (fbs=bs_op.OR.EMPTY(bs_op)).AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
    nz=RECNO()
    fnvx=nvx
    ffbs=bs
    fdat=dat
    fkor=kor
    fnrd=nrd
    fnsk=nsk
    fnzk=nzk
    fsmd=0
    fsmdo=0
    fbs_op=bs_op
    SKIP
    SCAN REST WHILE bs=f_l.AND.fkp=kp.AND.fnrd=nrd FOR (bs_op=fbs.OR.EMPTY(bs_op).OR.EMPTY(fbs_op)).AND.fdat=dat.AND.fkor=kor.AND.;
                  fnvx=nvx.AND.fnsk=nsk.AND.nzk=fnzk.AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
         fsmd=fsmd+smd
         fsmdo=fsmdo+smdo
         DELETE
         prudl=.T.
    ENDSCAN
    GO nz
    IF fsmd#0.OR.fsmdo#0
         REPLACE smd WITH smd+fsmd,smdo WITH smdo+fsmdo
    ENDIF
ENDSCAN
IF prudl
    IF pr_setev
         USE avot EXCLUSIVE
         PACK
         USE avot
         SET ORDER TO avot1
    ELSE
         PACK
    ENDIF
ENDIF
prudl=.F.
SEEK fkp
SELECT osdkom
SET ORDER TO bs_kp
SEEK f_l+fkp
SCAN REST WHILE bs=f_l.AND.fkp=kp FOR (fbs=bs_op.OR.EMPTY(bs_op)).AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
    nz=RECNO()
    fnvx=nvx
    ffbs=bs
    fdat=dat
    fkor=kor
    fnrd=nrd
    fnsk=nsk
    fnzk=nzk
    fsmd=0
    fsmdo=0
    fbs_op=bs_op
    SKIP
    SCAN REST WHILE bs=f_l.AND.fkp=kp.AND.fnrd=nrd FOR (bs_op=fbs.OR.EMPTY(bs_op).OR.EMPTY(fbs_op)).AND.;
                   fdat=dat.AND.fkor=kor.AND.fnvx=nvx.AND.fnsk=nsk.AND.nzk=fnzk.AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
         fsmd=fsmd+db
         fsmdo=fsmdo+smdo
         DELETE
         prudl=.T.
    ENDSCAN
    GO nz
    IF fsmd#0.OR.fsmdo#0
         REPLACE db WITH db+fsmd,smdo WITH smdo+fsmdo
    ENDIF
ENDSCAN
IF prudl
    IF pr_setev
         USE osdkom EXCLUSIVE
         PACK
         USE osdkom
         SET ORDER TO kp_nrd
    ELSE
         PACK
    ENDIF
ENDIF
SET EXACT ON
RETURN
