PARAMETERS ch1
PRIVATE scr
SAVE SCREEN TO scr
chg12=0
IF ch1#5
*
    fname="out.txt        "
    nlist=1
    pr_otks=.F.
    DO Pr_file WITH chg12,fname,nlist,.T.,pr_otks
    IF pr_otks
         RETURN
    ENDIF
    SET DEVICE TO SCREEN
*
    RESTORE FROM tek_b ADDITIVE
    ff=IIF(EMPTY(AT(',',tek_b_24,1)),LEFT(tek_b_24,4),LEFT(LEFT(tek_b_24,AT(',',tek_b_24,1)-1)+'    ',4))
    RELEASE ALL LIKE tek_b_??
    SET COLOR TO &color13
    DO CASE
    CASE ch1<3
         ffnsk=SPACE(LEN(sch.nsk))
         ffkor='    '
         DEFINE WINDOW Zapros FROM 15,40 TO 19,65 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Hомер счета......" GET ff VALID Poisk_sc('ff',.T.,.F.,0,0,0,'71','.F.') ERROR 'Hет такого счета...'
         @ 1,0 SAY " Корреспондир.счет" GET ffkor
         @ 2,0 SAY " Код подразделения" GET ffnsk
    CASE ch1=3
         DEFINE WINDOW Zapros FROM 15,40 TO 17,65 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Hомер счета......" GET ff VALID Poisk_sc('ff',.T.,.F.,0,0,0,'71','.F.') ERROR 'Hет такого счета...'
    CASE ch1=4
         ffbs=SPACE(4)
         fsnds=SPACE(4)
         fssn=SPACE(4)
         DEFINE WINDOW Zapros FROM 14,40 TO 19,71 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Hомер счета..........." GET ff VALID Poisk_sc('ff',.T.,.F.,0,0,0,'71','.F.') ERROR 'Hет такого счета...'
         @ 1,0 SAY " Коppеспондиpующий счет" GET ffbs
         @ 2,0 SAY " Счет НДС.............." GET fsnds
         @ 3,0 SAY " Счет спецналога......." GET fssn
    ENDCASE
    READ
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
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
SELECT sprrab
SET ORDER TO tab
SET DELETED ON
DO CASE
CASE ch1=1
    SELECT 0
    USE ostrk
    SET RELATION TO tab INTO sprrab
    REPLACE ALL nsk WITH sprrab.cex
    USE ostrkr EXCLUSIVE
    SET ORDER TO bs_tab
    ZAP
    IF ffnsk=' '
         APPEND FROM ostrk FOR bs=ff
    ELSE
         APPEND FROM ostrk FOR bs=ff.AND.nsk=ffnsk
    ENDIF
    SELECT 0
    USE avotr
    SET ORDER TO bs_tab
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    SCAN REST WHILE bs=ff FOR !DELETE()
         IF !EMPTY(ffnsk)
              SELECT sprrab
              SEEK avotr.tab
         ENDIF
         IF EMPTY(ffnsk).OR.ffnsk=sprrab.cex
              SELECT ostrkr
              IF !SEEK(ff+avotr.tab)
                   APPEND BLANK
                   REPLACE tab WITH avotr.tab,bs WITH ff
              ENDIF
         ENDIF
    ENDSCAN
    SELECT 0
    USE yd_71
    SET ORDER TO bs_tbn
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    SCAN REST WHILE bs=ff FOR !DELETE()
         IF !EMPTY(ffnsk)
              SELECT sprrab
              SEEK yd_71.tbn
         ENDIF
         IF EMPTY(ffnsk).OR.ffnsk=sprrab.cex
              SELECT ostrkr
              IF !SEEK(ff+yd_71.tbn)
                   APPEND BLANK
                   REPLACE tab WITH yd_71.tbn,bs WITH ff
              ENDIF
         ENDIF
    ENDSCAN
    SELECT 0
    USE vn_71
    SET ORDER TO bs_tabo
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    SCAN REST WHILE bs=ff FOR !DELETE()
         IF !EMPTY(ffnsk)
              SELECT sprrab
              SEEK vn_71.tabo
         ENDIF
         IF EMPTY(ffnsk).OR.ffnsk=sprrab.cex
              SELECT ostrkr
              IF !SEEK(ff+vn_71.tabo)
                   APPEND BLANK
                   REPLACE tab WITH vn_71.tabo,bs WITH ff
              ENDIF
         ENDIF
         IF !EMPTY(ffnsk)
              SELECT sprrab
              SEEK vn_71.tabp
         ENDIF
         IF EMPTY(ffnsk).OR.ffnsk=sprrab.cex
              SELECT ostrkr
              IF !SEEK(ff+vn_71.tabp)
                   APPEND BLANK
                   REPLACE tab WITH vn_71.tabp,bs WITH ff
              ENDIF
         ENDIF
    ENDSCAN
    SELECT bk
    tgod=1900+VAL(nastf_b)
    SET ORDER TO bk2
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    SCAN REST WHILE kor=ff FOR MONTH(dat)=ntmec.AND.YEAR(dat)=tgod.AND.pr_spr='0'.AND.!DELETE()
         IF !EMPTY(ffnsk)
              SELECT sprrab
              SEEK LEFT(bk.kp,6)
         ENDIF
         IF EMPTY(ffnsk).OR.ffnsk=sprrab.cex
              SELECT ostrkr
              IF !SEEK(ff+LEFT(bk.kp,6))
                   APPEND BLANK
                   REPLACE tab WITH LEFT(bk.kp,6),bs WITH ff
              ENDIF
         ENDIF
    ENDSCAN
    SET ORDER TO kp
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    SCAN REST WHILE nzk=ff FOR MONTH(dat)=ntmec.AND.YEAR(dat)=tgod.AND.pr_spr='0'.AND.!DELETE()
         IF !EMPTY(ffnsk)
              SELECT sprrab
              SEEK LEFT(bk.kp,6)
         ENDIF
         IF EMPTY(ffnsk).OR.ffnsk=sprrab.cex
              SELECT ostrkr
              IF !SEEK(ff+LEFT(bk.kp,6))
                   APPEND BLANK
                   REPLACE tab WITH LEFT(bk.kp,6),bs WITH ff
              ENDIF
         ENDIF
    ENDSCAN
    SELECT ostrkr
    SET RELATION TO tab INTO sprrab
    REPLACE ALL nsk WITH sprrab.cex
    INDEX ON nsk+tab TAG rab
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Oborkomr
    DELETE TAG rab
    ZAP
    USE
    SELECT avotr
    USE
    SELECT vn_71
    USE
    SELECT yd_71
    USE
