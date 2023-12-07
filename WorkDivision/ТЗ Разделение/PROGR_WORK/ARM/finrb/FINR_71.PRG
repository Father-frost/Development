gfbs='    '
gfdat=DATE()
gfnrd='      '
gftab='      '
DEFINE POPUP Finr_71 FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Finr_71 PROMPT " В\<едение справочников    "
DEFINE BAR 2 OF Finr_71 PROMPT "\-"
DEFINE BAR 3 OF Finr_71 PROMPT " В\<ходная информация      "
DEFINE BAR 4 OF Finr_71 PROMPT "\-"
DEFINE BAR 5 OF Finr_71 PROMPT " Пе\<реход к след.месяцу   "
DEFINE BAR 6 OF Finr_71 PROMPT "\-"
DEFINE BAR 7 OF Finr_71 PROMPT " В\<ыходные формы          "
ON SELECTION POPUP Finr_71 DO Finr_71 WITH BAR()
SET PROCEDURE TO Proc_71
ACTIVATE POPUP Finr_71 BAR 3
SET PROCEDURE TO Procgol
RETURN
*
PROCEDURE Finr_71
PARAMETERS chg15
*
DEFINE POPUP Spr_71 FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Spr_71 PROMPT " Р\<аботники     "
IF FILE('KODZK.DBF')
	DEFINE BAR 2 OF Spr_71 PROMPT ' \<'+nastf_s
ENDIF
ON SELECTION POPUP Spr_71 DO Spr_71 WITH BAR()
*
DEFINE POPUP Vx_71 FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vx_71 PROMPT " О\<боpот по работнику     "
DEFINE BAR 2 OF Vx_71 PROMPT " А\<вансовые отчеты        "
DEFINE BAR 3 OF Vx_71 PROMPT " О\<статки по работнику    "
DEFINE BAR 4 OF Vx_71 PROMPT " В\<нутpення пеpедача      "
DEFINE BAR 5 OF Vx_71 PROMPT " А\<рхив авансовых отчетов "
ON SELECTION POPUP Vx_71 DO Vx_71 WITH BAR()
*
DEFINE POPUP Vyx_71 FROM 9,40 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vyx_71 PROMPT " О\<боротная ведомость по работникам "
DEFINE BAR 2 OF Vyx_71 PROMPT "     Ре\<естр авансовых отчетов      "
DEFINE BAR 3 OF Vyx_71 PROMPT "      С\<вод по подpазделениям       "
DEFINE BAR 4 OF Vyx_71 PROMPT "       И\<нформация по налогам       "
DEFINE BAR 5 OF Vyx_71 PROMPT "      П\<росмотр выходных форм       "
ON SELECTION POPUP Vyx_71 DO Vyxfkr WITH BAR()
*
DO CASE
CASE chg15=1
    ACTIVATE POPUP Spr_71
CASE chg15=3
    RESTORE FROM tek_b ADDITIVE
    ACTIVATE POPUP Vx_71
CASE chg15=5
    DEFINE WINDOW Zapros FROM 10,17 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    key=2
    @ 0,1 SAY "Выполняется переход к следующему месяцу."
    @ 1,1 SAY "Вы уверены ?"
    @ 1,21 PROMPT " Да  "
    @ 1,31 PROMPT " Hет "
    MENU TO key
    RELEASE WINDOW Zapros
    IF key=1
         DO Perex71
    ENDIF
CASE chg15=7
    ACTIVATE POPUP Vyx_71
ENDCASE
RETURN
*
PROCEDURE Spr_71
PARAMETERS chspr
HIDE POPUP ALL
DO CASE
CASE chspr=1
    SELECT sprrab
    DO Vvodn WITH "Chapsr","Strsaysr","Strgetsr",.T.,.T.,.T.,.T.,".F.","",;
         "F2sr","F3sr","F4sr","","","","","","F10sr","",.T.
CASE chspr=2
    SELECT 0
    USE kodzk
    SET ORDER TO kodzk
    DO Vvodn WITH "Chapzk","Strsayzk","Strgetzk",.T.,.T.,.T.,.F.,".F.","",;
                  "F2zk","","","","","","","","","",.T.
    USE
