PARAMETERS nerr
PRIVATE ssss
IF nerr=15
    RESTORE FROM tek_b ADDITIVE
    key=2
    DEFINE WINDOW Zapros FROM 9,15 TO 13,67 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,10 SAY 'Запорчен файл '+TRIM(nam_file)+'.DBF.'
    @ 1,3 SAY 'Будете выполнять его восстановление ?'
    @ 2,8 SAY "Вы уверены ?"
    @ 2,28 PROMPT " Да  "
    @ 2,38 PROMPT " Hет "
    MENU TO key
    RELEASE WINDOW Zapros
    IF key=1
         ACTIVATE WINDOW Pog_p
         SET COLOR TO &color15
         @ 0,0 SAY '░'
         SET COLOR TO &color13
         @ 0,1 SAY "Пожалуйста, подождите..."
         ssss=RTRIM(nam_file)+'.DBF'
         sssss=SYS(3)+'.SBF'
         COPY FILE &ssss TO &sssss
         DO Reviver WITH TRIM(nam_file)+'.dbf'
         s=UPPER(nam_file)
         IF s='SCH'.OR.s='SPRT'.OR.s='SPRNAZ'.OR.s='SKL'.OR.s='SPRRAB'.OR.;
            s='BK'.OR.s='SPR_BS'.OR.s='SPR_GRUP'.OR.s='SPR_REG'.OR.;
            nastf_8=1.AND.(s='SPR_VAL'.OR.s='KURS_VAL')
              SELECT 0
              USE &s
         ENDIF
         HIDE WINDOW Pog_p
         ACTIVATE SCREEN
    ENDIF
    RELEASE ALL LIKE tek_b_??
ENDIF
RETURN
