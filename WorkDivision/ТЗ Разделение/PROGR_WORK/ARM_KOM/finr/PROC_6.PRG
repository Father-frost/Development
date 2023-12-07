PROCEDURE Chapsk
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=22
ncoll=1
ncolr=78
step=1
npolscrm=2
SET COLOR TO &color4
@ nstrv-6,ncoll-1,nstrv+11,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-6 ,ncoll+5 SAY " F8 - Ø‡•§·‚†¢´•≠®• ¢ Ø´†‚•¶™• "
@ nstrv-5 ,ncoll-1 SAY "∫            à ≠ ‰ Æ ‡ ¨ † Ê ® Ô    Ø Æ     Æ ‡ £ † ≠ ® ß † Ê ® Ô ¨            ∫"
@ nstrv-4 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY "∫ äÆ§   ≥        H†®¨•≠Æ¢†≠®•          ≥     ÉÆ‡Æ§     ≥   äÆ§   ≥  ê†·Á•‚≠Î©  ∫"
@ nstrv-2 ,ncoll-1 SAY "∫Æ‡£†≠®ß≥                              ≥               ≥  °†≠™†  ≥    ·Á•‚     ∫"
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+3 ,ncoll-1 SAY "∫                                                                              "
@ nstrv+4 ,ncoll-1 SAY "∫                                                                              "
@ nstrv+5 ,ncoll-1 SAY "∫                                                                              "
@ nstrv+6 ,ncoll-1 SAY "∫                                                                              "
@ nstrv+7 ,ncoll-1 SAY "∫                                                                              "
@ nstrv+11,ncoll-1 SAY "» èÆ®·™:F2ƒ™Æ§,F3ƒ≠†®¨,F4-p/·Á•‚,F5-™Æ≠‚•™·‚ ÕÕ F9-§ÆØ.p•™¢®ß ÕÕ F10 - Ø•Á†‚Ï "
SAVE SCREEN TO scr
@ nstrv-4 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY "∫ äÆ§   ≥äÆ‡‡•·ØÆ≠§®‡.≥          é‚§•´•≠®•  °†≠™†          ≥  ÉÆ‡Æ§  °†≠™† ≥äÆ§∫"
@ nstrv-2 ,ncoll-1 SAY "∫Æ‡£†≠®ß≥     ·Á•‚    ≥                                    ≥               ≥p•£∫"
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒ∂"
@ nstrv+3 ,ncoll-1 SAY "                                                                              ∫"
@ nstrv+4 ,ncoll-1 SAY "                                                                              ∫"
@ nstrv+5 ,ncoll-1 SAY "                                                                              ∫"
@ nstrv+6 ,ncoll-1 SAY "                                                                              ∫"
@ nstrv+7 ,ncoll-1 SAY "                                                                              ∫"
SAVE SCREEN TO scr1
RESTORE SCREEN FROM scr
RETURN
*
PROCEDURE Strsaysk
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
DO CASE
CASE npolscr=1
    @ nstr,1  SAY kkl
    @ nstr,9  SAY ikl
    @ nstr,40 SAY gor
    @ nstr,56 SAY mfo
    @ nstr,66 SAY sch
CASE npolscr=2
    @ nstr,1  SAY kkl
    @ nstr,9  SAY korr
    @ nstr,23 SAY otd
    @ nstr,60 SAY gorb
    @ nstr,76 SAY pr_reg
ENDCASE
RETURN
*
PROCEDURE Strgetsk
PARAMETERS nstr,npolscr
PRIVATE nz,fkkl,scr,sss
IF EMPTY(kkl)
    pr_per=.T.
    IF nastf_o=1
         RESTORE FROM tek_b ADDITIVE
         tek_b_11=LEFT(RIGHT('0000000'+LTRIM(STR(VAL(tek_b_11)+1,7,0)),LEN(RTRIM(tek_b_11)))+SPACE(7),7)
         REPLACE kkl WITH tek_b_11
         sss=FULLPATH('tek_b.mem')
         SAVE TO &sss ALL LIKE tek_b_??
         RELEASE ALL LIKE tek_b_??
    ENDIF
ELSE
    pr_per=.F.
ENDIF
DO CASE
CASE npolscr=1
    nz=RECNO()
    DO WHILE .T.
         @ nstr,1 GET kkl
         READ
         IF LASTKEY()=27
              IF pr_per
                   prudalv=prudalv+1
                   DELETE
              ENDIF
              RETURN
         ENDIF
         fkkl=kkl
         SET ORDER TO kkl
         IF SEEK(fkkl)
              SKIP
              IF fkkl=kkl
                   DO Net_n WITH 10," í†™Æ© ™Æ§ „¶• •·‚Ï. èÆ¢‚Æ‡®‚•... "
              ELSE
                   GO nz
                   EXIT
              ENDIF
         ELSE
              DO Net_n WITH 10," ä†™†Ô-‚Æ †¢†p®Ô ¢ ·®·‚•¨•. Ç®§®¨Æ, p†ßp„Ë•≠ ®≠§•™·... "
              RETURN
         ENDIF
         GO nz
    ENDDO
    @ nstr,9  GET ikl
    @ nstr,40 GET gor
    @ nstr,56 GET mfo
    @ nstr,66 GET sch
CASE npolscr=2
    @ nstr, 9 GET korr
    @ nstr,23 GET otd
    @ nstr,60 GET gorb
    @ nstr,76 GET pr_reg VALID Poisk_tg('skl.pr_reg') ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
