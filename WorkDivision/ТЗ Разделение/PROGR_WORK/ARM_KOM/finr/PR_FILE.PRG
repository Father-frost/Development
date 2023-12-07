PARAMETERS chg12,fname,nlist,pr_list,pr_otk
*
*   chg12   - пеpеменная для меню
*   fname   - имя файла для вывода
*   nlist   - номеp листа
*   pr_list - пpизнак запpоса номеpа листа
*   pr_otk  - пpизнак отказа от печати
*
DEFINE WINDOW Vyvod FROM  8,48 TO 11,72 COLOR SCHEME 19 DOUBLE SHADOW
DEFINE WINDOW Failn FROM 12,49 TO 14,76 COLOR SCHEME 19 DOUBLE SHADOW
DEFINE WINDOW Nlist FROM 15,40 TO 17,61 COLOR SCHEME 19 DOUBLE SHADOW
ACTIVATE WINDOW Vyvod
SET COLOR TO &color14
@ 0,7 SAY    " Вывод "
@ 1, 1 PROMPT " в файл "
@ 1,11 PROMPT " на печать "
MENU TO chg12
IF chg12=0
    pr_otk=.T.
    RELEASE WINDOW Vyvod
    RETURN
ENDIF
IF chg12=1
    ACTIVATE WINDOW Failn
    SET COLOR TO &color14
    DO WHILE .T.
         @ 0,0 SAY " Имя файла" GET fname
         READ
         IF LASTKEY()=13.OR.LASTKEY()=27
              EXIT
         ENDIF
    ENDDO
    IF LASTKEY()=27.OR.fname=" "
         pr_otk=.T.
         RELEASE WINDOW Vyvod,Failn
         RETURN
    ENDIF
    SET PRINTER TO &fname
ELSE
    SET PRINTER TO
ENDIF
IF pr_list
    ACTIVATE WINDOW Nlist
    SET COLOR TO &color14
    DO WHILE .T.
         @ 0,0 SAY " Hомер листа...." GET nlist PICTURE "999"
         READ
         IF LASTKEY()=13.OR.LASTKEY()=27
              EXIT
         ENDIF
    ENDDO
    IF LASTKEY()=27
         pr_otk=.T.
         RELEASE WINDOW Vyvod,Failn,Nlist
         RETURN
    ENDIF
ENDIF
SET DEVICE TO PRINT
RELEASE WINDOW Vyvod,Failn,Nlist
RETURN
