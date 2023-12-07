PARAMETERS v_kluch
CLEAR ALL
CLOSE ALL
SET BELL OFF
SET BORDER TO DOUBLE
SET CLOCK ON
SET CONFIRM OFF
SET DATE BRITISH
SET CENTURY ON
SET DELETED OFF
SET DEVICE TO SCREEN
SET ECHO OFF
SET ESCAPE OFF
SET EXACT ON
SET EXCLUSIVE ON
*SET EXCLUSIVE OFF
SET FULLPATH OFF
SET HOURS TO 24
SET MESSAGE TO
SET MULTILOCKS ON
SET NEAR OFF
SET SAFE OFF
SET TALK OFF
SET FUNCTION "F1"  TO ";"
SET FUNCTION "F2"  TO ""
SET FUNCTION "F3"  TO ""
SET FUNCTION "F4"  TO ""
SET FUNCTION "F5"  TO ""
SET FUNCTION "F6"  TO ""
SET FUNCTION "F7"  TO ""
SET FUNCTION "F8"  TO ""
SET FUNCTION "F9"  TO ""
SET FUNCTION "F10" TO ""
RELEASE WINDOW ALL
RESTORE FROM nastf ADDITIVE
SET PATH TO &nastf_p
RESTORE FROM nsch ADDITIVE
ON ERROR DO Err_finr WITH ERROR(),MESSAGE(),MESSAGE(1)
RESTORE FROM sgat_prn ADDITIVE
IF nastf_q=1
    SET STATUS OFF
    SET SCOREBOARD OFF
ENDIF
SET COLOR OF SCHEME 1  TO w+/bg,w+/bg,n/bg,w+/bg,w+/bg,w+/n,gr+/bg,w/n,w+/n,w+/n
SET COLOR OF SCHEME 17 TO w+/bg,w+/bg,n/bg,w+/b,w+/bg,w+/n,gr+/bg,w/n,w+/n,w+/n
SET COLOR OF SCHEME 18 TO w+/bg,n+/w,n/bg,w+/b,w+/b,,w+/n,w/n
SET COLOR OF SCHEME 19 TO w+/bg,w+/bg,n/bg,w+/bg,w+/bg,w+/n,gr+/bg,w/n,w+/n,w+/n
SET COLOR OF SCHEME 21 TO w+/bg,w+/n,gr+/b,w+/b,n/bg,gr+/r,gr+/b,w/n
DEFINE WINDOW Out   FROM   0,0 TO 24,79 COLOR w+/bg,w+/bg,w+/bg,w+/bg,w+/bg,w+/r,w+/bg,w+/bg
DEFINE WINDOW Vybor FROM   7,0 TO 22,79 COLOR w+/bg,n+/w,n/b,w+/b,w+/b,,w+/n,w/n FLOAT GROW
DEFINE WINDOW Help_ FROM  9,30 TO 21,79 COLOR w+/bg,n+/w,gr+/b,w+/b,w+/b,,w+/n,w/n FLOAT GROW
DEFINE WINDOW Perex FROM 10,17 TO 13,59 COLOR SCHEME 18 DOUBLE SHADOW
DEFINE WINDOW Pogal FROM  9,22 TO 13,49 COLOR SCHEME 18 DOUBLE SHADOW
DEFINE WINDOW Pog_p FROM 11,27 TO 13,54 COLOR SCHEME 18 DOUBLE SHADOW
color7="gr+/n,w+/r,n"
color8="gr+/bg"
color11="n/w,w+/n"
color12="w+/n,n/w"
color13="n/bg"
color14="w+/bg,w+/n"
color15="n*/bg"
color20="w/n,n/n"
color21="w+/bg,n+/w"
color22="w+/r"
pr_kluch=.F.
pr_1=.T.
pr_2=.T.
pr_3=.T.
pr_4=.T.
pr_5=.T.
pr_setev=.T.
IF VAL(SYS(2010))<62
    @ 9,14 FILL TO 14,69 COLOR &color20
    SET COLOR TO &color13
    @ 8,13,13,68 BOX "ÉÍ»º¼ÍÈº°"
    SET COLOR TO &color14
    @ 10,15 SAY " p ¬¥âp FILES ¢ ä ©«¥ CONFIG.SYS < 62. ˆá¯p ¢ìâ¥..."
    @ 11,15 SAY "   ®á«¥ ç¥£® ­¥ § ¡ã¤ìâ¥ ¯¥p¥§ £pã§¨âì ¬ è¨­ã...   "
    READ
    QUIT
