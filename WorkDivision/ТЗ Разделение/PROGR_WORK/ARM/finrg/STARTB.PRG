PARAMETERS chg
DEFINE POPUP Bank FROM 7,20 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Bank PROMPT " В\<едение справочников     "
DEFINE BAR 2 OF Bank PROMPT "\-"
DEFINE BAR 3 OF Bank PROMPT " В\<ходная информация       "
DEFINE BAR 4 OF Bank PROMPT "\-"
DEFINE BAR 5 OF Bank PROMPT " В\<идеогpаммы              "
DEFINE BAR 6 OF Bank PROMPT "\-"
DEFINE BAR 7 OF Bank PROMPT " П\<ереход к следующ.месяцу "
DEFINE BAR 8 OF Bank PROMPT "\-"
DEFINE BAR 9 OF Bank PROMPT " В\<ыходные формы           "
ON SELECTION POPUP Bank DO Bank WITH BAR()
DEFINE POPUP Proch FROM 7,20 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Proch PROMPT " Р\<асчеты с поставщиками        "
DEFINE BAR 2 OF Proch PROMPT "\-"
DEFINE BAR 3 OF Proch PROMPT " Ра\<счеты с получателями        "
DEFINE BAR 4 OF Proch PROMPT "\-"
DEFINE BAR 5 OF Proch PROMPT " Рас\<четы с подотчетными лицами "
DEFINE BAR 6 OF Proch PROMPT "\-"
DEFINE BAR 7 OF Proch PROMPT " П\<рочие дебиторы - кредиторы   "
IF nastf_f=1
    DEFINE BAR 8 OF Proch PROMPT "\-"
    DEFINE BAR 9 OF Proch PROMPT " В\<нутрихозяйcтвенные расчеты   "
ENDIF
IF nastf_y=1
    DEFINE BAR 8+nastf_f+nastf_f OF Proch PROMPT "\-"
    DEFINE BAR 9+nastf_f+nastf_f OF Proch PROMPT " В\<едение депонентов "
ENDIF
ON SELECTION POPUP Proch DO Proch WITH BAR()
SAVE SCREEN TO scr1
DO CASE
CASE chg=1.AND.pr_1
    gfbs=SPACE(4)
    DEFINE WINDOW Zapros FROM 11,23 TO 13,46 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    RESTORE FROM tek_b ADDITIVE
    @ 0,0 SAY " Балансовый счет" GET gfbs VALID Poisk_sc('gfbs',.T.,.F.,0,0,0,'5','.F.') ERROR " Hет такого счета..."
    READ
    RELEASE ALL LIKE tek_b_??
    RELEASE WINDOW Zapros
    IF EMPTY(gfbs)
         RETURN
    ENDIF
    glpar='     '
    IF spr_bs.pr_prov='1'.AND.!EMPTY(spr_bs.scho3)
         DEFINE WINDOW Zapros FROM 11,31 TO 13,46 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Пароль"
         SET COLOR TO &color20
         @ 0,8 GET glpar
         READ
         RELEASE WINDOW Zapros
         IF glpar#spr_bs.scho3
              RETURN
         ENDIF
    ENDIF
    IF !EMPTY(gfbs)
         gpr_val=IIF(nastf_8=0.OR.spr_bs.pr_val='0',.F.,.T.)
         ACTIVATE POPUP Bank BAR 3
    ENDIF
CASE chg=3
    ACTIVATE POPUP Proch
CASE chg=5
    DO Serv
ENDCASE
RESTORE SCREEN FROM scr1
ACTIVATE SCREEN
SET COLOR TO &color13
@ 24,46 SAY "Расчетный месяц : "+tmec
RETURN
*
PROCEDURE Bank
PARAMETERS chg13
PRIVATE i
DEFINE POPUP Sprbk FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Sprbk PROMPT " О\<рганизации          "
DEFINE BAR 2 OF Sprbk PROMPT " П\<одpазделения        "
DEFINE BAR 3 OF Sprbk PROMPT " Р\<аботники            "
DEFINE BAR 4 OF Sprbk PROMPT " В\<иды документов      "
DEFINE BAR 5 OF Sprbk PROMPT " Т\<ексты документов    "
DEFINE BAR 6 OF Sprbk PROMPT " Ра\<зделы плана счетов "
DEFINE BAR 7 OF Sprbk PROMPT " Hаи\<менования счетов  "
i=7
IF nastf_8=1
    i=i+2
    DEFINE BAR 8 OF Sprbk PROMPT " Hаиме\<нования валют   "
    DEFINE BAR 9 OF Sprbk PROMPT " К\<уpсы валют          "
