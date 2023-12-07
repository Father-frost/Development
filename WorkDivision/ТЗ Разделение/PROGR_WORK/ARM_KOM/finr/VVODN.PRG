PARAMETERS Chap,Strsay,Strget,prvvod,prcorr,prudal,pr_vvod,usl,namhelp1,namhelp2,;
namhelp3,namhelp4,namhelp5,namhelp6,namhelp7,namhelp8,namhelp9,namhelp0,namudal,pr_pack
SET DELETED OFF
PRIVATE color,colorv1,colorv2,colorv3,colorv4,nstrn,nstrv,ncoll,ncolr,i,ii,step,;
        pruspudl,colorv5,ord_nam,n_v_r,nam_win,nam_winh
PRIVATE kolzap,scr1,prudalv,preof,prbof,ntek,nstr,nzkvvodv,key,npolscr,vscr,;
        polscr1,polscr2,polscr3,polscr4,polscr5,npolscrm,npromstr,ttime,tchas
PRIVATE del_time,pr_pusto,pr_v_pr
SAVE SCREEN TO vscr
colorv1="w+/bg,n+/w" && основной цвет
colorv2="w+/n"       && выделенный цвет
colorv3="w+/gr"      && цвет удаленных
colorv4="gr+/gr"     && цвет удаленных (выделенный)
colorv5="n/bg"       && цвет pамки
colorv6="n*/bg"
pr_v_pr=.T.
nstrv=0              && номер верхней строки
nstrn=0              && номер нижней строки
ncoll=0              && номер левой колонки
ncolr=80             && номер правой колонки
step=1               && количество строк в записи
polscr1=0
polscr2=0
polscr3=0
polscr4=0
polscr5=0
npolscr=1
npolscrm=1
prudalv=0
n_v_r=.T.
prbof=BOF()
preof=EOF()
IF EOF()
    IF BOF()
         prbof=.T.
    ELSE
         SKIP -1
         IF BOF()
              GO TOP
              prbof=.T.
         ENDIF
    ENDIF
ENDIF
DO &chap WITH colorv5,nstrv,nstrn,ncoll,ncolr,step,npolscrm,;
              polscr1,polscr2,polscr3,polscr4,polscr5
nam_win=WONTOP()
kolzap=INT((nstrn-nstrv)/step)
ntek=1
nstr=nstrv
del_time=10
ttime=TIME()
=SYS(2002)
nzkvvodv=RECNO()
IF !(EOF().OR.&usl)
     DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
               ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
