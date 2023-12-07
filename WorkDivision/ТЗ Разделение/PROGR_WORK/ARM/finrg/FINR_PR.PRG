DEFINE POPUP Finr_pr FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Finr_pr PROMPT " В\<едение справочников    "
DEFINE BAR 2 OF Finr_pr PROMPT "\-"
DEFINE BAR 3 OF Finr_pr PROMPT " В\<ходная информация      "
DEFINE BAR 4 OF Finr_pr PROMPT "\-"
DEFINE BAR 5 OF Finr_pr PROMPT " Пе\<реход к след.месяцу   "
DEFINE BAR 6 OF Finr_pr PROMPT "\-"
DEFINE BAR 7 OF Finr_pr PROMPT " В\<ыходные формы          "
ON SELECTION POPUP Finr_pr DO Finr_pr WITH BAR()
ACTIVATE POPUP Finr_pr BAR 3
RETURN
*
PROCEDURE Finr_pr
PARAMETERS chg15
*
DEFINE POPUP Spr_pr FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Spr_pr PROMPT " О\<рганизации   "
DEFINE BAR 2 OF Spr_pr PROMPT " П\<одpазделения "
ON SELECTION POPUP Spr_pr DO Spr_pr WITH BAR()
*
DEFINE POPUP Vx_pr FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vx_pr PROMPT " О\<боpот по оpганизации   "
DEFINE BAR 2 OF Vx_pr PROMPT " Д\<вижение по оpганизации "
DEFINE BAR 3 OF Vx_pr PROMPT " О\<статки по оpганизации  "
DEFINE BAR 4 OF Vx_pr PROMPT " А\<рхив движения          "
ON SELECTION POPUP Vx_pr DO Vx_pr WITH BAR()
*
DEFINE POPUP Vyx_pr FROM 9,40 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vyx_pr PROMPT " Оборот\<ная ведомость по организациям "
DEFINE BAR 2 OF Vyx_pr PROMPT "      С\<вод по подpазделениям         "
DEFINE BAR 3 OF Vyx_pr PROMPT "      П\<росмотр выходных форм         "
ON SELECTION POPUP Vyx_pr DO Vyxfdkp WITH BAR()
*
DO CASE
CASE chg15=1
    ACTIVATE POPUP Spr_pr
CASE chg15=3
    ACTIVATE POPUP Vx_pr
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
         DO Perex_pr
    ENDIF
    HIDE WINDOW ALL
    ACTIVATE SCREEN
CASE chg15=7
    ACTIVATE POPUP Vyx_pr
ENDCASE
RETURN
*
PROCEDURE Spr_pr
PARAMETERS chspr
HIDE POPUP ALL
DO CASE
CASE chspr=1
     SELECT skl
     DO Vvodn WITH "Chapsk","Strsaysk","Strgetsk",.T.,.T.,.T.,.T.,".F.","",;
          "F2sk","F3sk","F4sk","F5sk","","","F8sk","F9sk","prskl","",.T.
CASE chspr=2
    SELECT sch
    DO Vvodn WITH "Chapsc","Strsaysc","Strgetsc",.T.,.T.,.T.,.F.,".F.","",;
         "F2sc","F3sc","","","","","","","F10sc","",.T.