ENDIF
IF nastf_c=1
    i=i+1
    DEFINE BAR i OF Sprbk PROMPT " Лими\<ты для гpупп     "
ENDIF
IF nastf_a=1
    i=i+1
    DEFINE BAR i OF Sprbk PROMPT " Номера \<документов    "
ENDIF
IF nastf_i=1
    i=i+1
    DEFINE BAR i OF Sprbk PROMPT " Кредиты \<банков       "
ENDIF
i=i+1
DEFINE BAR i OF Sprbk PROMPT " Форму\<лы расчетов     "
ON SELECTION POPUP Sprbk DO Sprbk WITH BAR()
DEFINE POPUP Vyxbk FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR  1 OF Vyxbk PROMPT "     В\<едомость по поступлению денег     "
DEFINE BAR  2 OF Vyxbk PROMPT "     Ве\<домость по расходованию денег    "
DEFINE BAR  3 OF Vyxbk PROMPT "   С\<водная ведомость по коpp. счетам    "
DEFINE BAR  4 OF Vyxbk PROMPT " Е\<жедн. ведомость по поступлению денег  "
DEFINE BAR  5 OF Vyxbk PROMPT " Ежед\<н. ведомость по pасходованию денег "
DEFINE BAR  6 OF Vyxbk PROMPT "            К\<ассовая книга  КО-4        "
DEFINE BAR  7 OF Vyxbk PROMPT "             Ж\<уpнал - оpдеp             "
DEFINE BAR  8 OF Vyxbk PROMPT "               Вед\<омость                "
DEFINE BAR  9 OF Vyxbk PROMPT "         Ин\<фоpмация по pегионам         "
DEFINE BAR 10 OF Vyxbk PROMPT "      Инфо\<pмация по подpазделениям      " SKIP FOR nastf_x=0
DEFINE BAR 11 OF Vyxbk PROMPT "           П\<латежные документы          "
DEFINE BAR 12 OF Vyxbk PROMPT "       Рее\<стр платежных требований      "
DEFINE BAR 13 OF Vyxbk PROMPT "            Про\<чие ведомости            "
DEFINE BAR 14 OF Vyxbk PROMPT "         Просмо\<тр выходных форм         "
ON SELECTION POPUP Vyxbk DO Vyxfbk WITH BAR()
DO CASE
CASE chg13=1
    ACTIVATE POPUP Sprbk
CASE chg13=3
    IF nastf_c=1
         SELECT spr_grup
         SET ORDER TO grup
    ENDIF
    IF nastf_x=1
         SELECT 0
         USE lim_nsk
         SET ORDER TO kp_nrd
    ENDIF
    IF nastf_5=1
         SELECT 0
         USE spr_kart
         SET ORDER TO kod
    ENDIF
    SELECT bk
    SET ORDER TO kp
    ffdat=dat
    ffnzk=nzk
    PUSH KEY
    ON KEY LABEL Alt-F2 DO F2abk
    IF nastf_x=1
         ON KEY LABEL Alt-F3 DO F3abk
    ENDIF
    ON KEY LABEL Alt-F4 DO F4abk
    ON KEY LABEL Alt-F5 DO F5abk
    ON KEY LABEL Alt-F6 DO F6abk
    RESTORE FROM tek_b ADDITIVE
    IF tek_b_38=1
         ON KEY LABEL Alt-F7 DO F7abk
    ENDIF
    RELEASE ALL LIKE tek_b_??
    IF nastf_t=1
         ON KEY LABEL Alt-F8 DO F8abk
    ENDIF
    ON KEY LABEL Alt-F9 DO Menu_spr
    ON KEY LABEL Ctrl-Enter DO Ctr_bk
    ON KEY LABEL Ctrl-F5 DO F5cbk
    ON KEY LABEL Ctrl-F6 DO F6cbk
    ON KEY LABEL Ctrl-F7 DO F7cbk
    HIDE POPUP ALL
    SET EXACT OFF
    SEEK gfbs
    SET EXACT ON
    DO Vvodn WITH "Chapbk","Strsaybk","Strgetbk",.T.,.T.,.T.,.F.,"nzk#gfbs","F1bk",;
                  "F2bk","F3bk","F4bk","F5bk","F6bk","F7bk","F8bk","F9bk","prplat","Udal_bk",.T.
    SHOW POPUP Glavn,Bank
    POP KEY
    IF nastf_x=1.AND.Poisk_alia('LIM_NSK')
         USE
    ENDIF
    IF nastf_5=1.AND.Poisk_alia('SPR_KART')
         USE
    ENDIF
CASE chg13=5
    DO Video_bk
