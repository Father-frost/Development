PRIVATE nz
nz=RECNO()
fvid='  '
@ 16,41 FILL TO 18,60 COLOR &color20
SET COLOR TO &color13
@ 15,40,17,59 BOX "╔═╗║╝═╚║ "
SET COLOR TO &color14
@ 16,41 SAY " Вид фоpмулы" GET fvid
READ
IF LASTKEY()=27.OR.fvid=' '
    RETURN
ENDIF
*
SET ORDER TO bs_kp
SELECT spr_bs
SET ORDER TO bs
SELECT 0
USE avotrr EXCLUSIVE
ZAP
SET DELETED ON
APPEND FROM avot FOR kp=avot.kp.AND.nrd=avot.nrd.AND.nvx=avot.nvx
SET DELETED OFF
INDEX ON kor TAG rab1
INDEX ON nps TAG rab2
SET ORDER TO rab1
SELECT 0
USE spr_vid
SET ORDER TO kod
SET EXACT OFF
SEEK fvid
SET EXACT ON
SCAN REST WHILE kod=fvid FOR !DELETE()
    SELECT avotrr
    IF spr_vid.pr_kor='1'
         IF !SEEK(spr_vid.kor)
              APPEND BLANK
              REPLACE kp WITH avot.kp,nrd WITH avot.nrd,kor WITH spr_vid.kor,;
                     nsk WITH avot.nsk,pr_spr WITH avot.pr_spr,bs WITH avot.bs,;
                     dat WITH avot.dat,npp WITH avot.npp,nvx WITH avot.nvx
         ENDIF
    ELSE
         APPEND BLANK
    ENDIF
    REPLACE nps WITH spr_vid.npp
ENDSCAN
SELECT avotrr
SET ORDER TO rab2
=Menu_m("Помощь","","Расчет","","","","","","","")
SET RELATION TO fvid+STR(nps,3) INTO spr_vid
ON KEY LABEL F1 s=Help_br()
ON KEY LABEL F3 s=Rash_kor()
ON KEY LABEL Ctrl-PgUp GO TOP
ON KEY LABEL Ctrl-PgDn GO BOTTOM
BROWSE FIELDS kor :H='К/счет', spr_vid.nam :H='Hаименование',smd :H='Сумма' :W=spr_vid.form=' ';
       PREFERENCE Pl_kor COLOR SCHEME 21 TITLE 'Дополнительные суммы' FREEZE smd NOAPPEND NODELETE
ON KEY LABEL F1
ON KEY LABEL F3
ON KEY LABEL Ctrl-PgUp
ON KEY LABEL Ctrl-PgDn
SET RELATION TO
DELETE TAG rab1,rab2
SCAN FOR kor#' '.AND.smd#0
    SELECT avot
    IF !SEEK(avotrr.bs+avotrr.kp+avotrr.nrd+avotrr.kor)
         APPEND BLANK
         REPLACE kp WITH avotrr.kp,nrd WITH avotrr.nrd,kor WITH avotrr.kor,;
                 bs WITH avotrr.bs,pr_spr WITH avotrr.pr_spr
    ENDIF
    IF nastf_h=1.AND.EMPTY(uni)
         sss=FULLPATH('unin.mem')
         RESTORE FROM unin ADDITIVE
         unin=unin+1
         SAVE TO &sss ALL LIKE unin
         REPLACE uni WITH unin
         RELEASE unin
    ENDIF
    REPLACE nsk WITH avotrr.nsk,nvx WITH avotrr.nvx,smd WITH avotrr.smd,;
            dat WITH avotrr.dat,npp WITH avotrr.npp
    SELECT avotrr
ENDSCAN
ZAP
USE
SELECT spr_vid
USE
*
SELECT avot
IF RECCOUNT()#0
    GO nz
ENDIF
RETURN
*
PROCEDURE Help_br
DEFINE WINDOWS Help FROM 6,20 TO 19,59 COLOR gr+/n
ACTIVATE WINDOWS Help
@  0,1 SAY "           - предыдущая строка"
@  1,1 SAY "           - следующая строка"
@  2,1 SAY "Ctrl+T      - удалить строку"
@  3,1 SAY "Ctrl+N      - вставка новой записи"
@  4,1 SAY "PageUp      - предыдущий экран"
@  5,1 SAY "PageDown    - следующий экран"
@  6,1 SAY "Tab         - колонка вправо"
@  7,1 SAY "Shift+Tab   - колонка влево"
@  8,1 SAY "Ctrl+PageUp - в начало файла"
@  9,1 SAY "Ctrl+PageDn - конец файла"
@ 10,1 SAY "Esc         - выход без сохpанения"
@ 11,1 SAY "Ctrl+End    - выход c сохpанением"
READ
RELEASE WINDOWS Help
RETURN
*
PROCEDURE Rash_kor
PRIVATE fobozn,fform
SCAN FOR !DELETE()
    fobozn=spr_vid.obozn
    fform=spr_vid.form
    IF spr_vid.form=' '
         &fobozn=smd
    ELSE
         &fobozn=&fform
         REPLACE smd WITH &fobozn
    ENDIF
ENDSCAN
GO TOP
RETURN
*
*
PROCEDURE Menu_m
PARAMETERS a1,a2,a3,a4,a5,a6,a7,a8,a9,a0
SET COLOR TO &color11
a1=RTRIM(a1)+SPACE(6-LEN(RTRIM(a1)))
a2=RTRIM(a2)+SPACE(6-LEN(RTRIM(a2)))
a3=RTRIM(a3)+SPACE(6-LEN(RTRIM(a3)))
a4=RTRIM(a4)+SPACE(6-LEN(RTRIM(a4)))
a5=RTRIM(a5)+SPACE(6-LEN(RTRIM(a5)))
a6=RTRIM(a6)+SPACE(6-LEN(RTRIM(a6)))
a7=RTRIM(a7)+SPACE(6-LEN(RTRIM(a7)))
a8=RTRIM(a8)+SPACE(6-LEN(RTRIM(a8)))
a9=RTRIM(a9)+SPACE(6-LEN(RTRIM(a9)))
a0=RTRIM(a0)+SPACE(7-LEN(RTRIM(a0)))
@ 24,1  SAY LEFT(a1,6)
@ 24,9  SAY LEFT(a2,6)
@ 24,17 SAY LEFT(a3,6)
@ 24,25 SAY LEFT(a4,6)
@ 24,33 SAY LEFT(a5,6)
@ 24,41 SAY LEFT(a6,6)
@ 24,49 SAY LEFT(a7,6)
@ 24,57 SAY LEFT(a8,6)
@ 24,65 SAY LEFT(a9,6)
@ 24,73 SAY LEFT(a0,7)
SET COLOR TO &color7
@ 24,0  SAY "1"
@ 24,7  SAY " 2"
@ 24,15 SAY " 3"
@ 24,23 SAY " 4"
@ 24,31 SAY " 5"
@ 24,39 SAY " 6"
@ 24,47 SAY " 7"
@ 24,55 SAY " 8"
@ 24,63 SAY " 9"
@ 24,71 SAY " 0"
RETURN
