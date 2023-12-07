PRIVATE set_devi,i,pr_retu
SET ESCAPE OFF
DEFINE WINDOW Err_set FROM 0,0 TO 3,79 COLOR w+/b
set_devi=.F.
IF SET('DEVICE')='PRINT'
     SET DEVICE TO SCREEN
     set_devi=.T.
ENDIF
pr_retu=.F.
ACTIVATE WINDOW Err_set
SET COLOR TO w+/b,w+/n
@ 0,20 SAY " Вызвано пpеpывание. Что делать дальше  ?"
@ 1,22 PROMPT ' Игноpиpовать '
@ 1,46 PROMPT ' Пpекpатить '
MENU TO i
RELEASE WINDOW Err_set
DO CASE
CASE i=1
    SET ESCAPE ON
    IF set_devi
         SET DEVICE TO PRINT
    ENDIF
    RETRY
CASE i=0.OR.i=2
    pr_retu=.T.
ENDCASE
IF pr_retu
    SET DELETED OFF
    HIDE WINDOW ALL
    ACTIVATE SCREEN
    SET COLOR TO &color14
    SET PROCEDURE TO procgol
    FOR i=1 TO 25
         ssss='SELECT '+STR(i,2)
         &ssss
         IF !ALIAS()='SCH'.AND.!ALIAS()='SPRT'.AND.!ALIAS()='SPRNAZ'.AND.;
            !ALIAS()='SKL'.AND.!ALIAS()='SPRRAB'.AND.;
            !ALIAS()='BK'.AND.!ALIAS()='SPR_BS'.AND.!ALIAS()='SPR_GRUP'.AND.!ALIAS()='SPR_REG'
              IF (nastf_8=0.OR.nastf_8=1.AND.ALIAS()#'SPR_VAL'.AND.ALIAS()#'KURS_VAL')
                   USE
              ENDIF
         ENDIF
    ENDFOR
    RETURN TO MASTER
ENDIF
RETURN