CASE chg13=7
    key=2
    DEFINE WINDOW Zapros FROM 10,20 TO 13,62 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,1 SAY "Выполняется пеpеход к следующему месяцу."
    @ 1,3 SAY "Вы уверены ?"
    @ 1,23 PROMPT " Да  "
    @ 1,33 PROMPT " Hет "
    MENU TO key
    RELEASE WINDOW Zapros
    RESTORE FROM tek_b ADDITIVE
    IF key=1.AND.checkpass(1)
         ACTIVATE WINDOW Pog_p
         SET COLOR TO &color15
         @ 0,0 SAY '░'
         SET COLOR TO &color13
         @ 0,1 SAY "Пожалуйста, подождите..."
         SELECT bk
         IF pr_setev
              USE bk EXCLUSIVE
         ENDIF
         IF ALIAS()#'BK'
              SELECT 0
              USE bk
              SET ORDER TO kp
              RETURN
         ENDIF
         SELECT 0
         USE bk_arc
         SET DELETED ON
         APPEND FROM bk FOR MONTH(dat)=ntmec
         SET DELETED OFF
         USE
*
         SELECT bk
         SET ORDER TO kp
         SELECT spr_bs
         SET ORDER TO grup
         SET EXACT OFF
         SEEK tek_b_25
         SCAN REST WHILE grup=tek_b_25 FOR !DELETE()
              fsum=0
              fnzk=bs
              gpr_val=IIF(nastf_8=0.OR.pr_val='0',.F.,.T.)
              SELECT bk
              SET ORDER TO kp
              SEEK fnzk
              SCAN REST WHILE fnzk=nzk FOR MONTH(dat)=ntmec.AND.!DELETE()
                   IF gpr_val
                        fsum=fsum+IIF(vo='0',sm_val,-sm_val)
                   ELSE
                        fsum=fsum+IIF(vo='0',sm,-sm)
                   ENDIF
              ENDSCAN
              SET ORDER TO bk2
              SEEK fnzk
              SCAN REST WHILE fnzk=kor FOR MONTH(dat)=ntmec.AND.!DELETE()
                   IF gpr_val
                        fsum=fsum+IIF(vo='1',sm_val,-sm_val)
                   ELSE
                        fsum=fsum+IIF(vo='1',sm,-sm)
                   ENDIF
              ENDSCAN
              SELECT spr_bs
              IF gpr_val
                   REPLACE sm_val WITH sm_val+fsum
                   REPLACE saldm WITH Kurs_dat(vid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,sm_val)
              ELSE
                   REPLACE saldm WITH saldm+fsum
              ENDIF
         ENDSCAN
         SET EXACT ON
*
         SELECT bk
         DELETE FOR MONTH(dat)=ntmec
         PACK
         IF pr_setev
              USE bk
         ENDIF
         SET ORDER TO kp
         IF nastf_c=1
              SELECT 0
              USE lim_nsk
              SCAN FOR !DELETE()
                   SELECT bk
                   pr_net=SEEK(lim_nsk.nzk+lim_nsk.kp+lim_nsk.nrd+lim_nsk.kor)
                   SELECT lim_nsk
                   IF !pr_net
                        DELETE
                   ENDIF
              ENDSCAN
              IF pr_setev
                   USE lim_nsk EXCLUSIVE
              ENDIF
              PACK
              USE
         ENDIF
         tek_b_2=tek_b_2+1
         IF tek_b_2>12
              tek_b_2=1
              nastf_b=STR(VAL(nastf_b)+1,4)
         ENDIF
         ntmec=tek_b_2
         sss=FULLPATH('tek_b.mem')
         SAVE TO &sss ALL LIKE tek_b_??
		sss=FULLPATH('nastf.mem')
		SAVE TO &sss ALL LIKE nastf???
         tmec=name_mec(ntmec)
         HIDE WINDOW ALL
         SELECT spr_bs
         SET ORDER TO bs
         SEEK gfbs
         gpr_val=IIF(nastf_8=0.OR.spr_bs.pr_val='0',.F.,.T.)
         ACTIVATE SCREEN
         SET COLOR TO &color13
         @ 24,46 SAY "Расчетный месяц : "+tmec
    ENDIF
    RELEASE ALL LIKE tek_b_??
CASE chg13=9
    ACTIVATE POPUP Vyxbk
ENDCASE
RETURN
*
PROCEDURE Proch
PARAMETERS chgk
SAVE SCREEN TO scr2
DO CASE
CASE chgk=1.AND.pr_3
    DO Finr_6
CASE chgk=3.AND.pr_4
    DO Finr_16