ENDIF
SET COLOR TO &colorv1
DO WHILE .T.
    color=IIF(DELETE(),colorv4,colorv2)
    pr_pusto=RECCOUNT()#0.AND.!&usl
    IF pr_pusto
         pr_v_pr=.F.
         DO &Strsay WITH color,nstr,npolscr
         pr_v_pr=.T.
    ENDIF
    CLEAR TYPEAHEAD
    key=0
    DO WHILE key=0
         READ
         key=LASTKEY()
         IF TIME()>ttime
              FLUSH
              ttime=TIME()
              tmin=VAL(SUBSTR(ttime,4,2))
              IF tmin+del_time<60
                  tmin=STR(tmin+del_time,2,0)
              ELSE
                  tmin=STR(tmin+del_time-60,2,0)
                  IF LEFT(tmin,1)=" "
                      tmin="0"+RIGHT(tmin,1)
                  ENDIF
                  tchas=STR(VAL(LEFT(ttime,2))+1,2,0)
                  IF LEFT(tchas,1)=" "
                       tchas="0"+RIGHT(tchas,1)
                  ENDIF
                  ttime=STUFF(ttime,1,2,tchas)
              ENDIF
              ttime=STUFF(ttime,4,2,tmin)
         ENDIF
    ENDDO
    DO CASE
    CASE key=24.AND.!preof.AND.pr_pusto             && строка вниз
         color=IIF(DELETE(),colorv3,colorv1)
         pr_v_pr=.F.
         DO &Strsay WITH color,nstr,npolscr
         pr_v_pr=.T.
         SKIP
         IF EOF().OR.&usl
              preof=.T.
              SKIP -1
         ELSE
              prbof=.F.
              IF ntek=kolzap
                   npromstr=RECNO()
                   GO nzkvvodv
                   SKIP
                   nzkvvodv=RECNO()
                   GO npromstr
                   SET COLOR TO &colorv1
                   SCROLL nstrv,ncoll,nstrn-1,ncolr,step
              ELSE
                   ntek=ntek+1
                   nstr=nstr+step
              ENDIF
         ENDIF
    CASE key=5.AND.!prbof.AND.pr_pusto &&  строка вверх
         color=IIF(DELETE(),colorv3,colorv1)
         pr_v_pr=.F.
         DO &Strsay WITH color,nstr,npolscr
         pr_v_pr=.T.
         SKIP -1
         IF ntek=1
              IF BOF().OR.&usl
                   IF BOF()
                        GO TOP
                   ELSE
                        SKIP
                   ENDIF
                   prbof=.T.
              ELSE
                   preof=.F.
                   nzkvvodv=RECNO()
                   SET COLOR TO &colorv1
                   SCROLL nstrv,ncoll,nstrn-1,ncolr,-step
              ENDIF
         ELSE
              ntek=ntek-1
              nstr=nstr-step
              preof=.F.
         ENDIF
    CASE key=3.AND.pr_pusto.AND.!preof        && лист вниз
         npromstr=RECNO()
         GO nzkvvodv
         i=1
         SCAN REST WHILE !(&usl).AND.i<=kolzap
              i=i+1
         ENDSCAN
         IF EOF().OR.&usl
              SKIP -1
              i=i-1
              preof=.T.
              GO npromstr
              IF ntek#i
                   color=IIF(DELETE(),colorv3,colorv1)
                   pr_v_pr=.F.
                   DO &Strsay WITH color,nstr,npolscr
                   pr_v_pr=.T.
                   ntek=i
                   nstr=nstrv+step*(i-1)
                   GO nzkvvodv
                   SKIP i-1
              ENDIF
         ELSE
              GO nzkvvodv
              SKIP kolzap
              DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
              ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
         ENDIF
         prbof=.F.
    CASE key=18.AND.!prbof.AND.pr_pusto        && лист вверх
         npromstr=RECNO()
         GO nzkvvodv
         FOR i=1 TO kolzap
              SKIP -1
              IF BOF().OR.&usl
                   EXIT
              ENDIF
         ENDFOR
         IF BOF().OR.&usl
              prbof=.T.
              IF BOF()
                   GO TOP
              ELSE
                   SKIP
              ENDIF
         ENDIF
         IF nzkvvodv#RECNO()
             DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
                    ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
        ELSE
             GO npromstr
             color=IIF(DELETE(),colorv3,colorv1)
             pr_v_pr=.F.
             DO &Strsay WITH color,nstr,npolscr
             pr_v_pr=.T.
             GO nzkvvodv
             nstr=nstrv
             ntek=1
         ENDIF
         preof=.F.
    CASE key=7.AND.pr_pusto.AND.prudal     && удаление
         IF LOCK()
              IF DELETE()
                   RECALL
                   prudalv=prudalv-1
              ELSE
                   IF EMPTY(namudal)
                        DELETE
                        prudalv=prudalv+1
                   ELSE
                        SAVE SCREEN  TO scr1
                        pruspudl=.F.
                        =SYS(2002,1)
                        DO &namudal WITH pruspudl
                        =SYS(2002)
                        IF pruspudl
                             DELETE
                             prudalv=prudalv+1
                        ELSE
                             SET COLOR TO &colorv3
                             @ 10,22,14,55 BOX "┌─┐│┘─└│ "
                             @ 11,24 SAY "Информация присутствует в базе"
                             @ 12,24 SAY "   Удаление не выполняется.   "
                             @ 13,24 SAY "Продолжение - любая клавиша..."
                             READ
                        ENDIF
                        RESTORE SCREEN FROM scr1
                   ENDIF
              ENDIF
              UNLOCK
         ENDIF
    CASE key=13.AND.pr_pusto.AND.prcorr.AND.!DELETE()     && Enter
         IF LOCK()
              SET COLOR TO &colorv1
              =SYS(2002,1)
              IF npolscrm=1
                   DO &Strget WITH nstr,npolscr
              ELSE
                   i=npolscr
                   DO WHILE i<=npolscrm
                        ii="polscr"+STR(i,1,0)
                        RESTORE SCREEN FROM &ii
                        npromstr=RECNO()
                        ntek=1
                        DO Pscrs WITH npromstr,prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
                           ntek,kolzap,nzkvvodv,Strsay,i,colorv1,colorv2,colorv3
                        SET COLOR TO &colorv1
                        DO &Strget WITH nstr,i
                        i=i+1
                        IF LASTKEY()=27
                             EXIT
                        ENDIF
                   ENDDO
                   npolscr=i-1
              ENDIF
              =SYS(2002)
              ntek=1
              nstr=nstrv
              prbof=.F.
              DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
                      ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
              UNLOCK
         ENDIF
    CASE key=22.AND.prvvod          && Insert
         =SYS(2002,1)
         IF pr_vvod
              n_v_r=.F.
              ord_nam=SET("ORDER")
              SET ORDER TO 0
              key=999
              ntek=1
              nstr=nstrv
              SET COLOR TO &colorv1
              @ nstr,ncoll CLEAR TO nstrn-1,ncolr
              DO WHILE .T.
                   color=IIF(DELETE(),colorv4,colorv2)
                   pr_pusto=RECCOUNT()#0.AND.!&usl
                   IF pr_pusto
                        pr_v_pr=.F.
                        DO &Strsay WITH color,nstr,npolscr
                        pr_v_pr=.T.
                   ENDIF
                   IF key=999
                        key=22
                   ELSE
                        key=0
                   ENDIF
                   DO WHILE key=0
                        key=INKEY()
                        IF TIME()>ttime
                             FLUSH
                             ttime=TIME()
                             tmin=VAL(SUBSTR(ttime,4,2))
                             IF tmin+del_time<60
                                  tmin=STR(tmin+del_time,2,0)
                             ELSE
                                  tmin=STR(tmin+del_time-60,2,0)
                                  IF LEFT(tmin,1)=" "
                                       tmin="0"+RIGHT(tmin,1)
                                  ENDIF
                                  tchas=STR(VAL(LEFT(ttime,2))+1,2,0)
                                  IF LEFT(tchas,1)=" "
                                       tchas="0"+RIGHT(tchas,1)
                                  ENDIF
                                  ttime=STUFF(ttime,1,2,tchas)
                             ENDIF
                             ttime=STUFF(ttime,4,2,tmin)
                        ENDIF
                   ENDDO
                   DO CASE
                   CASE key=22          && Insert
                        color=IIF(DELETE(),colorv3,colorv1)
                        IF pr_pusto
                             DO &Strsay WITH color,nstr,npolscr
                             GO TOP
                        ENDIF
                        nzkvvodv=RECNO()
                        APPEND BLANK
                        SET COLOR TO &colorv1
                        IF npolscrm>1
                             @ nstrv,ncoll CLEAR TO nstrn-1,ncolr
                             nzkvvodv=RECNO()
                             ntek=1
                             nstr=nstrv
                             i=1
                             DO WHILE i<=npolscrm
                                  ii="polscr"+STR(i,1,0)
                                  RESTORE SCREEN FROM &ii
                                  DO &Strsay WITH colorv1,nstr,i
                                  DO &Strget WITH nstr,i
                                  i=i+1
                                  IF LASTKEY()=27
                                       EXIT
                                  ENDIF
                             ENDDO
                             npolscr=i-1
                        ELSE
                             IF pr_pusto
                                  nstr=nstr+1
                             ENDIF
                             IF nstr>=nstrn
                                  nstr=nstr-1
                                  SCROLL nstrv,ncoll,nstrn-1,ncolr,step
                             ELSE
                                  @ nstr,ncoll CLEAR TO nstrn-1,ncolr
                                  ntek=ntek+1
                             ENDIF
                             DO &Strget WITH nstr,npolscr
                             color=IIF(DELETE(),colorv3,colorv1)
                             DO &Strsay WITH color,nstr,npolscr
                        ENDIF
                   CASE key=24.AND.!preof.AND.pr_pusto       && строка вниз
                        color=IIF(DELETE(),colorv3,colorv1)
                        pr_v_pr=.F.
                        DO &Strsay WITH color,nstr,npolscr
                        pr_v_pr=.T.
                        SKIP
                        IF EOF()
                             preof=.T.
                             SKIP -1
                        ELSE
                             prbof=.F.
                             IF ntek=kolzap
                                  npromstr=RECNO()
                                  GO nzkvvodv
                                  SKIP
                                  nzkvvodv=RECNO()
                                  GO npromstr
                                  SET COLOR TO &colorv1
                                  SCROLL nstrv,ncoll,nstrn-1,ncolr,step
                             ELSE
                                  ntek=ntek+1
                                  nstr=nstr+step
                             ENDIF
                        ENDIF
                   CASE key=5.AND.!prbof.AND.pr_pusto &&  строка вверх
                        color=IIF(DELETE(),colorv3,colorv1)
                        pr_v_pr=.F.
                        DO &Strsay WITH color,nstr,npolscr
                        pr_v_pr=.T.
                        SKIP -1
                        IF ntek=1
                             IF BOF()
                                  GO TOP
                                  prbof=.T.
                             ELSE
                                  preof=.F.
                                  nzkvvodv=RECNO()
                                  SET COLOR TO &colorv1
                                  SCROLL nstrv,ncoll,nstrn-1,ncolr,-step
                             ENDIF
                        ELSE
                             ntek=ntek-1
                             nstr=nstr-step
                             preof=.F.
                        ENDIF
                   CASE key=3.AND.pr_pusto.AND.!preof        && лист вниз
                        npromstr=RECNO()
                        GO nzkvvodv
                        i=1
                        SCAN REST WHILE i<=kolzap
                             i=i+1
                        ENDSCAN
                        IF EOF()
                             SKIP -1
                             i=i-1
                             preof=.T.
                             GO npromstr
                             IF ntek#i
                                  color=IIF(DELETE(),colorv3,colorv1)
                                  pr_v_pr=.F.
                                  DO &Strsay WITH color,nstr,npolscr
                                  pr_v_pr=.T.
                                  ntek=i
                                  nstr=nstrv+step*(i-1)
                                  GO nzkvvodv
                                  SKIP i-1
                             ENDIF
                        ELSE
                             GO nzkvvodv
                             SKIP kolzap
                             DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
                             ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                        ENDIF
                        prbof=.F.
                   CASE key=18.AND.!prbof.AND.pr_pusto        && лист вверх
                        npromstr=RECNO()
                        GO nzkvvodv
                        FOR i=1 TO kolzap
                             SKIP -1
                             IF BOF()
                                  EXIT
                             ENDIF
                        ENDFOR
                        IF BOF()
                             prbof=.T.
                             GO TOP
                        ENDIF
                        IF nzkvvodv#RECNO()
 DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
     ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                        ELSE
                            GO npromstr
                            color=IIF(DELETE(),colorv3,colorv1)
                            pr_v_pr=.F.
                            DO &Strsay WITH color,nstr,npolscr
                            pr_v_pr=.T.
                            GO nzkvvodv
                            nstr=nstrv
                            ntek=1
                        ENDIF
                        preof=.F.
                   CASE key=7.AND.pr_pusto.AND.prudal     && удаление
                        IF DELETE()
                             RECALL
                             prudalv=prudalv-1
                        ELSE
                             IF EMPTY(namudal)
                                  DELETE
                                  prudalv=prudalv+1
                             ELSE
                                  pruspudl=.F.
                                  SAVE SCREEN TO scr1
                                  DO &namudal WITH pruspudl
                                  IF pruspudl
                                       DELETE
                                       prudalv=prudalv+1
                                 ELSE
                                       SET COLOR TO &colorv3
                                       @ 10,22,14,55 BOX "┌─┐│┘─└│ "
                                       @ 11,24 SAY "Информация присутствует в базе"
                                       @ 12,24 SAY "   Удаление не выполняется.   "
                                       @ 13,24 SAY "Продолжение - любая клавиша..."
                                       READ
                                  ENDIF
                                  RESTORE SCREEN FROM scr1
                             ENDIF
                        ENDIF
                   CASE key=13.AND.pr_pusto.AND.prcorr.AND.!DELETE()     && Enter
                        SET COLOR TO &colorv1
                        IF npolscrm=1
                             DO &Strget WITH nstr,npolscr
                        ELSE
                             i=npolscr
                             DO WHILE i<=npolscrm
                                  ii="polscr"+STR(i,1,0)
                                  RESTORE SCREEN FROM &ii
                                  npromstr=RECNO()
                                  ntek=1
                                  DO Pscrs WITH npromstr,prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
                                     ntek,kolzap,nzkvvodv,Strsay,i,colorv1,colorv2,colorv3
                                  SET COLOR TO &colorv1
                                  DO &Strget WITH nstr,i
                                  i=i+1
                                  IF LASTKEY()=27
                                       EXIT
                                  ENDIF
                             ENDDO
                             npolscr=i-1
                        ENDIF
                        ntek=1
                        nstr=nstrv
                        prbof=.F.
                        DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
                              ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                   CASE key=4.AND.pr_pusto && ->
                        IF npolscr<npolscrm
                             npolscr=npolscr+1
                             i="polscr"+STR(npolscr,1,0)
                             RESTORE SCREEN FROM &i
                             DO Pscrs WITH nzkvvodv,prbof,preof,nstr,nstrn,nstrv,ncoll,;
                        ncolr,step,ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                        ENDIF
                   CASE key=19.AND.pr_pusto && <-
                        IF npolscr>1
                             npolscr=npolscr-1
                             i="polscr"+STR(npolscr,1,0)
                             RESTORE SCREEN FROM &i
                             DO Pscrs WITH nzkvvodv,prbof,preof,nstr,nstrn,nstrv,ncoll,;
                         ncolr,step,ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                        ENDIF
                   CASE key=26.AND.pr_pusto && Ctrl + <-
                        IF npolscr#1
                             npolscr=1
                             RESTORE SCREEN FROM polscr1
                             DO Pscrs WITH nzkvvodv,prbof,preof,nstr,nstrn,nstrv,ncoll,;
                        ncolr,step,ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                        ENDIF
                   CASE key=2.AND.pr_pusto                   && Ctrl + ->
                        IF npolscr#npolscrm
                             npolscr=npolscrm
                             i="polscr"+STR(npolscrm,1,0)
                             RESTORE SCREEN FROM &i
                             DO Pscrs WITH nzkvvodv,prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
                           ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                        ENDIF
                   CASE (key=29.OR.key=31).AND.!prbof.AND.pr_pusto && Ctrl + PageUp или Ctrl + Home
                        prbof=.T.
                        preof=.F.
                        npromstr=RECNO()
                        GO TOP
                        ntek=1
                        IF nzkvvodv=RECNO()
                             GO npromstr
                             color=IIF(DELETE(),colorv3,colorv1)
                             pr_v_pr=.F.
                             DO &Strsay WITH color,nstr,npolscr
                             pr_v_pr=.T.
                             GO TOP
                             nstr=nstrv
                        ELSE
                             nstr=nstrv
                             DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,;
                         ncolr,step,ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                        ENDIF
                   CASE (key=23.OR.key=30).AND.!preof.AND.pr_pusto   && Ctrl + PageDn или Ctrl + End
                        prbof=.F.
                        preof=.T.
                        npromstr=RECNO()
                        GO nzkvvodv
                        i=1
                        SCAN REST WHILE i<=kolzap
                             i=i+1
                        ENDSCAN
                        IF EOF()
                             SKIP -1
                             i=i-1
                             GO npromstr
                             IF ntek#i
                                  color=IIF(DELETE(),colorv3,colorv1)
                                  pr_v_pr=.F.
                                  DO &Strsay WITH color,nstr,npolscr
                                  pr_v_pr=.T.
                                  ntek=i
                                  nstr=nstrv+step*(i-1)
                                  GO nzkvvodv
                                  SKIP i-1
                             ENDIF
                        ELSE
                             GO BOTTOM
                             DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
                             ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                        ENDIF
                   CASE key=27                               && Esc
                        FLUSH
                        EXIT
                   CASE key=28                               && F1 - help
                        SAVE SCREEN  TO scr1
                        CLEAR TYPEAHEAD
                        IF namhelp1#" "
                             DO &namhelp1
                        ELSE
                             SET COLOR TO gr+/n
                             i=IIF(prvvod,1,0)+IIF(prudal,1,0)+IIF(prcorr,1,0)
                             DEFINE WINDOW Zap_help FROM 6,20 TO 19+i,61 SHADOW
                             ACTIVATE WINDOW Zap_help
                             i=0
                             @  0,0 SAY "          - предыдущая строка  "
                             @  1,0 SAY "          - следующая строка   "
                             @  2,0 SAY " PageUp    - предыдущий экран   "
                             @  3,0 SAY " PageDown  - следующий экран    "
                             @  4,0 SAY " ->        - экран вправо       "
                             @  5,0 SAY " <-        - экран влево        "
                             @  6,0 SAY " Ctrl+<-   - в начало строки    "
                             @  7,0 SAY " Ctrl+->   - в конец строки     "
                             @  8,0 SAY " Ctrl+Home - в начало файла     "
                             @  9,0 SAY " Ctrl+End  - в конец файла      "
                             @ 10,0 SAY " Alt+F1    - контекстная помощь "
                             @ 11,0 SAY " Esc       - выход              "
                             IF prvvod
                                  @ 12,0 SAY " Insert    - вставить стpоку              "
                                  i=i+1
                             ENDIF
                             IF prcorr
                                  @ 12+i,0 SAY " Enter     - корректировать строку      "
                                  i=i+1
                             ENDIF
                             IF prudal
                                  @ 12+i,0 SAY " Delete    - удалить строку             "
                             ENDIF
                             READ
                             DEACTIVATE WINDOW Zap_help
                                  @ 18,21 SAY " Insert    - вставить стpоку              "
                        ENDIF
                        RESTORE SCREEN FROM scr1
                   CASE key<=-1.AND.key>=-9                 && F2-F10
                        namhelp="namhelp"+RIGHT(STR(1-key,2,0),1)
                        namhelp=&namhelp
                        IF namhelp#" "
                             SAVE SCREEN  TO scr1
                             DO &namhelp
                             RESTORE SCREEN FROM scr1
                             pr_pusto=RECCOUNT()#0.AND.!&usl
                             IF pr_pusto
                                  ntek=1
                                  nstr=nstrv
   DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
           ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                             ENDIF
                        ENDIF
                   ENDCASE
              ENDDO
              n_v_r=.T.
              SET COLOR TO &colorv1
              SET ORDER TO &ord_nam
         ELSE
              IF pr_pusto
                   color=IIF(DELETE(),colorv3,colorv1)
                   DO &Strsay WITH color,nstr,npolscr
                   GO nzkvvodv
                   i=1
                   SCAN REST WHILE !(&usl).AND.i<=kolzap
                        i=i+1
                   ENDSCAN
                   IF !(EOF().OR.&usl)
                        SET COLOR TO &colorv1
                        @ nstrv,ncoll CLEAR TO nstrn-1,ncolr
                        ntek=0
                        nstr=nstrv-step
                   ELSE
                        i=i-1
                        SKIP -1
                        ntek=i
                        nstr=nstrv+step*(i-1)
                   ENDIF
              ELSE
                   ntek=0
                   nstr=nstrv-step
              ENDIF
              IF npolscrm=1
                   ntek=ntek+1
                   IF ntek>kolzap
                        GO nzkvvodv
                        SKIP
                        ntek=kolzap
       DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
                     ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
                        nstr=nstrv+(kolzap-1)*step
                   ELSE
                        nstr=nstr+step
                   ENDIF
              ELSE
                   ntek=1
                   nstr=nstrv
              ENDIF
              APPEND BLANK
              SET COLOR TO &colorv1
              IF npolscrm>1
                   @ nstrv,ncoll CLEAR TO nstrn-1,ncolr
                   i=1
                   DO WHILE i<=npolscrm
                        ii="polscr"+STR(i,1,0)
                        RESTORE SCREEN FROM &ii
                        DO &Strsay WITH colorv1,nstr,i
                        DO &Strget WITH nstr,i
                        i=i+1
                        IF LASTKEY()=27
                             EXIT
                        ENDIF
                   ENDDO
                   npolscr=i-1
              ELSE
                   DO &Strget WITH nstr,npolscr
              ENDIF
         ENDIF
         =SYS(2002)
         prbof=.F.
         nstr=nstrv
         ntek=1
         DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
                       ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
    CASE key=4.AND.pr_pusto && ->
         IF npolscr<npolscrm
              npolscr=npolscr+1
              i="polscr"+STR(npolscr,1,0)
              RESTORE SCREEN FROM &i
              DO Pscrs WITH nzkvvodv,prbof,preof,nstr,nstrn,nstrv,ncoll,;
         ncolr,step,ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
         ENDIF
    CASE key=19.AND.pr_pusto && <-
         IF npolscr>1
              npolscr=npolscr-1
              i="polscr"+STR(npolscr,1,0)
              RESTORE SCREEN FROM &i
              DO Pscrs WITH nzkvvodv,prbof,preof,nstr,nstrn,nstrv,ncoll,;
          ncolr,step,ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
         ENDIF
    CASE key=26.AND.pr_pusto && Ctrl + <-
         IF npolscr#1
              npolscr=1
              RESTORE SCREEN FROM polscr1
              DO Pscrs WITH nzkvvodv,prbof,preof,nstr,nstrn,nstrv,ncoll,;
         ncolr,step,ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
         ENDIF
    CASE key=2.AND.pr_pusto                   && Ctrl + ->
         IF npolscr#npolscrm
              npolscr=npolscrm
              i="polscr"+STR(npolscrm,1,0)
              RESTORE SCREEN FROM &i
              DO Pscrs WITH nzkvvodv,prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
            ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
         ENDIF
    CASE (key=29.OR.key=31).AND.!prbof.AND.pr_pusto && Ctrl + PageUp или Ctrl + Home
         prbof=.T.
         preof=.F.
         npromstr=RECNO()
         IF usl='.F.'
              GO TOP
         ELSE
              DO WHILE !(BOF().OR.&usl)
                   SKIP -1
              ENDDO
              IF BOF()
                   GO TOP
              ELSE
                   SKIP
              ENDIF
         ENDIF
         i=RECNO()
         ntek=1
         IF nzkvvodv=RECNO()
              GO npromstr
              color=IIF(DELETE(),colorv3,colorv1)
              pr_v_pr=.F.
              DO &Strsay WITH color,nstr,npolscr
              pr_v_pr=.T.
              GO i
              nstr=nstrv
         ELSE
              nstr=nstrv
              DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,;
          ncolr,step,ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
         ENDIF
    CASE (key=23.OR.key=30).AND.!preof.AND.pr_pusto   && Ctrl + PageDn или Ctrl + End
         prbof=.F.
         preof=.T.
         npromstr=RECNO()
         GO nzkvvodv
         i=1
         SCAN REST WHILE !(&usl).AND.i<=kolzap
              i=i+1
         ENDSCAN
         IF EOF().OR.&usl
              SKIP -1
              i=i-1
              GO npromstr
              IF ntek#i
                   color=IIF(DELETE(),colorv3,colorv1)
                   pr_v_pr=.F.
                   DO &Strsay WITH color,nstr,npolscr
                   pr_v_pr=.T.
                   ntek=i
                   nstr=nstrv+step*(i-1)
                   GO nzkvvodv
                   SKIP i-1
              ENDIF
         ELSE
              IF usl='.F.'
                   GO BOTTOM
              ELSE
                   SCAN REST WHILE !(&usl)
                   ENDSCAN
                   SKIP -1
              ENDIF
              DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
              ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
         ENDIF
    CASE key=27                               && Esc
         FLUSH
         EXIT
    CASE key=28                               && F1 - help
         SAVE SCREEN  TO scr1
         CLEAR TYPEAHEAD
         IF namhelp1#" "
              =SYS(2002,1)
              DO &namhelp1
              =SYS(2002)
              RESTORE SCREEN FROM scr1
              pr_pusto=RECCOUNT()#0.AND.!&usl
              IF pr_pusto
                   ntek=1
                   nstr=nstrv
                   DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
            ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
              ENDIF
         ELSE
              SET COLOR TO gr+/n
              i=IIF(prvvod,1,0)+IIF(prudal,1,0)+IIF(prcorr,1,0)
              DEFINE WINDOW Zap_help FROM 6,20 TO 19+i,61 SHADOW
              ACTIVATE WINDOW Zap_help
              i=0
              @  0,0 SAY "          - предыдущая строка  "
              @  1,0 SAY "          - следующая строка   "
              @  2,0 SAY " PageUp    - предыдущий экран   "
              @  3,0 SAY " PageDown  - следующий экран    "
              @  4,0 SAY " ->        - экран вправо       "
              @  5,0 SAY " <-        - экран влево        "
              @  6,0 SAY " Ctrl+<-   - в начало строки    "
              @  7,0 SAY " Ctrl+->   - в конец строки     "
              @  8,0 SAY " Ctrl+Home - в начало файла     "
              @  9,0 SAY " Ctrl+End  - в конец файла      "
              @ 10,0 SAY " Alt+F1    - контекстная помощь "
              @ 11,0 SAY " Esc       - выход              "
              IF prvvod
                   @ 12,0 SAY " Insert    - pежим вставки новых записей"
                   i=i+1
              ENDIF
              IF prcorr
                   @ 12+i,0 SAY " Enter     - корректировать строку      "
                   i=i+1
              ENDIF
              IF prudal
                   @ 12+i,0 SAY " Delete    - удалить строку             "
              ENDIF
              READ
              DEACTIVATE WINDOW Zap_help
              RESTORE SCREEN FROM scr1
         ENDIF
    CASE key<=-1.AND.key>=-9                 && F2-F10
         namhelp="namhelp"+RIGHT(STR(1-key,2,0),1)
         namhelp=&namhelp
         IF namhelp#" "
              =SYS(2002,1)
              SAVE SCREEN  TO scr1
              DO &namhelp
              RESTORE SCREEN FROM scr1
              =SYS(2002)
              pr_pusto=RECCOUNT()#0.AND.!&usl
              IF pr_pusto
                   ntek=1
                   nstr=nstrv
                   DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
            ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
              ENDIF
         ENDIF
    ENDCASE
