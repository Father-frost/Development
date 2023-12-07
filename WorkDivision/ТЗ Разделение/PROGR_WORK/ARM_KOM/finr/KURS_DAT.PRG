PARAMETERS kval,datval,sumval
PRIVATE nam_file
nam_file=ALIAS()
IF sumval#0
    SELECT kurs_val
    SET NEAR ON
    SEEK kval+DTOC(datval,1)
    SET NEAR OFF
    IF !FOUND().AND.!BOF()
         SKIP -1
    ENDIF
    IF kval=kod.AND.kurs_val.kurs#0
         IF LEN(nam_file)#0
              SELECT &nam_file
         ENDIF
         RETURN ROUND(sumval*kurs_val.summa/kurs_val.kurs,0)
    ENDIF
ENDIF
IF !EMPTY(nam_file)
	SELECT &nam_file
ENDIF
RETURN 0.0