ENDCASE
SHOW POPUP Glavn,Proch,Finr_71,Spr_71
RETURN
*
PROCEDURE Vx_71
PARAMETERS chs
DO CASE
CASE chs=1
    DEFINE WINDOW Zapros FROM 16,39 TO 18,62 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    RESTORE FROM tek_b ADDITIVE
    ffbs=IIF(EMPTY(AT(',',tek_b_24,1)),LEFT(tek_b_24,4),LEFT(LEFT(tek_b_24,AT(',',tek_b_24,1)-1)+'    ',4))
    RELEASE ALL LIKE tek_b_??
    @ 0,0 SAY " Hомер счета...." GET ffbs VALID Poisk_sc('ffbs',.T.,.F.,0,0,0,'71','.F.') ERROR 'Hет такого счета...'
    READ
    RELEASE WINDOW Zapros
    IF LASTKEY()=27.AND.READKEY()#271
         RETURN
    ENDIF
    ACTIVATE WINDOW Pog_p
    SET COLOR TO &color15
    @ 0,0 SAY '░'
    SET COLOR TO &color13
    @ 0,1 SAY "Пожалуйста, подождите..."
    IF FILE('KODZK.DBF')
         SELECT 0
         USE kodzk
         SET ORDER TO kodzk
    ENDIF
    tgod=1900+VAL(nastf_b)
    SELECT 0
    USE ostrkr EXCLUSIVE
    SET ORDER TO bs_tab
    ZAP
    SET DELETED ON
    APPEND FROM ostrk FOR bs=ffbs
    SET DELETED OFF
    SELECT bk
    SET ORDER TO bk2
    SET EXACT OFF
    SEEK ffbs
    SET EXACT ON
    SCAN REST WHILE kor=ffbs FOR MONTH(dat)=ntmec.AND.YEAR(dat)=tgod.AND.pr_spr='0'.AND.!DELETE()
         SELECT ostrkr
         IF !SEEK(bk.kor+LEFT(bk.kp,6))
              APPEND BLANK
              REPLACE tab WITH LEFT(bk.kp,6),bs WITH bk.kor
         ENDIF
         IF bk.vo='0'
              REPLACE smk WITH smk+bk.sm
         ELSE
              REPLACE smd WITH smd+bk.sm
         ENDIF
    ENDSCAN
    SET ORDER TO kp
    SET EXACT OFF
    SEEK ffbs
    SET EXACT ON
    SCAN REST WHILE nzk=ffbs FOR MONTH(dat)=ntmec.AND.YEAR(dat)=tgod.AND.pr_spr='0'.AND.!DELETE()
         SELECT ostrkr
         IF !SEEK(bk.nzk+LEFT(bk.kp,6))
              APPEND BLANK
              REPLACE tab WITH LEFT(bk.kp,6),bs WITH bk.kor
         ENDIF
         IF bk.vo='1'
              REPLACE smk WITH smk+bk.sm
         ELSE
              REPLACE smd WITH smd+bk.sm
         ENDIF
    ENDSCAN
    SELECT 0
    USE vn_71
    SET ORDER TO bs_tabo
    SET EXACT OFF
    SEEK ffbs
    SET EXACT ON
    SCAN REST WHILE bs=ffbs FOR !DELETE()
         SELECT ostrkr
         IF !SEEK(vn_71.bs+vn_71.tabo)
              APPEND BLANK
              REPLACE tab WITH vn_71.tabo,bs WITH vn_71.bs
         ENDIF
         REPLACE smk WITH smk+vn_71.summa
         IF !SEEK(vn_71.bs+vn_71.tabp)
              APPEND BLANK
              REPLACE tab WITH vn_71.tabp,bs WITH vn_71.bs
         ENDIF
         REPLACE smd WITH smd+vn_71.summa
    ENDSCAN
    SELECT 0
    USE avotr
    SET ORDER TO bs_tab
    SET EXACT OFF
    SEEK ffbs
    SET EXACT ON
    SCAN REST WHILE bs=ffbs FOR !DELETE()
         SELECT ostrkr
         IF !SEEK(avotr.bs+avotr.tab)
              APPEND BLANK
              REPLACE tab WITH avotr.tab,bs WITH avotr.bs
         ENDIF
         REPLACE smk WITH smk+avotr.smk
    ENDSCAN
    SELECT 0
    USE yd_71
    SET ORDER TO bs_tbn
    SET EXACT OFF
    SEEK ffbs
    SET EXACT ON
    SCAN REST WHILE bs=ffbs FOR symk#0.AND.!DELETE()
         SELECT ostrkr
         IF !SEEK(yd_71.bs+yd_71.tbn)
              APPEND BLANK
              REPLACE tab WITH yd_71.tbn,bs WITH yd_71.bs
         ENDIF
         IF yd_71.symk>0
              REPLACE smk WITH smk+yd_71.symk
         ELSE
              REPLACE smd WITH smd-yd_71.symk
         ENDIF
    ENDSCAN
    SELECT 0
    USE kas_71
    SET ORDER TO bs_tbn
    SET EXACT OFF
    SEEK ffbs
    SET EXACT ON
    SCAN REST WHILE bs=ffbs FOR symk#0.AND.!DELETE()
         SELECT ostrkr
         IF SEEK(kas_71.bs+kas_71.tbn)
              REPLACE pr_vkl WITH '*'
         ELSE
              SELECT kas_71
              REPLACE symk WITH 0
         ENDIF
    ENDSCAN
    SELECT 0
    USE ostrk
    SET ORDER TO bs_tab
    SELECT ostrkr
    GO TOP
    HIDE WINDOW ALL
    ACTIVATE SCREEN
    HIDE POPUP ALL
    ON KEY LABEL Alt-F9 DO Menu_spr
    DO Vvodn WITH "Chapav","Strsayav","Strgetav",.T.,.F.,.F.,.F.,".F.","",;
         "F2avr","F3av","F4av","F5av","F6av","F7av","","F9av","F10av","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='OSTRKR'
         USE
    ENDIF
    IF Poisk_alia('KODZK')
         USE
    ENDIF
    IF Poisk_alia('AVOTR')
         USE
    ENDIF
    IF Poisk_alia('VN_71')
         USE
    ENDIF
    IF Poisk_alia('OSTRK')
         USE
    ENDIF
    IF Poisk_alia('KAS_71')
         USE
    ENDIF
    IF Poisk_alia('YD_71')
         USE
    ENDIF
