DEFINE POPUP Finr_79 FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Finr_79 PROMPT " ‚\<¥¤¥­¨¥ á¯à ¢®ç­¨ª®¢    "
DEFINE BAR 2 OF Finr_79 PROMPT "\-"
DEFINE BAR 3 OF Finr_79 PROMPT " ‚\<å®¤­ ï ¨­ä®à¬ æ¨ï      "
DEFINE BAR 4 OF Finr_79 PROMPT "\-"
DEFINE BAR 5 OF Finr_79 PROMPT " ¥\<à¥å®¤ ª á«¥¤.¬¥áïæã   "
DEFINE BAR 6 OF Finr_79 PROMPT "\-"
DEFINE BAR 7 OF Finr_79 PROMPT " ‚\<ëå®¤­ë¥ ä®à¬ë          "
ON SELECTION POPUP Finr_79 DO Finr_79 WITH BAR()
ACTIVATE POPUP Finr_79 BAR 3
RETURN
*
PROCEDURE Finr_79
PARAMETERS chg15
*
DEFINE POPUP Spr_79 FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Spr_79 PROMPT " Ž\<à£ ­¨§ æ¨¨   "
DEFINE BAR 2 OF Spr_79 PROMPT " \<®¤à §¤¥«¥­¨ï "
ON SELECTION POPUP Spr_79 DO Spr_79 WITH BAR()
*
DEFINE POPUP Vx_79 FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vx_79 PROMPT " „\<¢¨¦¥­¨¥ ¯® ä¨«¨ « ¬ "
DEFINE BAR 2 OF Vx_79 PROMPT " Ž\<áâ âª¨ ¯® ä¨«¨ « ¬  "
DEFINE BAR 3 OF Vx_79 PROMPT " €\<àå¨¢ ¤¢¨¦¥­¨ï       "
ON SELECTION POPUP Vx_79 DO Vx_79 WITH BAR()
*
DEFINE POPUP Vyx_79 FROM 9,40 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vyx_79 PROMPT " Ž\<¡®à®â­ ï ¢¥¤®¬®áâì ¯® ¯®¤à §¤¥«¥­¨ï¬ "
DEFINE BAR 2 OF Vyx_79 PROMPT "  ‘\<¢®¤­ ï ¢¥¤®¬®áâì ¯® ¯®¤à §¤¥«¥­¨ï¬  "
DEFINE BAR 3 OF Vyx_79 PROMPT "         Š\< àâ®çª  ¯®¤à §¤¥«¥­¨ï        "
DEFINE BAR 4 OF Vyx_79 PROMPT "      ‘¢\<®¤­ ï ¢¥¤®¬®áâì ¯® áç¥â ¬      "
DEFINE BAR 5 OF Vyx_79 PROMPT " ˆ\<­ä®à¬ æ¨ï ¯® áç¥â ¬ ¨ ¯®¤à §¤¥«¥­¨ï¬ "
DEFINE BAR 6 OF Vyx_79 PROMPT "         \<à®á¬®âà ¢ëå®¤­ëå ä®à¬        "
ON SELECTION POPUP Vyx_79 DO Vyxf79 WITH BAR()
*
*
DO CASE
CASE chg15=1
    ACTIVATE POPUP Spr_79
CASE chg15=3
    ACTIVATE POPUP Vx_79
CASE chg15=5
    DEFINE WINDOW Zapros FROM 10,17 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    key=2
    @ 0,1 SAY "‚ë¯®«­ï¥âáï ¯¥à¥å®¤ ª á«¥¤ãîé¥¬ã ¬¥áïæã."
    @ 1,1 SAY "‚ë ã¢¥à¥­ë ?"
    @ 1,21 PROMPT " „   "
    @ 1,31 PROMPT " H¥â "
    MENU TO key
    RELEASE WINDOW Zapros
    IF key=1
         DO Perex79
    ENDIF
CASE chg15=7
    ACTIVATE POPUP Vyx_79
