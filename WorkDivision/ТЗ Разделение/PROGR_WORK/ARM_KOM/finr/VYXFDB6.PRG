PARAMETERS ch1
SELECT skl
SET ORDER TO kkl
chg12=0
IF ch1#5
    SET COLOR TO &color13
    ffbs=IIF(ch1=4,nastf_2,nastf_1)
    DO CASE
    CASE ch1=2
         DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
         DEFINE BAR 1 OF Tekm PROMPT " В\<се корр.счета           "
         DEFINE BAR 2 OF Tekm PROMPT " К\<роме пустых корр.счетов "
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         menu_v=BAR()
         IF menu_v=0
              RETURN
         ENDIF
    CASE ch1=3
         fkkl=SPACE(LEN(skl.kkl))
         DEFINE WINDOW Zapros FROM 16,44 TO 18,70 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Код организации" GET fkkl
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27
              RETURN
         ENDIF
    CASE ch1=4
         DEFINE WINDOW Zapros FROM 15,40 TO 17,63 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Hомеp счета...." GET ffbs VALID Poisk_sc('ffbs',.T.,.F.,0,0,0,nastf_l,'.F.') ERROR 'Hет такого счета...'
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27.AND.READKEY()#271
              RETURN
         ENDIF
    ENDCASE
*
    fname="out.txt        "
    nlist=1
    pr_otk=.F.
    DO Pr_file WITH chg12,fname,nlist,.T.,pr_otk
    IF pr_otk
         RETURN
    ENDIF
*
    SET DEVICE TO SCREEN
    ACTIVATE WINDOW Pogal
    SET COLOR TO &color15
    @ 0,0 SAY '░'
    SET COLOR TO &color13
    @ 0,1 SAY "Пожалуйста, подождите..."
    @ 1,2 SAY ' Всего записей:       '
    @ 2,2 SAY ' Текущая запись:      '
    SET COLOR TO &color14
ENDIF
SET ESCAPE ON
ON ESCAPE DO Stop_esc
SET DELETED ON
DO CASE
CASE ch1=1
    SELECT spr_bs
    SET ORDER TO bs
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    APPEND FROM osdkom1 FOR bs=ffbs
    REPLACE kor WITH bs FOR EMPTY(kor)
    INDEX ON bs_op TAG rab2
    INDEX ON kor   TAG rab1
    SCAN FOR smko#0
         nz=RECNO()
         fbs_op=bs_op
         IF !SEEK(ffbs+fbs_op)
         	  APPEND BLANK
              REPLACE bs WITH ffbs,kor WITH fbs_op
         ENDIF
         GO nz
    ENDSCAN
    SELECT 0
    USE avotrr EXCLUSIVE
    ZAP
    APPEND FROM atot FOR bs=ffbs
    INDEX ON bs_op TAG rab2
    INDEX ON kor   TAG rab1
    SCAN
         IF !SEEK(avotrr.bs+avotrr.kor,"osdkomr")
              INSERT INTO osdkomr.dbf (bs, kor) VALUES (avotrr.bs, avotrr.kor)
         ENDIF
         IF !SEEK(avotrr.bs+avotrr.bs_op,"osdkomr")
              INSERT INTO osdkomr.dbf (bs, kor) VALUES (avotrr.bs, avotrr.bs_op)
         ENDIF
    ENDSCAN
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
    APPEND FROM bk FOR (kor=ffbs.OR.kor=nastf_2).AND.MONTH(dat)=ntmec
    SELECT bk
    SCAN FOR !DELETE().AND.MONTH(dat)=ntmec.AND.(nzk=ffbs.OR.nzk=nastf_2)
         SELECT bkr
         APPEND BLANK
         REPLACE nzk WITH bk.kor,kor WITH bk.nzk,vo WITH IIF(bk.vo='0','1','0')
    ENDSCAN
    SELECT bkr
    INDEX ON nzk TAG rab
    SCAN
         SELECT osdkomr
         IF !SEEK(bkr.kor+bkr.nzk)
              APPEND BLANK
              REPLACE bs WITH bkr.kor,kor WITH bkr.nzk
         ENDIF
    ENDSCAN
    SELECT osdkomr
    GO TOP
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Svod_6
    SELECT osdkomr
    DELETE TAG rab1,rab2
    ZAP
    USE
    SELECT avotrr
    DELETE TAG rab1,rab2
    ZAP
    USE
    SELECT bkr
    DELETE TAG rab
    ZAP
    USE