CASE chs=2
    IF FILE('KODZK.DBF')
         SELECT 0
         USE kodzk
         SET ORDER TO kodzk
    ENDIF
    SELECT 0
    USE avotr
    SET ORDER TO bs_tab
    gfbs=bs
    HIDE POPUP ALL
    ON KEY LABEL Alt-F9 DO Menu_spr
    DO Vvodn WITH "Chapsv","Strsaysv","Strgetsv",.T.,.T.,.T.,.F.,".F.","",;
         "F2avr","F3sv","F4sv","","F6sv",IIF(nastf_t=0,"",'F7sv'),"","","","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='AVOTR'
         USE
    ENDIF
    IF Poisk_alia('KODZK')
         USE
    ENDIF
CASE chs=3
    SELECT 0
    USE ostrk
    SET ORDER TO bs_tab
    SET RELATION TO tab INTO sprrab
    HIDE POPUP ALL
    ON KEY LABEL Alt-F9 DO Menu_spr
    DO Vvodn WITH "Chapor","Strsayor","Strgetor",.T.,.T.,.T.,.F.,".F.","",;
         "F2avr","","","","","","","","","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='OSTRK'
         USE
    ENDIF
CASE chs=4
    SELECT 0
    USE vn_71
    SET ORDER TO bs_tabo
    gfbs=bs
    gftab=tabo
    HIDE POPUP ALL
    ON KEY LABEL Alt-F9 DO Menu_spr
    DO Vvodn WITH "Chapvn","Strsayvn","Strgetvn",.T.,.T.,.T.,.F.,".F.","",;
         "F2vn","","","","","","","","","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='VN_71'
         USE
    ENDIF
CASE chs=5
    IF FILE('KODZK.DBF')
         SELECT 0
         USE kodzk
         SET ORDER TO kodzk
    ENDIF
    SELECT 0
    USE avtr_arc
    SET ORDER TO bs_tab
    HIDE POPUP ALL
    ON KEY LABEL Alt-F9 DO Menu_spr
    DO Vvodn WITH "Chapsv","Strsayar","",.F.,.F.,.F.,.F.,".F.","","F2avr","F3sv","","","","","","","F10ar","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='AVTR_ARC'
         USE
    ENDIF
    IF Poisk_alia('KODZK')
         USE
    ENDIF
ENDCASE
SHOW POPUP Glavn,Proch,Finr_71,Vx_71
RELEASE ALL LIKE tek_b_??
RETURN
