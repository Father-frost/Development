PARAMETERS ch1
PRIVATE scr,ff2,f_l
SAVE SCREEN TO scr
chg12=0
IF ch1#6
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
    ff2=SPACE(5)
    ff=nastf_u+'  '
    DEFINE WINDOW Zapros FROM 16,40 TO IIF(INLIST(ch1,2,4,5),18,19),66 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " Hомер счета......" GET ff VALID Val_nsch()
    IF ch1=1.OR.ch1=3
         @ 1,0 SAY " Код подразделения" GET ff2 VALID ch1=1.OR.Poisk_ns('ff2',.T.,0,0,0) ERROR 'Hет такого кода...'
    ENDIF
    READ
    RELEASE WINDOW Zapros
    IF ch1=2.AND.LASTKEY()=27.AND.ff=nastf_u+'  '.OR.(ch1=1.OR.ch1=3).AND.LASTKEY()=27.AND.EMPTY(ff2)
         RETURN
    ENDIF
    f_l=LEN(ALLT(ff))
    ACTIVATE WINDOW Pog_p
    SET COLOR TO &color15
    @ 0,0 SAY '░'
    SET COLOR TO &color13
    @ 0,1 SAY "Пожалуйста, подождите..."
    SET DEVICE TO PRINT
ENDIF
SET ESCAPE ON
ON ESCAPE DO Stop_esc
SET DELETED ON
DO CASE
CASE INLIST(ch1,1,2,3,4,5)
    IF INLIST(ch1,2,4,5)
         RESTORE FROM tek_b ADDITIVE
    ENDIF
    SELECT 0
    USE osdkomr EXCLUSIVE
    INDEX ON bs+nsk TAG rab
    ZAP
    APPEND FROM osd_79 FOR bs=ff.AND.(EMPTY(ff2).OR.nsk=ff2)
    SELECT 0
    USE dv_79
    SET ORDER TO ko_kp
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    SCAN REST WHILE bs=ff FOR !DELETE()
         SELECT osdkomr
         IF EMPTY(ff2).OR.dv_79.kp=ff2
              IF !SEEK(ff+dv_79.kp)
                   APPEND BLANK
                   REPLACE nsk WITH dv_79.kp,bs WITH ff
              ENDIF
         ENDIF
         IF EMPTY(ff2).OR.dv_79.ko=ff2
              IF !SEEK(ff+dv_79.ko)
                   APPEND BLANK
                   REPLACE nsk WITH dv_79.ko,bs WITH ff
              ENDIF
         ENDIF
         SELECT dv_79
    ENDSCAN
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
    SELECT 0
    USE lim_nsk
    SET ORDER TO kp_nrd
    SELECT bk
    SET ORDER TO bk2
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    SCAN REST WHILE kor=ff FOR MONTH(dat)=ntmec.AND.!DELETE()
         SELECT lim_nsk
         SEEK bk.kp+bk.nrd+bk.kor+bk.nzk+bk.vo+DTOC(bk.dat,1)
         SCAN REST WHILE kp=bk.kp.AND.nrd=bk.nrd.AND.kor=bk.kor.AND.nzk=bk.nzk.AND.vo=bk.vo.AND.dat=bk.dat FOR !DELETE().AND.(EMPTY(ff2).OR.nsk=ff2)
              SELECT bkr
              APPEND BLANK
              REPLACE nzk WITH bk.nzk,kor WITH bk.kor,nrd WITH bk.nrd,dat WITH bk.dat,;
                   text_1 WITH bk.text_1,sm WITH lim_nsk.summa,vo WITH bk.vo,pr_spr WITH bk.pr_spr,;
                      nsk WITH lim_nsk.nsk,kp WITH bk.kp
              SELECT lim_nsk
         ENDSCAN
         SELECT bk
    ENDSCAN
    SELECT bkr
    INDEX ON kor+nsk TAG rab
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    SCAN REST WHILE kor=ff
         SELECT osdkomr
         IF !SEEK(bkr.kor+bkr.nsk)
              APPEND BLANK
              REPLACE kp WITH bkr.nsk,bs WITH bkr.kor
         ENDIF
         SELECT bkr
    ENDSCAN
    SELECT lim_nsk
    USE
    SELECT osdkomr
    SET EXACT OFF
    SEEK ff
    SET EXACT ON
    @ PROW(),0 SAY &sgat2
    DO CASE
    CASE ch1=1.OR.ch1=2
         DO Oborko_1
    CASE ch1=3
         DO Kart_79
    CASE ch1=4
         DO Svod_79
    CASE ch1=5
         DO Shet_79
    ENDCASE
    SELECT osdkomr
    DELETE TAG rab
    ZAP
    USE
    SELECT dv_79
    USE
    SELECT bkr
    DELETE TAG rab
    ZAP
    USE
    IF INLIST(ch1,2,4,5)
         RELEASE ALL LIKE tek_b_??
    ENDIF
CASE ch1=6
    DO Prvyx
ENDCASE
SET DELETED OFF
SET ESCAPE OFF
SET PROCEDURE TO procgol
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN
*
PROCEDURE Val_nsch
PRIVATE pri,a
pri=0
a=LEN(ALLTRIM(ff))
DO CASE
CASE a=2
    SELECT spr_bs
    SET ORDER TO bs
    SET EXACT OFF
    IF SEEK(ALLTRIM(ff),"spr_bs")
         pri=1
    ELSE
         WAIT "Hет таких счетов !" WINDOW Nowa
    ENDIF
    SET EXACT ON
    SELECT spr_reg
CASE a=4
    IF Poisk_sc('ff',.T.,.F.,0,0,0,'76','.F.'))
         pri=1
    ELSE
         WAIT "Hет такого счета..." WINDOW Nowa
    ENDIF
ENDCASE
RETURN pri