ENDCASE
RETURN
*
PROCEDURE Spr_79
PARAMETERS chspr
HIDE POPUP ALL
DO CASE
CASE chspr=1
    SELECT skl
    DO Vvodn WITH "Chapsk","Strsaysk","Strgetsk",.T.,.T.,.T.,.F.,".F.","",;
                  "F2sk","F3sk","F4sk","","","","F8sk","F9sk","prskl","",.T.
CASE chspr=2
    SELECT sch
    DO Vvodn WITH "Chapsc","Strsaysc","Strgetsc",.T.,.T.,.T.,.F.,".F.","",;
         "F2sc","F3sc","","","","","","","F10sc","",.T.
ENDCASE
SHOW POPUP Glavn,Proch,Finr_79,Spr_79
RETURN
*
PROCEDURE Vx_79
PARAMETERS chs
HIDE POPUP ALL
DO CASE
CASE chs=1
    RESTORE FROM tek_b ADDITIVE
    SELECT 0
    USE dv_79
    SET ORDER TO ko_kp
    DO Vvodn WITH "Chapd9","Strsayd9","Strgetd9",.T.,.T.,.T.,.F.,".F.","",;
                  "F2d9","F3d9","F4d9","F5d9","","","","","","",.T.
    USE
    RELEASE ALL LIKE tek_b_??
CASE chs=2
    SELECT 0
    USE osd_79
    SET ORDER TO nsk
    DO Vvodn WITH "Chap79","Strsay79","Strget79",.T.,.T.,.T.,.F.,".F.","",;
                  "","","","","","","","","","",.T.
    USE
CASE chs=3
    SELECT 0
    USE dv79_arc
    SET ORDER TO ko_kp
    DO Vvodn WITH "Chap7a","Strsay7a","",.F.,.F.,.F.,.F.,".F.","",;
                  "F2d9","F3d9","F4d9","F5d9","","","","","","",.T.
    USE
ENDCASE
SHOW POPUP Glavn,Proch,Finr_79,Vx_79
RETURN
*
*
PROCEDURE Chap79
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
step=1
npolscrm=1
SET COLOR TO &color4
ncolr=78
@ nstrv-5,ncoll FILL TO nstrv+12,ncolr+2 COLOR &color20
@ nstrv-6,ncoll-1,nstrv+11,ncolr+1 BOX "ÉÍ»º¼ÍÈº "
@ nstrv-5 ,ncoll-1 SAY "º        Ž á â   â ª ¨    ¯ ®    ¯ ® ¤ à   § ¤ ¥ « ¥ ­ ¨ ï ¬"
@ nstrv-4 ,ncoll-1 SAY "ÇÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ nstrv-3 ,ncoll-1 SAY "º «.³ Š®¤ ³        ¨¬¥­®¢ ­¨¥          ³       Cã¬¬       ³      Cã¬¬ "
@ nstrv-2 ,ncoll-1 SAY "ºáç¥â³¯®¤à.³       ¯®¤à §¤¥«¥­¨ï         ³       ¤¥¡¥â      ³      ªà¥¤¨â"
@ nstrv-1 ,ncoll-1 SAY "ÇÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ nstrv+11,ncoll-1 SAY "ÈÍ F1 Ä ¯®¬®éì "
RETURN
*
PROCEDURE Strsay79
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr, 1 SAY bs
@ nstr, 6 SAY nsk
@ nstr,12 SAY Spr_nam('2',nsk,29)
@ nstr,42 SAY db PICTURE '999,999,999,999.99'
@ nstr,61 SAY kr PICTURE '999,999,999,999.99'
RETURN
*
PROCEDURE Strget79
PARAMETERS nstr,npolscr
IF EMPTY(nsk)
    REPLACE bs WITH nastf_u
