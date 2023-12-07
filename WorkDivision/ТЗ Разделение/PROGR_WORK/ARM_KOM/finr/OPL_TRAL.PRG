IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fffsum,nz,fnrd
IF fsmdo>smdo.AND.smd>0.OR.fsmdo<smdo.AND.smd<0
    SELECT tran_opl
    IF dv_kp.smdo=0
         SET EXACT OFF
         SEEK STR(dv_kp.uni,7)
         SET EXACT OFF
         SCAN REST WHILE uni=dv_kp.uni FOR ms=ntmec.AND.god=nastf_b.AND.pr_doc=0.AND.!DELETE()
              REPLACE summa WITH 0
              DELETE
         ENDSCAN
    ELSE
         IF SEEK(STR(dv_kp.uni,7)+DTOC(dv_kp.dat_op,1)+dv_kp.nrd_op)
              REPLACE summa WITH summa+dv_kp.smdo-fsmdo,bs WITH ff2
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
         REPLACE dv_kp.smdo WITH fsmdo
         RETURN
    ENDIF
* поиск документа
    fffsum=0
    SELECT bkr
    SET ORDER TO kp
    SET EXACT OFF
    SEEK osdkomr.kp+fnrd
    SET EXACT ON
    SCAN REST WHILE kp=osdkomr.kp.AND.nrd=fnrd FOR vo='0'.AND.pr_spr=osdkomr.pr_spr
         fdat=dat
         fffsum=sm
         EXIT
    ENDSCAN
    SELECT dv_kp
    IF EMPTY(fdat)
         pr_new=.T.
         fdat=IIF(fsmdo=0,fdat,dv_kp.dat_op)
         DEFINE WINDOW Zapros FROM 11,32 TO 13,50 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Дата " GET fdat
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27
              REPLACE dv_kp.smdo WITH fsmdo
              RETURN
         ENDIF
    ELSE
* документ найден и проверяем остаток
         pr_new=.F.
         nz=RECNO()
         SET EXACT OFF
         SCAN
              SELECT tran_opl
              SEEK STR(dv_kp.uni,7)
              SCAN REST WHILE uni=dv_kp.uni FOR dat=fdat.AND.nrd=fnrd.AND.!DELETE()
                   fffsum=fffsum-summa
              ENDSCAN
         ENDSCAN
         SET EXACT ON
         GO nz
    ENDIF
    klnrd=fnrd
    IF pr_new
         SELECT dv_kp
         REPLACE dat_op WITH fdat,nrd_op WITH fnrd
         SELECT tran_opl
         IF !SEEK(STR(dv_kp.uni,7)+DTOC(dv_kp.dat_op,1)+dv_kp.nrd_op)
              APPEND BLANK
              REPLACE uni WITH dv_kp.uni,dat WITH dv_kp.dat_op,nrd WITH dv_kp.nrd_op,ms WITH ntmec,god WITH nastf_b
         ELSE
              IF DELETE()
                   RECALL
                   REPLACE summa WITH 0
              ENDIF
         ENDIF
         REPLACE summa WITH summa+dv_kp.smdo-fsmdo,bs WITH ff2
    ELSE
         IF fffsum>=dv_kp.smdo-fsmdo.OR.fffsum>0
              SELECT dv_kp
              REPLACE dat_op WITH fdat,nrd_op WITH fnrd
              SELECT tran_opl
              IF !SEEK(STR(dv_kp.uni,7)+DTOC(dv_kp.dat_op,1)+dv_kp.nrd_op)
                   APPEND BLANK
                   REPLACE uni WITH dv_kp.uni,dat WITH dv_kp.dat_op,nrd WITH dv_kp.nrd_op,ms WITH ntmec,god WITH nastf_b
              ELSE
                   IF DELETE()
                        RECALL
                        REPLACE summa WITH 0
                   ENDIF
              ENDIF
              IF fffsum>=dv_kp.smdo-fsmdo
                   REPLACE summa WITH summa+dv_kp.smdo-fsmdo,bs WITH ff2
              ELSE
                   REPLACE summa WITH fffsum,bs WITH ff2
                   REPLACE dv_kp.smdo WITH fsmdo+fffsum
              ENDIF
         ELSE
              REPLACE dv_kp.smdo WITH fsmdo
         ENDIF
    ENDIF
ENDIF
SELECT dv_kp
RETURN
