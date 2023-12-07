SELECT 0
USE supavot EXCLUSIVE
SET ORDER TO bs_kp
ZAP
SELECT avot
SET ORDER TO bs_kp
SET EXACT OFF
SEEK osdkomr.bs+osdkomr.kp
SET EXACT ON
DO WHILE osdkomr.bs=bs.AND.osdkomr.kp=kp
    sss=0
    oldnrd=avot.nrd
    SELECT supavot
    APPEND BLANK
    REPLACE dat WITH avot.dat,kp WITH avot.kp,nvx WITH avot.nvx,nzk WITH avot.nzk
    REPLACE bs  WITH avot.bs,nrd WITH avot.nrd
    SELECT avot
    SCAN REST WHILE osdkomr.bs=bs.AND.osdkomr.kp=kp.AND.oldnrd=nrd FOR !DELETE()
         sss=sss+smd
    ENDSCAN
    SELECT supavot
    REPLACE smd WITH sss
    SELECT avot
ENDDO
SELECT supavot
SET EXACT OFF
SEEK osdkomr.bs+osdkomr.kp
SET EXACT ON
pr_ud_bn=.F.
DO Vvodn WITH "Chapaa","Strsayaa","Strgetaa",.T.,.T.,.T.,.T.,"(bs#osdkomr.bs.OR.kp#osdkomr.kp)",;
              " "," "," "," "," "," "," "," "," "," "," ",.T.
SELECT avot
IF pr_ud_bn
    SCAN FOR DELETE()
         SELECT supavot
         IF SEEK(avot.bs+avot.kp+avot.nrd)
              IF !DELETE()
                   SELECT avot
                   SCAN REST WHILE bs=osdkomr.bs.AND.kp=supavot.kp.AND.nrd=supavot.nrd
                        RECALL
                   ENDSCAN
                   SKIP -1
              ENDIF
         ENDIF
         SELECT avot
    ENDSCAN
    IF pr_setev
         USE avot EXCLUSIVE
         PACK
         USE avot
    ELSE
         PACK
    ENDIF
ENDIF
SELECT supavot
USE
SELECT osdkomr
REPLACE osdkomr.smd WITH 0
SELECT avot
SET EXACT OFF
SEEK osdkomr.bs+osdkomr.kp
SET EXACT ON
SCAN REST WHILE bs=osdkomr.bs.AND.kp=osdkomr.kp FOR !DELETE()
    SELECT osdkomr
    IF !SEEK(avot.bs+avot.kp)
         APPEND BLANK
         REPLACE kp WITH avot.kp,bs WITH avot.bs
    ENDIF
    REPLACE smd WITH smd+avot.smd
    SELECT avot
ENDSCAN
SELECT bk
SET ORDER TO bk2
SET EXACT OFF
SEEK nastf_k+osdkomr.kp
SET EXACT ON
SCAN REST WHILE kor=nastf_k.AND.kp=osdkomr.kp FOR MONTH(dat)=ntmec.AND.bk.vo='1'.AND.!DELETE()
    REPLACE osdkomr.smd WITH osdkomr.smd+bk.sm
ENDSCAN
SELECT osdkomr
RETURN