CASE ch1=2
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    APPEND FROM osdkom1 FOR bs=ffbs.AND.(menu_v=1.OR.db#0.OR.!EMPTY(kor))
    SET ORDER TO bs_kp
    SELECT 0
    USE osdkom1
    SET ORDER TO bs_kp
    SET EXACT OFF
    SEEK nastf_2
    SET EXACT ON
    SCAN REST WHILE bs=nastf_2 FOR !DELETE()
         IF !SEEK(ffbs+osdkom1.kp,"osdkomr")
              INSERT INTO osdkomr.dbf (bs, kp, pr_spr) VALUES;
                  (ffbs, osdkom1.kp, osdkom1.pr_spr)
         ENDIF
    ENDSCAN
    SELECT 0
    USE atot
    SET ORDER TO bs_kp
    SET EXACT OFF
    SEEK ffbs
    SCAN FOR bs=ffbs.AND.(menu_v=1.OR.!EMPTY(kor)).AND.!DELETE()
         IF !SEEK(atot.bs+atot.kp,"osdkomr")
              INSERT INTO osdkomr.dbf (bs, kp, pr_spr) VALUES ;
                   (atot.bs, atot.kp, atot.pr_spr)
         ENDIF
    ENDSCAN
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
    INDEX ON kor+kp TAG rab
    APPEND FROM bk FOR (kor=nastf_1.OR.kor=nastf_2).AND.MONTH(dat)=ntmec
    SELECT bk
    SCAN FOR !DELETE().AND.MONTH(dat)=ntmec.AND.(nzk=nastf_1.OR.nzk=nastf_2)
         SELECT bkr
         APPEND BLANK
         REPLACE nzk WITH bk.kor,kor WITH bk.nzk,vo WITH IIF(bk.vo='0','1','0'),;
                  kp WITH bk.kp,pr_spr WITH bk.pr_spr,sm WITH bk.sm
    ENDSCAN
    SELECT bkr
    SCAN
         IF !SEEK(ffbs+bkr.kp,"osdkomr")
              INSERT INTO osdkomr.dbf (bs, kp, pr_spr) VALUES ;
                   (ffbs, bkr.kp, bkr.pr_spr)
         ENDIF
    ENDSCAN
    SET EXACT ON
    SELECT osdkomr
    GO TOP
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Sprav_6
    ZAP
    USE
    SELECT atot
    USE
    SELECT osdkom1
    USE
    SELECT bkr
    ZAP
    DELETE TAG rab
    USE
CASE ch1=3
    SELECT spr_bs
    SET ORDER TO bs
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    INDEX ON kp TAG rab
    SELECT 0
    USE osdkom1 EXCLUSIVE
    INDEX ON bs+kp+nrd+nvx+kor TAG rab
    SCAN FOR (EMPTY(fkkl).OR.fkkl=kp).AND.!DELETE()
         IF !SEEK(osdkom1.kp,"osdkomr")
              INSERT INTO osdkomr.dbf (kp,pr_spr) VALUE (osdkom1.kp,osdkom1.pr_spr)
         ENDIF
    ENDSCAN
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
    INDEX ON kor+kp TAG rab
    APPEND FROM bk FOR kor=nastf_2.AND.MONTH(dat)=ntmec.AND.(EMPTY(fkkl).OR.fkkl=kp)
    SELECT bk
    SCAN FOR !DELETE().AND.MONTH(dat)=ntmec.AND.nzk=nastf_2.AND.(EMPTY(fkkl).OR.fkkl=kp)
         SELECT bkr
         APPEND BLANK
         REPLACE nzk WITH bk.kor,kor WITH bk.nzk,vo WITH IIF(bk.vo='0','1','0'),;
                  kp WITH bk.kp,pr_spr WITH bk.pr_spr,sm WITH bk.sm,;
                 nrd WITH bk.nrd,dat WITH bk.dat
    ENDSCAN
    SELECT bkr
    SCAN
         IF !SEEK(bkr.kp,"osdkomr")
              INSERT INTO osdkomr.dbf (kp,pr_spr) VALUE (bkr.kp,bkr.pr_spr)
         ENDIF
    ENDSCAN
    SELECT 0
    USE avotrr EXCLUSIVE
    ZAP
    APPEND FROM atot
    INDEX ON bs+kp+nrd+nvx+kor TAG rab
    SCAN FOR EMPTY(fkkl).OR.fkkl=kp
         IF !SEEK(avotrr.kp,"osdkomr")
              INSERT INTO osdkomr.dbf (kp,pr_spr) VALUE (avotrr.kp,avotrr.pr_spr)
         ENDIF
    ENDSCAN
    SELECT osdkomr
    RESTORE FROM tek_b ADDITIVE
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Inf_6
    RELEASE ALL LIKE tek_b_??
    SELECT osdkomr
    DELETE TAG rab
    ZAP
    USE
    SELECT avotrr
    DELETE TAG rab
    ZAP
    USE
    SELECT osdkom1
    DELETE TAG rab
    USE
    SELECT bkr
    DELETE TAG rab
    ZAP
    USE
CASE ch1=4
    IF !EMPTY(ffbs)
         SELECT 0
         USE osdkomr EXCLUSIVE
         ZAP
         APPEND FROM osdkom1 FOR bs_op=ffbs
         APPEND FROM atot    FOR bs_op=ffbs
         @ 1,18 SAY RECCOUNT() PICTURE '999999'
         @ 2,18 SAY ' '
         SET DEVICE TO PRINT
         @ PROW(),0 SAY &sgat2
         DO Pr_kor6
         USE
    ENDIF
CASE ch1=5
    DO Prvyx
ENDCASE
SET DELETED OFF
SET ESCAPE OFF
SET PROCEDURE TO Proc_6
SET DEVICE TO SCREEN
SET PRINTER TO
HIDE WINDOW ALL
ACTIVATE SCREEN
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN
