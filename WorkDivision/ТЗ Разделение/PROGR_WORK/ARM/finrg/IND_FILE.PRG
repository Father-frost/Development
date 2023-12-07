PARAMETERS ch3,ch2
PRIVATE set_devi,sss
set_devi=.F.
IF SET('DEVICE')='PRINT'
     SET DEVICE TO SCREEN
     set_devi=.T.
ENDIF
DEFINE WINDOW Zapros FROM 10,22 TO 14,49 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color15
@ 0,0 SAY '∞'
SET COLOR TO &color13
@ 0,1 SAY "èÆ¶†´„©·‚†, ØÆ§Æ¶§®‚•..."
@ 1,1 SAY " î†©´:"
RESTORE FROM tek_b ADDITIVE
DO CASE
CASE ch2=1
    @ 2,8 SAY 'äÆØ®‡Æ¢†≠®•'
CASE ch2=2
    @ 2,5 SAY 'ÇÆ··‚†≠Æ¢´•≠®•'
CASE ch2=3
    @ 2,8 SAY 'à≠§•™·†Ê®Ô'
CASE ch2=4
    @ 2,8 SAY 'ìØ†™Æ¢™†'
ENDCASE
SET COLOR TO &color14
DO CASE
CASE ch3=1
    SELECT bk
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "bk","nzk","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "bk","nzk", "*****",tek_b_13
         ENDIF
         IF pr_setev
              USE bk EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('bk.dbf'),LEN(FULLPATH('bk.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON nzk+nrd TAG nrd OF &sss
         INDEX ON nzk+kp+nrd+kor TAG kp OF &sss
         INDEX ON nzk+vo+pr_spr+kp+nrd+DTOC(dat,1)+kor TAG kp_dat OF &sss
         INDEX ON nzk+kor+kp TAG kor_kp OF &sss
         INDEX ON kor+kp+nzk TAG bk2    OF &sss
         INDEX ON nzk+DTOC(dat,1)+vo+pr_usl+DTOC(dati,1)+kp TAG bk3 OF &sss
         INDEX ON nzk+DTOC(dat,1)+vo+pr_usl+STR(1000000000000-sm,12,2)+kp TAG bk4 OF &sss
         INDEX ON nzk+STR(sm,15,2) TAG summa OF &sss
         INDEX ON kp+nrd+kor TAG kp_kor OF &sss
         IF pr_setev
              USE bk
              SET ORDER TO kp
         ENDIF
    CASE ch2=4
         IF pr_setev
              USE bk EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev
              USE bk
              SET ORDER TO kp
         ENDIF
    ENDCASE
CASE ch3=2
    SELECT spr_bs
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "spr_bs","bs","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "spr_bs","bs","*****",tek_b_13
         ENDIF
         IF pr_setev
              USE spr_bs EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('spr_bs.dbf'),LEN(FULLPATH('spr_bs.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON bs TAG bs OF &sss
         INDEX ON grup+bs TAG grup OF &sss
         IF pr_setev
              USE spr_bs
              SET ORDER TO bs
         ENDIF
    CASE ch2=4
         IF pr_setev
              USE spr_bs EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev
              USE spr_bs
              SET ORDER TO bs
         ENDIF
    ENDCASE
CASE ch3=3
    IF ALIAS()#'OSD_PR'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE osd_pr
         ELSE
              USE osd_pr EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE osd_pr EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "osd_pr","kp","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "osd_pr","kp","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('osd_pr.dbf'),LEN(FULLPATH('osd_pr.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON dog TAG dog OF &sss
         INDEX ON kp+dog TAG kp_dog OF &sss
         INDEX ON bs+kp+dog TAG bs_kp OF &sss
         IF pr_setev.AND.!pr_f
              USE osd_pr
              SET ORDER TO kp_dog
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE osd_pr
              SET ORDER TO kp_dog
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=4
	SELECT sprnaz
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "sprnaz","nam","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "sprnaz","nam","*****",tek_b_13
         ENDIF
         IF pr_setev
              USE sprnaz EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('sprnaz.dbf'),LEN(FULLPATH('sprnaz.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON wid_d TAG wid_d OF &sss
         IF pr_setev
              USE sprnaz
              SET ORDER TO wid_d
         ENDIF
    CASE ch2=4
         IF pr_setev
              USE sprnaz EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev
              USE sprnaz
              SET ORDER TO wid_d
         ENDIF
    ENDCASE
CASE ch3=5
    IF ALIAS()#'DV_PR'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE dv_pr
         ELSE
              USE dv_pr EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE dv_pr EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "dv_pr","kp","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "dv_pr","kp","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('dv_pr.dbf'),LEN(FULLPATH('dv_pr.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON dog TAG dog OF &sss
         INDEX ON kp+dog TAG kp_dog OF &sss
         INDEX ON bs+kp+dog TAG bs_kp OF &sss
         INDEX ON kor+kp+dog TAG kor_kp OF &sss
         IF pr_setev.AND.!pr_f
              USE dv_pr
              SET ORDER TO kp_dog
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE dv_pr
              SET ORDER TO kp_dog
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=6
	SELECT spr_grup
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "spr_grup","grup","***",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "spr_grup","grup","***",tek_b_13
         ENDIF
         IF pr_setev
              USE spr_grup EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('spr_grup.dbf'),LEN(FULLPATH('spr_grup.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON grup TAG grup OF &sss
         IF pr_setev
              USE spr_grup
              SET ORDER TO grup
         ENDIF
    CASE ch2=4
         IF pr_setev
              USE spr_grup EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev
              USE spr_grup
              SET ORDER TO grup
         ENDIF
    ENDCASE
CASE ch3=7
    IF FILE('PR.DBF')
         IF ALIAS()#'PR'
              pr_f=.T.
              SELECT 0
              IF ch2=1
                   USE pr
              ELSE
                   USE pr EXCLUSIVE
              ENDIF
         ELSE
              pr_f=.F.
              IF pr_setev
                   USE pr EXCLUSIVE
              ENDIF
         ENDIF
         @ 1,8 SAY ALIAS()
         DO CASE
         CASE ch2=1
              DO Copyr WITH "pr","mat","*****",tek_b_13
         CASE ch2=2.OR.ch2=3
              IF ch2=2
                   DO Vosstr WITH "pr","mat","*****",tek_b_13
              ENDIF
              sss=STUFF(FULLPATH('pr.dbf'),LEN(FULLPATH('pr.dbf'))-2,3,'CDX')
              INDEX ON npd TAG npd OF &sss
              INDEX ON nsk+mat TAG nsk OF &sss
              IF pr_setev.AND.!pr_f
                   USE pr
                   SET ORDER TO npd
              ENDIF
         CASE ch2=4
              PACK
              IF pr_setev.AND.!pr_f
                   USE pr
                   SET ORDER TO npd
              ENDIF
         ENDCASE
         IF pr_f
              USE
         ENDIF
    ENDIF
CASE ch3=8
    SELECT sprt
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "sprt","text_1","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "sprt","text_1","*****",tek_b_13
         ENDIF
         IF pr_setev
              USE sprt EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('sprt.dbf'),LEN(FULLPATH('sprt.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON wid_t TAG wid_t OF &sss
         INDEX ON IIF(EMPTY(text_1),' ',CHRTRAN(STRTRAN(text_1," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü")) TAG text OF &sss
         IF pr_setev
              USE sprt
              SET ORDER TO wid_t
         ENDIF
    CASE ch2=4
         IF pr_setev
              USE sprt EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev
              USE sprt
              SET ORDER TO wid_t
         ENDIF
    ENDCASE
CASE ch3=9
    SELECT sch
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "sch","icsk","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "sch","icsk","*****",tek_b_13
         ENDIF
         IF pr_setev
              USE sch EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('sch.dbf'),LEN(FULLPATH('sch.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON nsk TAG sch OF &sss
         INDEX ON IIF(EMPTY(icsk),' ',CHRTRAN(STRTRAN(icsk," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü")) TAG nam OF &sss
         IF pr_setev
              USE sch
              SET ORDER TO sch
         ENDIF
    CASE ch2=4
         IF pr_setev
              USE sch EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev
              USE sch
              SET ORDER TO sch
         ENDIF
    ENDCASE
CASE ch3=10
    SELECT skl
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "skl","ikl","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "skl","ikl","*****",tek_b_13
         ENDIF
         IF pr_setev
              USE skl EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('skl.dbf'),LEN(FULLPATH('skl.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON kkl TAG kkl OF &sss
         INDEX ON IIF(EMPTY(ikl),' ',CHRTRAN(STRTRAN(ikl," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü")) TAG ikl OF &sss
         INDEX ON sch TAG sch OF &sss
         INDEX ON unn TAG unn OF &sss
         IF pr_setev
              USE skl
              SET ORDER TO kkl
         ENDIF
    CASE ch2=4
         IF pr_setev
              USE skl EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev
              USE skl
              SET ORDER TO kkl
         ENDIF
    ENDCASE
CASE ch3=11
    IF ALIAS()#'KREDIT'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE kredit
         ELSE
              USE kredit EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE kredit EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('kredit.dbf'),LEN(FULLPATH('kredit.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON kp+dog TAG kp_dog OF &sss
    IF pr_setev.AND.!pr_f
         USE kredit
         SET ORDER TO kp_dog
    ENDIF
    IF pr_f
         USE
    ENDIF
CASE ch3=12
    SELECT sprrab
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "sprrab","tab","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "sprrab","tab","*****",tek_b_13
         ENDIF
         IF pr_setev
              USE sprrab EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('sprrab.dbf'),LEN(FULLPATH('sprrab.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON tab TAG tab OF &sss
         INDEX ON tbn TAG sprrab OF &sss
         INDEX ON fio TAG fio OF &sss
         INDEX ON cex+STR(tbn,6) TAG sprrab2 OF &sss
         IF pr_setev
              USE sprrab
              SET ORDER TO tab
         ENDIF
    CASE ch2=4
         IF pr_setev
              USE sprrab EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev
              USE sprrab
              SET ORDER TO tab
         ENDIF
    ENDCASE
CASE ch3=13
    IF ALIAS()#'AVOT'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE avot
         ELSE
              USE avot EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE avot EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "avot","nvx","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "avot","nvx","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('avot.dbf'),LEN(FULLPATH('avot.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON nrd TAG avot OF &sss
         INDEX ON kp+nrd TAG avot1 OF &sss
         INDEX ON bs+kp+nrd+kor TAG bs_kp OF &sss
         INDEX ON uni TAG uni OF &sss
         IF pr_setev.AND.!pr_f
              USE avot
              SET ORDER TO avot1
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE avot
              SET ORDER TO avot1
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=14
    IF ALIAS()#'AVOTR'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE avotr
         ELSE
              USE avotr EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE avotr EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "avotr","nvx","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "avotr","nvx","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('avotr.dbf'),LEN(FULLPATH('avotr.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON nvx TAG nrd OF &sss
         INDEX ON tab+nrd TAG avotr1 OF &sss
         INDEX ON bs+tab+nrd TAG bs_tab OF &sss
         INDEX ON bs+tab+nvx TAG bs_nvx OF &sss
         INDEX ON nzk TAG nzk OF &sss
         IF pr_setev.AND.!pr_f
              USE avotr
              SET ORDER TO avotr1
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE avotr
              SET ORDER TO avotr1
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=15
    IF ALIAS()#'OSDKOM'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE osdkom
         ELSE
              USE osdkom EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE osdkom EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "osdkom","nvx","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "osdkom","nvx","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('osdkom.dbf'),LEN(FULLPATH('osdkom.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON nrd TAG osdkom OF &sss
         INDEX ON kp+nrd TAG kp_nrd OF &sss
         INDEX ON bs+kp+nrd+kor TAG bs_kp OF &sss
         INDEX ON uni TAG uni OF &sss
         IF pr_setev.AND.!pr_f
              USE osdkom
              SET ORDER TO kp_nrd
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE osdkom
              SET ORDER TO kp_nrd
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=16
    IF ALIAS()#'OSTRK'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE ostrk
         ELSE
              USE ostrk EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE ostrk EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "ostrk","tab","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "ostrk","tab","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('ostrk.dbf'),LEN(FULLPATH('ostrk.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON bs+tab TAG bs_tab OF &sss
         IF pr_setev.AND.!pr_f
              USE ostrk
              SET ORDER TO bs_tab
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE ostrk
              SET ORDER TO bs_tab
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=17
    IF FILE('MATR.DBF')
         IF ALIAS()#'MATR'
              pr_f=.T.
              SELECT 0
              IF ch2=1
                   USE matr
              ELSE
                   USE matr EXCLUSIVE
              ENDIF
         ELSE
              pr_f=.F.
              IF pr_setev
                   USE matr EXCLUSIVE
              ENDIF
         ENDIF
         @ 1,8 SAY ALIAS()
         DO CASE
         CASE ch2=1
              DO Copyr WITH "matr","mat","*****",tek_b_13
         CASE ch2=2.OR.ch2=3
              IF ch2=2
                   DO Vosstr WITH "matr","mat","*****",tek_b_13
              ENDIF
              sss=STUFF(FULLPATH('matr.dbf'),LEN(FULLPATH('matr.dbf'))-2,3,'CDX')
              DELETE TAG ALL
              INDEX ON nam TAG nam OF &sss
              INDEX ON mat TAG mat OF &sss
              INDEX ON bs+mat TAG bs_mat OF &sss
              IF pr_setev.AND.!pr_f
                   USE matr
                   SET ORDER TO mat
              ENDIF
         CASE ch2=4
              PACK
              IF pr_setev.AND.!pr_f
                   USE matr
                   SET ORDER TO mat
              ENDIF
         ENDCASE
         IF pr_f
              USE
         ENDIF
    ENDIF
CASE ch3=18
    IF ALIAS()#'OSDKOM1'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE osdkom1
         ELSE
              USE osdkom1 EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE osdkom1 EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "osdkom1","kp","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "osdkom1","kp","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('osdkom1.dbf'),LEN(FULLPATH('osdkom1.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON nrd TAG osdkom OF &sss
         INDEX ON kp+nrd TAG kp_nrd OF &sss
         INDEX ON bs+kp+nrd+kor TAG bs_kp OF &sss
         INDEX ON nvx TAG nvx OF &sss
         INDEX ON kp+nvx TAG kp_nvx OF &sss
         INDEX ON uni TAG uni OF &sss
         IF pr_setev.AND.!pr_f
              USE osdkom1
              SET ORDER TO kp_nrd
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE osdkom1
              SET ORDER TO kp_nrd
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=19
    SELECT spr_reg
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "spr_reg","nam","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "spr_reg","nam","*****",tek_b_13
         ENDIF
         IF pr_setev
              USE spr_reg EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('spr_reg.dbf'),LEN(FULLPATH('spr_reg.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON kod TAG kod OF &sss
         IF pr_setev
              USE spr_reg
              SET ORDER TO kod
         ENDIF
    CASE ch2=4
         IF pr_setev
              USE spr_reg EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev
              USE spr_reg
              SET ORDER TO kod
         ENDIF
    ENDCASE
CASE ch3=20
    IF ALIAS()#'OSD_79'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE osd_79
         ELSE
              USE osd_79 EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE osd_79 EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "osd_79","kp","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "osd_79","kp","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('osd_79.dbf'),LEN(FULLPATH('osd_79.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON bs+nsk TAG nsk OF &sss
         IF pr_setev.AND.!pr_f
              USE osd_79
              SET ORDER TO nsk
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE osd_79
              SET ORDER TO nsk
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
 CASE ch3=21
    IF ALIAS()#'ATOT'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE atot
         ELSE
              USE atot EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE atot EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "atot","nvx","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "atot","nvx","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('atot.dbf'),LEN(FULLPATH('atot.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON nrd TAG avot OF &sss
         INDEX ON kp+nrd TAG avot1 OF &sss
         INDEX ON bs+kp+nrd+kor TAG bs_kp OF &sss
         INDEX ON nvx TAG nvx OF &sss
         INDEX ON kp+nvx TAG kp_nvx OF &sss
         INDEX ON bs+kp+nvx+kor TAG bs_kp_nvx OF &sss
         INDEX ON uni TAG uni OF &sss
         IF pr_setev.AND.!pr_f
              USE atot
              SET ORDER TO avot1
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE atot
              SET ORDER TO avot1
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
 CASE ch3=22
    IF ALIAS()#'VN_71'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE vn_71
         ELSE
              USE vn_71 EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE vn_71 EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "vn_71","nrd","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "vn_71","nrd","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('vn_71.dbf'),LEN(FULLPATH('vn_71.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON nrd TAG nrd OF &sss
         INDEX ON bs+tabo TAG bs_tabo OF &sss
         INDEX ON bs+tabp TAG bs_tabp OF &sss
         IF pr_setev.AND.!pr_f
              USE vn_71
              SET ORDER TO nrd
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE vn_71
              SET ORDER TO nrd
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
 CASE ch3=23
    IF ALIAS()#'SPR_VID'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE spr_vid
         ELSE
              USE spr_vid EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE spr_vid EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "spr_vid","form","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "spr_vid","form","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('spr_vid.dbf'),LEN(FULLPATH('spr_vid.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON kod+STR(npp,3) TAG kod OF &sss
         IF pr_setev.AND.!pr_f
              USE spr_vid
              SET ORDER TO kod
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE spr_vid
              SET ORDER TO kod
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=24
    IF nastf_8=0
         IF ALIAS()#'SPR_VAL'
              pr_f=.T.
              SELECT 0
              IF ch2=1
                   USE spr_val
              ELSE
                   USE spr_val EXCLUSIVE
              ENDIF
         ELSE
              pr_f=.F.
              IF pr_setev
                   USE spr_val EXCLUSIVE
              ENDIF
         ENDIF
    ELSE
         SELECT spr_val
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "spr_val","kod","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "spr_val","kod","*****",tek_b_13
         ENDIF
         IF nastf_8=1.AND.pr_setev
              USE spr_val EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('spr_val.dbf'),LEN(FULLPATH('spr_val.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON kod TAG kod OF &sss
         IF pr_setev.AND.(nastf_8=1.OR.!pr_f)
              USE spr_val
              SET ORDER TO kod
         ENDIF
    CASE ch2=4
         IF nastf_8=1.AND.pr_setev
              USE spr_val EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev.AND.(nastf_8=1.OR.!pr_f)
              USE spr_val
              SET ORDER TO kod
         ENDIF
    ENDCASE
    IF nastf_8=0.AND.pr_f
         USE
    ENDIF
 CASE ch3=25
    IF nastf_8=0
         IF ALIAS()#'KURS_VAL'
              pr_f=.T.
              SELECT 0
              IF ch2=1
                   USE kurs_val
              ELSE
                   USE kurs_val EXCLUSIVE
              ENDIF
         ELSE
              pr_f=.F.
              IF pr_setev
                   USE kurs_val EXCLUSIVE
              ENDIF
         ENDIF
    ELSE
         SELECT kurs_val
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "kurs_val","kod","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "kurs_val","kod","*****",tek_b_13
         ENDIF
         IF nastf_8=1.AND.pr_setev
              USE kurs_val EXCLUSIVE
         ENDIF
         sss=STUFF(FULLPATH('kurs_val.dbf'),LEN(FULLPATH('kurs_val.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON kod+DTOC(datn,1) TAG kod OF &sss
         IF pr_setev.AND.(nastf_8=1.OR.!pr_f)
              USE kurs_val
              SET ORDER TO kod
         ENDIF
    CASE ch2=4
         IF pr_setev
              USE kurs_val EXCLUSIVE
         ENDIF
         PACK
         IF pr_setev.AND.(nastf_8=1.OR.!pr_f)
              USE kurs_val
              SET ORDER TO kod
         ENDIF
    ENDCASE
    IF nastf_8=0.AND.pr_f
         USE
    ENDIF
CASE ch3=26
    IF ALIAS()#'LIM_NSK'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE lim_nsk
         ELSE
              USE lim_nsk EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE lim_nsk EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "lim_nsk","nsk","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "lim_nsk","nsk","*****",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('lim_nsk.dbf'),LEN(FULLPATH('lim_nsk.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON kp+nrd+kor+nzk+vo+DTOC(dat,1) TAG kp_nrd OF &sss
         INDEX ON nsk TAG nsk OF &sss
         IF pr_setev.AND.!pr_f
              USE lim_nsk
              SET ORDER TO kp_nrd
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE lim_nsk
              SET ORDER TO kp_nrd
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=27
    IF ALIAS()#'SPR_KART'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE spr_kart
         ELSE
              USE spr_kart EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE spr_kart EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('spr_kart.dbf'),LEN(FULLPATH('spr_kart.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON kod TAG kod OF &sss
    IF pr_setev.AND.!pr_f
         USE spr_kart
         SET ORDER TO kod
    ENDIF
    IF pr_f
         USE
    ENDIF
CASE ch3=28
    IF ALIAS()#'YD_71'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE yd_71
         ELSE
              USE yd_71 EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         USE yd_71 EXCLUSIVE
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "yd_71","tbn","******",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "yd_71","tbn","******",tek_b_13
         ENDIF
         sss=STUFF(FULLPATH('yd_71.dbf'),LEN(FULLPATH('yd_71.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON bs+tbn TAG bs_tbn OF &sss
         IF pr_setev.AND.!pr_f
              USE yd_71
              SET ORDER TO bs_tbn
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE yd_71
              SET ORDER TO bs_tbn
         ENDIF
    ENDCASE
    IF pr_f
         USE
	ELSE
         USE yd_71
         SET ORDER TO bs_tbn
    ENDIF
CASE ch3=29
    IF ALIAS()#'FORM_OT'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE form_ot
         ELSE
              USE form_ot EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE form_ot EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "form_ot","text","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "form_ot","text","*****",tek_b_13
         ENDIF
         DELETE TAG ALL
         INDEX ON nf+npp TAG nf_npp
         IF pr_setev.AND.!pr_f
              USE form_ot
              SET ORDER TO nf_npp
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE form_ot
              SET ORDER TO nf_npp
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=30
    IF ALIAS()#'RAZM_OT'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE razm_ot
         ELSE
              USE razm_ot EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE razm_ot EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "razm_ot","nam","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "razm_ot","nam","*****",tek_b_13
         ENDIF
         DELETE TAG ALL
         INDEX ON nf+npp TAG nf_npp
         IF pr_setev.AND.!pr_f
              USE razm_ot
              SET ORDER TO nf_npp
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE razm_ot
              SET ORDER TO nf_npp
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=31
    IF ALIAS()#'DV_79'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE dv_79
         ELSE
              USE dv_79 EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE dv_79 EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "dv_79","ko","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "dv_79","ko","*****",tek_b_13
         ENDIF
         DELETE TAG ALL
         INDEX ON bs+ko+kp+nrd TAG ko_kp
         INDEX ON bs+kp+ko+nrd TAG kp_ko
         INDEX ON bs+nrd TAG nrd
         INDEX ON summa TAG summa
         IF pr_setev.AND.!pr_f
              USE dv_79
              SET ORDER TO ko_kp
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE dv_79
              SET ORDER TO ko_kp
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=32
    IF ALIAS()#'DV79_ARC'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE dv79_arc
         ELSE
              USE dv79_arc EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE dv79_arc EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "dv79_arc","ko","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "dv79_arc","ko","*****",tek_b_13
         ENDIF
         DELETE TAG ALL
         INDEX ON bs+ko+kp+nrd TAG ko_kp
         INDEX ON bs+kp+ko+nrd TAG kp_ko
         INDEX ON bs+nrd TAG nrd
         INDEX ON summa TAG summa
         IF pr_setev.AND.!pr_f
              USE dv79_arc
              SET ORDER TO ko_kp
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE dv79_arc
              SET ORDER TO ko_kp
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=33
    IF ALIAS()#'DV_DP'
         pr_f=.T.
         SELECT 0
         IF ch2=1
              USE dv_dp
         ELSE
              USE dv_dp EXCLUSIVE
         ENDIF
    ELSE
         pr_f=.F.
         IF pr_setev
              USE dv_dp EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    DO CASE
    CASE ch2=1
         DO Copyr WITH "dv_dp","tab","*****",tek_b_13
    CASE ch2=2.OR.ch2=3
         IF ch2=2
              DO Vosstr WITH "dv_dp","tab","*****",tek_b_13
         ENDIF
         DELETE TAG ALL
         INDEX ON bs+tab+DTOC(dat,1)+nrd TAG tab
         INDEX ON bs+god+ms+tab+DTOC(dat,1)+nrd TAG god
         IF pr_setev.AND.!pr_f
              USE dv_dp
              SET ORDER TO tab
         ENDIF
    CASE ch2=4
         PACK
         IF pr_setev.AND.!pr_f
              USE dv_dp
              SET ORDER TO tab
         ENDIF
    ENDCASE
    IF pr_f
         USE
    ENDIF
CASE ch3=34
    IF FILE('KODZK.DBF')
         IF ALIAS()#'KODZK'
              pr_f=.T.
              SELECT 0
              IF ch2=1
                   USE kodzk
              ELSE
                   USE kodzk EXCLUSIVE
              ENDIF
         ELSE
              pr_f=.F.
              IF pr_setev
                   USE kodzk EXCLUSIVE
              ENDIF
         ENDIF
         @ 1,8 SAY ALIAS()
         DO CASE
         CASE ch2=1
              DO Copyr WITH "kodzk","nzk","*****",tek_b_13
         CASE ch2=2.OR.ch2=3
              IF ch2=2
                   DO Vosstr WITH "kodzk","nzk","*****",tek_b_13
              ENDIF
              sss=STUFF(FULLPATH('kodzk.dbf'),LEN(FULLPATH('kodzk.dbf'))-2,3,'CDX')
              INDEX ON nzk TAG kodzk OF &sss
              INDEX ON nam TAG nam OF &sss
              IF pr_setev.AND.!pr_f
                   USE kodzk
                   SET ORDER TO kodzk
              ENDIF
         CASE ch2=4
              PACK
              IF pr_setev.AND.!pr_f
                   USE kodzk
                   SET ORDER TO kodzk
              ENDIF
         ENDCASE
         IF pr_f
              USE
         ENDIF
    ENDIF
CASE ch3=39
    IF ALIAS()#'SUPAVOT'
         pr_f=.T.
         SELECT 0
         USE supavot EXCLUSIVE
    ELSE
         pr_f=.F.
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('supavot.dbf'),LEN(FULLPATH('supavot.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON bs+kp+nrd TAG bs_kp OF &sss
    IF pr_f
         USE
    ENDIF
CASE ch3=40
    IF ALIAS()#'DV_KP'
         pr_f=.T.
         SELECT 0
         USE dv_kp EXCLUSIVE
    ELSE
         pr_f=.F.
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('dv_kp.dbf'),LEN(FULLPATH('dv_kp.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON nrd+kor TAG nrd_kor OF &sss
    INDEX ON DTOC(dat,1)+nrd TAG dat_nrd OF &sss
    INDEX ON DTOC(dat,1)+nvx TAG dat_nvx OF &sss
    IF pr_f
         USE
    ENDIF
CASE ch3=41
    IF ALIAS()#'OSD_PRR'
         pr_f=.T.
         SELECT 0
         USE osd_prr EXCLUSIVE
    ELSE
         pr_f=.F.
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('osd_prr.dbf'),LEN(FULLPATH('osd_prr.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON kp TAG kp OF &sss
    INDEX ON kp+dog TAG kp_dog OF &sss
    INDEX ON bs+kp+dog TAG bs_kp OF &sss
    IF pr_f
         USE
    ENDIF
CASE ch3=42
    IF FILE('DV_MOL.DBF')
         IF ALIAS()#'DV_MOL'
              pr_f=.T.
              SELECT 0
              USE dv_mol EXCLUSIVE
         ELSE
              pr_f=.F.
              IF pr_setev
                   USE dv_mol EXCLUSIVE
              ENDIF
         ENDIF
         @ 1,8 SAY ALIAS()
         sss=STUFF(FULLPATH('dv_mol.dbf'),LEN(FULLPATH('dv_mol.dbf'))-2,3,'CDX')
         DELETE TAG ALL
         INDEX ON vo+nsk+mat+IIF(vo='0',DTOC(dat,1),DTOC(datv,1)) TAG nsk OF &sss
         INDEX ON vo+nrd TAG kp OF &sss
         INDEX ON vo+pr_spr+kp+mat TAG kp_mat OF &sss
         INDEX ON vo+pr_spr+nsk+kp+mat TAG kp_vn OF &sss
         IF pr_setev.AND.!pr_f
              USE dv_mol
              SET ORDER TO nsk
         ENDIF
         IF pr_f
              USE
         ENDIF
    ENDIF
CASE ch3=43
    IF ALIAS()#'SPR_LIM'
         pr_f=.T.
         SELECT 0
         USE spr_lim EXCLUSIVE
    ELSE
         pr_f=.F.
         IF pr_setev
              USE spr_lim EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('spr_lim.dbf'),LEN(FULLPATH('spr_lim.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON kod TAG lim OF &sss
    IF pr_setev.AND.!pr_f
         USE spr_lim
         SET ORDER TO lim
    ENDIF
    IF pr_f
         USE
    ENDIF
CASE ch3=44
    IF ALIAS()#'SCHR'
         pr_f=.T.
         SELECT 0
         USE schr EXCLUSIVE
    ELSE
         pr_f=.F.
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('schr.dbf'),LEN(FULLPATH('schr.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON nsk TAG sch OF &sss
    IF pr_f
         USE
    ENDIF
CASE ch3=45
    IF ALIAS()#'AVOTRR'
         pr_f=.T.
         SELECT 0
         USE avotrr EXCLUSIVE
    ELSE
         pr_f=.F.
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('avotrr.dbf'),LEN(FULLPATH('avotrr.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON tab+nrd TAG avotr1 OF &sss
    INDEX ON bs+tab+nrd TAG bs_tab OF &sss
    IF pr_f
         USE
    ENDIF
CASE ch3=46
    IF ALIAS()#'DV_PRR'
         pr_f=.T.
         SELECT 0
         USE dv_prr EXCLUSIVE
    ELSE
         pr_f=.F.
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('dv_prr.dbf'),LEN(FULLPATH('dv_prr.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON dog TAG dog OF &sss
    INDEX ON kp+dog TAG kp_dog OF &sss
    INDEX ON bs+kp+dog TAG bs_kp OF &sss
    IF pr_f
         USE
    ENDIF
CASE ch3=47
    IF ALIAS()#'OSTRKR'
         pr_f=.T.
         SELECT 0
         USE ostrkr EXCLUSIVE
    ELSE
         pr_f=.F.
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('ostrkr.dbf'),LEN(FULLPATH('ostrkr.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON bs+tab TAG bs_tab OF &sss
    IF pr_f
         USE
    ENDIF
CASE ch3=48
    IF ALIAS()#'BKR'
         pr_f=.T.
         SELECT 0
         USE bkr EXCLUSIVE
    ELSE
         pr_f=.F.
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('bkr.dbf'),LEN(FULLPATH('bkr.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON kp+pr_spr+nrd+kor TAG kp_pr OF &sss
    INDEX ON kp+nrd+kor TAG kp OF &sss
    INDEX ON kp+DTOC(dat,1)+nrd+kor TAG kp_dat OF &sss
    INDEX ON nzk+STR(VAL(vo),1)+STR(smo,15,2)+nrd TAG nzk OF &sss
    IF pr_f
         USE
    ENDIF
CASE ch3=49
    IF ALIAS()#'OSDKOMR'
         pr_f=.T.
         SELECT 0
         USE osdkomr EXCLUSIVE
    ELSE
         pr_f=.F.
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('osdkomr.dbf'),LEN(FULLPATH('osdkomr.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON bs+kp+nrd+kor TAG bs_kp OF &sss
    INDEX ON bs+kp+dog TAG kp_dog OF &sss
    INDEX ON bs+kp+pr_spr TAG kp_pr OF &sss
    INDEX ON pr_spr+kp TAG kp OF &sss
    IF pr_f
         USE
    ENDIF
CASE ch3=50
    IF ALIAS()#'BK_ARC'
         pr_f=.T.
         SELECT 0
         USE bk_arc EXCLUSIVE
    ELSE
         pr_f=.F.
         IF pr_setev
              USE bk_arc EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('bk_arc.dbf'),LEN(FULLPATH('bk_arc.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON nzk+nrd     TAG nrd OF &sss
    INDEX ON nzk+kp+nrd  TAG nzk_kp OF &sss
    INDEX ON nzk+STR(sm,15,2) TAG summa OF &sss
    INDEX ON nzk+DTOC(dat,1) TAG datd OF &sss
    INDEX ON kp+nrd      TAG kp OF &sss
    IF pr_setev.AND.!pr_f
         USE bk_arc
         SET ORDER TO kp
    ENDIF
    IF pr_f
         USE
    ENDIF
CASE ch3=51.AND.nastf_h=1
    IF ALIAS()#'TRAN_OPL'
         pr_f=.T.
         SELECT 0
         USE tran_opl EXCLUSIVE
    ELSE
         pr_f=.F.
         IF pr_setev
              USE tran_opl EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('tran_opl.dbf'),LEN(FULLPATH('tran_opl.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON STR(uni,7)+DTOC(dat,1)+nrd TAG uni OF &sss
    IF pr_setev.AND.!pr_f
         USE tran_opl
         SET ORDER TO uni
    ENDIF
    IF pr_f
         USE
    ENDIF
CASE ch3=52.AND.nastf_h=1
    IF ALIAS()#'TRAN_POS'
         pr_f=.T.
         SELECT 0
         USE tran_pos EXCLUSIVE
    ELSE
         pr_f=.F.
         IF pr_setev
              USE tran_pos EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('tran_pos.dbf'),LEN(FULLPATH('tran_pos.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON STR(uni,7)+DTOC(dat,1)+nrd TAG uni OF &sss
    IF pr_setev.AND.!pr_f
         USE tran_pos
         SET ORDER TO uni
    ENDIF
    IF pr_f
         USE
    ENDIF
CASE ch3=53
    IF ALIAS()#'SPR_NRD'
         pr_f=.T.
         SELECT 0
         USE spr_nrd EXCLUSIVE
    ELSE
         pr_f=.F.
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('spr_nrd.dbf'),LEN(FULLPATH('spr_nrd.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON bs+vo+STR(nrd,6) TAG nrd OF &sss
    IF pr_f
         USE
    ENDIF
CASE ch3=54
    IF ALIAS()#'KAS_71'
         pr_f=.T.
         SELECT 0
         USE kas_71 EXCLUSIVE
    ELSE
         pr_f=.F.
         USE kas_71 EXCLUSIVE
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('kas_71.dbf'),LEN(FULLPATH('kas_71.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON bs+tbn TAG bs_tbn OF &sss
    IF pr_f
         USE
	ELSE
         USE kas_71
         SET ORDER TO bs_tbn
    ENDIF
 CASE ch3=56
    IF ALIAS()#'ATOT_ARC'
         pr_f=.T.
         SELECT 0
         USE atot_arc EXCLUSIVE
    ELSE
         pr_f=.F.
         IF pr_setev
              USE atot_arc EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('atot_arc.dbf'),LEN(FULLPATH('atot_arc.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON nvx           TAG nvx OF &sss
    INDEX ON kp+nvx        TAG kp_nrd OF &sss
    INDEX ON bs+kp+nvx+kor TAG bs_kp_nvx OF &sss
    IF pr_f
         USE
    ELSE
         IF pr_setev
              USE atot_arc
              SET ORDER TO kp_nrd
         ENDIF
    ENDIF
CASE ch3=57
    IF ALIAS()#'AVOT_ARC'
         pr_f=.T.
         SELECT 0
         USE avot_arc EXCLUSIVE
    ELSE
         pr_f=.F.
         IF pr_setev
              USE avot_arc EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('avot_arc.dbf'),LEN(FULLPATH('avot_arc.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON nrd           TAG nrd OF &sss
    INDEX ON kp+nrd        TAG kp_nrd OF &sss
    INDEX ON bs+kp+nrd+kor TAG bs_kp OF &sss
    IF pr_f
         USE
    ELSE
         IF pr_setev
              USE avot_arc
              SET ORDER TO kp_nrd
         ENDIF
    ENDIF
CASE ch3=58
    IF ALIAS()#'AVTR_ARC'
         pr_f=.T.
         SELECT 0
         USE avtr_arc EXCLUSIVE
    ELSE
         pr_f=.F.
         IF pr_setev
              USE avtr_arc EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('avtr_arc.dbf'),LEN(FULLPATH('avtr_arc.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON nvx TAG nrd OF &sss
    INDEX ON bs+tab+nrd TAG bs_tab OF &sss
    IF pr_f
         USE
    ELSE
         IF pr_setev
              USE avtr_arc
              SET ORDER TO bs_tab
         ENDIF
    ENDIF
CASE ch3=59
    IF ALIAS()#'DVPR_ARC'
         pr_f=.T.
         SELECT 0
         USE dvpr_arc EXCLUSIVE
    ELSE
         pr_f=.F.
         IF pr_setev
              USE dvpr_arc EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('dvpr_arc.dbf'),LEN(FULLPATH('dvpr_arc.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON dog    TAG dog OF &sss
    INDEX ON kp+dog TAG kp_dog OF &sss
    IF pr_f
         USE
    ELSE
         IF pr_setev
              USE dvpr_arc
              SET ORDER TO kp_dog
         ENDIF
    ENDIF
CASE ch3=60
    IF ALIAS()#'SPR_OSN'
         pr_f=.T.
         SELECT 0
         USE spr_osn EXCLUSIVE
    ELSE
         pr_f=.F.
         IF pr_setev
              USE spr_osn EXCLUSIVE
         ENDIF
    ENDIF
    @ 1,8 SAY ALIAS()
    sss=STUFF(FULLPATH('spr_osn.dbf'),LEN(FULLPATH('spr_osn.dbf'))-2,3,'CDX')
    DELETE TAG ALL
    INDEX ON nvx           TAG nvx OF &sss
    INDEX ON kp+nvx        TAG kp_nvx OF &sss
    INDEX ON kp+nrd        TAG avot1 OF &sss
    IF pr_f
         USE
    ELSE
         IF pr_setev
              USE spr_osn
              SET ORDER TO kp_nvx
         ENDIF
    ENDIF
ENDCASE
IF set_devi
     SET DEVICE TO PRINT
ENDIF
RELEASE WINDOW Zapros
RELEASE ALL LIKE tek_b_??
RETURN