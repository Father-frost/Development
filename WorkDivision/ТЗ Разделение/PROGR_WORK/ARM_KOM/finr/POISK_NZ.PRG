PARAMETERS fname,pr_memo,n_str,n_poz,kol_zn
*
* fname   - имя пеpеменной или текущего поля
* pr_memo - пpизнак пеpеменной (.T.) или поля (.F.)
* n_str   - номеp стpоки
* n_poz   - номеp позиции
* kol_zn  - количество знаков наименования для вывода
*
PRIVATE f_poisk,nam_file,nz
nam_file=ALIAS()
SELECT kodzk
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         DO Vvodn WITH "Chapzk","Strsayzk","Strgetzk",.T.,.T.,.F.,.F.,".F."," ",;
              "F2zk","F3zk","","","","","","","","",.F.
         IF pr_memo
              &fname=nzk
         ELSE
              REPLACE &fname WITH nzk
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO kodzk
    IF EOF()
         GO TOP
    ENDIF
    nz=RECNO()
    f_poisk=SEEK(&fname)
    IF !f_poisk
         IF RECCOUNT()#0
              GO nz
         ENDIF
    ENDIF
ENDIF
IF n_str#0
    @ n_str,n_poz SAY LEFT(kodzk.nam,kol_zn)
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN f_poisk