ENDIF
DO Glmenu
ggrup='@@@'
box_1="ÉÍ»º¼ÍÈº "
box_2="ÉÍ»º¼ÍÈº°"
Delta=0
kol_bs=10
nam_str=""
SET PROCEDURE TO procgol
RESTORE FROM nam_org ADDITIVE
ON KEY LABEL Alt-F1 DO Help_mik
ON KEY LABEL Alt-P DO Calcul
SET COLOR TO &color13
? SPACE(10) AT 75
CLEAR
SET COLOR TO &color11
@ 1,1 SAY "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"     &&+nam_org1
@ 2,1 SAY "°   “ç¥â  ä¨­ ­á®¢®  -  à áç¥â­ëå  ®¯¥à æ¨©   °"     && Œ¨æª¥¢¨ç ‚.‚., Š®¢ «ìçãª ƒ.ˆ. "
@ 3,1 SAY "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"     &&+nam_org3
@ 5,1 CLEAR TO 23,78
RELEASE ALL LIKE nam_org?
RESTORE FROM tek_b ADDITIVE
ntmec=tek_b_2
kolstr=tek_b_14
RELEASE ALL LIKE tek_b_??
tmec=name_mec(ntmec)
SET COLOR TO &color11
@ 5,1 CLEAR TO 23,78
DEFINE POPUP glavn FROM 6,2 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Glavn PROMPT " \< ­ª  -  Š áá         "
DEFINE BAR 2 OF Glavn PROMPT "\-"
DEFINE BAR 3 OF Glavn PROMPT " „\<¥¡¨â®àë - Šà¥¤¨â®àë  "
DEFINE BAR 4 OF Glavn PROMPT "\-"
DEFINE BAR 5 OF Glavn PROMPT " ‘¥à\<¢¨á                "
ON SELECTION POPUP Glavn DO Startb WITH BAR()
SET COLOR TO &color13
@ 24,5  SAY "‘¥£®¤­ïè­ïï ¤ â  :"+DTOC(DATE())
@ 24,46 SAY " áç¥â­ë© ¬¥áïæ : "+tmec
SAVE SCREEN TO scrg
SELECT 0
USE sch
IF ALIAS()='SCH'
    SET ORDER TO sch
ENDIF
SELECT 0
USE sprt
IF ALIAS()='SPRT'
    SET ORDER TO wid_t
ENDIF
SELECT 0
USE sprnaz
IF ALIAS()='SPRNAZ'
    SET ORDER TO wid_d
ENDIF
SELECT 0
USE skl
IF ALIAS()='SKL'
    SET ORDER TO kkl
ENDIF
SELECT 0
USE sprrab
IF ALIAS()='SPRRAB'
    SET ORDER TO tab
ENDIF
SELECT 0
USE bk
IF ALIAS()='BK'
    SET ORDER TO kp
ENDIF
SELECT 0
USE spr_bs
IF ALIAS()='SPR_BS'
    SET ORDER TO grup
ENDIF
SELECT 0
USE spr_grup
IF ALIAS()='SPR_GRUP'
    SET ORDER TO grup
ENDIF
ggrup='@@@'
SELECT 0
USE spr_reg
IF ALIAS()='SPR_REG'
    SET ORDER TO kod
ENDIF
IF nastf_8=1
    SELECT 0
    USE spr_val
    IF ALIAS()='SPR_VAL'
         SET ORDER TO kod
    ENDIF
    SELECT 0
    USE kurs_val
    IF ALIAS()='KURS_VAL'
         SET ORDER TO kod
    ENDIF
ENDIF
ACTIVATE POPUP Glavn
ON KEY
ON ERROR
CLOSE ALL
SET FUNCTION "F3" TO "quit;"
SET FUNCTION "F5" TO "browse;"
SET FUNCTION "F9" TO "DO Start WITH 0;"
SET COLOR TO w+/b
SET SYSMENU TO DEFAULT
IF nastf_q=1
    QUIT
ENDIF
CLOSE ALL
RETURN
*
PROCEDURE comp_1        && ‡ é¨â 
PARAMETERS getput
PRIVATE nH1,nH2,cR,cA,cCod,cKey,i,c
IF !FILE("getcomp.fxp").or.getput#"???????"     && ¥ãáâ ­®¢«¥­­ ï ª®¯¨ï!
    DO Termin
    QUIT
ENDIF
nH1=FOPEN("getcomp.fxp")
IF nH1 < 0
    WAIT WINDOW "Žè¨¡ª  ®âªàëâ¨ï getcomp.fxp !"
    QUIT
ENDIF
cR=FREAD(nH1,133)		   && Š®¤
=FCLOSE(nH1)
LOAD comp.fxp
cKey=SUBSTR(cR,1,1)
cA=cKey
FOR i=2 TO 5
    c=SUBSTR(cR,i,1)
    cA=cA+CHR((ASC(c)-ASC(ckey)-(i-1))%256)
ENDFOR
ca=ca+SPACE(128)
CALL comp.fxp WITH cA
cCod=cKey
FOR i=2 TO LEN(cA)
	c=substr(cA,i,1)
	cCod=cCod+chr((asc(c)+asc(cKey)+i-1)%256)
ENDFOR
RELEASE cA
RELEASE MODULE comp.fxp
IF cCod#cR      && ¥ãáâ ­®¢«¥­­ ï ª®¯¨ï!
    DO Termin
    QUIT
ENDIF
getput="ECOSOFT"
RETURN
*
PROCEDURE Termin    && Terminator
DEFINE WINDOW Waler;
    FROM INT((SROW()-10)/2),INT((SCOL()-41)/2);
    TO INT((SROW()-10)/2)+9,INT((SCOL()-41)/2)+40;
    NOFLOAT NOCLOSE SHADOW COLOR SCHEME 7
ACTIVATE WINDOW waler
SET CURSOR OFF
@ 1,3 SAY "“ ‚ á ­¥ à ¡®ç ï ª®¯¨ï ¯à®£à ¬¬ë !"
@ 2,3 SAY "   ® ¢á¥¬ ¢®¯®á ¬ ®¡à é ©â¥áì:"
@ 3,3 SAY "      â¥«. (0172) 77-50-52"
@ 4,3 SAY "                  20-17-52"
@ 5,3 SAY "           Š®¢ «ìçãª ƒ.ˆ."
@ 6,3 SAY '           Š” "ŠŽ‘Ž”’"'
=inkey(20)
RELEASE WINDOW waler
RETURN