CASE chgk=5.AND.pr_5
    DO Finr_71
CASE chgk=7
    DO Finr_pr
CASE chgk=9.AND.nastf_f=1
    DO Finr_79
CASE chgk=9.AND.nastf_f=0.OR.chgk=11
    DO Finr_dp
ENDCASE
RESTORE SCREEN FROM scr2
RETURN
*
PROCEDURE Sprbk
PARAMETERS chspr
HIDE POPUP ALL
DO CASE
CASE chspr=1
    SELECT skl
    DO Vvodn WITH "Chapsk","Strsaysk","Strgetsk",.T.,.T.,.T.,.F.,".F.","",;
         "F2sk","F3sk","F4sk","F5sk","F6sk","","F8sk","F9sk","prskl","",.T.
CASE chspr=2
    SELECT sch
    DO Vvodn WITH "Chapsc","Strsaysc","Strgetsc",.T.,.T.,.T.,.F.,".F.","",;
         "F2sc","F3sc","","","","","","","F10sc","",.T.
CASE chspr=3
    SELECT sprrab
    DO Vvodn WITH "Chapsr","Strsaysr","Strgetsr",.T.,.T.,.T.,.T.,".F.","",;
         "F2sr","F3sr","F4sr","","","","","","F10sr","",.T.
CASE chspr=4
    SELECT sprnaz
    DO Vvodn WITH "Chapsn","Strsaysn","Strgetsn",.T.,.T.,.T.,.F.,".F.","",;
         "","","","","","","","","","",.T.
CASE chspr=5
    SELECT sprt
    DO Vvodn WITH "Chapsw","Strsaysw","Strgetsw",.T.,.T.,.T.,.F.,".F.","",;
         "F2sw","F3sw","","","","","","","","",.T.
CASE chspr=6
    SELECT spr_grup
    SET ORDER TO grup
    DO Vvodn WITH "Chapsg","Strsaysg","Strgetsg",.T.,.T.,.T.,.F.,".F.","",;
         "","","","","","","","","","",.T.
CASE chspr=7
    SELECT spr_grup
    SET ORDER TO grup
    SELECT spr_bs
    ggrup='@@@'
    DO Vvodn WITH "Chapss","Strsayss","Strgetss",.T.,.T.,.T.,.F.,".F.","",;
         "","","","","","","F8ss","F9ss","F10ss","",.T.
CASE nastf_8=1.AND.chspr=8
    SELECT spr_val
    DO Vvodn WITH "Chapwl","Strsaywl","Strgetwl",.T.,.T.,.T.,.F.,".F.","",;
         "","","","","","","","","","",.T.
CASE nastf_8=1.AND.chspr=9
    SELECT kurs_val
    DO Vvodn WITH "Chapkl","Strsaykl","Strgetkl",.T.,.T.,.T.,.F.,".F.","",;
         "","","","","","","","","","",.T.
CASE nastf_c=1.AND.chspr=(8+IIF(nastf_8=1,2,0))
    SELECT 0
    USE spr_lim
    SET ORDER TO lim
    DO Vvodn WITH "Chaplm","Strsaylm","Strgetlm",.T.,.T.,.T.,.F.,".F.","",;
         "","","","","","","","F9lm","F10lm","",.T.
    USE
CASE nastf_a=1.AND.chspr=8+IIF(nastf_8=1,2,0)+IIF(nastf_c=1,1,0)
    SELECT 0
    USE spr_nrd
    SET ORDER TO nrd
    DO Vvodn WITH "Chapnd","Strsaynd","Strgetnd",.T.,.T.,.T.,.F.,".F.","",;
         "","","","","","","","","","",.T.
    USE
CASE chspr=8+IIF(nastf_8=1,2,0)+IIF(nastf_c=1,1,0)+IIF(nastf_a=1,1,0)
    SELECT 0
    USE kredit
    SET ORDER TO kp_dog
    DO Vvodn WITH "Chapkr","Strsaykr","Strgetkr",.T.,.T.,.T.,.F.,".F.","",;
         "","F3kr","F4kr","F5kr","","","","","F10kr","",.T.
    USE
CASE chspr=9+IIF(nastf_8=1,2,0)+IIF(nastf_c=1,1,0)+IIF(nastf_a=1,1,0)
    SELECT 0
    USE spr_vid
    SET ORDER TO kod
    DO Vvodn WITH "Chapsb","Strsaysb","Strgetsb",.T.,.T.,.T.,.F.,".F.","",;
         "","","","","","","","","","",.T.
    USE
ENDCASE
SHOW POPUP Glavn,Bank,Sprbk
RETURN