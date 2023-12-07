PARAMETERS kval,datval,namsum,sumval,summar,namsum1,sumval1,summar1
PRIVATE nam_file
nam_file=ALIAS()
DEFINE WINDOW Zapros FROM 5,50 TO IIF(EMPTY(namsum1),8,9),74 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY 'Вид валюты' GET &kval VALID Poisk_wl(kval,.F.,0,0,0) ERROR 'Hет такой валюты...'
@ 1,1 SAY namsum GET &sumval
IF !EMPTY(namsum1)
@ 2,1 SAY namsum1 GET &sumval1
ENDIF
READ
RELEASE WINDOW Zapros
SET COLOR TO &color21
IF &sumval#0
    SELECT kurs_val
    SET NEAR ON
    SEEK &kval+DTOC(datval,1)
    SET NEAR OFF
    IF !FOUND()
         SKIP -1
    ENDIF
    IF &kval=kod.AND.kurs_val.kurs#0
         IF LEN(nam_file)#0
              SELECT &nam_file
         ENDIF
         REPLACE &summar WITH ROUND(&sumval*kurs_val.summa/kurs_val.kurs,0)
    ENDIF
    IF LEN(nam_file)#0
         SELECT &nam_file
    ENDIF
ELSE
    REPLACE &summar WITH 0
ENDIF
IF EMPTY(namsum1)
    RETURN
ENDIF
IF &sumval1#0
    SELECT kurs_val
    SET NEAR ON
    SEEK &kval+DTOC(datval,1)
    SET NEAR OFF
    IF !FOUND()
         SKIP -1
    ENDIF
    IF &kval=kod.AND.kurs_val.kurs#0
         IF LEN(nam_file)#0
              SELECT &nam_file
         ENDIF
         REPLACE &summar1 WITH ROUND(&sumval1*kurs_val.summa/kurs_val.kurs,0)
    ENDIF
    IF LEN(nam_file)#0
         SELECT &nam_file
    ENDIF
ELSE
    REPLACE &summar1 WITH 0
ENDIF
RETURN