IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fffsum,nz,fnrd
IF smko=0
    SELECT tran_pos
    IF dv_kp.smko=0
         SET EXACT OFF
         SEEK STR(dv_kp.uni,7)
         SET EXACT OFF
         SCAN REST WHILE uni=dv_kp.uni FOR ms=ntmec.AND.god=nastf_b.AND.!DELETE()
              REPLACE summa WITH 0
              DELETE
         ENDSCAN
    ELSE
         IF SEEK(STR(dv_kp.uni,7)+DTOC(dv_kp.dat_op,1)+dv_kp.nrd_op)
              REPLACE summa WITH summa+dv_kp.smko-fsmko,bs WITH ff2
         ENDIF
    ENDIF
ELSE
    fnrd=klnrd
    fdat=CTOD('  /  /  ')
    DEFINE WINDOW Zapros FROM 11,29 TO 13,53 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,1 SAY "Номер документа" GET fnrd
    READ
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
         REPLACE dv_kp.smko WITH fsmko
         RETURN
    ENDIF
    SELECT bkr
    SET ORDER TO kp
    SET EXACT OFF
    SEEK osdkomr.kp+fnrd
    SET EXACT ON
    SCAN REST WHILE kp=osdkomr.kp.AND.nrd=fnrd FOR (vo='1'.OR.dv_kp.smko<0.AND.vo='0').AND.pr_spr=osdkomr.pr_spr
         fdat=dat
         fffsum=sm
         EXIT
    ENDSCAN
    SELECT dv_kp
    IF EMPTY(fdat)
         pr_new=.T.
         fdat=IIF(fsmko=0,fdat,dv_kp.dat_op)
         DEFINE WINDOW Zapros FROM 11,32 TO 13,50 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Дата " GET fdat
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27
              REPLACE dv_kp.smko WITH fsmko
              RETURN
         ENDIF
    ELSE
         pr_new=.F.
* документ найден и проверяем остаток
         nz=RECNO()
         SET EXACT OFF
         SCAN FOR !DELETE()
              SELECT tran_pos
              SEEK STR(dv_kp.uni,7)
              SCAN REST WHILE uni=dv_kp.uni FOR dat=fdat.AND.nrd=fnrd.AND.ms=ntmec.AND.god=nastf_b.AND.!DELETE()
                   fffsum=fffsum-summa
              ENDSCAN
         ENDSCAN
         SET EXACT ON
         GO nz
    ENDIF
    IF FILE('TRANZIT.DBF').AND.FILE('SPR_DOG.DBF')
*  расчет аванса по договору
         SELECT 0
         USE tranzit
         SET ORDER TO uni
         SEEK dv_kp.uni
         fdog=tranzit.dog
         fsump=summap
         USE spr_dog
         SET ORDER TO kp_dog
         SEEK osdkomr.kp+fdog
         fpr_av=pr_av
         USE
         SELECT dv_kp
         IF fpr_av#0
              fdog=ROUND(fsump*fpr_av/100.0,0)
              IF fsump-fdog<smk-fsmko.AND.fsmko>fdog+smk-fsump
                   REPLACE smko WITH fdog+smk-fsump
              ENDIF
         ENDIF
    ENDIF
*
    klnrd=fnrd
    IF pr_new
         SELECT dv_kp
         REPLACE dat_op WITH fdat,nrd_op WITH fnrd
         SELECT tran_pos
         IF !SEEK(STR(dv_kp.uni,7)+DTOC(dv_kp.dat_op,1)+dv_kp.nrd_op)
              APPEND BLANK
              REPLACE uni WITH dv_kp.uni,dat WITH dv_kp.dat_op,nrd WITH dv_kp.nrd_op,ms WITH ntmec,god WITH nastf_b
         ELSE
              IF DELETE()
                   RECALL
                   REPLACE summa WITH 0,ms WITH ntmec,god WITH nastf_b
              ENDIF
         ENDIF
         REPLACE summa WITH summa+dv_kp.smko-fsmko,bs WITH ff2
    ELSE
         IF fffsum>=dv_kp.smko-fsmko.OR.fffsum>0
              SELECT dv_kp
              REPLACE dat_op WITH fdat,nrd_op WITH fnrd
              SELECT tran_pos
              IF !SEEK(STR(dv_kp.uni,7)+DTOC(dv_kp.dat_op,1)+dv_kp.nrd_op).OR.dv_kp.dat_op#dat.OR.ms#ntmec.OR.god#nastf_b
                   APPEND BLANK
                   REPLACE uni WITH dv_kp.uni,dat WITH dv_kp.dat_op,nrd WITH dv_kp.nrd_op,ms WITH ntmec,god WITH nastf_b
              ELSE
                   IF DELETE()
                        RECALL
                        REPLACE summa WITH 0,ms WITH ntmec,god WITH nastf_b
                   ENDIF
              ENDIF
              IF fffsum>=dv_kp.smko-fsmko
                   REPLACE summa WITH summa+dv_kp.smko-fsmko,bs WITH ff2
              ELSE
                   REPLACE summa WITH summa+fffsum,bs WITH ff2
                   REPLACE dv_kp.smko WITH fsmko+fffsum
              ENDIF
         ELSE
              REPLACE dv_kp.smko WITH fsmko
         ENDIF
    ENDIF
ENDIF
SELECT dv_kp
RETURN