ENDCASE
READ
IF (LASTKEY()#27.OR.READKEY()=271.OR.READKEY()=15).AND.npolscr=2
    SAVE SCREEN TO scr
    DO F9sk
    RESTORE SCREEN FROM scr
ENDIF
RETURN
*
PROCEDURE F2sk
PRIVATE i,fpoisk,nz
nz=RECNO()
@ 15,34 FILL TO 17,48 COLOR &color20
SET COLOR TO &color13
@ 14,33,16,47 BOX "…Õª∫ºÕ»∫ "
SET ORDER TO kkl
SET COLOR TO &color14
fpoisk=SPACE(LEN(kkl))
@ 15,34 SAY " äÆ§" GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ ™Æ§†. èÆ¢‚Æ‡®‚•..."
    IF RECCOUNT()#0
         GO nz
    ENDIF
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3sk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
@ 15,19 FILL TO 17,65 COLOR &color20
SET COLOR TO &color13
@ 14,18,16,64 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color14
SET ORDER TO ikl
fpoisk=SPACE(LEN(ikl))
@ 15,20 SAY "H†®¨•≠Æ¢†≠®•" GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
fpoisk=CHRTRAN(STRTRAN(fpoisk," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü")
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ ≠†®¨•≠Æ¢†≠®Ô. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4sk
PRIVATE fpoisk,nz
nz=RECNO()
@ 10,26 FILL TO 12,56 COLOR &color20
SET COLOR TO &color13
@ 9,25,11,55 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color14
fpoisk=SPACE(LEN(skl.sch))
@ 10,26 SAY " ê†·Á•‚≠Î© ·Á•‚" GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
SET ORDER TO sch
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 13,'H•‚ ‚†™Æ£Æ p†·Á•‚≠Æ£Æ ·Á•‚†...'
    IF RECCOUNT()#0
         GO nz
    ENDIF
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F5sk
IF RECCOUNT()=0
	RETURN
ENDIF
PRIVATE nz
nz=RECNO()
@ 15,23 FILL TO 17,65 COLOR &color20
SET COLOR TO &color13
@ 14,22,16,64 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color14
fpoiskk=SPACE(LEN(ikl))
@ 15,23 SAY " î‡†£¨•≠‚" GET fpoiskk
READ
IF LASTKEY()=27
    RETURN
ENDIF
fpoiskk=CHRTRAN(STRTRAN(fpoiskk," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü")
SET FILTER TO (fpoiskk $ CHRTRAN(STRTRAN(ikl," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü"))
GO TOP
IF EOF()
    SET FILTER TO
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ ß≠†Á•≠®Ô. èÆ¢‚Æ‡®‚•... "
    GO nz
ELSE
    ACTIVATE SCREEN
    DEFINE POPUP listfrag FROM 8,20 TO 18,60 COLOR SCHEME 17 SHADOW IN SCREEN PROMPT FIELD kkl+" "+ikl;
           TITLE ' é‡£†≠®ß†Ê®® · ‰‡†£¨•≠‚Æ¨ ...'+fpoiskk+'...' SCROLL
    ON SELECTION POPUP listfrag DEACTIVATE POPUP listfrag
    ACTIVATE POPUP listfrag
    SET FILTER TO
ENDIF
RETURN
*
PROCEDURE F8sk
IF RECCOUNT()=0
    RETURN
ENDIF
DEFINE WINDOW Zapros FROM 8,3 TO 15,77 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color13
@ 0,1 SAY 'èÆ´„Á†‚•´Ï'+SPACE(45)+'---------------'
@ 1,1 SAY 'äÆ§'+SPACE(42)+'----------|    ·Á. N    |'
@ 2,1 SAY SPACE(45)+'|   äÆ§   |             |'
@ 3,1 SAY 'Å†≠™ ØÆ´.'+SPACE(36)+'|         |             |'
@ 4,1 SAY SPACE(45)+'------------------------|'
@ 5,1 SAY '¢ £.'+SPACE(65)+'|'
SET COLOR TO &color12
@ 0,12 GET ikl
@ 0,42 GET ikl1
@ 1, 5 GET unn
@ 1,16 GET ikld
@ 2, 1 GET ikldd
@ 2,57 GET sch
@ 3,11 GET otd
@ 3,47 GET mfo
@ 3,57 GET korr
@ 4, 1 GET otdd
@ 5, 6 GET gorb
READ
RELEASE WINDOW Zapros
ACTIVATE SCREEN
RETURN
*
PROCEDURE F9sk
@ 13,22 FILL TO 20,79 COLOR &color20
SET COLOR TO &color13
@ 12,21,19,78 BOX box_1
SET COLOR TO &color14
@ 13,23 SAY 'ÑÆØ.≠†®¨.' GET ikl1
@ 14,33 GET ikld
@ 15,33 GET ikldd
@ 16,23 SAY 'äÆ´®Á•·‚¢Æ §≠•© §Æ™„¨•≠‚ÆÆ°ÆpÆ‚†' GET kol_dn
@ 17,23 SAY 'èpÆÊ•≠‚ Ø•≠® ß† §•≠Ï ØpÆ·pÆÁ™®..' GET pr_pen
@ 18,23 SAY 'ìÁ•‚≠Î© ≠Æ¨•‡ ≠†´Æ£ÆØ´†‚•´ÏÈ®™†.' GET unn
READ
RETURN
*
*
PROCEDURE Chapsr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=22
ncoll=19
ncolr=70
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-7,ncoll FILL TO nstrv+11,ncolr+2 COLOR &color20
@ nstrv-8,ncoll-1,nstrv+10,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-7 ,ncoll-1 SAY "∫             ëØ‡†¢ÆÁ≠®™ ‡†°Æ‚≠®™Æ¢"
@ nstrv-6 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-5 ,ncoll-1 SAY "∫ ñ•Â:"
@ nstrv-4 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY "∫í†°•´Ï≠Î©≥  ñ•Â ≥             î.à.é."
@ nstrv-2 ,ncoll-1 SAY "∫  ≠Æ¨•‡  ≥      ≥"
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+10,ncoll-1 SAY "» èÆ®·™:F2ƒ‚†°.≠Æ¨•‡,F3-îàé,F4-‰‡†£¨•≠‚ Õ F10ƒØ•Á†‚Ï "
RETURN
*
PROCEDURE Strsaysr
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    SELECT sch
    SET ORDER TO sch
    SEEK sprrab.cex
    @ 7,25 SAY sch.icsk
    SELECT sprrab
ENDIF
SET COLOR TO &color
@ nstr,21 SAY tab
@ nstr,29 SAY cex
@ nstr,36 SAY fio
RETURN
*
PROCEDURE Strgetsr
PARAMETERS nstr,npolscr
PRIVATE nz,ftab
IF EMPTY(tab)
    pr_per=.T.
ELSE
    pr_per=.F.
ENDIF
nz=RECNO()
DO WHILE .T.
    @ nstr,21 GET tab
    READ
    IF LASTKEY()=27
         IF pr_per
              prudalv=prudalv+1
              DELETE
         ENDIF
         RETURN
    ENDIF
    ftab=tab
    SET ORDER TO tab
    IF SEEK(ftab)
         SKIP
         IF ftab=tab
              DO Net_n WITH 10," í†™Æ© ™Æ§ „¶• •·‚Ï. èÆ¢‚Æ‡®‚•... "
         ELSE
              GO nz
              REPLACE tbn WITH VAL(tab)
              EXIT
         ENDIF
    ELSE
         DO Net_n WITH 10," ä†™†Ô-‚Æ †¢†p®Ô ¢ ·®·‚•¨•. Ç®§®¨Æ, p†ßp„Ë•≠ ®≠§•™·... "
         RETURN
    ENDIF
    GO nz
ENDDO
@ nstr,29 GET cex VALID Poisk_ns('sprrab.cex',.F.,7,25,30) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
@ nstr,36 GET fio
READ
RETURN
*
PROCEDURE F2sr
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
SET ORDER TO tab
nz=RECNO()
@ 15,35 FILL TO 17,59 COLOR &color20
SET COLOR TO &color13
@ 14,34,16,58 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(tab))
@ 15,35 SAY " í†°•´Ï≠Î© ≠Æ¨•‡" GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10,"  H•‚ ‚†™Æ£Æ ≠Æ¨•‡†. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3sr
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
SET ORDER TO fio
nz=RECNO()
@ 15,20 FILL TO 17,71 COLOR &color20
SET COLOR TO &color13
@ 14,19,16,70 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(fio))
@ 15,20 SAY " î†¨®´®Ô à.é." GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ© ‰†¨®´®®. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4sr
IF RECCOUNT()=0
	RETURN
ENDIF
PRIVATE nz
nz=RECNO()
@ 15,23 FILL TO 17,70 COLOR &color20
SET COLOR TO &color13
@ 14,22,16,69 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color14
fpoiskk=SPACE(LEN(fio))
@ 15,23 SAY " î‡†£¨•≠‚" GET fpoiskk
READ
IF LASTKEY()=27
    RETURN
ENDIF
fpoiskk=CHRTRAN(STRTRAN(fpoiskk," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü")
SET FILTER TO (fpoiskk $ CHRTRAN(STRTRAN(fio," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü"))
GO TOP
IF EOF()
    SET FILTER TO
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ ß≠†Á•≠®Ô. èÆ¢‚Æ‡®‚•... "
    GO nz
ELSE
    ACTIVATE SCREEN
    DEFINE POPUP listfrag FROM 8,20 TO 18,60 COLOR SCHEME 17 SHADOW IN SCREEN PROMPT FIELD tab+" "+fio;
           TITLE ' ê†°Æ‚≠®™ · ‰‡†£¨•≠‚Æ¨ ...'+fpoiskk+'...' SCROLL
    ON SELECTION POPUP listfrag DEACTIVATE POPUP listfrag
    ACTIVATE POPUP listfrag
    SET FILTER TO
ENDIF
RETURN
*
*
PROCEDURE Chapss
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
DEFINE WINDOW Chapss FROM 4,0 TO 23,79 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chapss
nstrv=5
nstrn=16
ncoll=0
ncolr=77
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-5 ,ncoll SAY "   è ´ † ≠   · Á • ‚ Æ ¢   ° „ Â £ † ´ ‚ • p · ™ Æ £ Æ   „ Á • ‚ †"
@ nstrv-4 ,ncoll SAY "ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒ"
@ nstrv-3 ,ncoll SAY " ê†ß§•´≥      H†®¨•≠Æ¢†≠®•        ≥ HÆ¨•‡ ≥      H†®¨•≠Æ¢†≠®•        ≥ è‡®ß≠†™"
@ nstrv-2 ,ncoll SAY "       ≥        p†ß§•´†           ≥ ·Á•‚† ≥         ·Á•‚†            ≥ ¢†´Ó‚Î"
@ nstrv-1 ,ncoll SAY "ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ"
@ nstrv+11,ncoll SAY "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
@ nstrv+12,ncoll SAY "ÕÕ F1-ØÆ¨ÆÈÏ ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ F10 - Ø•Á†‚Ï ÕÕÕÕÕÕ"
RETURN
*
PROCEDURE Strsayss
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
IF grup#ggrup.AND.pr_v_pr.OR.nstr=nstrv.OR.nstr=nstrn-1
    SELECT spr_grup
    SEEK spr_bs.grup
    SELECT spr_bs
    @ nstr,0 SAY grup
    @ nstr,8 SAY spr_grup.nam
    ggrup=grup
ENDIF
@ nstr,35 SAY bs
@ nstr,43 SAY nam
@ nstr,74 SAY pr_val
RETURN
*
PROCEDURE Strgetss
PARAMETERS nstr,npolscr
@ nstr, 0 GET grup VALID Poisk_sg('spr_bs.grup',.F.,nstr,8,25) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
@ nstr,35 GET bs
@ nstr,43 GET nam
@ nstr,74 GET pr_val VALID pr_val='0'.OR.pr_val='1' ERROR 'á≠†Á•≠®• 0 - Æ°ÎÁ≠Î©, 1 - ¢†´Ó‚≠Î©...'
READ
RETURN
*
*
PROCEDURE Chapsg
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
DEFINE WINDOW Chapsg FROM 6,30 TO 22,64 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Chapsg
nstrv=4
nstrn=15
ncoll=0
ncolr=32
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-4 ,ncoll SAY "        ê†ß§•´Î Ø´†≠† ·Á•‚Æ¢"
@ nstrv-3 ,ncoll SAY "ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
@ nstrv-2 ,ncoll SAY " ê†ß§•´≥      H†®¨•≠Æ¢†≠®•"
@ nstrv-1 ,ncoll SAY "ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
RETURN
*
PROCEDURE Strsaysg
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,2 SAY grup
@ nstr,8 SAY nam
RETURN
*
PROCEDURE Strgetsg
PARAMETERS nstr,npolscr
@ nstr,2 GET grup
@ nstr,8 GET nam
READ
RETURN
*
*
PROCEDURE Chapsc
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=21
ncoll=18
IF nastf_z=0
    ncolr=53
ELSE
    ncolr=63
ENDIF
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-4,ncoll FILL TO nstrv+11,ncolr+2 COLOR &color20
@ nstrv-5,ncoll-1,nstrv+10,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-4 ,ncoll-1 SAY '∫    ëØ‡†¢ÆÁ≠®™ ØÆ§‡†ß§•´•≠®©  (åéã)'
@ nstrv-3 ,ncoll-1 SAY '«ƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'+IIF(nastf_z=0,'','¬ƒƒƒƒƒƒƒƒƒ')+'∂'
@ nstrv-2 ,ncoll-1 SAY '∫ äÆ§ ≥       H†®¨•≠Æ¢†≠®•           '+IIF(nastf_z=0,'','≥Ç®§ Øp-¢†')
@ nstrv-1 ,ncoll-1 SAY '«ƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'+IIF(nastf_z=0,'','¡ƒƒƒƒƒƒƒƒƒ')+'∂'
@ nstrv+10,ncoll-1 SAY "» èÆ®·™:F2ƒ™Æ§,F3-≠†®¨•≠ÕÕ F10-Ø•Á†‚Ï"
RETURN
*
PROCEDURE Strsaysc
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,18 SAY nsk
@ nstr,24 SAY icsk
IF nastf_z=1
    @ nstr,55 SAY vid_pr
ENDIF
RETURN
*
PROCEDURE Strgetsc
PARAMETERS nstr,npolscr
PRIVATE scr
@ nstr,18 GET nsk
@ nstr,24 GET icsk
IF nastf_z=1
    @ nstr,55 GET vid_pr
ENDIF
READ
RETURN
*
PROCEDURE F2sc
PRIVATE fpoisk,nz,scr
nz=RECNO()
@ 8,42 FILL TO 12,62 COLOR &color20
SET COLOR TO &color13
@ 7,41,11,61 BOX "…Õª∫ºÕ»∫ "
@ 7,46 SAY " èÆ®·™ åéã "
@ 8,42,10,60 BOX "⁄ƒø≥Ÿƒ¿≥ "
SET ORDER TO sch
SET COLOR TO &color14
@ 9,43 SAY " äÆ§ åéã..."
fpoisk=SPACE(LEN(nsk))
@ 9,55 GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
IF SEEK(RTRIM(fpoisk))
    RETURN
ENDIF
DO Net_n WITH 10," H•‚ ‚†™Æ£Æ åéã. èÆ¢‚Æ‡®‚•... "
IF RECCOUNT()#0
     GO nz
ENDIF
RETURN
*
PROCEDURE F3sc
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz,scr
nz=RECNO()
fpoisk=SPACE(LEN(icsk))
DEFINE WINDOW Zapros FROM 7,17 TO 9,62 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "ç†®¨•≠Æ¢†≠®•" GET fpoisk
READ
RELEASE WINDOW Zapros
IF EMPTY(fpoisk)
    RETURN
ENDIF
fpoisk=CHRTRAN(STRTRAN(fpoisk," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü")
SET ORDER TO nam
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ åéã. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
*
PROCEDURE Chapmt
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=22
ncoll=1
ncolr=75
step=1
SET COLOR TO &color4
npolscrm=1
@ nstrv-5,ncoll FILL TO nstrv+12,ncolr+2 COLOR &color20
@ nstrv-6,ncoll-1,nstrv+11,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-5 ,ncoll-1 SAY "∫              ë Ø ‡ † ¢ Æ Á ≠ ® ™     ¨ † ‚ • ‡ ® † ´ Æ ¢"
@ nstrv-4 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY "∫HÆ¨•≠™´†‚„‡≠Î©≥     H†®¨•≠Æ¢†≠®•   ¨†‚•p®†´†   ≥Ö§®≠. ≥Å†´.≥     ñ•≠†      ∫"
@ nstrv-2 ,ncoll-1 SAY "∫    ≠Æ¨•‡     ≥                                ≥®ß¨•‡.≥·Á•‚≥"
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+11,ncoll+3 SAY " èÆ®·™: F2 ƒ ™Æ§, F3 - ≠†®¨•≠Æ¢†≠®•, F4 - ‰‡†£¨•≠‚ "
RETURN
*
PROCEDURE Strsaymt
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,1  SAY mat
@ nstr,16 SAY nam
@ nstr,49 SAY izm
@ nstr,56 SAY bs
@ nstr,61 SAY cen
RETURN
*
PROCEDURE F2mt
PRIVATE fpoisk,nz
nz=RECNO()
SET COLOR TO &color13
@ 15,25 FILL TO 17,54 COLOR &color20
@ 14,24,16,53 BOX "⁄ƒø≥Ÿƒ¿≥ "
SET ORDER TO mat
SET COLOR TO &color14
fpoisk=SPACE(LEN(mat))
@ 15,25 SAY " HÆ¨•‡......." GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
fpoisk=RTRIM(fpoisk)
SET EXACT OFF
SEEK fpoisk
SET EXACT ON
IF FOUND()
    RETURN
ENDIF
DO Net_n WITH 17,"H•‚ ‚†™Æ£Æ ™Æ§†. èÆ¢‚Æ‡®‚•..."
IF RECCOUNT()#0
    GO nz
ENDIF
RETURN
*
PROCEDURE F3mt
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
SET COLOR TO &color13
@ 15,19 FILL TO 17,56 COLOR &color20
@ 14,18,16,55 BOX "⁄ƒø≥Ÿƒ¿≥ "
SET ORDER TO nam
SET COLOR TO &color14
fpoisk=SPACE(LEN(nam))
@ 15,19 SAY " H†®¨•≠Æ¢†≠®• " GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
fpoisk=CHRTRAN(STRTRAN(fpoisk," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü")
SET EXACT OFF
IF !SEEK(fpoisk)
    DO Net_n WITH 17,"H•‚ ‚†™Æ£Æ ≠†®¨•≠Æ¢†≠®Ô. èÆ¢‚Æ‡®‚•..."
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4mt
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
SET COLOR TO &color13
@ 15,24 FILL TO 17,56 COLOR &color20
@ 14,23,16,55 BOX box_2
SET COLOR TO &color14
fpoisk=SPACE(LEN(nam))
@ 15,24 SAY " î‡†£¨•≠‚" GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
fpoisk=CHRTRAN(STRTRAN(fpoisk," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü")
SET FILTER TO (fpoisk $ CHRTRAN(STRTRAN(nam," ",""),"†°¢£§•¶ß®©™´¨≠ÆØ‡·‚„‰ÂÊÁËÈÎÏÍÌÓÔ","ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôõúöùûü"))
GO TOP
IF EOF()
    SET FILTER TO
    DO Net_n WITH 10," H•‚ ‚†™Æ© ®≠‰Æ‡¨†Ê®®. èÆ¢‚Æ‡®‚•... "
    GO nz
ELSE
    ACTIVATE SCREEN
    DEFINE POPUP Listfrag FROM 8,20 TO 18,60 COLOR SCHEME 17 SHADOW IN SCREEN PROMPT FIELD mat+" "+nam;
           TITLE ' å†‚•‡®†´Î · ‰‡†£¨•≠‚Æ¨ ...'+fpoisk+'...' SCROLL
    ON SELECTION POPUP Listfrag DEACTIVATE POPUP Listfrag
    ACTIVATE POPUP Listfrag
    SET FILTER TO
ENDIF
RETURN
*
*  é°Æ‡Æ‚ ØÆ ØÆ·‚†¢È®™„
*
PROCEDURE Chapak1
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-8 ,ncoll-1,nstrv+11,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-7 ,ncoll-1 SAY "∫                  é ° Æ p Æ ‚     Ø Æ    Ø Æ · ‚ † ¢ È ® ™ † ¨"
@ nstrv-6 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-5 ,ncoll-1 SAY "∫ èÆ·‚†¢È®™:                                   ë†´Ï§Æ"
@ nstrv-4 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY "∫  äÆ§    ≥Å†´.≥     C†´Ï§Æ    ≥    C†´Ï§Æ     ≥     é°ÆpÆ‚    ≥    é°ÆpÆ‚"
@ nstrv-2 ,ncoll-1 SAY "∫ ØÆ·‚†¢È.≥·Á•‚≥     §•°•‚     ≥    ™‡•§®‚     ≥     §•°•‚     ≥    ™‡•§®‚"
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+11,ncoll-1 SAY "»Õ F1 ƒ ØÆ¨ÆÈÏ ÕÕÕ F2 ƒ ØÆ®·™ ÕÕ F3 - ·†´Ï§Æ ÕÕ F4 - §¢®¶•≠®• ÕÕ F5 - ÆØ´†‚† "
RETURN
*
PROCEDURE Strsayak1
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 7,15 SAY Spr_nam(pr_spr,kp,30)
    sss=db-kr+smd-smk
    DO CASE
    CASE sss>0
         @ 7,54 SAY '§•°•‚  '+TRANSFORM(sss,'999,999,999,999.99')
    CASE sss<0
         @ 7,54 SAY '™p•§®‚ '+TRANSFORM(-sss,'999,999,999,999.99')
    OTHERWISE
         @ 7,54 SAY SPACE(25)
    ENDCASE
ENDIF
IF !EMPTY(pr_prib)
    SET COLOR TO &color8
    @ nstr,2 SAY pr_prib
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY pr_spr
@ nstr, 3 SAY kp
@ nstr,11 SAY bs
@ nstr,16 SAY db
@ nstr,32 SAY kr
@ nstr,48 SAY smd
@ nstr,64 SAY smk
RETURN
*
PROCEDURE Strgetak1
PARAMETERS nstr,npolscr
IF EMPTY(KP)
    @ 7,15 SAY SPACE(30)
    REPLACE bs WITH f_1
ENDIF
@ nstr,1  GET pr_spr VALID INLIST(pr_spr,'0','1') ERROR 'á≠†Á•≠®• 0 - p†°Æ‚≠®™, 1 - Æp£†≠®ß†Ê®Ô'
@ nstr,3  GET kp VALID IIF(pr_spr='0',Poisk_ta('osdkomr.kp',.F.,7,15,30),Poisk_kl('osdkomr.kp',.F.,7,15,30)) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
@ nstr,11 GET bs VALID Poisk_sc('osdkomr.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H•‚ ‚†™Æ£Æ ·Á•‚†...'
READ
RETURN
*
PROCEDURE F2av1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpois,nz
nz=RECNO()
@ 14,28 FILL TO 16,53 colo &color20
SET COLOR TO &color13
@ 13,26,15,51 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(skl.kkl))
@ 14,28 SAY IIF(pr_spr='1',"äÆ§ Æ‡£†≠®ß†Ê®®","í†°•´Ï≠Î© ≠Æ¨•‡") GET fpoisk VALID IIF(pr_spr='0',Poisk_ta('fpoisk',.T.,0,0,0),Poisk_kl('fpoisk',.T.,0,0,0)) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
READ
IF EMPTY(fpoisk)
    RETURN
ENDIF
SET ORDER TO bs_kp
IF !SEEK(osdkomr.bs+fpoisk)
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ Æ°ÆpÆ‚†. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F3ak1
SELECT osdkom1
SET ORDER TO bs_kp
SET EXACT OFF
SEEK osdkomr.bs+osdkomr.kp
SET EXACT ON
DO Vvodn WITH "Chapok1","Strsayok1","Strgetok1",.F.,.F.,.F.,.F.,;
              "(bs#osdkomr.bs.OR.kp#osdkomr.kp)","","F2ok1","F3ok1","F4ok1","F5ok1","","","","","","",.T.
SELECT osdkomr
RETURN
*
*    è‡Æ·¨Æ‚‡ Æ·‚†‚™Æ¢ ØÆ Æ‡£†≠®ß†Ê®Ô¨
*
PROCEDURE Chapok1
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
RESTORE FROM tek_b ADDITIVE
SET COLOR TO &color4
@ nstrv-9-nastf_3,ncoll-1,nstrv+11,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-8-nastf_3,ncoll-1 SAY "∫           é · ‚ † ‚ ™ ®      Ø Æ     ™ ´ ® • ≠ ‚ † ¨"
@ nstrv-7-nastf_3,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
IF nastf_3=1
    @ nstrv-7 ,ncoll-1 SAY "∫ èÆ§p†ß§•´•≠®•:"
ENDIF
@ nstrv-6 ,ncoll-1 SAY "∫ ép£†≠®ß†Ê®Ô:"
@ nstrv-5 ,ncoll-1 SAY "∫ í•™·‚:"
@ nstrv-4 ,ncoll-1 SAY '«ƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒ'+IIF(nastf_3=0,'ƒƒƒ','')+'¬ƒƒƒƒƒƒƒƒƒƒƒƒ'+IIF(nastf_3=0,'ƒƒƒ','')+IIF(nastf_3=0,'','¬ƒƒƒƒƒ')+'∂'
@ nstrv-3 ,ncoll-1 SAY '∫ N ≥ HÆ¨•p≥'+tek_b_7+'≥  Ñ†‚†  ≥  äÆ§    ≥Å†´.≥äÆ‡.≥    C„¨¨†   '+IIF(nastf_3=0,'   ','')+'≥   C„¨¨†    '+IIF(nastf_3=0,'   ','')+IIF(nastf_3=0,'','≥ äÆ§ ')
@ nstrv-2 ,ncoll-1 SAY '∫Ø/Ø≥Ø´.§Æ™≥'+tek_b_8+'≥        ≥Æ‡£†≠®ß†Ê≥·Á•‚≥·Á•‚≥    §•°•‚   '+IIF(nastf_3=0,'   ','')+'≥   ™‡•§®‚   '+IIF(nastf_3=0,'   ','')+IIF(nastf_3=0,'','≥ØÆ§p.')
@ nstrv-1 ,ncoll-1 SAY '«ƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒ'+IIF(nastf_3=0,'ƒƒƒ','')+'¡ƒƒƒƒƒƒƒƒƒƒƒƒ'+IIF(nastf_3=0,'ƒƒƒ','')+IIF(nastf_3=0,'','¡ƒƒƒƒƒ')+'∂'
@ nstrv+11,ncoll-1 SAY "»Õ èÆ®·™: F2ƒÆp£†≠®ß†Ê®Ô,F3-≠Æ¨•p ííç Õ à‚Æ£: F4-ííç,F5-Æ°È®© Õ F10 - Ø•Á†‚Ï "
RELEASE ALL LIKE tek_b_??
RETURN
*
PROCEDURE Strsayok1
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    ffdat=dat
    ffkp=kp
    ffnrd=nrd
    ffnvx=nvx
    ffpr_spr=pr_spr
    ffbs=bs
    ffnsk=nsk
    ffnpp=npp
    SET COLOR TO &color21
    IF nastf_3=1
         @ 5,17 SAY Spr_nam('0',nsk,30)
    ENDIF
    @ 6,15 SAY Spr_nam(pr_spr,kp,30)
    @ 7,15 SAY text
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY npp
@ nstr, 5 SAY nrd
@ nstr,12 SAY nvx
@ nstr,19 SAY dat
@ nstr,28 SAY pr_spr
@ nstr,30 SAY kp
@ nstr,38 SAY bs
@ nstr,43 SAY kor
@ nstr,48 SAY db PICTURE IIF(nastf_3=0,'','999999999.99')
@ nstr,IIF(nastf_3=0,64,61) SAY kr PICTURE IIF(nastf_3=0,'','999999999.99')
IF nastf_3=1
    @ nstr,74 SAY nsk
ENDIF
RETURN
*
PROCEDURE Strgetok1
PARAMETERS nstr,npolscr
IF EMPTY(kp)
    REPLACE kp WITH ffkp,nvx WITH ffnvx,nrd WITH ffnrd,dat WITH ffdat,pr_spr WITH ffpr_spr,;
            bs WITH ffbs,nsk WITH ffnsk,npp WITH ffnpp
    @ 6,15 SAY SPACE(30)
    @ 7,15 SAY SPACE(50)
ENDIF
@ nstr, 1 GET npp
@ nstr, 5 GET nrd
@ nstr,12 GET nvx
@ nstr,19 GET dat
@ nstr,28 GET pr_spr VALID INLIST(pr_spr,'0','1') ERROR 'á≠†Á•≠®• 0 - p†°Æ‚≠®™, 1 - Æp£†≠®ß†Ê®Ô'
@ nstr,30 GET kp  VALID IIF(pr_spr='1',Poisk_kl('osdkom1.kp',.F.,6,15,30),Poisk_ta('osdkom1.kp',.F.,7,15,30)) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
@ nstr,38 GET bs  VALID Poisk_sc('osdkom1.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H•‚ ‚†™Æ£Æ ·Á•‚†...'
@ nstr,43 GET kor VALID IIF(bs=nastf_2,.T.,Poisk_sc('osdkom1.kor',.F.,.F.,0,0,0,' ','.F.')) ERROR 'H•‚ ‚†™Æ£Æ ·Á•‚†...'
@ nstr,48 GET db PICTURE IIF(nastf_3=0,'','999999999.99')
@ nstr,IIF(nastf_3=0,64,61) GET kr PICTURE IIF(nastf_3=0,'','999999999.99')
IF nastf_3=1
    @ nstr,74 GET nsk VALID IIF(nastf_1#nastf_2.AND.bs=nastf_2,.T.,Poisk_ns('osdkom1.nsk',.F.,5,17,30)) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
ENDIF
@ 7,15 GET text
READ
IF nastf_h=1.AND.EMPTY(uni)
    sss=FULLPATH('unin.mem')
    RESTORE FROM unin ADDITIVE
    unin=unin+1
    SAVE TO &sss ALL LIKE unin
    REPLACE uni WITH unin
    RELEASE unin
ENDIF
RETURN
*
PROCEDURE F2ok1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
@ 14,24 FILL TO 16,52 COLOR &color20
SET COLOR TO &color13
@ 13,23,15,51 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(skl.kkl))
@ 14,25 SAY "äÆ§ Æp£†≠®ß†Ê®®..." GET fpoisk VALID Poisk_kl('fpoisk',.T.,0,0,0) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
READ
IF EMPTY(fpoisk)
    RETURN
ENDIF
SET ORDER TO kp_nrd
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ Æ·‚†‚™†. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3ok1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
@ 14,24 FILL TO 16,43 COLOR &color20
SET COLOR TO &color13
@ 13,23,15,42 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(osdkom1.nvx))
@ 14,25 SAY "HÆ¨•‡ ííç" GET fpoisk
READ
IF EMPTY(fpoisk)
    RETURN
ENDIF
SET ORDER TO nvx
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ Æ·‚†‚™†. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4ok1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnvx,nz,fsumd,fsumk
nz=RECNO()
SET ORDER TO kp_nvx
fkp=kp
fnvx=nvx
IF SEEK(fkp+fnvx)
    SUM db,kr TO fsumd,fsumk REST WHILE fkp=kp.AND.fnvx=nvx
    DO Net_n WITH 14,"Ñ•°•‚ "+STR(fsumd,15,2)+". äp•§®‚ "+STR(fsumk,15,2)+'.'
ENDIF
GO nz
RETURN
*
PROCEDURE F5ok1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fsumd,nz,fsumk
nz=RECNO()
fsumd=0
fsumk=0
fbs=bs
SUM db,kr TO fsumd,fsumk FOR bs=fbs
DO Net_n WITH 14,"à‚Æ£Æ: §•°•‚ - "+STR(fsumd,15,2)+", ™p•§®‚ - "+STR(fsumk,15,2)
GO nz
RETURN
*
PROCEDURE F10ok1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,nlist,fname,chg12,nstr,nnstr,nlist
nz=RECNO()
nlist=1
nnstr=0
nstr=kolstr+1
ffkp=SPACE(7)
SAVE SCREEN
SET COLOR TO &color13
@ 16,41 FILL TO 18,67 COLOR &color20
@ 15,40,17,66 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color14
@ 16,41 SAY " äÆ§ Æ‡£†≠®ß†Ê®®" GET ffkp
READ
RESTORE SCREEN
IF LASTKEY()=27
   RETURN
ENDIF
*
chg12=0
fname="out.txt        "
nlist=1
pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,pr_otk
IF pr_otk
    RETURN
ENDIF
SET DEVICE TO SCREEN
@ 11,23 FILL TO 13,50 COLOR &color20
SET COLOR TO &color15
@ 10,22,12,49 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color13
@ 11,24 SAY "èÆ¶†´„©·‚†, ØÆ§Æ¶§®‚•..."
SET DEVICE TO PRINT
*
DIMENSION mnsk(100,2)
kolns=0
mnsk=0
RESTORE FROM tek_b ADDITIVE
@ PROW(),0 SAY &sgat2
SET ORDER TO kp_nrd
fsumma=0
IF EMPTY(ffkp)
    GO TOP
ELSE
    SET EXACT OFF
    SEEK ffkp
    SET EXACT ON
ENDIF
DO WHILE !EOF()
    fkp=kp
    fsum=0
    kol_or=0
    pr_per=.T.
    SCAN REST WHILE fkp=kp FOR kr#0.AND.!DELETE()
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "ã®·‚ "+STR(nnstr,2)+". à≠‰Æp¨†Ê®Ô ØÆ Æ·‚†‚™†¨ ≠•ÆØ´†Á•≠≠ÎÂ ¨†‚•‡®†´Æ¢ ≠† ≠†Á†´Æ "+tmec+' 19'+nastf_b+' £.'
@ 1,0 SAY REPLICATE('-',82)
@ 2,0 SAY '| äÆ§   |    H†®¨•≠Æ¢†≠®• Æ‡£†≠®ß†Ê®®  | HÆ¨•p|  Ñ†‚†  |'+tek_b_46+'|       ë„¨¨†      |'
@ 3,0 SAY '|Æ‡£†≠®ß|                              |Ø´†‚•¶|        |      |                  |'
@ 4,0 SAY REPLICATE('-',82)
              ENDIF
              nstr=4
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              IF pr_per
                   @ nstr,1 SAY kp
                   @ nstr,9 SAY Spr_nam(pr_spr,kp,30)
                   pr_per=.F.
              ENDIF
              @ nstr,40 SAY nrd
              @ nstr,47 SAY dat
              @ nstr,56 SAY nvx
              @ nstr,63 SAY kr PICTURE '999,999,999,999.99'
         ENDIF
         fsum=fsum+kr
         kol_or=kol_or+1
         IF nastf_3=1
              FOR i=1 TO kolns
                   IF mnsk(i,1)=nsk
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolns
                   kolns=i
                   mnsk(i,1)=nsk
              ENDIF
              mnsk(i,2)=mnsk(i,2)+kr
         ENDIF
    ENDSCAN
    IF kol_or>1
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,1  SAY 'à‚Æ£Æ ØÆ '+fkp
              @ nstr,63 SAY fsum PICTURE '999,999,999,999.99'
         ENDIF
    ENDIF
    IF kol_or>0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,1 SAY REPLICATE('-',81)
         ENDIF
    ENDIF
    fsumma=fsumma+fsum
ENDDO
IF fsumma#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr, 1 SAY 'à‚Æ£Æ'
         @ nstr,63 SAY fsumma PICTURE '999,999,999,999.99'
    ENDIF
ENDIF
IF nastf_3=1
    SELECT sch
    pr_per=.T.
    FOR i=1 TO kolns
         nstr=nstr+1
         IF nnstr>=nlist
              IF pr_per
                   @ nstr, 1 SAY '¢ ‚Æ¨ Á®·´•'
                   pr_per=.F.
              ENDIF
              SEEK mnsk(i,1)
              @ nstr,20 SAY mnsk(i,1)+' '+sch.icsk
              @ nstr,63 SAY mnsk(i,2) PICTURE '999,999,999,999.99'
         ENDIF
    ENDFOR
    SELECT osdkom1
ENDIF
EJECT
RELEASE ALL LIKE tek_b_??
GO nz
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN
*
*   Ñ¢®¶•≠®• ØÆ ØÆ·‚†¢È®™„
*
PROCEDURE F4ak1
SELECT atot
SET ORDER TO avot1
ffnpp=npp
ffdat=dat
ffkp=kp
ffnrd=nrd
ffnvx=nvx
ffpr_spr=pr_spr
ffbs=bs
ffnsk=nsk
SET EXACT OFF
SEEK osdkomr.kp
SET EXACT ON
DO Vvodn WITH "Chapoo1","Strsayoo1","Strgetoo2",.T.,.T.,.T.,.F.,"kp#osdkomr.kp","",;
     "","","F4oo1","","","","","","","",.T.
SELECT osdkomr
REPLACE smd WITH 0,smk WITH 0
SELECT bk
SET ORDER TO bk2
SET EXACT OFF
SEEK f_1+osdkomr.kp
SET EXACT ON
SCAN REST WHILE kor=f_1.AND.kp=osdkomr.kp FOR MONTH(dat)=ntmec.AND.!DELETE()
    SELECT osdkomr
    IF bk.vo='0'
         REPLACE smk WITH smk+bk.sm
    ELSE
         REPLACE smd WITH smd+bk.sm
    ENDIF
ENDSCAN
IF f_1#f_2
    SET EXACT OFF
    SEEK f_2+osdkomr.kp
    SET EXACT ON
    SCAN REST WHILE kor=f_2.AND.kp=osdkomr.kp FOR MONTH(dat)=ntmec.AND.!DELETE()
         SELECT osdkomr
         IF bk.vo='0'
              REPLACE smk WITH smk+bk.sm
         ELSE
              REPLACE smd WITH smd+bk.sm
         ENDIF
    ENDSCAN
ENDIF
SELECT atot
SET ORDER TO bs_kp
SET EXACT OFF
SEEK f_1+osdkomr.kp
SET EXACT ON
SCAN REST WHILE bs=f_1.AND.kp=osdkomr.kp FOR !DELETE()
    SELECT osdkomr
    REPLACE smd WITH smd+atot.smd,smk WITH smk+atot.smk
ENDSCAN
SELECT osdkomr
RETURN
*
* á†Á®·´•≠®•
*
PROCEDURE F5ak1
PRIVATE nz,sss
SAVE SCREEN
@ 16,40 FILL TO 20,68 COLOR &color20
SET COLOR TO &color13
@ 15,39,19,67 BOX box_2
SET COLOR TO &color14
ff2=nastf_2
@ 17,41 SAY " HÆ¨•‡ ·Á•‚† ¢ °†≠™•" GET ff2 VALID Poisk_sc('ff2',.T.,.F.,0,0,0,' ','.F.') ERROR 'H•‚ ‚†™Æ£Æ ·Á•‚†...'
READ
IF LASTKEY()=27.AND.READKEY()#271
    RESTORE SCREEN
    RETURN
ENDIF
@ 11,23 FILL TO 13,50 COLOR &color20
SET COLOR TO &color15
@ 10,22,12,49 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color13
@ 11,24 SAY "èÆ¶†´„©·‚†, ØÆ§Æ¶§®‚•..."
RESTORE FROM tek_b ADDITIVE
IF ff2#tek_b_20
    DO Pr_atot WITH osdkomr.kp,ff2
    tek_b_20=ff2
    sss=FULLPATH('tek_b.mem')
    SAVE TO &sss ALL LIKE tek_b_??
ENDIF
RELEASE ALL LIKE tek_b_??
SELECT atot
SET ORDER TO bs_kp
SELECT osdkom1
SET ORDER TO bs_kp
SELECT bk
SET ORDER TO bk2
SET EXACT OFF
SEEK ff2+osdkomr.kp
DO WHILE kor=ff2.AND.kp=osdkomr.kp.AND.!EOF()
    fnrd=nrd
    sm_bk=0
    SCAN REST WHILE kor=ff2.AND.kp=osdkomr.kp.AND.fnrd=nrd FOR MONTH(dat)=ntmec.AND.vo='1'.AND.pr_spr=osdkomr.pr_spr.AND.!DELETE()
         sm_bk=sm_bk+sm
         fdat=dat
    ENDSCAN
    IF sm_bk#0
         SELECT atot
         sss=0
         pr_poisk=SEEK(f_1+osdkomr.kp+fnrd).AND.smko=0
         IF !pr_poisk
              SELECT osdkom1
              pr_poisk=SEEK(f_1+osdkomr.kp+fnrd).AND.smko=0
         ENDIF
         nz=RECNO()
         IF pr_poisk
              SCAN REST WHILE bs=f_1.AND.kp=osdkomr.kp.AND.nrd=fnrd FOR !DELETE().AND.pr_spr=osdkomr.pr_spr
                   sss=sss+IIF(ALIAS()='ATOT',smk,kr)
              ENDSCAN
              IF sss=sm_bk
                   IF RECCOUNT()#0
                        GO nz
                   ENDIF
                   SCAN REST WHILE bs=osdkomr.bs.AND.kp=osdkomr.kp.AND.nrd=fnrd FOR !DELETE().AND.pr_spr=osdkomr.pr_spr
                        REPLACE smko WITH IIF(ALIAS()='ATOT',smk,kr),bs_op WITH ff2
                        IF nastf_h=1
                             nam_file=ALIAS()
                             funi=uni
                             fsmko=smko
                             SELECT tran_pos
                             APPEND BLANK
                             REPLACE uni WITH funi,dat WITH fdat,nrd WITH fnrd,ms WITH ntmec
                             REPLACE summa WITH fsmko,bs WITH ff2,god WITH nastf_b
                             SELECT &nam_file
                        ENDIF
                   ENDSCAN
              ENDIF
         ENDIF
    ENDIF
ENDDO
SET EXACT ON
SELECT 0
USE dv_kp EXCLUSIVE
SET ORDER TO dat_nrd
ZAP
SELECT atot
SET EXACT OFF
SEEK osdkomr.bs+osdkomr.kp
SET EXACT ON
sss=0
SCAN REST WHILE osdkomr.bs=bs.AND.osdkomr.kp=kp FOR !DELETE().AND.(menu_v=1.OR.!EMPTY(kor)).AND.pr_spr=osdkomr.pr_spr
    IF nastf_h=0
         sss=sss+1
         REPLACE unid WITH sss
    ENDIF
    INSERT INTO dv_kp.dbf (dat, nvx, pr_spr, kor, pr_otk, bs_op, nrd,;
         smk, smko, uni, dat_op, nrd_op, text) VALUES ;
         (atot.dat, atot.nvx, atot.pr_spr, atot.kor,;
         '§', atot.bs_op, atot.nrd, atot.smk,;
         atot.smko, IIF(nastf_h=0,sss,atot.uni), atot.dat_op, atot.nrd_op, atot.text)
ENDSCAN
SELECT osdkom1
SET ORDER TO bs_kp
SET EXACT OFF
SEEK osdkomr.bs+osdkomr.kp
SET EXACT ON
SCAN REST WHILE osdkomr.bs=bs.AND.osdkomr.kp=kp FOR kr#0.AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
    IF nastf_h=0
         sss=sss+1
         REPLACE unid WITH sss
    ENDIF
    INSERT INTO dv_kp.dbf (dat, nvx, pr_spr, kor, pr_otk, bs_op, nrd,;
         smk, smko, uni, dat_op, nrd_op, text) VALUES;
         (osdkom1.dat, osdkom1.nvx, osdkom1.pr_spr,;
         osdkom1.kor, '·', osdkom1.bs_op, osdkom1.nrd,;
         osdkom1.kr, osdkom1.smko, IIF(nastf_h=0,sss,osdkom1.uni), osdkom1.dat_op, osdkom1.nrd_op, osdkom1.text)
ENDSCAN
* ØÆ´„Á•≠®• ÆØ´†‚ ØÆ §Æ™„¨•≠‚†¨
SELECT 0
USE bkr EXCLUSIVE
ZAP
SET ORDER TO kp_dat
* ØÆ´„Á•≠®• †¢†≠·Æ¢
SET DELETED ON
APPEND FROM bk FOR kp=osdkomr.kp.AND.kor=ff2.AND.MONTH(dat)=ntmec.AND.pr_spr=osdkomr.pr_spr
SET DELETED OFF
SELECT bk
SET ORDER TO kp
SET EXACT OFF
SEEK ff2+osdkomr.kp
SET EXACT ON
SCAN REST WHILE nzk=ff2.AND.kp=osdkomr.kp FOR MONTH(dat)=ntmec.AND.pr_spr=osdkomr.pr_spr.AND.!DELETE()
    SELECT bkr
    APPEND BLANK
    REPLACE dat WITH bk.dat,kor WITH ff2,kp WITH bk.kp,nrd WITH bk.nrd,pr_spr WITH bk.pr_spr,;
             sm WITH bk.sm,vo WITH IIF(bk.vo='0','1','0')
ENDSCAN
SELECT bkr
REPLACE ALL pr_otk WITH '§',smo WITH 0
SELECT osdkom1
SET EXACT OFF
SEEK ff2+osdkomr.kp
SET EXACT ON
SCAN REST WHILE bs=ff2.AND.kp=osdkomr.kp FOR !DELETE().AND.db#0.AND.pr_spr=osdkomr.pr_spr
    SELECT bkr
    APPEND BLANK
    REPLACE pr_otk WITH '·',pr_spr WITH osdkom1.pr_spr,dat WITH osdkom1.dat,;
               nrd WITH osdkom1.nrd,kor WITH ff2,kp WITH osdkom1.kp,sm WITH osdkom1.db,vo WITH '1'
ENDSCAN
SELECT dv_kp
fsum=0
fsumv=0
sopl=0
del_sum=0
klnrd=SPACE(6)
ON KEY LABEL Tab DO Doc_opl
IF nastf_h=1
	ON KEY LABEL Alt-F3 DO Alt3dd1
	ON KEY LABEL Alt-F4 DO Alt4dd1
	ON KEY LABEL Alt-F5 DO Alt5dd1
    ON KEY LABEL Alt-F7 DO Alt7dd1
ENDIF
DO Vvodn WITH "Chapdd1","Strsaydd1","Strgetdd1",.F.,.T.,.F.,.T.,".F.",;
  "F1dd1","F2dd1","F3dd1","F4dd1","F5dd1","F6dd1","F7dd1","F8dd1","F9dd1","F10dd1","",.T.
ON KEY LABEL Tab
ON KEY LABEL Alt-F3
ON KEY LABEL Alt-F4
ON KEY LABEL Alt-F5
ON KEY LABEL Alt-F7
SELECT bkr
ZAP
USE
SELECT osdkomr
REPLACE smko WITH 0
SELECT dv_kp
SCAN FOR !DELETE()
    IF pr_otk='·'
         SELECT osdkom1
    ELSE
         SELECT atot
    ENDIF
    IF nastf_h=0
         SEEK osdkomr.bs+osdkomr.kp+dv_kp.nrd+dv_kp.kor
         SCAN REST WHILE osdkomr.bs=bs.AND.osdkomr.kp=kp.AND.dv_kp.nrd=nrd.AND.dv_kp.kor=kor FOR dv_kp.uni=unid.AND.!DELETE()
              REPLACE smko WITH dv_kp.smko,bs_op WITH dv_kp.bs_op,;
              osdkomr.smko WITH osdkomr.smko+dv_kp.smko
         ENDSCAN
    ELSE
         SET ORDER TO uni
         IF SEEK(dv_kp.uni)
              REPLACE smko WITH dv_kp.smko,bs_op WITH dv_kp.bs_op
              REPLACE nrd_op WITH dv_kp.nrd_op,dat_op WITH dv_kp.dat_op,;
                osdkomr.smko WITH osdkomr.smko+dv_kp.smko
         ENDIF
    ENDIF
ENDSCAN
USE
SELECT osdkomr
REPLACE pr_prib WITH IIF(smko<(db+smd).AND.(kr+smk)#smko,'*',' ')
RETURN
*
PROCEDURE Doc_opl
PUSH KEY
@ nstr,ncoll FILL TO nstr,ncolr-1 COLOR w+/bg
SELECT bkr
ON KEY LABEL Tab DO Ex_vvodn
DO Vvodn WITH "Chapbkr","Strbkr","",.F.,.F.,.F.,.F.,".F.","","","","","","","","","","","",.F.
@ nstr,ncoll FILL TO nstr,ncolr-1 COLOR w+/n
SET COLOR TO &color21
@ nstr, 2 SAY ' '
@ nstr, 9 SAY ' '
@ nstr,18 SAY ' '
@ nstr,23 SAY ' '
@ nstr,39 SAY ' '
POP KEY
=SYS(2002)
SELECT dv_kp
RETURN
*
PROCEDURE Ex_vvodn
KEYBOARD CHR(27)
@ nstr,ncoll FILL TO nstr,ncolr COLOR w+/BG
SAVE SCREEN TO vscr
RETURN
*
PROCEDURE Chapbkr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=7
nstrn=21
ncoll=56
step=1
npolscrm=1
ncolr=78
RETURN
*
PROCEDURE Strbkr
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,56 SAY pr_otk
@ nstr,58 SAY nrd
@ nstr,64 SAY IIF(vo='1',sm,-sm) PICTURE '999999999999.99'
RETURN
*
*  é°‡†°Æ‚™† ß†Á®·´•≠®Ô
*
PROCEDURE Chapdd1
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=8
nstrn=21
ncoll=1
ncolr=55
step=1
npolscrm=1
@ nstrv-8,ncoll-1,nstrv+16,79 BOX "…Õª∫ºÕ»∫ "
RESTORE FROM tek_b ADDITIVE
SET COLOR TO &color4
@ nstrv-8 ,ncoll-1 SAY '… èÆ®·™: F1-ííç,F2-·„¨¨† Õ F8-·°pÆ· Æ·‚†‚™† §•≠•£ '+IIF(nastf_h=0,'','Õ F9 - ÆØ´†‚Î ')
@ nstrv-7 ,65 SAY ' ëÁ•‚ '+ff2
@ nstrv-7 ,ncoll-1 SAY "∫                 é ° Æ p Æ ‚     Ø Æ     Ø Æ · ‚ † ¢ È ® ™ „   ≥"
@ nstrv-6 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-5 ,ncoll-1 SAY '∫ èÆ·‚†¢È®™:                                           ≥       Å † ≠ ™'
@ nstrv-4 ,ncoll-1 SAY "∫ í•™·‚:                                               √ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY '«ƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥ N Ø´†‚≥  ë„¨¨† §•°•‚  ∫'
@ nstrv-2 ,ncoll-1 SAY '∫ ≥'+tek_b_46+'≥  Ñ†‚†  ≥ä/·Á≥  ë„¨¨† ™‡•§®‚ ≥  ë„¨¨† ÆØ´†‚Î √ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂'
@ nstrv-1 ,ncoll-1 SAY '«ƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
@ nstrv   ,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+1 ,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+2 ,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+3 ,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+4 ,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+5 ,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+6 ,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+7 ,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+8 ,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+9 ,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+10,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+11,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+12,ncoll-1 SAY "∫                                                      ≥"
@ nstrv+13,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+14,ncoll-1 SAY "∫   à‚Æ£Æ              ≥               ≥               ≥"
@ nstrv+15,ncoll-1 SAY "∫   Ç·•£Æ              ≥               ≥               ≥é·‚†‚Æ™"
@ nstrv+16,ncoll-1 SAY "» F3-®‚Æ£ Õ Ñ„°´Ï:F4-§Æ™„¨,F5-·‚pÆ™† Õ F6-°†≠™ Õ F7ƒ·°pÆ· Æ·‚†‚™† Õ F10-Ø•Á†‚ÏÕº"
RELEASE ALL LIKE tek_b_??
SET COLOR TO &color21
sss=0
fsum=0
fsumv=0
SCAN FOR !DELETE()
    sss=sss+smk
    fsumv=fsumv+smko
    IF bs_op=ff2
         fsum=fsum+smko
    ENDIF
ENDSCAN
@ 23,24 SAY sss PICTURE '999999999999.99'
sopl=0
SELECT bkr
i=nstrv-1
SCAN FOR !DELETE()
    sopl=sopl+IIF(vo='1',sm,-sm)
    IF i<nstrn
         @ i,56 SAY pr_otk
         @ i,58 SAY nrd
         @ i,64 SAY IIF(vo='1',sm,-sm) PICTURE '999999999999.99'
         i=i+1
    ENDIF
ENDSCAN
GO TOP
@ 22,64 SAY sopl PICTURE '999999999999.99'
@ 3,15 SAY Spr_nam(osdkomr.pr_spr,osdkomr.kp,30)
SELECT dv_kp
GO TOP
RETURN
*
*
PROCEDURE Strsaydd1
PARAMETERS color,nstr,npolscr
SET COLOR TO &color21
IF !pr_v_pr
    @ 4,9 SAY LEFT(text,46)
ENDIF
@ 22,40 SAY fsum  PICTURE '999999999999.99'
@ 23,40 SAY fsumv PICTURE '999999999999.99'
IF sopl-fsum<0
    SET COLOR TO &color22
ENDIF
@ 23,64 SAY sopl-fsum PICTURE '999999999999.99'
SET COLOR TO &color
@ nstr, 1 SAY pr_otk
@ nstr, 3 SAY nvx
@ nstr,10 SAY dat
@ nstr,19 SAY kor
@ nstr,24 SAY smk
IF smko>smk
    SET COLOR TO w+/r
ENDIF
@ nstr,40 SAY smko
SET COLOR TO n/bg
IF bs_op=ff2
    @ nstr,55 SAY '*'
ELSE
    @ nstr,55 SAY '≥'
ENDIF
RETURN
*
PROCEDURE Strgetdd1
PARAMETERS nstr,npolscr
PRIVATE fsmko
fsmko=smko
@ nstr,40 GET smko
READ
IF fsmko#smko
    IF nastf_h=1
         DO Opl_pos
    ENDIF
    fsum=fsum-fsmko+smko
    fsumv=fsumv-fsmko+smko
ENDIF
REPLACE bs_op WITH IIF(smko=0,'    ',ff2)
RETURN
*
PROCEDURE F1dd1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk1,fpoisk2,nz
nz=RECNO()
@ 10,26 FILL TO 12,47 COLOR &color20
SET COLOR TO &color13
@ 9,25,11,46 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color14
fpoisk=SPACE(6)
@ 10,26 SAY " çÆ¨•p ííç " GET fpoisk
READ
IF LASTKEY()=27
    RETURN
ENDIF
GO TOP
SCAN WHILE fpoisk#nvx
ENDSCAN
IF EOF()
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ ß≠†Á•≠®Ô. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F2dd1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk1,fpoisk2,nz
nz=RECNO()
@ 10,26 FILL TO 12,51 COLOR &color20
SET COLOR TO &color13
@ 9,25,11,50 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color14
fpoisk=0
@ 10,26 SAY " C„¨¨† " GET fpoisk PICTURE '999999999999.99'
READ
IF LASTKEY()=27
    RETURN
ENDIF
GO TOP
SCAN WHILE fpoisk#smk
ENDSCAN
IF EOF()
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ ß≠†Á•≠®Ô. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F3dd1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,fsum,fsum1,fsum2,fkp,fnrd
nz=RECNO()
SET ORDER TO nrd_kor
fkp=osdkomr.kp
fnrd=dv_kp.nrd
SET EXACT OFF
SEEK fnrd
SET EXACT ON
IF FOUND()
    fsum1=0
    SELECT bk
    SET ORDER TO kp_kor
    SEEK fkp+fnrd+ff2
    SCAN REST WHILE fkp=kp.AND.fnrd=nrd.AND.kor=ff2 FOR MONTH(dat)=ntmec.AND.!DELETE()
         fsum1=fsum1+IIF(vo='1',sm,-sm)
    ENDSCAN
    SELECT dv_kp
    fsum=0
    fsum2=0
    SCAN REST WHILE fnrd=nrd FOR !DELETE()
         fsum=fsum+dv_kp.smk
         fsum2=fsum2+dv_kp.smko
    ENDSCAN
    del_sum=fsum1-fsum2
    DO Net_n WITH 6," à‚Æ£Æ ØÆ "+fnrd+". ë„¨¨† "+STR(fsum,15,2)+"."+" é·‚†‚Æ™ "+STR(fsum1-fsum2,15,2)
ENDIF
SET ORDER TO dat_nrd
GO nz
RETURN
*
PROCEDURE F4dd1
PRIVATE fsmko,nz,fkp,fnrd
IF EMPTY(nrd).OR.RECCOUNT()=0.OR.!EMPTY(bs_op).AND.bs_op#ff2
    RETURN
ENDIF
nz=RECNO()
SET ORDER TO nrd_kor
fkp=osdkomr.kp
fnrd=nrd
SET EXACT OFF
SEEK fnrd
SET EXACT ON
SCAN REST WHILE fnrd=nrd FOR smk#smko
    fsmko=smko
    REPLACE smko WITH smk
    IF fsmko#smko
         IF nastf_h=1
              DO Opl_pos
              KEYBOARD CHR(13)
         ENDIF
         fsum=fsum-fsmko+smko
         fsumv=fsumv-fsmko+smko
    ENDIF
    REPLACE bs_op WITH IIF(smko=0,'    ',ff2)
ENDSCAN
CLEAR TYPEAHEAD
SET ORDER TO dat_nrd
GO nz
RETURN
*
PROCEDURE F5dd1
IF !EMPTY(bs_op).AND.bs_op#ff2
    RETURN
ENDIF
PRIVATE fsmko
fsmko=smko
IF smko=0.OR.nastf_h=1
    REPLACE smko WITH smk
ENDIF
IF fsmko#smko
    IF nastf_h=1
         DO Opl_pos
    ENDIF
    fsum=fsum-fsmko+smko
    fsumv=fsumv-fsmko+smko
ENDIF
REPLACE bs_op WITH IIF(smko=0,'    ',ff2)
RETURN
*
PROCEDURE F6dd1
PUSH KEY
ON KEY
SELECT bk
SET ORDER TO kp_kor
SET EXACT OFF
SEEK osdkomr.kp
SET EXACT ON
DO Vvodn WITH "Chapbk1","Strsaybk1","Strgetb6",.T.,.T.,.T.,.F.,"osdkomr.kp#kp","",;
  "","","","","","","","","","",.T.
SELECT dv_kp
sss=0
fsum=0
fsumv=0
SCAN FOR !DELETE()
    sss=sss+smk
    fsumv=fsumv+smko
    IF bs_op=ff2
         fsum=fsum+smko
    ENDIF
ENDSCAN
SET COLOR TO &color21
@ 11,56 CLEAR TO 20,78
@ 23,24 SAY sss PICTURE '999999999999.99'
sopl=0
SELECT bkr
i=nstrv-1
SCAN FOR !DELETE()
    sopl=sopl+IIF(vo='1',sm,-sm)
    IF i<nstrn
         @ i,56 SAY pr_otk
         @ i,58 SAY nrd
         @ i,64 SAY IIF(vo='1',sm,-sm) PICTURE '999999999999.99'
         i=i+1
    ENDIF
ENDSCAN
GO TOP
@ 22,64 SAY sopl PICTURE '999999999999.99'
SAVE SCREEN  TO scr1
SELECT dv_kp
GO TOP
POP KEY
RETURN
*
PROCEDURE F7dd1
IF !EMPTY(bs_op).AND.bs_op#ff2
    RETURN
ENDIF
PRIVATE fsmko
fsmko=smko
IF nastf_h=0
    REPLACE smko WITH del_sum
ELSE
    REPLACE smko WITH 0
ENDIF
IF fsmko#smko
    IF nastf_h=1
         DO Opl_pos
    ENDIF
    fsum=fsum-fsmko+smko
    fsumv=fsumv-fsmko+smko
ENDIF
REPLACE bs_op WITH IIF(smko=0,'    ',ff2)
RETURN
*
PROCEDURE F8dd1
IF !EMPTY(bs_op).AND.bs_op#ff2
    RETURN
ENDIF
PRIVATE fsmko,sss,sss1,sss2
sss1=sopl-fsum
sss2=smk-smko
sss=IIF(sss1>sss2.AND.smk>=0.OR.sss1<sss2.AND.smk<0,sss2,sss1)
fsmko=smko
REPLACE smko WITH smko+sss
IF fsmko#smko
    IF nastf_h=1
         DO Opl_pos
    ENDIF
    fsum=fsum-fsmko+smko
    fsumv=fsumv-fsmko+smko
ENDIF
REPLACE bs_op WITH IIF(smko=0,'    ',ff2)
RETURN
*
PROCEDURE F9dd1
IF nastf_h=0
    RETURN
ENDIF
ffuni=uni
SELECT tran_pos
SET EXACT OFF
SEEK STR(ffuni,7)
SET EXACT ON
DO Vvodn WITH "Chapop","Strsayop","Strgetop",.T.,.T.,.T.,.F.,"ffuni#uni","",;
              "","F3op","","","","","","","","",.T.
SELECT dv_kp
RETURN
*
PROCEDURE F10dd1
PRIVATE nlist,fname,chg12,nstr,nnstr,nlist,pt_otk,nz,fbs,fkp,sss,fsum,scr
SAVE SCREEN TO scr
@ 7,45 FILL TO 13,70 COLOR &color20
SET COLOR TO &color13
@ 6,44,12,69 BOX "…Õª∫ºÕ»∫∞"
SET COLOR TO &color14
@  8,46 PROMPT ' Å†≠™ ØÆ Æp£†≠®ß†Ê®®  ' && 1
@ 10,46 PROMPT ' éØ´†‚† ØÆ §Æ™„¨•≠‚†¨ ' && 2
MENU TO menu_v
IF menu_v=0
    RETURN
ENDIF
RESTORE SCREEN FROM scr
nlist=1
nnstr=0
nstr=kolstr+1
*
chg12=0
fname="out.txt        "
nlist=1
m.pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.F.,m.pr_otk
IF m.pr_otk
    RETURN
ENDIF
RESTORE FROM nsch ADDITIVE
*
SET ORDER TO nrd_kor
nz=RECNO()
fkp=osdkomr.kp
DO CASE
CASE menu_v=1
    SELECT bk
    SET ORDER TO kp_kor
    SET EXACT OFF
    SEEK fkp
    SET EXACT ON
    fsumpr=0
    fsumrx=0
    SCAN REST WHILE kp=fkp FOR MONTH(dat)=ntmec.AND.!DELETE().AND.pr_spr='1'
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "ã®·‚ "+STR(nnstr,2)+" à≠‰Æp¨†Ê®Ô Æ §¢®¶•≠®® §•≠•¶≠ÎÂ ·p•§·‚¢ "
@ 1,0 SAY "ØÆ Æp£†≠®ß†Ê®® "+bk.KP+' '+skl.ikl
@ 2,0 SAY REPLICATE('-',59)
@ 3,0 SAY "|Å†´.|HÆ¨•p |  Ñ†‚†  |äÆpp|     ë„¨¨†     |     ë„¨¨†     |"
@ 4,0 SAY "|·Á•‚|§Æ™„¨.| ÆØ´†‚Î |·Á•‚|    Øp®ÂÆ§†    |    p†·ÂÆ§†    |"
@ 5,0 SAY REPLICATE('-',59)
              ENDIF
              nstr=5
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr, 1 SAY nzk
              @ nstr, 6 SAY nrd
              @ nstr,13 SAY dat
              @ nstr,22 SAY kor
              IF vo='0'
                   @ nstr,27 SAY sm
                   fsumpr=fsumpr+sm
              ELSE
                   fsumrx=fsumrx+sm
                   @ nstr,43 SAY sm
              ENDIF
         ENDIF
    ENDSCAN
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',59)
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY "à‚Æ£Æ"
         @ nstr,27 SAY fsumpr PICTURE '999999999999.99'
         @ nstr,43 SAY fsumrx PICTURE '999999999999.99'
    ENDIF
CASE menu_v=2
    DO Pr_razb6
ENDCASE
SELECT dv_kp
SET ORDER TO dat_nrd
IF RECCOUNT()#0
    GO nz
ENDIF
EJECT
SET PRINTER TO
SET DEVICE TO SCREEN
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN
*
PROCEDURE Pr_razb6
PRIVATE scr,nz
SET DEVICE TO SCREEN
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '∞'
SET COLOR TO &color13
@ 0,1 SAY "èÆ¶†´„©·‚†, ØÆ§Æ¶§®‚•..."
@ 1,2 SAY ' Ç·•£Æ ß†Ø®·•©:       '
@ 2,2 SAY ' í•™„È†Ô ß†Ø®·Ï:      '
SET COLOR TO &color14
@ 1,18 SAY RECCOUNT() PICTURE '999999'
@ 2,18 SAY ' '
SET DEVICE TO PRINT
PRIVATE ii
DIMENSION mbs(100,3)
n1=1
n2=10
n3=17
n4=24
n5=32
n6=64
n7=83
n8=92
n9=99
mbs=0
nnstr=0
nstr=kolstr+1
ii=0
GO TOP
fmbs=0
pr_nam=.T.
ffsum=0
ffsumop=0
DO WHILE !EOF()
    fnrd=nrd
    fsum=0
    fsumop=0
    fsmko=0
    mbs=0
    kolbs=0
    fnvx=nvx
    fdat=dat
    SCAN REST WHILE fnrd=nrd
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         fsum=fsum+smk
         fsmko=fsmko+smko
         IF nastf_h=1
              SELECT tran_pos
              SET EXACT OFF
              SEEK STR(dv_kp.uni,7)
              SET EXACT ON
              SCAN REST WHILE uni=dv_kp.uni FOR ms=ntmec.AND.god=nastf_b.AND.!DELETE()
                   FOR i=1 TO kolbs
                        IF mbs(i,1)=dat.AND.mbs(i,2)=nrd
                             EXIT
                        ENDIF
                   ENDFOR
                   IF i>kolbs
                        kolbs=i
                        mbs(i,1)=dat
                        mbs(i,2)=nrd
                   ENDIF
                   mbs(i,3)=mbs(i,3)+summa
                   fsumop=fsumop+summa
              ENDSCAN
         ENDIF
    ENDSCAN
    IF nstr>kolstr
         nnstr=nnstr+1
         DO chap1dd WITH nnstr,nstr,nlist
         pr_nam=.T.
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY fdat
         @ nstr,n2 SAY fnrd
         @ nstr,n3 SAY fnvx
         @ nstr,n4 SAY osdkomr.kp
         IF pr_nam
              @ nstr,n5 SAY Spr_nam(osdkomr.pr_spr,osdkomr.kp,30)
              pr_nam=.F.
         ENDIF
         @ nstr,n6 SAY fsum PICTURE '999,999,999,999.99'
    ENDIF
    IF nastf_h=1
         FOR i=1 TO kolbs
              IF i>1
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO chap1dd WITH nnstr,nstr,nlist
                        pr_nam=.T.
                   ENDIF
                   nstr=nstr+1
              ENDIF
              IF nnstr>=nlist
                   @ nstr,n7 SAY mbs(i,1)
                   @ nstr,n8 SAY mbs(i,2)
                   @ nstr,n9 SAY mbs(i,3) PICTURE '999,999,999,999.99'
              ENDIF
         ENDFOR
         IF kolbs>1
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n7 SAY 'à‚Æ£Æ ÆØ´†Á•≠Æ'
                   @ nstr,n9 SAY fsumop PICTURE '999,999,999,999.99'
              ENDIF
         ENDIF
         IF fsmko#fsumop
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n7 SAY 'éË®°™† ØÆ ÆØ´†‚•'
                   @ nstr,n9 SAY fsmko-fsumop PICTURE '999,999,999,999.99'
              ENDIF
         ENDIF
    ENDIF
    fmbs=fmbs+fsum
    ffsumop=ffsumop+fsumop
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',IIF(nastf_h=1,117,82))
    ENDIF
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "à‚Æ£Æ ØÆ Æp£†≠®ß†Ê®® "+osdkomr.kp
    @ nstr,n5 SAY Spr_nam(osdkomr.pr_spr,osdkomr.kp,30)
    @ nstr,n6 SAY fmbs PICTURE '999,999,999,999.99'
    IF nastf_h=1
         @ nstr,n9 SAY ffsumop PICTURE '999,999,999,999.99'
    ENDIF
ENDIF
nstr=nstr+1
IF nnstr>=nlist
     @ nstr,0 SAY REPLICATE('=',IIF(nastf_h=1,117,82))
ENDIF
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN
*
PROCEDURE Chap1dd
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,0  SAY "ã®·‚ "+STR(nst,2)+'. éØ´†‚† Æ£p„ßÆ™ ß† ¨•·ÔÊ '+tmec+' 19'+nastf_b+' £.'+SPACE(10)+DTOC(DATE())
    @ 1,0  SAY REPLICATE('-',IIF(nastf_h=1,118,83))
    @ 2,0  SAY '|  Ñ†‚†  |HÆ¨•‡ |HÆ¨•‡ |  äÆ§  |        èÆ´„Á†‚•´Ï             |       ë„¨¨†      |'+IIF(nastf_h=1,'  Ñ†‚†  | çÆ¨•‡|       ë„¨¨†      |','')
    @ 3,0  SAY '|        |§Æ™„¨.| ííç  |ØÆ´„Á†‚|                               |                  |'+IIF(nastf_h=1,' ÆØ´†‚Î |§Æ™„¨.|      ÆØ´†‚Î      |','')
    @ 4,0  SAY REPLICATE('-',IIF(nastf_h=1,118,83))
ENDIF
nstr=4
RETURN
*
*
PROCEDURE Chapop
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=14
nstrn=22
ncoll=33
ncolr=77
step=1
npolscrm=1
@ nstrv-3,ncoll FILL TO nstrv+9,ncolr+2 COLOR &color20
SET COLOR TO &color4
@ nstrv-4,ncoll-1,nstrv+8,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-4,ncoll-1 SAY "…ÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕ—ÕÕÕÕÕ"
@ nstrv-3,ncoll-1 SAY "∫  Ñ†‚†  ≥ çÆ¨•‡≥       ë„¨¨†      ≥Å/·Á≥å•·ÔÊ"
@ nstrv-2,ncoll-1 SAY "∫ ÆØ´†‚Î ≥§Æ™„¨.≥      ÆØ´†‚Î      ≥ÆØ´.≥® £Æ§"
@ nstrv-1,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒ∂"
@ nstrv+8,ncoll-1 SAY "»Õ F3 - ®‚Æ£ "
RETURN
*
PROCEDURE Strsayop
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,33 SAY dat
@ nstr,42 SAY nrd
@ nstr,49 SAY summa PICTURE '999,999,999,999.99'
@ nstr,68 SAY bs
@ nstr,73 SAY ms
@ nstr,76 SAY god
RETURN
*
PROCEDURE Strgetop
PARAMETERS nstr,npolscr
IF EMPTY(uni)
    REPLACE uni WITH ffuni
ENDIF
@ nstr,33 GET dat
@ nstr,42 GET nrd
@ nstr,49 GET summa PICTURE '999,999,999,999.99'
@ nstr,68 GET bs VALID Poisk_sc('tran_pos.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H•‚ ‚†™Æ£Æ ·Á•‚†...'
@ nstr,73 GET ms
@ nstr,76 GET god
READ
RETURN
*
PROCEDURE F3op
PRIVATE fsum
fsum=0
SET EXACT OFF
IF SEEK(STR(ffuni,7))
    SCAN REST WHILE ffuni=uni FOR !DELETE()
         fsum=fsum+summa
    ENDSCAN
    DO Net_n WITH 11,"ë„¨¨† "+TRANSFORM(fsum,'999,999,999,999.99')
ENDIF
SEEK STR(ffuni,7)
SET EXACT ON
RETURN
*
*       Ñ¢®¶•≠®• ØÆ °†≠™„ ® ™†··•
*
PROCEDURE Chapbk1
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
step=1
npolscrm=1
ncolr=IIF(nastf_d=1,76,68)
SET COLOR TO &color4
@ nstrv-10,ncoll-1,nstrv+11,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv- 9,ncoll-1 SAY '∫                Ñ¢®¶•≠®• §•≠•¶≠ÎÂ ·‡•§·‚¢ ØÆ °†≠™„ ® ™†··•'
@ nstrv- 8,ncoll-1 SAY '«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'+IIF(nastf_d=0,'','ƒƒƒƒƒƒƒƒ')+'ƒƒƒƒƒƒƒƒ∂'
@ nstrv- 7,ncoll-1 SAY '∫ éØ•‡†Ê®Ô:'
@ nstrv- 6,ncoll-1 SAY '∫ é‡£†≠®ß†Ê®Ô:'
@ nstrv- 5,ncoll-1 SAY '«ƒƒƒ¬ƒƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'+IIF(nastf_d=0,'','¬ƒƒƒ¬ƒƒƒ')+'∂'
@ nstrv- 4,ncoll-1 SAY '∫Ç®§≥HÆ¨•‡≥Å†´.≥ äÆ§   ≥HÆ¨•‡ ≥  Ñ†‚†  ≥  Ñ†‚†  ≥äÆ‡‡≥      ë„¨¨†    '+IIF(nastf_d=0,'','≥Ç®§≥Ç®§')
@ nstrv- 3,ncoll-1 SAY '∫ÆØ•≥®·ÂÆ§≥·Á•‚≥Æ‡£†≠®ß≥°†≠™. ≥§Æ™„¨•≠-≥ ÆØ´†‚Î ≥·Á•‚≥               '+IIF(nastf_d=0,'','≥§Æ™≥‚•™')
@ nstrv- 2,ncoll-1 SAY '∫‡†Ê≥ÔÈ®© ≥    ≥(‡†°Æ‚)≥§Æ™„¨.≥   ‚†   ≥        ≥    ≥               '+IIF(nastf_d=0,'','≥„¨.≥·‚†')
@ nstrv- 1,ncoll-1 SAY '«ƒƒƒ¡ƒƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'+IIF(nastf_d=0,'','¡ƒƒƒ¡ƒƒƒ')+'∂'
RETURN
*
PROCEDURE Strsaybk1
PARAMETERS color,nstr,npolscr
PRIVATE n_str_x
IF !pr_v_pr
    ffvo=vo
    ffnzk=nzk
    ffdat=dat
    ffpr_spr=pr_spr
    SET COLOR TO &color21
    @ 5,20 SAY IIF(bk.vo='0','è‡®ÂÆ§','ê†·ÂÆ§')
    @ 6,20 SAY Spr_nam(pr_spr,kp,30)
ENDIF
SET COLOR TO &color
@ nstr,1  SAY vo
@ nstr,3  SAY pr_spr
@ nstr,5  SAY nvx
@ nstr,11 SAY nzk
@ nstr,16 SAY kp
@ nstr,24 SAY nrd
@ nstr,31 SAY dati
@ nstr,40 SAY dat
@ nstr,49 SAY kor
@ nstr,54 SAY sm
IF nastf_d=1
    @ nstr,70 SAY wid_d
    @ nstr,74 SAY wid_t
ENDIF
RETURN
*
PROCEDURE Strgetb6
PARAMETERS nstr,npolscr
PRIVATE scr,nn_poz,fvo,fnzk,fdat,fnrd,fkor,fsm
pr_new=.F.
IF EMPTY(vo)
    @ 5,20 SAY SPACE(30)
    REPLACE kp WITH osdkomr.kp,pr_spr WITH osdkomr.pr_spr
    pr_new=.T.
ENDIF
fvo=vo
fnvx=nvx
fnzk=nzk
fnrd=nrd
fdat=dat
fkor=kor
fsm=sm
@ nstr,1  GET vo VALID vo='0'.OR.vo='1' ERROR '0 - Ø‡®ÂÆ§, 1 - ‡†·ÂÆ§...'
@ nstr,5  GET nvx
@ nstr,11 GET nzk VALID Poisk_sc('bk.nzk',.F.,.F.,0,0,0,'','.F.') ERROR " H•‚ ‚†™Æ£Æ ·Á•‚†..."
@ nstr,24 GET nrd
@ nstr,40 GET dat VALID EMPTY(dat).OR.nastf_9=0.OR.MONTH(dat)=ntmec.AND.YEAR(dat)=YEAR(DATE()) ERROR 'ç•™Æ‡‡•™‚≠† §†‚†...'
@ nstr,49 GET kor VALID Poisk_sc('bk.kor',.F.,.F.,0,0,0,' ','.F.') ERROR 'ç•‚ ‚†™Æ£Æ ·Á•‚†...'
@ nstr,54 GET sm
READ
IF fnzk=ff2.OR.fkor=ff2.OR.nzk=ff2.OR.kor=ff2
    DO CASE
    CASE (pr_new.OR.fnzk#ff2.AND.fkor#ff2).AND.(nzk=ff2.OR.kor=ff2).AND.MONTH(dat)=ntmec
         * ¢·‚†¢™† ≠Æ¢Æ© ·‚‡Æ™®
         SELECT bkr
         APPEND BLANK
         REPLACE dat WITH bk.dat,kp WITH bk.kp,nrd WITH bk.nrd,pr_spr WITH bk.pr_spr,;
                  sm WITH bk.sm,kor WITH ff2
         IF bk.kor=ff2
              REPLACE vo WITH bk.vo
         ELSE
              REPLACE vo WITH IIF(bk.vo='0','1','0')
         ENDIF
    CASE nzk#ff2.AND.kor#ff2.OR.EMPTY(dat)
         * „§†´•≠®• ·‚‡Æ™®
         SELECT bkr
         IF SEEK(bk.kp+DTOC(fdat,1)+fnrd+ff2)
              DELETE
         ENDIF
    OTHERWISE
         * ™Æ‡‡•™‚®‡Æ¢™†
         SELECT bkr
         IF SEEK(bk.kp+DTOC(fdat,1)+fnrd+ff2)
              REPLACE dat WITH bk.dat,nrd WITH bk.nrd,sm WITH bk.sm
              IF bk.kor=ff2
                   REPLACE vo WITH bk.vo
              ELSE
                   REPLACE vo WITH IIF(bk.vo='0','1','0')
              ENDIF
         ELSE
              DO Net_n WITH 11,'éË®°™† ¢ ·®·‚•¨•...'
         ENDIF
    ENDCASE
ENDIF
SELECT bk
IF LASTKEY()=27
    RETURN
ENDIF
IF nastf_d=1
    @ nstr,70 GET wid_d VALID Poisk_wd('bk.wid_d',.F.,0,0,0) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
    @ nstr,74 GET wid_t VALID Poisk_wt('bk.wid_t') ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
    READ
    SAVE SCREEN TO scr
    @ 7,21 FILL TO 14,74 COLOR &color20
    SET COLOR TO &color13
    @ 6,20,13,73 BOX "…Õª∫ºÕ»∫∞"
    @  8,22 GET text_1
    @  9,22 GET text_2
    @ 10,22 GET text_3
    @ 11,22 GET text_4
    SET COLOR TO &color14
    READ
    RESTORE SCREEN FROM scr
ENDIF
RETURN
*
*   é°‡†°Æ‚™† §¢®¶•≠®Ô
*
PROCEDURE Chapoo1
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=22
ncoll=7
ncolr=IIF(nastf_3=0,71,77)
step=1
npolscrm=1
RESTORE FROM tek_b ADDITIVE
SET COLOR TO &color4
@ nstrv-8-nastf_3,ncoll FILL TO nstrv+12,ncolr+2 COLOR &color20
@ nstrv-9-nastf_3,ncoll-1,nstrv+11,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-8-nastf_3,ncoll-1 SAY "∫         Ñ ¢ ® ¶ • ≠ ® •    Ø Æ     Ø Æ · ‚ † ¢ È ® ™ † ¨"
@ nstrv-7-nastf_3,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"+IIF(nastf_3=0,"∂","ƒƒƒƒƒƒ∂")
IF nastf_3=1
    @ nstrv-7 ,ncoll-1 SAY "∫ èÆ§p†ß§•´•≠®•:"
ENDIF
@ nstrv-6 ,ncoll-1 SAY "∫ èÆ·‚†¢È®™:"
@ nstrv-5 ,ncoll-1 SAY "∫ í•™·‚:"
@ nstrv-4 ,ncoll-1 SAY "«ƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"+IIF(nastf_3=0,"∂","¬ƒƒƒƒƒ∂")
@ nstrv-3 ,ncoll-1 SAY '∫ N ≥ HÆ¨•p≥'+tek_b_7+'≥  Ñ†‚†  ≥  äÆ§    ≥Å†´.≥äÆ‡.≥      C„¨¨†       '+IIF(nastf_3=0,'','≥ äÆ§ ')
@ nstrv-2 ,ncoll-1 SAY '∫Ø/Ø≥Ø´.§Æ™≥'+tek_b_8+'≥        ≥Æ‡£†≠®ß†Ê≥·Á•‚≥·Á•‚≥      ™‡•§®‚      '+IIF(nastf_3=0,'','≥ØÆ§p.')
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"+IIF(nastf_3=0,"∂","¡ƒƒƒƒƒ∂")
@ nstrv+11,ncoll-1 SAY "» èÆ®·™: F2ƒØÆ·‚†¢È®™,F3-≠Æ¨•p ííçÕÕ F4 - ®‚Æ£ ÕÕ F10 - Ø•Á†‚Ï ÕÕÕ"+IIF(nastf_3=0,"º","ÕÕÕÕÕÕº")
RELEASE ALL LIKE tek_b_??
RETURN
*
PROCEDURE Strsayoo1
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    ffdat=dat
    ffkp=kp
    ffnrd=nrd
    ffnvx=nvx
    ffpr_spr=pr_spr
    ffbs=bs
    ffnsk=nsk
    ffnpp=npp
    SET COLOR TO &color21
    IF nastf_3=1
         @ 4,23 SAY Spr_nam('0',nsk,30)
    ENDIF
    @ 5,21 SAY Spr_nam(pr_spr,kp,30)
    @ 6,21 SAY text
ENDIF
SET COLOR TO &color
@ nstr, 7 SAY npp
@ nstr,11 SAY nrd
@ nstr,18 SAY nvx
@ nstr,25 SAY dat
@ nstr,34 SAY pr_spr
@ nstr,36 SAY kp
@ nstr,44 SAY bs
@ nstr,49 SAY kor
@ nstr,54 SAY smk PICTURE '999,999,999,999.99'
IF nastf_3=1
    @ nstr,73 SAY nsk
ENDIF
RETURN
*
PROCEDURE Strgetoo1
PARAMETERS nstr,npolscr
IF EMPTY(kp)
    REPLACE kp WITH ffkp,nvx WITH ffnvx,nrd WITH ffnrd,dat WITH ffdat,pr_spr WITH ffpr_spr,;
            bs WITH ffbs,nsk WITH ffnsk,npp WITH ffnpp
    @ 5,21 SAY SPACE(30)
    @ 6,21 SAY SPACE(50)
ENDIF
@ nstr, 7 GET npp
@ nstr,11 GET nrd
@ nstr,18 GET nvx
@ nstr,25 GET dat
@ nstr,34 GET pr_spr VALID pr_spr='0'.or.pr_spr='1' ERROR 'á≠†Á•≠®• 0 - p†°Æ‚≠®™, 1 - Æp£†≠®ß†Ê®Ô'
@ nstr,36 GET kp VALID IIF(pr_spr='1',Poisk_kl('atot.kp',.F.,5,21,30),Poisk_ta('atot.kp',.F.,6,21,30)) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
@ nstr,44 GET bs VALID Poisk_sc('atot.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H•‚ ‚†™Æ£Æ ·Á•‚†...'
@ nstr,49 GET kor VALID Poisk_sc('atot.kor',.F.,.F.,0,0,0,' ','.F.') ERROR 'H•‚ ‚†™Æ£Æ ·Á•‚†...'
@ nstr,54 GET smk PICTURE '999,999,999,999.99'
IF nastf_3=1
    @ nstr,73 GET nsk VALID Poisk_ns('atot.nsk',.F.,4,23,30) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
ENDIF
@ 6,21 GET text
READ
IF nastf_h=1.AND.EMPTY(uni)
    sss=FULLPATH('unin.mem')
    RESTORE FROM unin ADDITIVE
    unin=unin+1
    SAVE TO &sss ALL LIKE unin
    REPLACE uni WITH unin
    RELEASE unin
ENDIF
IF nastf_m=1.AND.LEFT(kor,1)='2'
    SAVE SCREEN TO scr
    @ 20,44 FILL TO 22,60 COLOR &color20
    SET COLOR TO &color13
    @ 19,43,21,59 BOX "…Õª∫ºÕ»∫ "
    SET COLOR TO &color14
    @ 20,45 SAY nastf_s GET nzk VALID Poisk_nz('atot.nzk',.F.,0,0,0) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
    READ
    RESTORE SCREEN FROM scr
ENDIF
RETURN
*
PROCEDURE Strgetoo2
PARAMETERS nstr,npolscr
IF EMPTY(kp)
    REPLACE kp WITH osdkomr.kp,nvx WITH ffnvx,nrd WITH ffnrd,dat WITH ffdat,pr_spr WITH osdkomr.pr_spr,;
            bs WITH ffbs,nsk WITH ffnsk,npp WITH ffnpp
ENDIF
@ nstr, 7 GET npp
@ nstr,11 GET nrd
@ nstr,18 GET nvx
@ nstr,25 GET dat
@ nstr,44 GET bs VALID Poisk_sc('atot.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'H•‚ ‚†™Æ£Æ ·Á•‚†...'
@ nstr,49 GET kor VALID Poisk_sc('atot.kor',.F.,.F.,0,0,0,' ','.F.') ERROR 'H•‚ ‚†™Æ£Æ ·Á•‚†...'
@ nstr,54 GET smk
IF nastf_3=1
    @ nstr,70 GET nsk VALID Poisk_ns('atot.nsk',.F.,5,23,30) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
ENDIF
READ
IF nastf_h=1.AND.EMPTY(uni)
    sss=FULLPATH('unin.mem')
    RESTORE FROM unin ADDITIVE
    unin=unin+1
    SAVE TO &sss ALL LIKE unin
    REPLACE uni WITH unin
    RELEASE unin
ENDIF
RETURN
*
PROCEDURE F2oo1
PRIVATE fpoisk,nz
nz=RECNO()
@ 14,24 FILL TO 16,49 color &color20
SET COLOR TO &color13
@ 13,23,15,48 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(skl.kkl))
@ 14,25 SAY "äÆ§ Æp£†≠®ß†Ê®®" GET fpoisk VALID Poisk_kl('fpoisk',.T.,0,0,0) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
READ
IF EMPTY(fpoisk)
    RETURN
ENDIF
SET ORDER TO avot1
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ© ®≠‰Æp¨†Ê®®... "
    IF RECCOUNT()#0
         GO nz
    ENDIF
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3oo1
PRIVATE fpoisk,nz
nz=RECNO()
@ 14,24 FILL TO 16,43 color &color20
SET COLOR TO &color13
@ 13,23,15,42 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(atot.nvx))
@ 14,25 SAY "HÆ¨•‡ ííç" GET fpoisk
READ
IF EMPTY(fpoisk)
    RETURN
ENDIF
SET ORDER TO nvx
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ© ®≠‰Æp¨†Ê®®... "
    IF RECCOUNT()#0
         GO nz
    ENDIF
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4oo1
PRIVATE fnvx,nz,fsum,fkp
nz=RECNO()
SET ORDER TO kp_nvx
fnvx=nvx
fkp=kp
IF SEEK(fkp+fnvx)
    SUM smk TO fsum REST WHILE fnvx=nvx.AND.fkp=kp
    DO Net_n WITH 14,"ë„¨¨† "+STR(fsum,15,2)+".è‡Æ§Æ´¶•≠®• - ´Ó°†Ô ™´†¢®Ë†..."
ENDIF
IF RECCOUNT()#0
    GO nz
ENDIF
RETURN
*
PROCEDURE F10oo1
PRIVATE nz,nlist,fname,chg12,nstr,nnstr,nlist
nz=RECNO()
nlist=1
nnstr=0
nstr=kolstr+1
ffbs=SPACE(4)
SAVE SCREEN
SET COLOR TO &color13
@ 16,41 FILL TO 18,64 COLOR &color20
@ 15,40,17,63 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color14
@ 16,41 SAY " äÆpp•·Ø. ·Á•‚.." GET ffbs
READ
RESTORE SCREEN
IF ffbs=' '
   RETURN
ENDIF
*
chg12=0
fname="out.txt        "
nlist=1
pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,pr_otk
IF pr_otk
    RETURN
ENDIF
SET DEVICE TO SCREEN
@ 11,23 FILL TO 13,50 COLOR &color20
SET COLOR TO &color15
@ 10,22,12,49 BOX "…Õª∫ºÕ»∫ "
SET COLOR TO &color13
@ 11,24 SAY "èÆ¶†´„©·‚†, ØÆ§Æ¶§®‚•..."
SET DEVICE TO PRINT
*
DIMENSION mnsk(100,2)
kolns=0
mnsk=0
RESTORE FROM tek_b ADDITIVE
@ PROW(),0 SAY &sgat2
IF pr_setev
    USE atot EXCLUSIVE
ENDIF
INDEX ON kor+kp TAG rab
fsumma=0
SET EXACT OFF
SEEK ffbs
SET EXACT ON
DO WHILE kor=ffbs.AND.!EOF()
    fkp=kp
    fsum=0
    kol_or=0
    pr_per=.T.
    SCAN REST WHILE kor=ffbs.AND.fkp=kp FOR !DELETE()
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "ã®·‚ "+STR(nnstr,2)+"  à≠‰Æp¨†Ê®Ô ØÆ ØÆ´„Á•≠®Ó ØÆ ™Æpp•·ØÆ≠§®p„ÓÈ•¨„ ·Á•‚„ "+ffbs+' ß† ¨•·ÔÊ '+tmec
@ 1,0 SAY REPLICATE('-',82)
@ 2,0 SAY '| äÆ§   |    H†®¨•≠Æ¢†≠®• Æ‡£†≠®ß†Ê®®  | HÆ¨•p|  Ñ†‚†  |'+tek_b_7+'|       ë„¨¨†      |'
@ 3,0 SAY '|Æ‡£†≠®ß|                              |Ø´†‚•¶|        |'+tek_b_8+'|      ØÆ´„Á•≠Æ    |'
@ 4,0 SAY REPLICATE('-',82)
              ENDIF
              nstr=4
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              IF pr_per
                   SELECT atot
                   @ nstr,1 SAY kp
                   @ nstr,9 SAY Spr_nam(pr_spr,kp,30)
                   pr_per=.F.
              ENDIF
              @ nstr,40 SAY nrd
              @ nstr,47 SAY dat
              @ nstr,56 SAY nvx
              @ nstr,63 SAY smk PICTURE '999,999,999,999.99'
         ENDIF
         fsum=fsum+smk
         kol_or=kol_or+1
         IF nastf_3=1
              FOR i=1 TO kolns
                   IF mnsk(i,1)=nsk
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolns
                   kolns=i
                   mnsk(i,1)=nsk
              ENDIF
              mnsk(i,2)=mnsk(i,2)+smk
         ENDIF
    ENDSCAN
    IF kol_or>1
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,1  SAY 'à‚Æ£Æ ØÆ '+fkp
              @ nstr,63 SAY fsum PICTURE '999,999,999,999.99'
         ENDIF
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,1 SAY REPLICATE('-',81)
    ENDIF
    fsumma=fsumma+fsum
ENDDO
IF fsumma#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr, 1 SAY 'à‚Æ£Æ'
         @ nstr,63 SAY fsumma PICTURE '999,999,999,999.99'
    ENDIF
ENDIF
IF nastf_3=1
    SELECT sch
    pr_per=.T.
    FOR i=1 TO kolns
         nstr=nstr+1
         IF nnstr>=nlist
              IF pr_per
                   @ nstr, 1 SAY '¢ ‚Æ¨ Á®·´•'
                   pr_per=.F.
              ENDIF
              SEEK mnsk(i,1)
              @ nstr,20 SAY mnsk(i,1)+' '+sch.icsk
              @ nstr,63 SAY mnsk(i,2) PICTURE '999,999,999,999.99'
         ENDIF
    ENDFOR
    SELECT atot
ENDIF
EJECT
RELEASE ALL LIKE tek_b_??
DELETE TAG rab
IF pr_setev
    USE atot
    SET ORDER TO avot1
ENDIF
IF RECCOUNT()#0
    GO nz
ENDIF
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN
*
*
PROCEDURE Chappr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=13
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-13,ncoll-1,nstrv+10,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-12,ncoll-1 SAY "∫                   è ‡ ® Â Æ § ≠ Î •    § Æ ™ „ ¨ • ≠ ‚ Î                     ∫"
@ nstrv-11,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-10,ncoll-1 SAY "∫ ë™´†§:                                                       ≥     ë„¨¨†     ∫"
@ nstrv-9 ,ncoll-1 SAY "∫ éØ•‡†Ê®Ô:                                                    ≥   ØÆ ·‚‡Æ™•   ∫"
@ nstrv-8 ,ncoll-1 SAY "∫ é‚Ø‡†¢®‚•´Ï:                                                 ≥               ∫"
@ nstrv-7 ,ncoll-1 SAY "∫ å†‚•‡®†´:                      ñ•≠† (·Øp†¢ÆÁ)                √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-6 ,ncoll-1 SAY "∫                                    (ØÆ §Æ™„¨)                ≥   äÆpp.·Á•‚   ∫"
@ nstrv-5 ,ncoll-1 SAY "«ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒ¬ƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒ¥               ∫"
@ nstrv-4 ,ncoll-1 SAY "∫ HÆ¨•‡≥          ≥HÆ¨•‡≥Ç®§≥  äÆ§  ≥HÆ¨•‡ ≥             ≥     ¿ƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY "∫Ø‡®ÂÆ§≥HÆ¨•‡ TTH ≥·™´†-≥ÆØ•≥ Æ‚Ø‡†-≥Ø´†‚•¶≥HÆ¨•™´†‚„‡≠Î©≥ äÆ´®Á•·‚¢Æ≥  Ñ†‚†   ∫"
@ nstrv-2 ,ncoll-1 SAY "∫§Æ™„¨.≥          ≥§†   ≥‡†Ê≥ ¢®‚•´Ô≥‚‡•°Æ¢≥   ≠Æ¨•‡     ≥           ≥         ∫"
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒ¡ƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+10,ncoll-1 SAY "»Õ F1 ƒ ØÆ¨ÆÈÏ ÕÕÕ F2 ƒ ØÆ®·™ ÕÕÕ F3 ƒ ®‚Æ£ ØÆ §Æ™„¨•≠‚„ "
RETURN
*
PROCEDURE Strsaypr
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    SELECT sch
    SEEK pr.nsk
    @ 3,15 SAY sch.icsk
    SELECT so
    SEEK pr.vo
    @ 4,15 SAY so.nop
    DO CASE
    CASE vo="07"
         SELECT sch
         SEEK LEFT(pr.kp,LEN(nsk))
         @ 5,15 SAY sch.icsk
    CASE vo="05"
         SELECT skl
         SET ORDER TO kkl
         SEEK pr.kp
         @ 5,15 SAY skl.ikl
    CASE vo="06"
         SELECT sprrab
         SET ORDER TO tab
         SEEK LEFT(pr.kp,LEN(tab))
         @ 5,15 SAY LEFT(sprrab.fio,30)
    ENDCASE
    SELECT matr
    SET ORDER TO mat
    SEEK pr.mat
    @ 6,12 SAY matr.nam
    @ 6,48 SAY matr.cen
    @ 7,48 SAY pr.cen
    @ 7,9 SAY SPACE(25)
    SELECT pr
    @ 5,64 SAY summa
    @ 8,72 SAY kor
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY npd
@ nstr, 8 SAY np
@ nstr,19 SAY nsk
@ nstr,25 SAY vo
@ nstr,29 SAY kp
@ nstr,37 SAY npt
@ nstr,44 SAY mat
@ nstr,58 SAY kol
@ nstr,70 SAY dat
RETURN
*
PROCEDURE Strgetpr
PARAMETERS nstr,npolscr
IF vo="05"
    fnpt=npt
    @ nstr,37 GET npt
    @ nstr,70 GET dat
    READ
ENDIF
RETURN
*
PROCEDURE F2pr
PRIVATE fnpd,nz
nz=RECNO()
@ 10,23 FILL TO 14,56 COLOR &color20
SET COLOR TO &color13
@ 9,22,13,55 BOX "…Õª∫ºÕ»∫ "
@ 9,34 SAY " èÆ®·™ "
@ 10,23,12,54 BOX "⁄ƒø≥Ÿƒ¿≥ "
SET ORDER TO npd
DO WHILE .T.
    SET COLOR TO &color14
    DO WHILE .T.
         fnpd=SPACE(LEN(npd))
         @ 11,25 SAY " HÆ¨•‡ §Æ™„¨•≠‚†..." GET  fnpd
         READ
         IF LASTKEY()=13.OR.LASTKEY()=27
              EXIT
         ENDIF
    ENDDO
    IF LASTKEY()=27.OR.EMPTY(fnpd)
         EXIT
    ENDIF
    SET ORDER TO npd
    IF SEEK(fnpd)
         RETURN
    ENDIF
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ §Æ™„¨•≠‚†. èÆ¢‚Æp®‚•... "
ENDDO
IF RECCOUNT()#0
    GO nz
ENDIF
RETURN
*
PROCEDURE F3pr
PRIVATE fnpd,nz,scr,fsum
nz=RECNO()
@ 9,19 FILL TO 13,52 COLOR &color20
SET COLOR TO &color13
@ 8,18,12,51 BOX "…Õª∫ºÕ»∫ "
@ 8,25 SAY " à‚Æ£ ØÆ §Æ™„¨•≠‚„ "
@ 9,20,11,49 BOX "⁄ƒø≥Ÿƒ¿≥ "
DO WHILE .T.
    SET COLOR TO &color14
    fnpd=pr.npd
    DO WHILE .T.
         @ 10,21 SAY " HÆ¨•‡ §Æ™„¨•≠‚†..." GET  fnpd
         READ
         IF LASTKEY()=13.OR.LASTKEY()=27
              EXIT
         ENDIF
    ENDDO
    IF LASTKEY()=27.OR.EMPTY(fnpd)
         IF RECCOUNT()#0
              GO nz
         ENDIF
         RETURN
    ENDIF
    SET ORDER TO npd
    IF SEEK(fnpd)
         fsum=0
         nz=RECNO()
         SCAN REST WHILE fnpd=npd FOR !DELETE()
              fsum=fsum+summa
         ENDSCAN
         SAVE SCREEN TO scr
         SET COLOR TO &color13
         @ 13,18,16,51 BOX "⁄ƒø≥Ÿƒ¿≥ "
         SET COLOR TO &color14
         @ 14,20 SAY "ë„¨¨†"
         @ 14,26 SAY fsum PICTURE "99999999999.99"
         @ 15,20 SAY "è‡Æ§Æ´¶•≠®• - ´Ó°†Ô ™´†¢®Ë†..."
         READ
         RESTORE SCREEN FROM scr
    ELSE
         DO Net_n WITH 10," H•‚ ‚†™Æ£Æ §Æ™„¨•≠‚†. èÆ¢‚Æp®‚•..."
    ENDIF
ENDDO
RETURN
*
*
PROCEDURE Chapdm
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=13
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-12,ncoll-1,nstrv+10,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-11,ncoll-1 SAY "∫                   Ñ ¢ ® ¶ • ≠ ® •     Ø Æ     å é ã „                        ∫"
@ nstrv-10,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv- 9,ncoll-1 SAY "∫ åéã:                                  éØ•p†Ê®Ô:              ≥      ë„¨¨†"
@ nstrv- 8,ncoll-1 SAY "∫ èÆ´„Á†‚•´Ï/ØÆ·‚†¢È®™:                                        ≥    ØÆ ·‚‡Æ™•"
@ nstrv- 7,ncoll-1 SAY "∫ å†‚•‡®†´:                     ñ•≠† (·Øp†¢ÆÁ≠)                ≥"
@ nstrv- 6,ncoll-1 SAY "∫ Å/·Á•‚:       Ö§.®ß¨.:             (ØÆ §Æ™„¨)                ≥"
@ nstrv- 5,ncoll-1 SAY "«ƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒ¡ƒƒƒ¬ƒäÆpp.·Á•‚ƒ∂"
@ nstrv- 4,ncoll-1 SAY "∫Ç®§≥äÆ§ ≥ HÆ¨•‡≥        ≥          ≥   äÆ§   ≥ HÆ¨•p≥HÆ¨•™´†‚„‡≠Î©≥"
@ nstrv- 3,ncoll-1 SAY "∫ÆØ•≥åéã†≥ §Æ™„-≥  Ñ†‚†  ≥HÆ¨•p TTH/≥ØÆ´„Á†‚./≥Ø´†‚•¶≥   ≠Æ¨•‡     √ƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv- 2,ncoll-1 SAY "∫‡†Ê≥    ≥ ¨•≠‚†≥        ≥Ñ†‚† ØÆ´„Á≥ØÆ·‚†¢È®™≥§Æ™„¨.≥             ≥äÆ´®Á•·‚¢Æ"
@ nstrv- 1,ncoll-1 SAY "«ƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+10,ncoll-1 SAY "»Õ F1 ƒ ØÆ¨ÆÈÏ ÕÕ F2 - ØÆ®·™ ÕÕ F3 - ®‚Æ£ "
RETURN
*
PROCEDURE Strsaydm
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    IF vo='0'
         @ 4,50 SAY 'Øp®ÂÆ§'
    ELSE
         @ 4,50 SAY 'p†·ÂÆ§'
    ENDIF
    @ 5,24 SAY Spr_nam(pr_spr,kp,30)
    SELECT sch
    SEEK dv_mol.nsk
    @ 4,7 SAY sch.icsk
    SELECT matr
    SET ORDER TO mat
    SEEK dv_mol.mat
    @ 7,25 SAY matr.izm
    @ 7,10 SAY matr.bs
    @ 6,12 SAY matr.nam
    @ 6,48 SAY matr.cen
    @ 7,48 SAY dv_mol.cen
    SELECT dv_mol
    @ 6,64 SAY summa
    @ 9,70 SAY kor
    fvo=vo
    fnsk=nsk
    fnrd=nrd
    fnp=np
    fpr_spr=pr_spr
    fkp=kp
    fnpt=npt
ENDIF
SET COLOR TO &color
@ nstr,2  SAY vo
@ nstr,4  SAY nsk
@ nstr,10 SAY nrd
@ nstr,17 SAY dat
IF vo='0'
    @ nstr,26 SAY np
ELSE
    @ nstr,26 SAY datv
    @ nstr,34 SAY SPACE(2)
ENDIF
@ nstr,37 SAY pr_spr
@ nstr,39 SAY kp
@ nstr,47 SAY npt
@ nstr,54 SAY mat
@ nstr,68 SAY kol
RETURN
*
PROCEDURE F2dm
PRIVATE nz,fnsk,fmat,fvo
@ 6,20 FILL TO 12,57 COLOR &color20
SET COLOR TO &color13
@ 5,19,11,56 BOX "…Õª∫ºÕ»∫ "
@ 5,35 SAY " èÆ®·™ "
@ 6,20,10,55 BOX "⁄ƒø≥Ÿƒ¿≥ "
nz=RECNO()
SET COLOR TO &color14
fvo=SPACE(LEN(vo))
fnsk=SPACE(LEN(nsk))
fmat=SPACE(LEN(mat))
@ 7,21 SAY " Ç®§ ÆØ•p†Ê®®......" GET fvo VALID fvo='0'.or.fvo='1' ERROR "0 - Øp®ÂÆ§, 1 - p†·ÂÆ§..."
@ 8,21 SAY " äÆ§ åéã†.........." GET fnsk
@ 9,21 SAY " HÆ¨•≠™´. ≠Æ¨•‡...." GET fmat
READ
IF !EMPTY(fnsk)
    SET ORDER TO nsk
    SET EXACT OFF
    IF EMPTY(fmat)
         SEEK RTRIM(fvo+fnsk)
    ELSE
         SEEK RTRIM(fvo+fnsk+fmat)
    ENDIF
    SET EXACT ON
    IF !FOUND()
         DO Net_n WITH 13," H•‚ ‚†™Æ© ®≠‰Æp¨†Ê®®. èÆ¢‚Æp®‚•..."
         IF RECCOUNT()#0
              GO nz
         ENDIF
    ENDIF
ENDIF
RETURN
*
PROCEDURE F3dm
PRIVATE fnrd,nz,fsum,fvo
nz=RECNO()
fnrd=NRD
fvo=VO
SET ORDER TO kp
IF SEEK(fvo+fnrd)
    fsum=0
    SCAN REST WHILE fnrd=nrd.AND.vo=fvo FOR !DELETE()
         fsum=fsum+summa
    ENDSCAN
    DO Net_n WITH 13," ë„¨¨† "+STR(fsum,15,2)+". è‡Æ§Æ´¶•≠®• - ´Ó°†Ô ™´†¢®Ë†..."
ENDIF
IF RECCOUNT()#0
    GO nz
ENDIF
RETURN
*
*
PROCEDURE Chaptg
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=21
ncoll=42
ncolr=67
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-5,ncoll-1,nstrv+10,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-4 ,ncoll-1 SAY "∫    ëØ‡†¢ÆÁ≠®™ p•£®Æ≠Æ¢"
@ nstrv-3 ,ncoll-1 SAY "«ƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-2 ,ncoll-1 SAY "∫ äÆ§ ≥   H†®¨•≠Æ¢†≠®•"
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+10,ncoll-1 SAY "»Õ F1 ƒ ØÆ¨ÆÈÏ "
RETURN
*
PROCEDURE Strsaytg
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,42 SAY kod
@ nstr,47 SAY nam
RETURN
*
PROCEDURE Strgettg
PARAMETERS nstr,npolscr
@ nstr,42 GET kod
@ nstr,47 GET nam
READ
RETURN
*
*
PROCEDURE Chapsn
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=13
nstrn=22
ncoll=26
ncolr=62
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-5,ncoll FILL TO nstrv+10,ncolr+2 COLOR &color20
@ nstrv-6,ncoll-1,nstrv+9,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-5 ,ncoll-1 SAY "∫     ëØp†¢ÆÁ≠®™ ¢®§Æ¢ §Æ™„¨•≠‚Æ¢"
@ nstrv-4 ,ncoll-1 SAY "«ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY "∫ Ç®§  ≥      H†®¨•≠Æ¢†≠®• ¢®§†"
@ nstrv-2 ,ncoll-1 SAY "∫§Æ™„¨.≥          §Æ™„¨•≠‚†"
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+9 ,ncoll-1 SAY "»Õ F1 ƒ ØÆ¨ÆÈÏ "
RETURN
*
PROCEDURE Strsaysn
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,28 SAY wid_d
@ nstr,33 SAY nam
RETURN
*
PROCEDURE Strgetsn
PARAMETERS nstr,npolscr
PRIVATE nz,fwid_d,scr
nz=RECNO()
DO WHILE .T.
    @ nstr,28 GET wid_d
    READ
    fwid_d=wid_d
    SET ORDER TO wid_d
    IF SEEK(fwid_d)
         SKIP
         IF fwid_d=wid_d
              DO Net_n WITH 10,' í†™Æ© ™Æ§ „¶• •·‚Ï. èÆ¢‚Æ‡®‚•...'
         ELSE
              GO nz
              EXIT
         ENDIF
    ELSE
         DO Net_n WITH 10," ä†™†Ô-‚Æ †¢†p®Ô ¢ ·®·‚•¨•. Ç®§®¨Æ, p†ßp„Ë•≠ ®≠§•™·..."
         RETURN
    ENDIF
    GO nz
ENDDO
@ nstr,33 GET nam
READ
RETURN
*
*
PROCEDURE Chapsw
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=23
ncoll=1
ncolr=78
step=4
npolscrm=1
SET COLOR TO &color4
@ nstrv-6,ncoll-1,nstrv+12,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-5 ,ncoll-1 SAY "∫                 ë Ø ‡ † ¢ Æ Á ≠ ® ™      ‚ • ™ · ‚ Æ ¢"
@ nstrv-4 ,ncoll-1 SAY "«ƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY "∫ äÆ§ ≥             H † ® ¨ • ≠ Æ ¢ † ≠ ® •              ≥   Ç®§   ≥ H†ß≠†Á•≠®•"
@ nstrv-2 ,ncoll-1 SAY "∫‚•™·‚≥                                                  ≥ÆØ•p†Ê®® ≥  Ø´†‚•¶†"
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+12,ncoll-1 SAY "»Õ F1 ƒ ØÆ¨ÆÈÏ ÕÕ èÆ®·™: F2 ƒ ™Æ§, F3 - ≠†®¨•≠Æ¢†≠®• "
RETURN
*
PROCEDURE Strsaysw
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr  , 2 SAY wid_t
@ nstr  , 7 SAY text_1
@ nstr  ,61 SAY vid_op
@ nstr  ,71 SAY nazn_pl
@ nstr+1, 7 SAY text_2
@ nstr+2, 7 SAY text_3
@ nstr+3, 7 SAY text_4
RETURN
*
PROCEDURE Strgetsw
PARAMETERS nstr,npolscr
PRIVATE nz,fwid_t
nz=RECNO()
DO WHILE .T.
    @ nstr,2 GET wid_t
    READ
    fwid_t=wid_t
    SET ORDER TO wid_t
    IF SEEK(fwid_t)
         SKIP
         IF fwid_t=wid_t
              DO Net_n WITH 10," í†™Æ© ™Æ§ „¶• •·‚Ï. èÆ¢‚Æ‡®‚•... "
         ELSE
              GO nz
              EXIT
         ENDIF
    ELSE
         DO Net_n WITH 10," ä†™†Ô-‚Æ †¢†p®Ô ¢ ·®·‚•¨•. Ç®§®¨Æ, p†ßp„Ë•≠ ®≠§•™·... "
         RETURN
    ENDIF
    GO nz
ENDDO
@ nstr  ,7 GET text_1
@ nstr+1,7 GET text_2
@ nstr+2,7 GET text_3
@ nstr+3,7 GET text_4
@ nstr ,61 GET vid_op
@ nstr ,71 GET nazn_pl
READ
RETURN
*
PROCEDURE F2sw
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz,scr
nz=RECNO()
SET ORDER TO wid_t
fpoisk=0
DEFINE WINDOW Zapros FROM 12,41 TO 14,51 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "äÆ§ " GET fpoisk PICTURE "99"
READ
RELEASE WINDOW Zapros
ACTIVATE SCREEN
IF LASTKEY()=27
    RETURN
ENDIF
IF !SEEK(fpoisk)
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ ¢®§†. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F3sw
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz,scr
nz=RECNO()
SET ORDER TO text
fpoisk=SPACE(LEN(text_1))
DEFINE WINDOW Zapros FROM 12,7 TO 14,73 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "ç†®¨•≠Æ¢†≠®•" GET fpoisk
READ
RELEASE WINDOW Zapros
ACTIVATE SCREEN
IF LASTKEY()=27
    RETURN
ENDIF
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ£Æ ‚•™·‚†. èÆ¢‚Æ‡®‚•... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
*
PROCEDURE Poisk_wd
PARAMETERS fname,pr_memo,n_str,n_poz,kol_zn
*
* fname   - ®¨Ô Ø•p•¨•≠≠Æ© ®´® ‚•™„È•£Æ ØÆ´Ô
* pr_memo - Øp®ß≠†™ Ø•p•¨•≠≠Æ© (.T.) ®´® ØÆ´Ô (.F.)
* n_str   - ≠Æ¨•p ·‚pÆ™®
* n_poz   - ≠Æ¨•p ØÆß®Ê®®
* kol_zn  - ™Æ´®Á•·‚¢Æ ß≠†™Æ¢ ≠†®¨•≠Æ¢†≠®Ô §´Ô ¢Î¢Æ§†
*
PRIVATE f_poisk,nam_file
nam_file=ALIAS()
SELECT sprnaz
IF &fname=0
    DO WHILE &fname=0
         DO Vvodn WITH "Chapsn","Strsaysn","Strgetsn",.T.,.T.,.F.,.F.,".F.","",;
              "","","","","","","","","","",.T.
         IF pr_memo
              &fname=wid_d
         ELSE
              REPLACE &fname WITH wid_d
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO wid_d
    f_poisk=SEEK(&fname)
ENDIF
IF n_str#0
    @ n_str,n_poz SAY LEFT(sprnaz.nam,kol_zn)
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN f_poisk
*
*
PROCEDURE Poisk_wt
PARAMETERS fname
*
* fname   - ®¨Ô ‚•™„È•£Æ ØÆ´Ô
*
PRIVATE f_poisk,nam_file
nam_file=ALIAS()
SELECT sprt
SET ORDER TO wid_t
IF &fname=0
    DO WHILE &fname=0
         DO Vvodn WITH "Chapsw","Strsaysw","Strgetsw",.T.,.T.,.F.,.F.,".F.","",;
                       "F2sw","F3sw","","","","","","","","",.T.
         REPLACE &fname WITH wid_t
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO wid_t
    f_poisk=SEEK(&fname)
ENDIF
SELECT &nam_file
IF text_1=SPACE(50)
    REPLACE text_1 WITH sprt.text_1, text_2 WITH sprt.text_2,;
            text_3 WITH sprt.text_3, text_4 WITH sprt.text_4,;
            vid_op WITH sprt.vid_op,nazn_pl WITH sprt.nazn_pl
ENDIF
RETURN f_poisk
*
*
PROCEDURE Poisk_tg
PARAMETERS fname
*
* fname  - ®¨Ô ‚•™„È•£Æ ØÆ´Ô
*
PRIVATE f_poisk,nam_file,nz
nam_file=ALIAS()
SELECT spr_reg
IF &fname=' '
    DO WHILE &fname=' '
         DO Vvodn WITH "Chaptg","Strsaytg","Strgettg",.T.,.T.,.F.,.F.,".F.","",;
                       "","","","","","","","","","",.F.
         REPLACE &fname WITH kod
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO kod
    nz=RECNO()
    f_poisk=SEEK(&fname)
    IF !f_poisk
         IF RECCOUNT()#0
              GO nz
         ENDIF
    ENDIF
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN f_poisk
*
*
PROCEDURE Net_n
PARAMETERS nn_str,nam_titr
PRIVATE n
n=INT((80-LEN(nam_titr))/2)
DEFINE WINDOW Zapros FROM nn_str,n-2 TO nn_str+2,82-n COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY nam_titr
READ
RELEASE WINDOW Zapros
RETURN
*
*  è‡ÆÊ•§„‡† ØÆ´„Á•≠®Ô §†≠≠ÎÂ ¢ ATOT ®ß PR ® DV_MOL
*
PROCEDURE Priem_6
PARAMETERS p
DEFINE WINDOW Zapros FROM 10,13 TO 12,67 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
fpath=SPACE(25)
@ 0,0 SAY " ì™†¶®‚• Ø„‚Ï §´Ô ‰†©´Æ¢" GET fpath
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    RETURN
ENDIF
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '∞'
SET COLOR TO &color13
@ 0,1 SAY "èÆ¶†´„©·‚†, ØÆ§Æ¶§®‚•..."
@ 1,2 SAY ' Ç·•£Æ ß†Ø®·•©:       '
@ 2,2 SAY ' í•™„È†Ô ß†Ø®·Ï:      '
SET COLOR TO &color14
fpath=RTRIM(fpath)
IF RIGHT(fpath,1)#"\"
    fpath=fpath+"\"
ENDIF
DO CASE
CASE p=1
    IF FILE(fpath+"pr.dbf")
         RESTORE FROM tek_b ADDITIVE
         SELECT 0
         USE atot
         SET ORDER TO bs_kp_nvx
         REPLACE ALL pr_zam WITH ' '
         IF FILE('MATR.DBF')
              SELECT 0
              USE matr
              SET ORDER TO mat
         ENDIF
         SELECT 0
         USE nast_pr
         SELECT 0
         USE (fpath+"PR.DBF")
         RESTORE FROM nastf ADDITIVE
         @ 1,18 SAY RECCOUNT() PICTURE '999999'
         SCAN FOR vo="05".AND.kor=nastf_1.AND.!DELETE()
              @ 2,18 SAY RECNO() PICTURE '999999'
              SELECT atot
              IF !SEEK(pr.kor+pr.kp+IIF(tek_b_47=0,LEFT(pr.np,6),pr.npd)+pr.bs)
                   APPEND BLANK
                   REPLACE nvx WITH IIF(tek_b_47=0,LEFT(pr.np,6),pr.npd),dat WITH pr.dat,kp WITH pr.kp,bs WITH pr.kor,;
                           kor WITH pr.bs,nsk WITH pr.nsk,pr_spr WITH '1',nrd WITH pr.npt
                   IF nastf_h=1.AND.EMPTY(uni)
                        sss=FULLPATH('unin.mem')
                        RESTORE FROM unin ADDITIVE
                        unin=unin+1
                        SAVE TO &sss ALL LIKE unin
                        REPLACE uni WITH unin
                        RELEASE unin
                   ENDIF
              ENDIF
              IF Poisk_alia('MATR')
                   SELECT matr
                   SEEK pr.mat
                   SELECT atot
              ENDIF
              IF pr_zam=' '
                   REPLACE text WITH matr.nam+SPACE(30)
                   REPLACE smk WITH pr.summa,pr_zam WITH '*'
              ELSE
                   REPLACE text WITH RTRIM(text)+','+matr.nam
                   REPLACE smk WITH smk+pr.summa
              ENDIF
              SELECT nast_pr
              SCAN FOR !DELETE()
                   fff=nast_pr.kor
                   IF fff=' '
                        n_kor=' '
                   ELSE
                        n_kor=&fff
                   ENDIF
                   fff=nast_pr.form
                   IF fff=' '
                        n_summa=0
                   ELSE
                        n_summa=&fff
                   ENDIF
                   fff=nast_pr.usl
                   IF fff=SPACE(LEN(nast_pr.usl))
                        n_usl=.T.
                   ELSE
                        n_usl=&fff
                   ENDIF
                   IF n_usl.AND.n_summa#0
                        SELECT atot
                        IF !SEEK(pr.kor+pr.kp+IIF(tek_b_47=0,LEFT(pr.np,6),pr.npd)+n_kor)
                             APPEND BLANK
                             REPLACE bs WITH pr.kor,kp WITH pr.kp,;
                                    nrd WITH pr.npt,kor WITH n_kor,pr_spr WITH '1',;
                                    nvx WITH IIF(tek_b_47=0,LEFT(pr.np,6),pr.npd),dat WITH pr.dat
                             IF nastf_h=1.AND.EMPTY(uni)
                                  sss=FULLPATH('unin.mem')
                                  RESTORE FROM unin ADDITIVE
                                  unin=unin+1
                                  SAVE TO &sss ALL LIKE unin
                                  REPLACE uni WITH unin
                                  RELEASE unin
                             ENDIF
                        ENDIF
                        IF EMPTY(pr_zam)
                             REPLACE smk WITH n_summa,pr_zam WITH '*'
                        ELSE
                             REPLACE smk WITH smk+n_summa
                        ENDIF
                   ENDIF
              ENDSCAN
         ENDSCAN
         RELEASE ALL LIKE nastf*
         RELEASE ALL LIKE tek_b_??
         USE
         IF Poisk_alia('MATR')
              SELECT matr
              USE
         ENDIF
         SELECT atot
         USE
         SELECT nast_pr
         USE
    ELSE
         DO Net_n WITH 11,'H• ≠†©§•≠ ‰†©´: '+fpath+"PR.DBF"+'.'
    ENDIF
CASE p=3
    IF FILE(fpath+"DV_MOL.DBF")
         RESTORE FROM nastf ADDITIVE
         IF FILE('MATR.DBF')
              SELECT 0
              USE matr
              SET ORDER TO mat
         ENDIF
         SELECT 0
         USE atot
         SET ORDER TO bs_kp_nvx
         REPLACE ALL pr_zam WITH ' '
         SELECT 0
         USE (fpath+"DV_MOL.DBF")
         @ 1,18 SAY RECCOUNT() PICTURE '999999'
         SCAN FOR LEFT(vo,1)="0".AND.pr_spr='1'.AND.kor=nastf_1.AND.!DELETE()
              @ 2,18 SAY RECNO() PICTURE '999999'
              SELECT atot
              IF !SEEK(dv_mol.kor+dv_mol.kp+LEFT(dv_mol.np,6)+dv_mol.bs)
                   APPEND BLANK
                   REPLACE nvx WITH dv_mol.np, dat WITH dv_mol.dat,kp WITH dv_mol.kp,;
                            bs WITH dv_mol.kor,kor WITH dv_mol.bs,nsk WITH dv_mol.nsk,;
                        pr_spr WITH dv_mol.pr_spr,nrd WITH dv_mol.npt
                   IF nastf_h=1.AND.EMPTY(uni)
                        sss=FULLPATH('unin.mem')
                        RESTORE FROM unin ADDITIVE
                        unin=unin+1
                        SAVE TO &sss ALL LIKE unin
                        REPLACE uni WITH unin
                        RELEASE unin
                   ENDIF
              ENDIF
              IF Poisk_alia('MATR')
                   SELECT matr
                   SEEK dv_mol.mat
                   SELECT atot
              ENDIF
              IF pr_zam=' '
                   REPLACE text WITH matr.nam+SPACE(30)
                   REPLACE smk WITH dv_mol.summa,pr_zam WITH '*'
              ELSE
                   REPLACE text WITH RTRIM(text)+','+matr.nam
                   REPLACE smk WITH smk+dv_mol.summa
              ENDIF
         ENDSCAN
         RELEASE ALL LIKE nastf_??
         USE IN dv_mol
         USE IN atot
    ELSE
         DO Net_n WITH 11,'H• ≠†©§•≠ ‰†©´: '+fpath+"DV_MOL.DBF"+'.'
    ENDIF
ENDCASE
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN
*
PROCEDURE Poisk_alia
PARAMETERS nam_alias
PRIVATE i,s
FOR i=1 TO 25
	s='SELECT '+STR(i,2)
	&s
    IF ALIAS()=nam_alias
         RETURN .T.
    ENDIF
ENDFOR
RETURN .F.
*
*
PROCEDURE Chapzk
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=21
ncoll=33
ncolr=69
step=1
npolscrm=1
nam_str=''
nam_str1=''
nam_str2=''
DO Nastr WITH "     à≠‰Æ‡¨†Ê®Ô    ØÆ    ",RTRIM(nastf_s),"†¨",37,nam_str
DO Nastr WITH "",RTRIM(nastf_s),"†",6,nam_str1
DO Nastr WITH "         ",RTRIM(nastf_s),"†",30,nam_str2
SET COLOR TO &color4
@ nstrv-5,ncoll FILL TO nstrv+11,ncolr+2 COLOR &color20
@ nstrv-6,ncoll-1,nstrv+10,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-5 ,ncoll-1 SAY "∫"+nam_str+"∫"
@ nstrv-4 ,ncoll-1 SAY "«ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY "∫ äÆ§  ≥       H†®¨•≠Æ¢†≠®•"
@ nstrv-2 ,ncoll-1 SAY "∫"+nam_str1+"≥"+nam_str2+"∫"
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv+10,ncoll-1 SAY "»Õ èÆ®·™: F2 ƒ ™Æ§, F3 - ≠†®¨•≠Æ¢†≠®• "
RETURN
*
PROCEDURE Strsayzk
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,33 SAY nzk
@ nstr,40 SAY nam
RETURN
*
PROCEDURE Strgetzk
PARAMETERS nstr,npolscr
@ nstr,33 GET nzk
@ nstr,40 GET nam
READ
RETURN
*
PROCEDURE F2zk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnpd,nz
nz=RECNO()
fnpd=SPACE(LEN(nzk))
DEFINE WINDOW Zapros FROM 10,41 TO 12,54 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY ' äÆ§' GET fnpd
READ
RELEASE WINDOW Zapros
SET ORDER TO kodzk
IF EMPTY(fnpd)
    RETURN
ENDIF
IF !SEEK(fnpd)
    DO Net_n WITH 14," H•‚ ‚†™Æ£Æ ™Æ§†. èÆ¢‚Æp®‚•..."
    GO nz
ENDIF
RETURN
*
PROCEDURE F3zk
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnam,nz
nz=RECNO()
fnam=SPACE(LEN(nam))
DEFINE WINDOW Zapros FROM 10,19 TO 12,65 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY ' ç†®¨•≠Æ¢†≠®•' GET fnam
READ
RELEASE WINDOW Zapros
SET ORDER TO nam
IF EMPTY(fnam)
    RETURN
ENDIF
SET EXACT OFF
IF !SEEK(RTRIM(fnam))
    DO Net_n WITH 14," H•‚ ‚†™Æ£Æ ≠†®¨•≠Æ¢†≠®Ô. èÆ¢‚Æp®‚•..."
    GO nz
ENDIF
SET EXACT ON
RETURN
*
*
PROCEDURE Chapar
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-9 ,ncoll-1,nstrv+11,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-8 ,ncoll-1 SAY "∫         Ä ‡ Â ® ¢    § ¢ ® ¶ • ≠ ® Ô    Ø Æ     Ø Æ · ‚ † ¢ È ® ™ † ¨"
@ nstrv-7 ,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
@ nstrv-6 ,ncoll-1 SAY "∫ èÆ§p†ß§•´•≠®•:"
@ nstrv-5 ,ncoll-1 SAY "∫ èÆ·‚†¢È®™:"
@ nstrv-4 ,ncoll-1 SAY "«ƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒ¬ƒƒƒƒƒƒ∂"
@ nstrv-3 ,ncoll-1 SAY '∫ N ≥ HÆ¨•p≥ çÆ¨•‡≥  Ñ†‚†  ≥  äÆ§    ≥Å†´.≥äÆ‡.≥       C„¨¨†      ≥ äÆ§ ≥ å•·ÔÊ'
@ nstrv-2 ,ncoll-1 SAY '∫Ø/Ø≥Ø´.§Æ™≥  ííç ≥        ≥Æ‡£†≠®ß†Ê≥·Á•‚≥·Á•‚≥       ™‡•§®‚     ≥ØÆ§p.≥ ® £Æ§'
@ nstrv-1 ,ncoll-1 SAY "«ƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒ¡ƒƒƒƒƒƒ∂"
@ nstrv+11,ncoll-1 SAY "»ÕÕ èÆ®·™: F2 ƒ ØÆ·‚†¢È®™, F3 - ≠Æ¨•p ííç ÕÕÕÕ F4 - ®‚Æ£ ÕÕÕÕ F10 - Ø•Á†‚Ï "
RETURN
*
PROCEDURE Strsayar
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 6,23 SAY Spr_nam('2',nsk,30)
    @ 7,21 SAY Spr_nam(pr_spr,kp,30)
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY npp
@ nstr, 5 SAY nrd
@ nstr,12 SAY nvx
@ nstr,19 SAY dat
@ nstr,28 SAY pr_spr
@ nstr,30 SAY kp
@ nstr,38 SAY bs
@ nstr,43 SAY kor
@ nstr,48 SAY smk PICTURE '999,999,999,999.99'
@ nstr,67 SAY nsk
@ nstr,73 SAY ms
@ nstr,76 SAY god
RETURN
*
PROCEDURE F2ar
IF RECCOUNT()=0
    GO nz
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
fpoisk=SPACE(LEN(skl.kkl))
@ 14,24 FILL TO 16,49 COLOR &color20
SET COLOR TO &color13
@ 13,23,15,48 BOX box_1
SET COLOR TO &color14
@ 14,25 SAY "äÆ§ Æp£†≠®ß†Ê®®" GET fpoisk VALID Poisk_kl('fpoisk',.T.,0,0,0) ERROR 'H•‚ ‚†™Æ£Æ ™Æ§†...'
READ
IF EMPTY(fpoisk)
    RETURN
ENDIF
SET ORDER TO kp_nrd
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ© ®≠‰Æp¨†Ê®®..."
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3ar
IF RECCOUNT()=0
    GO nz
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
fpoisk=SPACE(LEN(nvx))
DEFINE WINDOW Zapros FROM 13,23 TO 15,42 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY "HÆ¨•‡ ííç" GET fpoisk
READ
RELEASE WINDOW Zapros
IF EMPTY(fpoisk)
    RETURN
ENDIF
SET ORDER TO nvx
SET EXACT OFF
IF !SEEK(RTRIM(fpoisk))
    DO Net_n WITH 10," H•‚ ‚†™Æ© ®≠‰Æp¨†Ê®®..."
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F4ar
IF RECCOUNT()=0
    GO nz
ENDIF
PRIVATE fnvx,nz,fsum,fkp
nz=RECNO()
SET ORDER TO kp_nvx
fnvx=nvx
fkp=kp
fms=ms
fgod=god
IF SEEK(fkp+fnvx)
    SUM smk TO fsum REST WHILE fnvx=nvx.AND.fkp=kp FOR ms=fms.AND.fgod=god
    DO Net_n WITH 14,"ë„¨¨† "+TRANSFORM(fsum,'999,999,999,999.99')+"..."
ENDIF
GO nz
RETURN
*
PROCEDURE Alt3dd1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE ffsum,nz,nzz
nzz=RECNO()
PUSH KEY
ON KEY
* ÆØ‡•§•´•≠®• ®·ØÆ´ÏßÆ¢†≠®Ô ·„¨¨ ÆØ´†‚
SELECT bkr
REPLACE ALL smo WITH 0
SELECT dv_kp
SET EXACT OFF
SCAN
    SELECT tran_pos
    SEEK STR(dv_kp.uni,7)
    SCAN REST WHILE uni=dv_kp.uni FOR ms=ntmec.AND.god=nastf_b.AND.!DELETE()
         SELECT bkr
         IF !SEEK(osdkomr.kp+DTOC(tran_pos.dat,1)+tran_pos.nrd)
              APPEND BLANK
              REPLACE kp WITH osdkomr.kp,dat WITH tran_pos.dat,nrd WITH tran_pos.nrd
         ENDIF
         REPLACE smo WITH smo+tran_pos.summa
    ENDSCAN
ENDSCAN
* †¢‚Æ¨†‚®Á•·™†Ô ÆØ´†‚† ØÆ §Æ™„¨•≠‚†¨
SELECT bkr
GO TOP
SELECT dv_kp
GO nzz
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '∞'
SET COLOR TO &color13
@ 0,1 SAY "èÆ¶†´„©·‚†, ØÆ§Æ¶§®‚•..."
@ 1,2 SAY ' Ç·•£Æ ß†Ø®·•©:       '
@ 2,2 SAY ' í•™„È†Ô ß†Ø®·Ï:      '
SET COLOR TO &color14
@ 1,18 SAY RECCOUNT() PICTURE '999999'
@ 2,18 SAY ' '
ii=0
SCAN REST FOR smko#smk.AND.smk#0    && .AND.(sopl-fsum)>0
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    DO WHILE smko#smk.AND.smk#0.AND.(sopl-fsum)#0
         ffsum=0
         SELECT bkr
         SCAN REST FOR (vo='1'.OR.vo='0'.AND.dv_kp.smk<0).AND.!DELETE()
              ffsum=sm-smo
              IF ffsum#0
                   EXIT
              ENDIF
         ENDSCAN
         SELECT dv_kp
         IF EOF('BKR').OR.ffsum=0
              EXIT
         ENDIF
         ffsum=IIF(ffsum>0,IIF(ffsum>smk-smko,smk-smko,ffsum),IIF(ffsum<smk-smko,smk-smko,ffsum))
         ffsum=IIF(ffsum>0,IIF(ffsum>sopl-fsum,sopl-fsum,ffsum),IIF(ffsum<sopl-fsum,sopl-fsum,ffsum))
         REPLACE smko WITH smko+ffsum,bs_op WITH ff2
         REPLACE bkr.smo WITH bkr.smo+ffsum
         fsum=fsum+ffsum
         fsumv=fsumv+ffsum
         SELECT tran_pos
         IF !SEEK(STR(dv_kp.uni,7)+DTOC(bkr.dat,1)+bkr.nrd).OR.ms#ntmec.OR.god#nastf_b
              APPEND BLANK
              REPLACE uni WITH dv_kp.uni,dat WITH bkr.dat,nrd WITH bkr.nrd,ms WITH ntmec,god WITH nastf_b
         ELSE
              IF DELETE()
                   RECALL
                   REPLACE summa WITH 0,ms WITH ntmec,god WITH nastf_b
              ENDIF
         ENDIF
         REPLACE summa WITH summa+ffsum,bs WITH ff2
         SELECT dv_kp
    ENDDO
    IF EOF('BKR')
         EXIT
    ENDIF
ENDSCAN
HIDE WINDOW Pogal
ACTIVATE SCREEN
SET EXACT ON
SELECT bkr
DELETE FOR sm=0
REPLACE ALL smo WITH 0
SCAN FOR DELETE()
    PACK
    EXIT
ENDSCAN
GO TOP
SELECT dv_kp
GO nzz
ntek=1
nstr=nstrv
nzkvvodv=RECNO()
IF !(EOF().OR.&usl)
    DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
          ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
ENDIF
color=IIF(DELETE(),colorv4,colorv2)
pr_pusto=RECCOUNT()#0.AND.!&usl
IF pr_pusto
    pr_v_pr=.F.
    DO &Strsay WITH color,nstr,npolscr
    pr_v_pr=.T.
ENDIF
POP KEY
RETURN
*
PROCEDURE Alt4dd1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fsum
* ØÆ´„Á•≠®• ÆØ´†‚ ØÆ §Æ™„¨•≠‚†¨
PUSH KEY
ON KEY
fsum=0
SELECT tran_pos
SET ORDER TO uni
SET EXACT OFF
SEEK STR(dv_kp.uni,7)
SET EXACT ON
SCAN REST WHILE uni=dv_kp.uni FOR ms=ntmec.AND.god=nastf_b.AND.!DELETE()
    fsum=fsum+summa
ENDSCAN
SELECT dv_kp
DO Net_n WITH 11,'éØ´†‚† - '+LTRIM(TRANSFORM(smko,'999,999,999,999.99'))+', F9 - '+LTRIM(TRANSFORM(fsum,'999,999,999,999.99'))+', ‡†ß≠®Ê† - '+LTRIM(TRANSFORM(smko-fsum,'999,999,999,999.99'))
POP KEY
=SYS(2002)
RETURN
*
PROCEDURE Alt5dd1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz
PUSH KEY
ON KEY
nz=RECNO()
* ØÆ´„Á•≠®• ®·ØÆ´ÏßÆ¢†≠®Ô †¢†≠·Æ¢
SELECT bkr
SET ORDER TO kp_dat
SELECT dv_kp
SET EXACT OFF
SCAN
    SELECT tran_pos
    SEEK STR(dv_kp.uni,7)
    SCAN REST WHILE uni=dv_kp.uni FOR ms=ntmec.AND.god=nastf_b.AND.!DELETE()
         SELECT bkr
         IF !SEEK(osdkomr.kp+DTOC(tran_pos.dat,1)+tran_pos.nrd)
              APPEND BLANK
              REPLACE kp WITH osdkomr.kp,dat WITH tran_pos.dat,nrd WITH tran_pos.nrd
         ENDIF
         REPLACE smo WITH smo+tran_pos.summa
    ENDSCAN
ENDSCAN
SET EXACT ON
SELECT bkr
GO TOP
DO Vvodn WITH "Chappp","Strsaypp","",.F.,.F.,.F.,.F.,".F.","","","","","","","","","","","",.T.
SELECT bkr
DELETE FOR sm=0
REPLACE ALL smo WITH 0
SCAN FOR DELETE()
    PACK
    EXIT
ENDSCAN
SELECT dv_kp
GO nz
POP KEY
=SYS(2002)
RETURN
*
PROCEDURE Alt7dd1
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,fsmko
PUSH KEY
ON KEY
nz=RECNO()
SELECT dv_kp
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '∞'
SET COLOR TO &color13
@ 0,1 SAY "èÆ¶†´„©·‚†, ØÆ§Æ¶§®‚•..."
@ 1,2 SAY ' Ç·•£Æ ß†Ø®·•©:       '
@ 2,2 SAY ' í•™„È†Ô ß†Ø®·Ï:      '
SET COLOR TO &color14
@ 1,18 SAY RECCOUNT() PICTURE '999999'
@ 2,18 SAY ' '
ii=0
SCAN REST FOR EMPTY(bs_op).OR.bs_op=ff2
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    fsmko=smko
    REPLACE smko WITH 0
    IF fsmko#smko
         DO Opl_pos
         fsum=fsum-fsmko+smko
         fsumv=fsumv-fsmko+smko
    ENDIF
    REPLACE bs_op WITH IIF(smko=0,'    ',ff2)
ENDSCAN
GO nz
HIDE WINDOW Pogal
ACTIVATE SCREEN
ntek=1
nstr=nstrv
nzkvvodv=RECNO()
IF !(EOF().OR.&usl)
    DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
          ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
ENDIF
color=IIF(DELETE(),colorv4,colorv2)
pr_pusto=RECCOUNT()#0.AND.!&usl
IF pr_pusto
    pr_v_pr=.F.
    DO &Strsay WITH color,nstr,npolscr
    pr_v_pr=.T.
ENDIF
POP KEY
=SYS(2002)
RETURN
*
*
PROCEDURE Chappp
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=14
nstrn=22
ncoll=23
ncolr=75
step=1
npolscrm=1
@ nstrv-3,ncoll FILL TO nstrv+9,ncolr+2 COLOR &color20
SET COLOR TO &color4
@ nstrv-4,ncoll-1,nstrv+8,ncolr+1 BOX "…Õª∫ºÕ»∫ "
@ nstrv-4,ncoll-1 SAY "…ÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ"
@ nstrv-3,ncoll-1 SAY "∫  Ñ†‚†  ≥ çÆ¨•‡≥  ë„¨¨† §Æ™„¨•≠‚† ≥       ë„¨¨†      "
@ nstrv-2,ncoll-1 SAY "∫§Æ™„¨•≠.≥§Æ™„¨.≥Ø‡®ÂÆ§(-),‡†·Â.(+)≥      ÆØ´†‚Î      "
@ nstrv-1,ncoll-1 SAY "«ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂"
RETURN
*
PROCEDURE Strsaypp
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,23 SAY dat
@ nstr,32 SAY nrd
@ nstr,39 SAY IIF(vo='1',sm,-sm) PICTURE '999,999,999,999.99'
@ nstr,58 SAY smo PICTURE '999,999,999,999.99'
RETURN
RETURN
*
*
PROCEDURE Poisk_sg
PARAMETERS fname,pr_memo,n_str,n_poz,kol_zn
*
* fname   - ®¨Ô Ø•p•¨•≠≠Æ© ®´® ‚•™„È•£Æ ØÆ´Ô
* pr_memo - Øp®ß≠†™ Ø•p•¨•≠≠Æ© (.T.) ®´® ØÆ´Ô (.F.)
* n_str   - ≠Æ¨•p ·‚pÆ™®
* n_poz   - ≠Æ¨•p ØÆß®Ê®®
* kol_zn  - ™Æ´®Á•·‚¢Æ ß≠†™Æ¢ ≠†®¨•≠Æ¢†≠®Ô §´Ô ¢Î¢Æ§†
*
PRIVATE f_poisk,nam_file
nam_file=ALIAS()
SELECT spr_grup
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         DO Vvodn WITH "Chapsg","Strsaysg","Strgetsg",.T.,.T.,.F.,.T.,".F.","",;
              "","","","","","","","","","",.T.
         IF pr_memo
              &fname=grup
         ELSE
              REPLACE &fname WITH grup
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO grup
    f_poisk=SEEK(&fname)
ENDIF
IF n_str#0
    @ n_str,n_poz SAY LEFT(spr_grup.nam,kol_zn)
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN f_poisk