ENDIF
@ nstr, 1 GET bs VALID Poisk_sc('osd_79.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H¥â â ª®£® áç¥â ...'
@ nstr, 6 GET nsk VALID Poisk_ns('osd_79.nsk',.F.,nstr,12,29) ERROR 'H¥â â ª®£® ª®¤ ...'
@ nstr,42 GET db PICTURE '999,999,999,999.99'
@ nstr,61 GET kr PICTURE '999,999,999,999.99'
READ
RETURN
*
*
PROCEDURE Chapd9
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
step=1
npolscrm=1
SET COLOR TO &color4
ncolr=78
@ nstrv-8,ncoll FILL TO nstrv+12,ncolr+1 COLOR &color20
@ nstrv-9,ncoll-1,nstrv+11,ncolr+1 BOX "ÉÍ»º¼ÍÈº "
@ nstrv-8 ,ncoll-1 SAY "º              „¢¨¦¥­¨¥ ¯® ¢­ãâà¨å®§ï©áâ¢¥­­ë¬ à áç¥â ¬"
@ nstrv-7 ,ncoll-1 SAY "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ nstrv-6 ,ncoll-1 SAY "º Žâ ª®£®:"
@ nstrv-5 ,ncoll-1 SAY "º Š  ª®¬ã:"
@ nstrv-4 ,ncoll-1 SAY "ÇÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ nstrv-3 ,ncoll-1 SAY "º ®¬¥à³  „ â   ³Žâ ª®£®³ Š ª®¬ã³ «.³Š®àà³       Cã¬¬       ³     ‡  çâ®"
@ nstrv-2 ,ncoll-1 SAY "º¤®ªã¬.³        ³       ³       ³áç¥â³áç¥â³                  ³"
@ nstrv-1 ,ncoll-1 SAY "ÇÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ nstrv+11,ncoll-1 SAY "ÈÍ F1 Ä ¯®¬®éì ÍÍÍ ®¨áª: F2-®â¯à.,F3-¯®«ãç.,F4-¤®ªã¬.,F5-áã¬¬  "
RETURN
*
PROCEDURE Strsayd9
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 6,11 SAY Spr_nam('2',ko,30)
    @ 7,11 SAY Spr_nam('2',kp,30)
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY nrd
@ nstr, 8 SAY dat
@ nstr,17 SAY ko
@ nstr,25 SAY kp
@ nstr,33 SAY bs
@ nstr,38 SAY kor
@ nstr,43 SAY summa PICTURE '999,999,999,999.99'
@ nstr,62 SAY LEFT(text,17)
RETURN
*
PROCEDURE Strgetd9
PARAMETERS nstr,npolscr
IF EMPTY(ko)
    @ 6,11 SAY SPACE(30)
    @ 7,11 SAY SPACE(30)
    REPLACE bs WITH nastf_u
ENDIF
@ nstr, 1 GET nrd
@ nstr, 8 GET dat
@ nstr,17 GET ko VALID Poisk_ns('dv_79.ko',.F.,6,11,30) ERROR 'H¥â â ª®£® ª®¤ ...'
@ nstr,25 GET kp VALID Poisk_ns('dv_79.kp',.F.,7,11,30) ERROR 'H¥â â ª®£® ª®¤ ...'
@ nstr,38 GET kor VALID Poisk_kk() ERROR 'H¥â â ª®£® áç¥â ...'
@ nstr,43 GET summa PICTURE '999,999,999,999.99'
@ nstr,62 GET text FUNCTION 'S17'
READ
RETURN
*
PROCEDURE Poisk_kk
PRIVATE sss
DO CASE
CASE tek_b_37#ko.AND.tek_b_37#kp
    REPLACE kor WITH nastf_u
    RETURN .T.
CASE (tek_b_37=ko.OR.tek_b_37=kp).AND.kor=nastf_u
    RETURN .F.
OTHERWISE
    sss=Poisk_sc('dv_79.kor',.F.,.F.,0,0,0,' ','.F.')
    IF LEFT(kor,2)='68'.OR.LEFT(kor,2)='69'
         REPLACE text WITH spr_bs.nam
    ENDIF
    RETURN sss
ENDCASE
RETURN
*
PROCEDURE F2d9
PRIVATE fko,fkp,nz,fbs
nz=RECNO()
@ 10,27 FILL TO 16,48 COLOR &color20
SET COLOR TO &color13
@ 9,26,15,47 BOX box_2
SET COLOR TO &color14
fbs=bs
fko=SPACE(LEN(ko))
fkp=SPACE(LEN(kp))
@ 11,28 SAY ' ‘ç¥â.......' GET fbs VALID Poisk_sc('fbs',.T.,.F.,0,0,0,' ','.F.') ERROR '¥â â ª®£® áç¥â ...'
@ 12,28 SAY ' Š®¤ ®â ª®£®' GET fko VALID Poisk_ns('fko',.T.,0,0,0) ERROR 'H¥â â ª®£® ª®¤ ...'
@ 13,28 SAY " Š®¤ ª  ª®¬ã" GET fkp VALID EMPTY(fkp).OR.Poisk_ns('fkp',.T.,0,0,0) ERROR 'H¥â â ª®£® ª®¤ ...'
READ
IF EMPTY(fko)
    RETURN
ENDIF
SET ORDER TO ko_kp
SET EXACT OFF
IF !SEEK(RTRIM(fbs+fko+fkp))
    DO Net_n WITH 10," H¥â â ª®© ¨­ä®p¬ æ¨¨. ®¢â®p¨â¥... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3d9
PRIVATE fko,fkp,nz,fbs
nz=RECNO()
@ 10,27 FILL TO 16,48 COLOR &color20
SET COLOR TO &color13
@ 9,26,15,47 BOX box_2
SET COLOR TO &color14
fbs=bs
fko=SPACE(LEN(ko))
fkp=SPACE(LEN(kp))
@ 11,28 SAY ' ‘ç¥â.......' GET fbs VALID Poisk_sc('fbs',.T.,.F.,0,0,0,' ','.F.') ERROR '¥â â ª®£® áç¥â ...'
@ 12,28 SAY ' Š®¤ ª  ª®¬ã' GET fkp VALID Poisk_ns('fkp',.T.,0,0,0) ERROR 'H¥â â ª®£® ª®¤ ...'
@ 13,28 SAY " Š®¤ ®â ª®£®" GET fko VALID EMPTY(fko).OR.Poisk_ns('fko',.T.,0,0,0) ERROR 'H¥â â ª®£® ª®¤ ...'
READ
IF EMPTY(fkp)
    RETURN
ENDIF
SET ORDER TO kp_ko
SET EXACT OFF
IF !SEEK(RTRIM(fbs+fkp+fko))
    DO Net_n WITH 10," H¥â â ª®© ¨­ä®p¬ æ¨¨. ®¢â®p¨â¥... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4d9
PRIVATE fnrd,nz,fbs
nz=RECNO()
@ 10,27 FILL TO 15,53 COLOR &color20
SET COLOR TO &color13
@ 9,26,14,52 BOX box_2
SET COLOR TO &color14
fbs=bs
fnrd=SPACE(LEN(nrd))
@ 11,28 SAY ' ‘ç¥â...........' GET fbs VALID Poisk_sc('fbs',.T.,.F.,0,0,0,' ','.F.') ERROR '¥â â ª®£® áç¥â ...'
@ 12,28 SAY ' ®¬¥à ¤®ªã¬¥­â ' GET fnrd
READ
SET ORDER TO nrd
SET EXACT OFF
IF !SEEK(RTRIM(fbs+fnrd))
    DO Net_n WITH 10," H¥â â ª®© ¨­ä®p¬ æ¨¨. ®¢â®p¨â¥... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F5d9
PRIVATE fko,fkp,nz,fbs
nz=RECNO()
@ 12,27 FILL TO 16,55 COLOR &color20
SET COLOR TO &color13
@ 11,26,15,54 BOX box_2
SET COLOR TO &color14
fsum=0
@ 13,28 SAY ' ‘ã¬¬ ' GET fsum PICTURE '999,999,999,999.99'
READ
SET ORDER TO summa
SET NEAR ON
SEEK(fsum)
SET NEAR OFF
IF !FOUND()
    SKIP -1
ENDIF
RETURN
*
*
PROCEDURE Chap7a
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
step=1
npolscrm=1
SET COLOR TO &color4
ncolr=78
@ nstrv-8,ncoll FILL TO nstrv+12,ncolr+1 COLOR &color20
@ nstrv-9,ncoll-1,nstrv+11,ncolr+1 BOX "ÉÍ»º¼ÍÈº "
@ nstrv-8 ,ncoll-1 SAY "º              €àå¨¢ ¤¢¨¦¥­¨ï ¯® ¢­ãâà¨å®§ï©áâ¢¥­­ë¬ à áç¥â ¬"
@ nstrv-7 ,ncoll-1 SAY "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ nstrv-6 ,ncoll-1 SAY "º Žâ ª®£®:                                       Œ¥áïæ ¨ £®¤:"
@ nstrv-5 ,ncoll-1 SAY "º Š  ª®¬ã:"
@ nstrv-4 ,ncoll-1 SAY "ÇÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ nstrv-3 ,ncoll-1 SAY "º ®¬¥à³  „ â   ³Žâ ª®£®³ Š ª®¬ã³ «.³Š®àà³       Cã¬¬       ³     ‡  çâ®"
@ nstrv-2 ,ncoll-1 SAY "º¤®ªã¬.³        ³       ³       ³áç¥â³áç¥â³                  ³"
@ nstrv-1 ,ncoll-1 SAY "ÇÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ nstrv+11,ncoll-1 SAY "ÈÍ F1 Ä ¯®¬®éì ÍÍÍ ®¨áª: F2-®â¯à.,F3-¯®«ãç.,F4-¤®ªã¬.,F5-áã¬¬  "
RETURN
*
PROCEDURE Strsay7a
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 6,11 SAY Spr_nam('2',ko,30)
    @ 6,62 SAY ms+' '+god
    @ 7,11 SAY Spr_nam('2',kp,30)
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY nrd
@ nstr, 8 SAY dat
@ nstr,17 SAY ko
@ nstr,25 SAY kp
@ nstr,33 SAY bs
@ nstr,38 SAY kor
@ nstr,43 SAY summa PICTURE '999,999,999,999.99'
@ nstr,62 SAY LEFT(text,17)
RETURN
*
*
PROCEDURE Perex79
PRIVATE scr
SELECT 0
USE dv_79 EXCLUSIVE
SET ORDER TO ko_kp
IF RECCOUNT()=0
    @ 11,18 FILL TO 14,61 COLOR &color20
    SET COLOR TO &color13
    @ 10,17,13,60 box box_1
    SET COLOR TO &color14
    key=2
    @ 11,19 SAY "…áâì ¯®¤®§p¥­¨¥ çâ® ¯¥p¥å®¤ ã¦¥ ¢ë¯®«­¥­."
    @ 12,19 SAY "p®¤®«¦ âì ?"
    @ 12,39 PROMPT " „   "
    @ 12,49 PROMPT " H¥â "
    MENU TO key
    IF key=0.OR.key=2
         USE
         RETURN
    ENDIF
ENDIF
SET COLOR TO &color14
USE
SAVE SCREEN TO scr
HIDE POPUP ALL
SET CLOCK OFF
CLEAR
sss='!del dbf79_'+LTRIM(STR(ntmec,2))+'.exe'
&sss
sss='!lha a dbf79_'+LTRIM(STR(ntmec,2))+' dv_79.* osd_79.* dv79_arc.*'
&sss
sss='!lha s dbf79_'+LTRIM(STR(ntmec,2))
&sss
sss='!del dbf79_'+LTRIM(STR(ntmec,2))+'.lzh'
&sss
RESTORE SCREEN FROM scr
SET CLOCK ON
SHOW POPUP Glavn,Proch,Finr_79
ACTIVATE WINDOW Pog_p
SET COLOR TO &color15
@ 0,0 SAY '°'
SET COLOR TO &color13
@ 0,1 SAY "®¦ «ã©áâ , ¯®¤®¦¤¨â¥..."
ff=nastf_u+'  '
SELECT 0
USE dv79_arc
SET DELETED ON
APPEND FROM dv_79
SET DELETED OFF
REPLACE ms WITH STR(ntmec,2),god WITH nastf_b FOR EMPTY(ms).AND.EMPTY(god)
USE osd_79 EXCLUSIVE
SET ORDER TO nsk
SELECT 0
USE dv_79 EXCLUSIVE
SET ORDER TO ko_kp
SET EXACT OFF
SEEK ff
SCAN FOR !DELETE()
    SELECT osd_79
    IF !SEEK(ff+dv_79.kp)
         APPEND BLANK
         REPLACE nsk WITH dv_79.kp,bs WITH ff
    ENDIF
    IF !SEEK(ff+dv_79.ko)
         APPEND BLANK
         REPLACE nsk WITH dv_79.ko,bs WITH ff
    ENDIF
ENDSCAN
SET EXACT ON
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
SCAN REST WHILE kor=ff FOR !EMPTY(dat).AND.!DELETE()
    SELECT lim_nsk
    SEEK bk.kp+bk.nrd+bk.kor+bk.nzk+bk.vo+DTOC(bk.dat,1)
    SCAN REST WHILE kp=bk.kp.AND.nrd=bk.nrd.AND.kor=bk.kor.AND.nzk=bk.nzk.AND.vo=bk.vo.AND.dat=bk.dat FOR !DELETE()
         SELECT bkr
         APPEND BLANK
         REPLACE nzk WITH bk.nzk,kor WITH bk.kor,nrd WITH bk.nrd,dat WITH bk.dat,;
              text_1 WITH bk.text_1,sm WITH lim_nsk.summa,vo WITH bk.vo,pr_spr WITH bk.pr_spr,;
                 nsk WITH lim_nsk.nsk,kp WITH bk.kp
         SELECT lim_nsk
    ENDSCAN
ENDSCAN
SELECT lim_nsk
USE
SELECT bkr
INDEX ON kor+nsk TAG rab
SET EXACT OFF
SCAN
    SELECT osd_79
    IF !SEEK(ff+bkr.nsk)
         APPEND BLANK
         REPLACE nsk WITH bkr.nsk,bs WITH ff
    ENDIF
    SELECT bkr
ENDSCAN
SET EXACT ON
SELECT osd_79
SCAN FOR !DELETE()
    fnsk=nsk
    sumprs=0
    sumrxs=0
    SELECT bkr
    SET EXACT OFF
    SEEK ff+fnsk
    SET EXACT ON
    SCAN REST WHILE kor=ff.AND.fnsk=nsk
         IF vo='0'
              sumrxs=sumrxs+sm
         ELSE
              sumprs=sumprs+sm
         ENDIF
    ENDSCAN
    SELECT dv_79
    SET EXACT OFF
    SET ORDER TO ko_kp
    SEEK ff+fnsk
    SCAN REST WHILE ff=bs.AND.fnsk=ko FOR !DELETE()
         sumrxs=sumrxs+summa
    ENDSCAN
    SET ORDER TO kp_ko
    SEEK ff+fnsk
    SCAN REST WHILE ff=bs.AND.fnsk=kp FOR !DELETE()
         sumprs=sumprs+summa
    ENDSCAN
    SET EXACT ON
    SELECT osd_79
    sald=db-kr+sumprs-sumrxs
    IF sald>=0
         REPLACE db WITH sald,kr WITH 0.0
    ELSE
         REPLACE kr WITH -sald,db WITH 0.0
    ENDIF
ENDSCAN
SELECT bkr
DELETE TAG rab
ZAP
USE
SELECT osd_79
DELETE FOR db=0.AND.kr=0
PACK
SELECT osd_79
USE
SELECT dv_79
ZAP
USE
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN
