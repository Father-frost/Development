DEFINE POPUP Finr_6 FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Finr_6 PROMPT " В\<едение справочников    "
DEFINE BAR 2 OF Finr_6 PROMPT "\-"
DEFINE BAR 3 OF Finr_6 PROMPT " В\<ходная информация      "
DEFINE BAR 4 OF Finr_6 PROMPT "\-"
DEFINE BAR 5 OF Finr_6 PROMPT " Р\<асчет                  "
DEFINE BAR 6 OF Finr_6 PROMPT "\-"
DEFINE BAR 7 OF Finr_6 PROMPT " В\<ыходные формы          "
ON SELECTION POPUP Finr_6 DO Finr_6 WITH BAR()
SET PROCEDURE TO Proc_6
ACTIVATE POPUP Finr_6 BAR 3
SET PROCEDURE TO Procgol
RETURN
*
PROCEDURE Finr_6
PARAMETERS chg15
*
DEFINE POPUP Spr_6 FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Spr_6 PROMPT " О\<рганизации   "
DEFINE BAR 2 OF Spr_6 PROMPT " П\<одpазделения "
DEFINE BAR 3 OF Spr_6 PROMPT " М\<атериалы     "
DEFINE BAR 4 OF Spr_6 PROMPT " Ра\<ботники     "
ON SELECTION POPUP Spr_6 DO Spr_6 WITH BAR()
*
DEFINE POPUP Vx_6 FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vx_6 PROMPT " О\<боpот по поставщикам           "
DEFINE BAR 2 OF Vx_6 PROMPT " Д\<вижение по поставщикам         "
DEFINE BAR 3 OF Vx_6 PROMPT " О\<статки по поставщикам          "
DEFINE BAR 4 OF Vx_6 PROMPT " П\<риход материалов               "
DEFINE BAR 5 OF Vx_6 PROMPT " П\<оступление материалов на МОЛов "
DEFINE BAR 6 OF Vx_6 PROMPT " Ар\<хив движения по поставщикам   "
ON SELECTION POPUP Vx_6 DO Vx_6 WITH BAR()
*
DEFINE POPUP Ras_6 FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Ras_6 PROMPT " П\<рием данных          "
DEFINE BAR 2 OF Ras_6 PROMPT "\-"
DEFINE BAR 3 OF Ras_6 PROMPT " П\<еpеход к след.месяцу "
ON SELECTION POPUP Ras_6 DO Ras_6 WITH BAR()
*
DEFINE POPUP Vyx_6 FROM 11,40 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vyx_6 PROMPT " В\<едомость по поступлению пpодукции "
DEFINE BAR 2 OF Vyx_6 PROMPT " Ве\<домость по оpганизациям          "
DEFINE BAR 3 OF Vyx_6 PROMPT " И\<нфоpмация по оpганизациям         "
DEFINE BAR 4 OF Vyx_6 PROMPT " Ин\<фоpмация по оплатам              "
DEFINE BAR 5 OF Vyx_6 PROMPT " Пр\<осмотр выходных форм             "
ON SELECTION POPUP Vyx_6 DO Vyxfdb6 WITH BAR()
*
DO CASE
CASE chg15=1
    ACTIVATE POPUP Spr_6
CASE chg15=3
    ACTIVATE POPUP Vx_6
CASE chg15=5
    ACTIVATE POPUP Ras_6
CASE chg15=7
    ACTIVATE POPUP Vyx_6
ENDCASE
RETURN
*
PROCEDURE Spr_6
PARAMETERS chspr
HIDE POPUP ALL
DO CASE
CASE chspr=1
    SELECT skl
    DO Vvodn WITH "Chapsk","Strsaysk","Strgetsk",.T.,.T.,.T.,.T.,".F.","",;
         "F2sk","F3sk","F4sk","F5sk","","","F8sk","F9sk","prskl","",.T.
CASE chspr=2
    SELECT sch
    DO Vvodn with "Chapsc","Strsaysc","Strgetsc",.T.,.T.,.T.,.F.,".F.","",;
         "F2sc","F3sc","","","","","","","F10sc","",.T.
CASE chspr=3.AND.FILE('MATR.DBF')
    SELECT 0
    USE matr
    SET ORDER TO mat
    DO Vvodn with "Chapmt","Strsaymt","Strgetmt",.F.,.F.,.F.,.F.,".F.","",;
         "F2mt","F3mt","F4mt","","","","","","","",.T.
    USE
CASE chspr=4
    SELECT sprrab
    DO Vvodn with "Chapsr","Strsaysr","Strgetsr",.T.,.T.,.T.,.F.,".F.","",;
         "F2sr","F3sr","F4sr","","","","","","F10sr","",.T.