ENDCASE
SHOW POPUP Glavn,Proch,Finr_pr,Spr_pr
RETURN
*
PROCEDURE Vx_pr
PARAMETERS chs
DO CASE
CASE chs=1
    DEFINE WINDOW Zapros FROM 16,40 TO 18,59 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    RESTORE FROM tek_b ADDITIVE
    ffbs=IIF(EMPTY(AT(',',tek_b_4,1)),LEFT(tek_b_4,4),LEFT(LEFT(tek_b_4,AT(',',tek_b_4,1)-1)+'    ',4))
    f15=tek_b_15
    RELEASE ALL LIKE tek_b_??
    @ 0,1 SAY "Hомер счета" GET ffbs VALID Poisk_sc('ffbs',.T.,.F.,0,0,0,'76','.F.') ERROR 'Hет такого счета...'
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
    SELECT 0
    USE osdkomr EXCLUSIVE
    IF f15=0
         SET ORDER TO kp_dog
    ELSE
         SET ORDER TO bs_kp
    ENDIF
    ZAP
    SET DELETED ON
    APPEND FROM osd_pr FOR bs=ffbs
    SET DELETED OFF
    SELECT bk
    SET ORDER TO bk2
    SET EXACT OFF
    SEEK ffbs
    SET EXACT ON
    SCAN REST WHILE kor=ffbs FOR MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(bk.kor+bk.kp+IIF(f15=0,bk.dog,''))
              APPEND BLANK
              REPLACE kp WITH bk.kp,bs WITH bk.kor,pr_spr WITH bk.pr_spr,dog WITH bk.dog
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
    SCAN REST WHILE nzk=ffbs FOR MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(bk.nzk+bk.kp+IIF(f15=0,bk.dog,''))
              APPEND BLANK
              REPLACE kp WITH bk.kp,bs WITH bk.nzk,pr_spr WITH bk.pr_spr,dog WITH bk.dog
         ENDIF
         IF bk.vo='1'
              REPLACE smk WITH smk+bk.sm
         ELSE
              REPLACE smd WITH smd+bk.sm
         ENDIF
    ENDSCAN
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
    SET DELETED ON
    APPEND FROM bk FOR MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b.AND.(kor=ffbs.OR.nzk=ffbs)
    SET DELETED OFF
    INDEX ON pr_spr+kp+nzk+kor TAG rab
    SELECT 0
    USE dv_pr
    SET ORDER TO bs_kp
    SET EXACT OFF
    SEEK ffbs
    SET EXACT ON
    SCAN REST WHILE bs=ffbs FOR !DELETE()
         SELECT osdkomr
         IF !SEEK(ffbs+dv_pr.kp+IIF(f15=0,dv_pr.dog,''))
              APPEND BLANK
              REPLACE kp WITH dv_pr.kp,bs WITH ffbs,pr_spr WITH dv_pr.pr_spr,dog WITH dv_pr.dog
         ENDIF
         REPLACE smk WITH smk+dv_pr.smk,smd WITH smd+dv_pr.smd
    ENDSCAN
    SET ORDER TO kor_kp
    SET EXACT OFF
    SEEK ffbs
    SET EXACT ON
    SCAN REST WHILE kor=ffbs FOR !DELETE()
         SELECT osdkomr
         IF !SEEK(ffbs+dv_pr.kp+IIF(f15=0,dv_pr.dog,''))
              APPEND BLANK
              REPLACE kp WITH dv_pr.kp,bs WITH ffbs,pr_spr WITH dv_pr.pr_spr,dog WITH dv_pr.dog
         ENDIF
         REPLACE smd WITH smd+dv_pr.smk,smk WITH smk+dv_pr.smd
    ENDSCAN
    SELECT 0
    USE osd_pr
    SET ORDER TO bs_kp
    IF nastf_7=1
         SELECT 0
         USE kodzk
         SET ORDER TO kodzk
    ENDIF
    SELECT osdkomr
    sss=0
    GO TOP
    HIDE WINDOW ALL
    ACTIVATE SCREEN
    HIDE POPUP ALL
    DO Vvodn WITH "Chapak","Strsayak","Strgetak",.T.,.F.,.F.,.F.,".F.","",;
         "F2av","F3_pr","F4_pr","F5_pr","F6_pr","","","","","",.T.
    ZAP
    USE
    IF Poisk_alia('OSD_PR')
         USE
    ENDIF
    IF Poisk_alia('DV_PR')
         USE
    ENDIF
    IF Poisk_alia('BKR')
         DELETE TAG rab
         ZAP
         USE
    ENDIF
    IF nastf_7=1.AND.Poisk_alia('KODZK')
         USE
    ENDIF
CASE chs=2
    IF nastf_7=1
         SELECT 0
         USE kodzk
         SET ORDER TO kodzk
    ENDIF
    SELECT 0
    USE dv_pr
    SET ORDER TO dog
    HIDE POPUP ALL
    DO Vvodn WITH "Chapd_","Strsayd_","Strgetd_",.T.,.T.,.T.,.T.,".F.","",;
         "F2s_","F3s_","","","F6d_","","","","","",.T.
    USE
    IF nastf_7=1.AND.Poisk_alia('KODZK')
         USE
    ENDIF
CASE chs=3
    SELECT 0
    USE osd_pr
    SET ORDER TO dog
    HIDE POPUP ALL
    DO Vvodn WITH "Chaps_","Strsays_","Strgets_",.T.,.T.,.T.,.T.,".F.","",;
         "F2s_","F3s_","","","","","","","","",.T.
    USE
CASE chs=4
    SELECT 0
    USE dvpr_arc
    SET ORDER TO kp_dog
    HIDE POPUP ALL
    DO Vvodn WITH "Chapd_","Strsayd_","",.F.,.F.,.F.,.F.,".F.","","F2s_","F3s_","","","","","","","","",.T.
    USE
ENDCASE
SHOW POPUP Glavn,Proch,Finr_pr,Vx_pr
RETURN
