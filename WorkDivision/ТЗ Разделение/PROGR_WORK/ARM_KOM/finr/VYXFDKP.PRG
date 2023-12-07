PARAMETERS ch1
PRIVATE scr
SAVE SCREEN TO scr
chg12=0
IF ch1#3
*
    fname="out.txt        "
    nlist=1
    pr_otk=.F.
    DO Pr_file WITH chg12,fname,nlist,.T.,pr_otk
    IF pr_otk
         RETURN
    ENDIF
    SET DEVICE TO SCREEN
*
    DEFINE WINDOW Zapros FROM 15,39 TO 17,62 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    RESTORE FROM tek_b ADDITIVE
    ff=IIF(EMPTY(AT(',',tek_b_4,1)),LEFT(tek_b_4,4),LEFT(LEFT(tek_b_4,AT(',',tek_b_4,1)-1)+'    ',4))
    RELEASE ALL LIKE tek_b_??
    @ 0,0 SAY " Hомер счета...." GET ff VALID Poisk_sc('ff',.T.,.F.,0,0,0,'76','.F.') ERROR 'Hет такого счета...'
    READ
    RELEASE WINDOW Zapros
    IF LASTKEY()=27.AND.READKEY()#271
         RETURN
    ENDIF
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
    RESTORE FROM tek_b ADDITIVE
    SELECT 0
    USE osd_prr EXCLUSIVE
    ZAP
    APPEND FROM osd_pr FOR bs=ff
    IF tek_b_15=1
         SET ORDER TO kp
    ELSE
         SET ORDER TO kp_dog
    ENDIF
    SELECT 0
    USE dv_pr
    SET ORDER TO bs_kp
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    SCAN REST WHILE bs=ff FOR !DELETE()
         SELECT osd_prr
         IF IIF(tek_b_15=1,!SEEK(dv_pr.kp),!SEEK(dv_pr.kp+dv_pr.dog))
              APPEND BLANK
              REPLACE kp WITH dv_pr.kp,bs WITH ff,pr_spr WITH '1'
              IF tek_b_15=0
                   REPLACE dog WITH dv_pr.dog,dat WITH dv_pr.dat
              ENDIF
         ENDIF
    ENDSCAN
    SET ORDER TO kor_kp
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    SCAN REST WHILE kor=ff FOR !DELETE()
         SELECT osd_prr
         IF IIF(tek_b_15=1,!SEEK(dv_pr.kp),!SEEK(dv_pr.kp+dv_pr.dog))
              APPEND BLANK
              REPLACE kp WITH dv_pr.kp,bs WITH ff,pr_spr WITH '1'
              IF tek_b_15=0
                   REPLACE dog WITH dv_pr.dog,dat WITH dv_pr.dat
              ENDIF
         ENDIF
    ENDSCAN
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
    APPEND FROM bk FOR (nzk=ff.OR.kor=ff).AND.MONTH(dat)=ntmec
    INDEX ON kp+dog TAG rab
    SCAN
         SELECT osd_prr
         IF IIF(tek_b_15=1,!SEEK(bkr.kp),!SEEK(bkr.kp+bkr.dog))
              APPEND BLANK
              REPLACE kp WITH bkr.kp,bs WITH bkr.kor,pr_spr WITH bkr.pr_spr
              IF tek_b_15=0
                   REPLACE dat WITH bkr.dat,dog WITH bkr.dog
              ENDIF
         ENDIF
    ENDSCAN
    SELECT osd_prr
    SET ORDER TO bs_kp
    GO TOP
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Oborkom
    SELECT osd_prr
    USE
    SELECT dv_pr
    USE
    SELECT bkr
    DELETE TAG rab
    USE
    RELEASE ALL LIKE tek_b_??
CASE ch1=2
    SELECT 0
    USE dv_prr EXCLUSIVE
    ZAP
    APPEND FROM dv_pr FOR bs=ff
    INDEX ON nsk+kor TAG rab
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    GO TOP
    DO Svod_pr
    DELETE TAG rab
    USE
CASE ch1=3
    DO Prvyx
ENDCASE
SET DELETED OFF
SET ESCAPE OFF
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN
