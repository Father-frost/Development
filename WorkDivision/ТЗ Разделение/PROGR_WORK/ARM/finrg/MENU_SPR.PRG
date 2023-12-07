PRIVATE scr,nam_file,set_devi
SAVE SCREEN TO scr
ON KEY LABEL Alt-F9
set_devi=.F.
IF SET('DEVICE')='PRINT'
     SET DEVICE TO SCREEN
     set_devi=.T.
ENDIF
*
nam_file=ALIAS()
DEFINE POPUP menu_spr FROM 7,26 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF menu_spr PROMPT " О\<рганизации          "
DEFINE BAR 2 OF menu_spr PROMPT " П\<одpазделения        "
DEFINE BAR 3 OF menu_spr PROMPT " Р\<аботники            "
DEFINE BAR 4 OF menu_spr PROMPT " В\<иды документов      "
DEFINE BAR 5 OF menu_spr PROMPT " Т\<ексты документов    "
DEFINE BAR 6 OF menu_spr PROMPT " Ра\<зделы плана счетов "
DEFINE BAR 7 OF menu_spr PROMPT " Hаи\<менования счетов  "
IF nastf_8=1
    DEFINE BAR 8 OF menu_spr PROMPT " Hаиме\<нования валют   "
    DEFINE BAR 9 OF menu_spr PROMPT " К\<уpсы валют          "
ENDIF
ON SELECTION POPUP menu_spr DEACTIVATE POPUP menu_spr
ACTIVATE POPUP menu_spr
DO CASE
CASE BAR()=1
    SELECT skl
    DO Vvodn WITH "Chapsk","Strsaysk","Strgetsk",.T.,.T.,.T.,.T.,".F.","","F2sk","F3sk","F4sk","F5sk","","","F8sk","F9sk","prskl","",.T.
CASE BAR()=2
    SELECT sch
    DO Vvodn WITH "Chapsc","Strsaysc","Strgetsc",.T.,.T.,.T.,.F.,".F.","","F2sc","F3sc","","","","","","","F10sc","",.T.
CASE BAR()=3
    SELECT sprrab
    DO Vvodn WITH "Chapsr","Strsaysr","Strgetsr",.T.,.T.,.T.,.T.,".F.","","F2sr","F3sr","F4sr","","","","","","F10sr","",.T.
CASE BAR()=4
    SELECT sprnaz
    DO Vvodn WITH "Chapsn","Strsaysn","Strgetsn",.T.,.T.,.T.,.F.,".F.","","","","","","","","","","","",.T.
CASE BAR()=5
    SELECT sprt
    DO Vvodn WITH "Chapsw","Strsaysw","Strgetsw",.T.,.T.,.T.,.F.,".F.","","F2sw","F3sw","","","","","","","","",.T.
CASE BAR()=6
    SELECT spr_grup
    SET ORDER TO grup
    DO Vvodn WITH "Chapsg","Strsaysg","Strgetsg",.T.,.T.,.T.,.F.,".F.","","","","","","","","","","","",.T.
CASE BAR()=7
    SELECT spr_grup
    SET ORDER TO grup
    SELECT spr_bs
    ggrup='@@@'
    DO Vvodn WITH "Chapss","Strsayss","Strgetss",.T.,.T.,.T.,.F.,".F.","","","","","","","","F8ss","F9ss","F10ss","",.T.
CASE BAR()=8
    SELECT spr_val
    DO Vvodn WITH "Chapwl","Strsaywl","Strgetwl",.T.,.T.,.T.,.F.,".F.","","","","","","","","","","","",.T.
CASE BAR()=9
    SELECT kurs_val
    SET ORDER TO kod
    DO Vvodn WITH "Chapkl","Strsaykl","Strgetkl",.T.,.T.,.T.,.F.,".F.","","","","","","","","","","","",.T.
ENDCASE
*
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RESTORE SCREEN FROM scr
IF set_devi
     SET DEVICE TO PRINT
ENDIF
ON KEY LABEL Alt-F9 DO Menu_spr
RETURN