ENDCASE
SHOW POPUP Glavn,Proch,Finr_6,Spr_6
RETURN
*
PROCEDURE Vx_6
PARAMETERS chs
DO CASE
CASE chs=1
    DO Obor_pos
CASE chs=2
    IF nastf_m=1
         SELECT 0
         USE kodzk
         SET ORDER TO kodzk
    ENDIF
    SELECT 0
    USE atot
    SET ORDER TO avot1
    ffnpp=npp
    ffdat=dat
    ffkp=kp
    ffnrd=nrd
    ffnvx=nvx
    ffpr_spr=pr_spr
    ffbs=bs
    ffnsk=nsk
    ON KEY LABEL Alt-F9 DO Menu_spr
    HIDE POPUP ALL
    DO Vvodn WITH "Chapoo1","Strsayoo1","Strgetoo1",.T.,.T.,.T.,.F.,".F.","",;
         "F2oo1","F3oo1","F4oo1","","","","","","F10oo1","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='ATOT'
         USE
    ENDIF
    IF nastf_m=1.AND.Poisk_alia('KODZK')
         USE
    ENDIF
CASE chs=3
    SELECT 0
    USE osdkom1
    SET ORDER TO kp_nrd
    ffnpp=npp
    ffdat=dat
    ffkp=kp
    ffnrd=nrd
    ffnvx=nvx
    ffpr_spr=pr_spr
    ffbs=bs
    ffnsk=nsk
    ON KEY LABEL Alt-F9 DO Menu_spr
    HIDE POPUP ALL
    DO Vvodn WITH "Chapok1","Strsayok1","Strgetok1",.T.,.T.,.T.,.F.,".F.","",;
         "F2ok1","F3ok1","F4ok1","F5ok1","","","","","F10ok1","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='OSDKOM1'
         USE
    ENDIF
CASE chs=4
    IF FILE('PR.DBF').AND.FILE('MATR.DBF').AND.FILE('NASTR.MEM').AND.FILE('SO.DBF')
         RESTORE FROM nastr ADDITIVE
         SELECT 0
         USE so
         SET ORDER TO so
         SELECT 0
         USE matr
         SET ORDER TO mat
         SELECT 0
         USE pr
         SET ORDER TO npd
         ON KEY LABEL Alt-F9 DO Menu_spr
         HIDE POPUP ALL
         DO Vvodn WITH "Chappr","Strsaypr","Strgetpr",.F.,.T.,.F.,.F.,".F.","",;
                       "F2pr","F3pr","","","","","","","","",.T.
         ON KEY LABEL Alt-F9
         USE
         IF Poisk_alia('MATR')
              USE
         ENDIF
         IF Poisk_alia('SO')
              USE
         ENDIF
         RELEASE ALL LIKE nastr_?
    ENDIF
CASE chs=5
    IF FILE('DV_MOL.DBF').AND.FILE('MATR.DBF').AND.FILE('NASTR.MEM')
         RESTORE FROM nastr ADDITIVE
         SELECT 0
         USE matr
         SET ORDER TO mat
         SELECT 0
         USE dv_mol
         SET ORDER TO nsk
         ON KEY LABEL Alt-F9 DO Menu_spr
         HIDE POPUP ALL
         DO Vvodn WITH "Chapdm","Strsaydm","Strgetpr",.F.,.F.,.F.,.F.,".F.","",;
                       "F2dm","F3dm","","","","","","","","",.T.
         ON KEY LABEL Alt-F9
         USE
         IF Poisk_alia('MATR')
              USE
         ENDIF
         RELEASE ALL LIKE nastr_?
    ENDIF
CASE chs=6
    SELECT 0
    USE atot_arc
    SET ORDER TO kp_nrd
    ON KEY LABEL Alt-F9 DO Menu_spr
    HIDE POPUP ALL
    DO Vvodn WITH "Chapar","Strsayar","",.F.,.F.,.F.,.F.,".F.","",;
         "F2ar","F3ar","F4ar","","","","","","F10ar6","",.T.
    ON KEY LABEL Alt-F9
    IF ALIAS()='ATOT_ARC'
         USE
    ENDIF
ENDCASE
SHOW POPUP Glavn,Proch,Finr_6,Vx_6
RETURN
*
PROCEDURE Ras_6
PARAMETERS chspr
DEFINE POPUP Ras_61 FROM 11,42 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Ras_61 PROMPT " П\<риход материалов               "
DEFINE BAR 2 OF Ras_61 PROMPT "\-"
DEFINE BAR 3 OF Ras_61 PROMPT " П\<оступление материалов на МОЛов "
ON SELECTION POPUP Ras_61 DO Priem_6 WITH BAR()
DO CASE
CASE chspr=1
    ACTIVATE POPUP Ras_61
CASE chspr=3
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
         DO Perex6
    ENDIF
ENDCASE
RETURN