ENDDO
=SYS(2002,1)
IF prudalv#0.AND.pr_pack
    DEFINE WINDOW Pog_vvod FROM 11,27 TO 13,54 COLOR SCHEME 18 DOUBLE SHADOW
    ACTIVATE WINDOW Pog_vvod
    SET COLOR TO &colorv6
    @ 0,0 SAY '░'
    SET COLOR TO &colorv1
    @ 0,1 SAY "Пожалуйста, подождите..."
    IF pr_setev
         i_alia=ALIAS()
         ii=ORDER()
         USE &i_alia EXCLUSIVE
         PACK
         USE &i_alia
         SET ORDER TO &ii
    ELSE
         PACK
    ENDIF
    RELEASE WINDOW Pog_vvod
ENDIF
IF EMPTY(nam_win)
    RESTORE SCREEN FROM vscr
ELSE
    DEACTIVATE WINDOW &nam_win
ENDIF
RETURN
*
PROCEDURE Pscrs
PARAMETERS npromstr,prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,ntek,;
           kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
PRIVATE i
GO npromstr
nstr=nstrv
SET COLOR TO &colorv1
@ nstrv,ncoll CLEAR TO nstrn-1,ncolr
i=1
DO WHILE i<=kolzap
     IF EOF().OR.&usl
         SET COLOR TO &colorv1
         @ nstr,ncoll CLEAR TO nstrn-1,ncolr
         SKIP -1
         i=i-1
         nstr=nstr-step
         EXIT
    ELSE
         color=IIF(DELETE(),colorv3,colorv1)
         DO &Strsay WITH color,nstr,npolscr
         nstr=nstr+step
         i=i+1
         SKIP
    ENDIF
ENDDO
prbof=.F.
SET COLOR TO &colorv2
IF i<ntek
    ntek=i
ENDIF
GO npromstr
SKIP ntek
preof=EOF().OR.&usl
SKIP -1
nzkvvodv=npromstr
nstr=nstrv+(ntek-1)*step
RETURN