CASE ch1=2
    SELECT 0
    USE kodzk
    SET ORDER TO kodzk
    SELECT 0
    USE avotrr EXCLUSIVE
    ZAP
    APPEND FROM avotr FOR bs=ff.AND.(EMPTY(ffkor).OR.kor=ffkor)
    SET RELATION TO tab INTO sprrab
    REPLACE ALL nsk WITH sprrab.cex
    INDEX ON nsk+tab TAG rab
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    RESTORE FROM tek_b ADDITIVE
    DO Reestr
    RELEASE ALL LIKE tek_b_??
    SET RELATION TO
    DELETE TAG rab
    ZAP
    USE
    SELECT kodzk
    USE
CASE ch1=3
    SELECT 0
    USE avotrr EXCLUSIVE
    ZAP
    APPEND FROM avotr FOR bs=ff
    SET RELATION TO tab INTO sprrab
    REPLACE ALL nsk WITH sprrab.cex
    INDEX ON nsk+kor TAG rab
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    RESTORE FROM tek_b ADDITIVE
    DO Svod_71
    RELEASE ALL LIKE tek_b_??
    SET RELATION TO
    DELETE TAG rab
    ZAP
    USE
CASE ch1=4
    SELECT 0
    USE avotr
    SET ORDER TO bs_nvx
    SELECT 0
    USE kodzk
    SET ORDER TO kodzk
    SELECT 0
    USE avotrr EXCLUSIVE
    ZAP
    APPEND FROM avotr FOR bs=ff.AND.kor=ffbs
    INDEX ON tab+nvx TAG rab
    SET RELATION TO tab INTO sprrab
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    DO Nal_71
    DELETE TAG rab
    ZAP
    USE
    SELECT kodzk
    USE
    SELECT avotr
    USE
CASE ch1=5
    DO Prvyx
ENDCASE
SET DELETED OFF
SET ESCAPE OFF
SET PROCEDURE TO Proc_71
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN
