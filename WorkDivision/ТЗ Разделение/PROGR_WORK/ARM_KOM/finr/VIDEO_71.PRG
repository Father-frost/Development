DEFINE POPUP Video FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Video PROMPT " ‚\<¥¤®¬®áâì ¢ë¯« âë ª®¬ ­¤¨à®¢®ç­ëå     "
DEFINE BAR 2 OF Video PROMPT " €p\<å¨¢ ¢å®¤­®© ¨­ä®à¬ æ¨¨              "
ON SELECTION POPUP Video DO Video WITH BAR()
ACTIVATE POPUP Video
RETURN
*
PROCEDURE Video
PARAMETERS ch1
PRIVATE nz,nzz
DO CASE
CASE ch1=1
    fdat1=DATE()
    fdat2=DATE()
    SET COLOR TO &color13
    IF nastf_v=0
         DEFINE WINDOW Zapros FROM 12,45 TO 14,71 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " ‡  ª ª®¥ ç¨á«®" GET fdat1
         READ
         fdat2=fdat1
    ELSE
         DEFINE WINDOW Zapros FROM 12,45 TO 15,72 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " ‘ ª ª®£® ç¨á« " GET fdat1
         @ 1,0 SAY " ® ª ª®¥ ç¨á«®" GET fdat2 VALID fdat2>=fdat1 ERROR 'H¥¢¥p¥­ ¯¥p¨®¤...'
         READ
    ENDIF
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
         ACTIVATE SCREEN
         RETURN
    ENDIF
    IF fdat2<fdat1
         fdat2=fdat1
    ENDIF
          * ACTIVATE WINDOW Pog_p
          * SET COLOR TO &color15
          * @ 0,0 SAY '°'
          * SET COLOR TO &color13
          * @ 0,1 SAY "®¦ «ã©áâ , ¯®¤®¦¤¨â¥..."
      tgod=VAL(nastf_b)
    RESTORE FROM tek_b ADDITIVE
    SELECT sprrab
    SET ORDER TO tab
    SELECT bk
    INDEX ON nzk+kp TO rab
    SET EXACT OFF
    SEEK gfbs
    SET EXACT ON
    DO spis_70 WITH fdat1,fdat2,gfbs
    DELETE TAG rab
CASE ch1=2
    SELECT 0
    USE bk_arc
    SET ORDER TO nzk_kp
    SET EXACT OFF
    SEEK gfbs
    SET EXACT ON
    HIDE POPUP ALL
    DO Vvodn WITH "Chapbr","Strsaybr","Strgetbr",.F.,.T.,.F.,.F.,"nzk#gfbs","",;
                  "F2br","F3br","F4br","F5br","F6br","","","","F10br","",.T.
    USE
    SHOW POPUP Glavn,Bank
ENDCASE
SHOW POPUP Glavn,Bank,Video
RETURN
*
*
PROCEDURE Chapbr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
step=1
npolscrm=1
ncolr=78
SET COLOR TO &color4
@ nstrv-11,ncoll-1,nstrv+11,ncolr+1 BOX "ÉÍ»º¼ÍÈº "
@ nstrv-10,ncoll-1 SAY 'º         € à å ¨ ¢   ¤ ¢ ¨ ¦ ¥ ­ ¨ ï   ¤ ¥ ­ ¥ ¦ ­ ë å   á à ¥ ¤ á â ¢'
@ nstrv- 9,ncoll-1 SAY 'ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶'
@ nstrv- 8,ncoll-1 SAY 'º Ž¯¥à æ¨ï:'
@ nstrv- 7,ncoll-1 SAY 'º Žà£ ­¨§ æ¨ï:                                '+IIF(nastf_11=0,'','Š®¬ã')
@ nstrv-6 ,ncoll-1 SAY 'º „®ªã¬¥­â:'
@ nstrv-5 ,ncoll-1 SAY 'ÇÄÄÄÄÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶'
@ nstrv-4 ,ncoll-1 SAY 'º  « ­.³‚¨¤³‚¨¤³H®¬¥à³ Š®¤   ³H®¬¥à ³  „ â   ³  „ â   ³Š®àà³       ‘ã¬¬       '
@ nstrv-3 ,ncoll-1 SAY 'º  áç¥â ³®¯¥³á¯à³¨áå®¤³®à£ ­¨§³¡ ­ª. ³¤®ªã¬¥­-³ ®¯« âë ³áç¥â³¢ «îâ             '
@ nstrv-2 ,ncoll-1 SAY 'º       ³à æ³1/0³ïé¨© ³(à ¡®â)³¤®ªã¬.³   â    ³        ³    ³                  '
@ nstrv-1 ,ncoll-1 SAY 'ÇÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶'
@ nstrv+11,ncoll-1 SAY 'È ®¨áª: F2-®à£ ­¨§ æ¨ï,F3-¤®ªã¬¥­â,F4-áã¬¬ ,F5-¤ â  Í F6 - íªà ­ Í F10-¯¥ç âì '
RETURN
*
PROCEDURE Strsaybr
PARAMETERS color,nstr,npolscr
SET COLOR TO &color21
IF !pr_v_pr
    SET COLOR TO &color21
    @ 4,12 SAY IIF(vo='0','à¨å®¤',' áå®¤')
    @ 5,15 SAY Spr_nam(pr_spr,kp,30)
    SELECT sprnaz
    SEEK bk_arc.wid_d
    @ 6,12 SAY sprnaz.nam
    SELECT bk_arc
    IF nastf_11=1
         @ 5,51 SAY pr_sprk
         @ 5,53 SAY kpp
         @ 6,48 SAY Spr_nam(pr_sprk,kpp,30)
    ENDIF
    @  9,68 SAY vid_val
    @ 10,61 SAY sm_val PICTURE '999,999,999,999.99'
ENDIF
SET COLOR TO &color
@ nstr, 3 SAY nzk
@ nstr,10 SAY vo
@ nstr,14 SAY pr_spr
@ nstr,17 SAY nvx
@ nstr,23 SAY kp
@ nstr,31 SAY nrd
@ nstr,38 SAY dati
@ nstr,47 SAY dat
@ nstr,56 SAY kor
@ nstr,61 SAY sm PICTURE '999,999,999,999.99'
RETURN
*
PROCEDURE Strgetbr
PARAMETERS nstr,npolscr
@ nstr,14 GET pr_spr VALID pr_spr='0'.OR.pr_spr='1' ERROR '‡­ ç¥­¨¥ 0 - p ¡®â­¨ª, 1 - ®p£ ­¨§ æ¨ï'
@ nstr,23 GET kp VALID Poisk_kp('bk_arc.kp',pr_spr,5,15,30) ERROR '¥â â ª®£® ª®¤ ...'
IF nastf_11=1
    @ 5,51 GET pr_sprk VALID pr_sprk='0'.OR.pr_sprk='1' ERROR '‡­ ç¥­¨¥ 0 - p ¡®â­¨ª, 1 - ®p£ ­¨§ æ¨ï'
    @ 5,53 GET kpp VALID Poisk_kp('bk_arc.kpp',pr_sprk,6,48,30) ERROR '¥â â ª®£® ª®¤ ...'
ENDIF
READ
RETURN
*
PROCEDURE F2br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnrd,fvo,fdat,nz
nz=RECNO()
@ 11,20 FILL TO 16,48 COLOR &color20
SET COLOR TO &color13
@ 10,19,15,47 BOX box_2
SET COLOR TO &color14
fnrd=SPACE(LEN(nrd))
fkp=SPACE(LEN(kp))
IF pr_spr='0'
    @ 12,21 SAY ' ’ ¡¥«ì­ë© ­®¬¥à' GET fkp VALID Poisk_ta('fkp',.T.,0,0,0) ERROR 'H¥â â ª®£® â ¡¥«ì­®£® ­®¬¥à ...'
ELSE
    @ 12,21 SAY ' Š®¤ ®à£ ­¨§ æ¨¨' GET fkp VALID Poisk_kl('fkp',.T.,0,0,0) ERROR 'H¥â â ª®£® ª®¤ ...'
ENDIF
@ 13,21 SAY " H®¬¥à ¤®ªã¬¥­â " GET fnrd
READ
IF EMPTY(fkp)
    RETURN
ENDIF
SET ORDER TO nzk_kp
SET EXACT OFF
IF !SEEK(RTRIM(gfbs+fkp+fnrd))
    DO Net_n WITH 10," H¥â â ª®© ¨­ä®p¬ æ¨¨. ®¢â®p¨â¥... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnrd
nz=RECNO()
fnrd=SPACE(LEN(bk.nrd))
DEFINE WINDOW Zapros FROM 12,22 TO 14,48 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " H®¬¥à ¤®ªã¬¥­â " GET fnrd
READ
RELEASE WINDOW Zapros
IF EMPTY(nrd)
    RETURN
ENDIF
SET ORDER TO nrd
IF !SEEK(gfbs+fnrd)
    DO Net_n WITH 15," H¥â â ª®£® ¤®ªã¬¥­â . ®¢â®p¨â¥... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F4br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk
fpoisk=0
DEFINE WINDOW Zapros FROM 11,32 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " ‘ã¬¬ " GET fpoisk PICTURE '999,999,999,999.99'
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    RETURN
ENDIF
SET ORDER TO summa
SET NEAR ON
SEEK gfbs+STR(fpoisk,15,2)
SET NEAR OFF
IF EOF()
    GO BOTTOM
ELSE
    IF !FOUND().AND.nzk#gfbs
         SKIP -1
         IF nzk#gfbs
              SET EXACT OFF
              SEEK gfbs
              SET EXACT ON
         ENDIF
    ENDIF
ENDIF
RETURN
*
PROCEDURE F5br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk
fpoisk=DATE()
DEFINE WINDOW Zapros FROM 11,43 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " „ â " GET fpoisk
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    RETURN
ENDIF
SET ORDER TO datd
SET NEAR ON
SEEK gfbs+DTOC(fpoisk,1)
SET NEAR OFF
IF EOF()
    GO BOTTOM
ENDIF
RETURN
*
PROCEDURE F6br
IF RECCOUNT()=0
    RETURN
ENDIF
SET COLOR TO &color13
@ 0,0,23,79 BOX "ÉÍ»º¼ÍÈº "
@  4,0 SAY 'Ç'+REPLICATE('Ä',78)+'¶'
@ 10,0 SAY 'Ç'+REPLICATE('Ä',78)+'¶'
@ 14,0 SAY 'Ç'+REPLICATE('Ä',78)+'¶'
@ 17,0 SAY 'Ç'+REPLICATE('Ä',78)+'¶'
SET COLOR TO &color14
@  1, 1 SAY '‚¨¤ ®¯¥à æ¨¨....'+vo
@  1,20 SAY IIF(vo='0','à¨å®¤',' áå®¤')
@  2, 1 SAY 'Žâ ª®£® (ª®¬ã)..'+pr_spr
@  2,19 SAY ' 0 - p ¡®â­¨ª, 1 - ®p£ ­¨§ æ¨ï'
@  3, 1 SAY ' « ­á®¢ë© áç¥â '+nzk
@  3,25 SAY 'Š®àà¥á¯®­¤¨àãîé¨© áç¥â '+kor
@  2,51 SAY '®¬¥à ¨áå®¤ïé¨© (¢å®¤ïé¨©)'
@  3,69 SAY nvx
@  5, 1 SAY 'Š®¤ ¯®«ãç â¥«ï'
@  6, 4 SAY '(¯« â¥«ìé¨ª )'
@  7, 6 SAY kp
IF pr_spr='0'
    @  5,25 SAY '” ¬¨«¨ï ˆ.Ž. '+sprrab.fio
ELSE
    @  5,25 SAY ' ¨¬¥­®¢ ­¨¥ '+skl.ikl
    @  6,21 SAY '„®¯.­ ¨¬¥­®¢ ­¨¥ '+skl.ikld
    @  7,33 SAY skl.ikldd
    @  8,22 SAY 'Žâ¤¥«¥­¨¥ ¡ ­ª  '+skl.otd
    @  9,22 SAY ' áç¥â­ë© áç¥â  '+skl.sch
    @  9,55 SAY 'à¨§­ ª à¥£¨®­  '+skl.pr_reg
ENDIF
@ 11, 1 SAY '®¬¥à ¤®ªã¬¥­â  '+nrd
@ 12, 1 SAY '„ â  ¤®ªã¬¥­â ..'+DTOC(dati)
@ 13, 1 SAY '„ â  ®¯« âë.....'+DTOC(dat)
@ 11,40 SAY '‚¨¤ ¢ «îâë.'+vid_val
@ 11,60 SAY 'Šãàá'+STR(IIF(sm_val=0,0,ROUND(sm/sm_val,5)),15,5)
@ 12,36 SAY '‘ã¬¬  ¢ ¢ «îâ¥ '+STR(sm_val,15,2)
@ 13,36 SAY '‘ã¬¬  ¢ àã¡«ïå '+STR(sm,15,2)
@ 16, 1 SAY '„®£®¢®p...............'+dog
@ 18, 1 SAY '‚¨¤ ¤®ªã¬¥­â ...'+STR(wid_d,2)
SELECT sprnaz
SEEK bk_arc.wid_d
SELECT bk_arc
@ 18,19 SAY sprnaz.nam
@ 18,51 SAY '‚¨¤ â¥ªáâ ......'+STR(wid_t,2)
@ 19, 1 SAY '’¥ªáâ ¤®ªã¬¥­â .'+text_1
@ 20,17 SAY text_2
@ 21,17 SAY text_3
@ 22,17 SAY text_4
READ
RETURN
*
*