DEFINE POPUP Tekm FROM 11,48 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Tekm PROMPT " В\<се корр.счета           "
DEFINE BAR 2 OF Tekm PROMPT " К\<роме пустых корр.счетов "
ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
ACTIVATE POPUP Tekm
menu_v=BAR()
IF menu_v=0
    RETURN
ENDIF
f_1=nastf_1
f_2=nastf_2
ACTIVATE WINDOW Pog_p
SET COLOR TO &color15
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
IF nastf_h=1
    SELECT 0
    USE tran_pos
    SET ORDER TO uni
ENDIF
SELECT 0
USE osdkomr EXCLUSIVE
SET ORDER TO kp_pr
ZAP
SELECT 0
USE osdkom1
SET ORDER TO kp_nrd
ffkp=kp
ffnrd=nrd
ffnvx=nvx
ffpr_spr=pr_spr
ffbs=bs
ffnsk=nsk
ffdat=dat
SET EXACT OFF
SCAN FOR (bs=f_1.OR.bs=f_2).AND.!DELETE()
    SELECT osdkomr
    IF !SEEK(f_1+osdkom1.kp+osdkom1.pr_spr)
         INSERT INTO osdkomr.dbf (kp, bs, bs_op, pr_spr) VALUES;
              (osdkom1.kp, m.f_1, osdkom1.bs_op, osdkom1.pr_spr )
    ENDIF
    REPLACE db WITH db+osdkom1.db,kr WITH kr+osdkom1.kr
    IF osdkom1.kr#0.AND.osdkom1.smko#0
         REPLACE smko WITH smko+osdkom1.smko
    ENDIF
ENDSCAN
SELECT bk
SET ORDER TO bk2
SEEK f_1
SCAN REST WHILE kor=f_1 FOR MONTH(dat)=ntmec.AND.!DELETE()
    SELECT osdkomr
    IF !SEEK(f_1+bk.kp+bk.pr_spr))
         INSERT INTO osdkomr.dbf (kp, bs, pr_spr) VALUES ;
              (bk.kp, m.f_1, bk.pr_spr )
    ENDIF
    REPLACE smd WITH smd+IIF(bk.vo='1',bk.sm,-bk.sm)
ENDSCAN
SET ORDER TO kp
SEEK f_1
SCAN REST WHILE nzk=f_1 FOR MONTH(dat)=ntmec.AND.!DELETE()
    SELECT osdkomr
    IF !SEEK(f_1+bk.kp+bk.pr_spr))
         INSERT INTO osdkomr.dbf (kp, bs, pr_spr) VALUES ;
              (bk.kp, m.f_1, bk.pr_spr )
    ENDIF
    REPLACE smd WITH smd+IIF(bk.vo='0',bk.sm,-bk.sm)
ENDSCAN
IF f_1#f_2
    SET ORDER TO bk2
    SEEK f_2
    SCAN REST WHILE kor=f_2 FOR MONTH(dat)=ntmec.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(f_1+bk.kp+bk.pr_spr))
              INSERT INTO osdkomr.dbf (kp, bs, pr_spr) VALUES ;
                   (bk.kp, m.f_1, bk.pr_spr )
         ENDIF
         REPLACE smd WITH smd+IIF(bk.vo='1',bk.sm,-bk.sm)
    ENDSCAN
    SET ORDER TO kp
    SEEK f_2
    SCAN REST WHILE nzk=f_2 FOR MONTH(dat)=ntmec.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(f_1+bk.kp+bk.pr_spr))
              INSERT INTO osdkomr.dbf (kp, bs, pr_spr) VALUES ;
                   (bk.kp, m.f_1, bk.pr_spr )
         ENDIF
         REPLACE smd WITH smd+IIF(bk.vo='0',bk.sm,-bk.sm)
    ENDSCAN
ENDIF
SELECT 0
USE atot
SET ORDER TO bs_kp
SCAN FOR bs=f_1.AND.(menu_v=1.OR.!EMPTY(kor)).AND.!DELETE()
    SELECT osdkomr
    IF !SEEK(atot.bs+atot.kp+atot.pr_spr)
         INSERT INTO osdkomr.dbf (kp, bs, bs_op, pr_spr) VALUES ;
              (atot.kp, atot.bs, atot.bs_op, atot.pr_spr)
    ENDIF
    REPLACE smko WITH smko+atot.smko,smk WITH smk+atot.smk
ENDSCAN
SET EXACT ON
SELECT osdkomr
REPLACE pr_prib WITH '*' FOR smko<(db+smd).AND.(kr+smk)#smko
GO TOP
HIDE WINDOW ALL
ACTIVATE SCREEN
HIDE POPUP ALL
DO Vvodn WITH "Chapak1","Strsayak1","Strgetak1",.T.,.F.,.F.,.F.,".F.","",;
              "F2av1","F3ak1","F4ak1","F5ak1","","","","","","",.T.
IF UPPER(ALIAS())='OSDKOMR'
    USE
ENDIF
IF USED('OSDKOM1')
    USE IN osdkom1
ENDIF
IF USED('KODZK')
    USE IN kodzk
ENDIF
IF USED('ATOT')
    USE IN atot
ENDIF
IF USED('TRAN_POS')
    USE IN tran_pos
ENDIF
RETURN
