f_l=nastf_l
f_e=nastf_e
f_k=nastf_k
ACTIVATE WINDOW Pog_p
SET COLOR TO &color15
@ 0,0 SAY '°'
SET COLOR TO &color13
@ 0,1 SAY "®¦ «γ©αβ , ―®¤®¦¤¨β¥..."
IF FILE('KODZK.DBF')
    SELECT 0
    USE kodzk
    SET ORDER TO kodzk
ENDIF
IF nastf_h=1
    SELECT 0
    USE tran_opl
    SET ORDER TO uni
ENDIF
SELECT 0
USE osdkomr EXCLUSIVE
SET ORDER TO kp_pr
ZAP
SELECT 0
USE osdkom
SET ORDER TO osdkom
ffkp=kp
ffnrd=nrd
ffnvx=nvx
ffpr_spr=pr_spr
ffbs=bs
ffnsk=nsk
ffdat=dat
SCAN FOR (osdkom.bs=f_l.OR.osdkom.bs=f_k).AND.!DELETE()
    SELECT osdkomr
    IF !SEEK(f_l+osdkom.kp+osdkom.pr_spr)
         APPEND BLANK
         REPLACE kp WITH osdkom.kp,bs WITH f_l,bs_op WITH osdkom.bs_op,pr_spr WITH osdkom.pr_spr
         replace nzk with osdkom.nzk,nrd with osdkom.nrd
    ENDIF
    REPLACE db WITH db+osdkom.db,kr WITH kr+osdkom.kr
    IF osdkom.db#0.AND.osdkom.smdo#0
    	REPLACE smdo WITH smdo+osdkom.smdo
    ENDIF
ENDSCAN
SELECT bk
SET ORDER TO bk2
SET EXACT OFF
SEEK f_e
SCAN REST WHILE kor=f_e FOR MONTH(dat)=ntmec.AND.!DELETE()
    SELECT osdkomr
    IF !SEEK(f_l+bk.kp+bk.pr_spr))
         APPEND BLANK
         REPLACE kp WITH bk.kp,bs WITH f_l,pr_spr WITH bk.pr_spr
    ENDIF
    REPLACE smk WITH smk+IIF(bk.vo='0',bk.sm,-bk.sm)
ENDSCAN
SET ORDER TO kp
SEEK f_e
SCAN REST WHILE nzk=f_e FOR MONTH(dat)=ntmec.AND.!DELETE()
    SELECT osdkomr
    IF !SEEK(f_l+bk.kp+bk.pr_spr))
         APPEND BLANK
         REPLACE kp WITH bk.kp,bs WITH f_l,pr_spr WITH bk.pr_spr
    ENDIF
    REPLACE smk WITH smk+IIF(bk.vo='1',bk.sm,-bk.sm)
ENDSCAN
IF f_e#f_k
    SET ORDER TO bk2
    SEEK f_k
    SCAN REST WHILE kor=f_k FOR MONTH(dat)=ntmec.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(f_l+bk.kp+bk.pr_spr))
              APPEND BLANK
              REPLACE kp WITH bk.kp,bs WITH f_l,pr_spr WITH bk.pr_spr
         ENDIF
         REPLACE smk WITH smk+IIF(bk.vo='0',bk.sm,-bk.sm)
    ENDSCAN
    SET ORDER TO kp
    SEEK f_k
    SCAN REST WHILE nzk=f_k FOR MONTH(dat)=ntmec.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(f_l+bk.kp+bk.pr_spr))
              APPEND BLANK
              REPLACE kp WITH bk.kp,bs WITH f_l,pr_spr WITH bk.pr_spr
         ENDIF
         REPLACE smk WITH smk+IIF(bk.vo='1',bk.sm,-bk.sm)
    ENDSCAN
ENDIF
SET EXACT ON
SELECT 0
USE avot
SET ORDER TO bs_kp
SCAN FOR bs=f_l.AND.!DELETE()
    SELECT osdkomr
    IF !SEEK(avot.bs+avot.kp+avot.pr_spr)
         APPEND BLANK
         REPLACE kp WITH avot.kp,bs WITH avot.bs,bs_op WITH avot.bs_op,pr_spr WITH avot.pr_spr
    ENDIF
    REPLACE smd WITH smd+avot.smd,smdo WITH smdo+avot.smdo
ENDSCAN
SELECT osdkomr
REPLACE pr_prib WITH '*' FOR smdo<(kr+smk).AND.(db+smd)#smdo
GO TOP
HIDE WINDOW ALL
ACTIVATE SCREEN
HIDE POPUP ALL
ON KEY LABEL Alt-F9 DO Menu_spr
f15=1
DO Vvodn WITH "Chapak","Strsayak","Strgetak",.T.,.F.,.F.,.F.,".F.","",;
     "F2av","F3ak","F4ak","F5ak",IIF(nastf_h=0,"F6ak",''),"","","","","",.T.
ON KEY LABEL Alt-F9
IF ALIAS()='OSDKOMR'
    USE
ENDIF
IF Poisk_alia('OSDKOM')
    USE
ENDIF
IF Poisk_alia('KODZK')
    USE
ENDIF
IF Poisk_alia('AVOT')
    USE
ENDIF
IF nastf_h=1.AND.Poisk_alia('TRAN_OPL')
    USE
ENDIF
RETURN