PARAMETERS fname,pr_memo,n_str,n_poz,kol_zn
PRIVATE f_poisk,nam_file,nz
nam_file=ALIAS()
SELECT sprrab
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         DO Vvodn WITH "Chapsr","Strsaysr","Strgetsr",.T.,.T.,.F.,.F.,".F.","",;
              "F2sr","F3sr","F4sr","","","","","","F10sr","",.F.
         IF pr_memo
              &fname=tab
         ELSE
              REPLACE &fname WITH tab
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO tab
    IF EOF()
         GO TOP
    ENDIF
    nz=RECNO()
    f_poisk=SEEK(LEFT(&fname,6))
    IF !f_poisk
         IF RECCOUNT()#0
              GO nz
         ENDIF
    ENDIF
ENDIF
IF n_str#0
    IF kol_zn>LEN(sprrab.fio)
         @ n_str,n_poz SAY LEFT(sprrab.fio,kol_zn)+SPACE(kol_zn-LEN(sprrab.fio))
    ELSE
         @ n_str,n_poz SAY LEFT(sprrab.fio,kol_zn)
    ENDIF
ENDIF
SELECT &nam_file
RETURN f_poisk
