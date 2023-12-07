PARAMETERS fkp,fbs
PRIVATE fnvx,fnrd
*  pазбиение
SELECT atot
SET ORDER TO avot1
SET EXACT OFF
SEEK fkp
SCAN REST WHILE fkp=kp FOR smk#0.AND.smko#0.AND.smko<smk.AND.bs_op#fbs.AND.(menu_v=1.OR.!EMPTY(kor)).AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
    nz=RECNO()
    ffbs=bs
    fdat=dat
    fkor=kor
    fnvx=nvx
    fnrd=nrd
    fnsk=nsk
    fpr_spr=pr_spr
    fdat_op=dat_op
    fnrd_op=nrd_op
    fsmk=smk-smko
    REPLACE smk WITH smko
    INSERT INTO atot.dbf (kp, nvx, nrd, nsk, pr_spr, bs, dat, kor, smk);
           VALUES (fkp, fnvx, fnrd, fnsk, fpr_spr, ffbs, fdat, fkor, fsmk)
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
SELECT osdkom1
SET ORDER TO kp_nrd
SEEK fkp
SCAN REST WHILE fkp=kp FOR kr#0.AND.smko#0.AND.smko<kr.AND.bs_op#fbs.AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
    nz=RECNO()
    ffbs=bs
    fdat=dat
    fkor=kor
    fnvx=nvx
    fnrd=nrd
    fnsk=nsk
    fpr_spr=pr_spr
    fdat_op=dat_op
    fnrd_op=nrd_op
    fsmk=kr-smko
    REPLACE kr WITH smko
    INSERT INTO osdkom1.dbf (kp, nvx, nrd, nsk, pr_spr, bs, dat, kor, kr);
         VALUES (fkp, fnvx, fnrd, fnsk, fpr_spr, ffbs, fdat, fkor, fsmk)
    IF nastf_h=1
         sss=FULLPATH('unin.mem')
         RESTORE FROM unin ADDITIVE
         unin=unin+1
         SAVE TO &sss ALL LIKE unin
         REPLACE uni WITH unin
         RELEASE unin
         REPLACE uni WITH funi,nrd_op WITH fnrd_op,dat_op WITH fdat_op
    ENDIF
    GO nz
ENDSCAN
* гpуппиpовка
prudl=.F.
SELECT atot
SET ORDER TO bs_kp
SET EXACT OFF
SEEK f_1+fkp
SCAN REST WHILE bs=f_1.AND.fkp=kp FOR (fbs=bs_op.OR.EMPTY(bs_op)).AND.(menu_v=1.OR.!EMPTY(kor)).AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
    nz=RECNO()
    fnvx=nvx
    ffbs=bs
    fdat=dat
    fkor=kor
    fnrd=nrd
    fnsk=nsk
    fsmk=0
    fsmko=0
    fbs_op=bs_op
    SKIP
    SCAN REST WHILE bs=f_1.AND.fkp=kp.AND.fnrd=nrd FOR (bs_op=fbs.OR.EMPTY(bs_op).OR.EMPTY(fbs_op)).AND.fdat=dat.AND.fkor=kor.AND.;
                  fnvx=nvx.AND.fnsk=nsk.AND.(menu_v=1.OR.!EMPTY(kor)).AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
         fsmk=fsmk+smk
         fsmko=fsmko+smko
         DELETE
         prudl=.T.
    ENDSCAN
    GO nz
    IF fsmk#0.OR.fsmko#0
         REPLACE smk WITH smk+fsmk,smko WITH smko+fsmko
    ENDIF
ENDSCAN
IF prudl
    IF pr_setev
         USE atot EXCLUSIVE
    ENDIF
    PACK
    IF pr_setev
         USE atot
         SET ORDER TO avot1
    ENDIF
ENDIF
prudl=.F.
SEEK fkp
SELECT osdkom1
SET ORDER TO bs_kp
SEEK f_1+fkp
SCAN REST WHILE bs=f_1.AND.fkp=kp FOR (fbs=bs_op.OR.EMPTY(bs_op)).AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
    nz=RECNO()
    fnvx=nvx
    ffbs=bs
    fdat=dat
    fkor=kor
    fnrd=nrd
    fnsk=nsk
    fnzk=nzk
    fsmk=0
    fsmko=0
    fbs_op=bs_op
    SKIP
    SCAN REST WHILE bs=f_1.AND.fkp=kp.AND.fnrd=nrd FOR (bs_op=fbs.OR.EMPTY(bs_op).OR.EMPTY(fbs_op)).AND.fdat=dat.AND.fkor=kor.AND.;
                  fnvx=nvx.AND.fnsk=nsk.AND.nzk=fnzk.AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
         fsmk=fsmk+kr
         fsmko=fsmko+smko
         DELETE
         prudl=.T.
    ENDSCAN
    GO nz
    IF fsmk#0.OR.fsmko#0
         REPLACE kr WITH kr+fsmk,smdo WITH smko+fsmko
    ENDIF
ENDSCAN
IF prudl
    IF pr_setev
         USE osdkom1 EXCLUSIVE
    ENDIF
    PACK
    IF pr_setev
         USE osdkom1
         SET ORDER TO kp_nrd
    ENDIF
ENDIF
SET EXACT ON
RETURN
