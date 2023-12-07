DEFINE POPUP Finr_dp FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Finr_dp PROMPT " В\<едение справочников    "
DEFINE BAR 2 OF Finr_dp PROMPT "\-"
DEFINE BAR 3 OF Finr_dp PROMPT " В\<ходная информация      "
DEFINE BAR 4 OF Finr_dp PROMPT "\-"
DEFINE BAR 5 OF Finr_dp PROMPT " В\<ыходные формы          "
ON SELECTION POPUP Finr_dp DO Finr_dp WITH BAR()
ACTIVATE POPUP Finr_dp BAR 3
RETURN
*
PROCEDURE Finr_dp
PARAMETERS chg15
*
DEFINE POPUP Spr_dp FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Spr_dp PROMPT " О\<рганизации   "
DEFINE BAR 2 OF Spr_dp PROMPT " П\<одразделения "
DEFINE BAR 3 OF Spr_dp PROMPT " Р\<аботники     "
ON SELECTION POPUP Spr_dp DO Spr_dp WITH BAR()
*
DEFINE POPUP Vx_dp FROM 9,51 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vx_dp PROMPT " Д\<вижение депонентов "
ON SELECTION POPUP Vx_dp DO Vx_dp WITH BAR()
*
DEFINE POPUP Vyx_dp FROM 9,45 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Vyx_dp PROMPT " Д\<вижение депонентов за месяц "
DEFINE BAR 2 OF Vyx_dp PROMPT "   Н\<акопительная ведомость    "
DEFINE BAR 3 OF Vyx_dp PROMPT "    П\<росмотр выходных форм    "
ON SELECTION POPUP Vyx_dp DO Vyxfdp WITH BAR()
*
*
DO CASE
CASE chg15=1
    ACTIVATE POPUP Spr_dp
CASE chg15=3
    ACTIVATE POPUP Vx_dp
CASE chg15=5
    ACTIVATE POPUP Vyx_dp
ENDCASE
RETURN
*
PROCEDURE Spr_dp
PARAMETERS chspr
HIDE POPUP ALL
DO CASE
CASE chspr=1
    SELECT skl
    DO Vvodn WITH "Chapsk","Strsaysk","Strgetsk",.T.,.T.,.T.,.F.,".F.","",;
                  "F2sk","F3sk","F4sk","","","","F8sk","F9sk","prskl","",.T.
CASE chspr=2
    SELECT sch
    DO Vvodn WITH "Chapsc","Strsaysc","Strgetsc",.T.,.T.,.T.,.F.,".F.","",;
         "F2sc","F3sc","","","","","","","F10sc","",.T.
CASE chspr=3
    SELECT sprrab
    DO Vvodn WITH "Chapsr","Strsaysr","Strgetsr",.T.,.T.,.T.,.T.,".F.","",;
         "F2sr","F3sr","F4sr","","","","","","F10sr","",.T.
ENDCASE
SHOW POPUP Glavn,Proch,Finr_dp,Spr_dp
RETURN
*
PROCEDURE Vx_dp
PARAMETERS chs
HIDE POPUP ALL
DO CASE
CASE chs=1
    SELECT 0
    USE dv_dp
    SET ORDER TO tab
    DO Vvodn WITH "Chapdp","Strsaydp","Strgetdp",.T.,.T.,.T.,.F.,".F.","",;
                  "F2dp","","","F5dp","F6dp","","","","","",.T.
    USE
ENDCASE
SHOW POPUP Glavn,Proch,Finr_dp,Vx_dp
RETURN
*
*
PROCEDURE Chapdp
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=11
nstrn=22
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-7,ncoll FILL TO nstrv+12,ncolr+2 COLOR &color20
@ nstrv-8,ncoll-1,nstrv+11,ncolr+1 BOX "╔═╗║╝═╚║ "
@ nstrv-7 ,ncoll-1 SAY "║                    Д в и ж е н и е   д е п о н е н т о в"
@ nstrv-6 ,ncoll-1 SAY "╟──────────────────────────────────────────────────────────────────────────────╢"
@ nstrv-5 ,ncoll-1 SAY "║ Ф.И.О.:                                         Месяц    Год"
@ nstrv-4 ,ncoll-1 SAY "╟────┬───────┬──────┬────────┬────┬──────────────────┬─────────────────────────╢"
@ nstrv-3 ,ncoll-1 SAY "║Бал.│Таб. N │Hомеp │  Дата  │Корр│       Cумма      │          Текст"
@ nstrv-2 ,ncoll-1 SAY "║счет│от кого│докум.│документ│счет│                  │"
@ nstrv-1 ,ncoll-1 SAY "╟────┴───────┴──────┴────────┴────┴──────────────────┴─────────────────────────╢"
@ nstrv+11,ncoll-1 SAY "╚════ F2 ─ поиск ════ F5 ─ выписка расходного ордера ════ F6 ─ просмотр оплат "
RETURN
*
PROCEDURE Strsaydp
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 6,10 SAY Spr_nam('0',tab,30)
    @ 6,56 SAY ms
    @ 6,63 SAY god
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY bs
@ nstr, 6 SAY tab
@ nstr,14 SAY nrd
@ nstr,21 SAY dat
@ nstr,30 SAY kor
@ nstr,35 SAY summa PICTURE '999,999,999,999.99'
@ nstr,54 SAY LEFT(text,25)
RETURN
*
PROCEDURE Strgetdp
PARAMETERS nstr,npolscr
IF ms#STR(ntmec,2).AND.!EMPTY(ms).OR.god#nastf_b.AND.!EMPTY(god)
    RETURN
ENDIF
IF EMPTY(tab)
    REPLACE bs WITH nastf__
ENDIF
@ nstr, 1 GET bs VALID Poisk_sc('dv_dp.bs',.F.,.F.,0,0,0,' ','.F.') ERROR 'Hет такого счета...'
@ nstr, 6 GET tab VALID Poisk_ta('dv_dp.tab',.F.,6,10,30) ERROR 'Hет такого кода...'
@ nstr,14 GET nrd
@ nstr,21 GET dat
@ nstr,30 GET kor VALID Poisk_sc('dv_dp.kor',.F.,.F.,0,0,0,' ','.F.') ERROR 'Нет такого счета...'
@ nstr,35 GET summa PICTURE '999,999,999,999.99'
@ nstr,54 GET text FUNCTION 'S25'
READ
IF EMPTY(ms).OR.EMPTY(god)
    REPLACE ms WITH STR(ntmec,2),god WITH nastf_b
ENDIF
RETURN
*
PROCEDURE F2dp
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz,fpoisk1,fpoisk2
nz=RECNO()
@ 14,24 FILL TO 17,49 COLOR &color20
SET COLOR TO &color13
@ 13,23,16,48 BOX box_1
SET COLOR TO &color14
fpoisk1=bs
fpoisk2=SPACE(LEN(sprrab.tab))
@ 14,25 SAY "Балансовый счет" GET fpoisk1 VALID Poisk_sc('fpoisk1',.T.,.F.,0,0,0,' ','.F.') ERROR 'Hет такого счета...'
@ 15,25 SAY "Табельный номер" GET fpoisk2 VALID Poisk_ta('fpoisk2',.T.,0,0,0) ERROR 'Hет такого табельного номера...'
READ
IF EMPTY(fpoisk1)
     RETURN
ENDIF
SET ORDER TO tab
SET EXACT OFF
SEEK RTRIM(fpoisk1+fpoisk2)
SET EXACT ON
IF !FOUND()
    DO Net_n WITH 10," Hет такой инфоpмации. Повторите... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F5dp
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnrd,fdati,fsm
fnrd=SPACE(6)
fdati=DATE()
fsm=summa
RESTORE FROM tek_b ADDITIVE
SELECT bk
SET ORDER TO bk2
SET EXACT OFF
SEEK dv_dp.bs+dv_dp.tab
SET EXACT ON
f_bk=.F.
SCAN REST WHILE kor=dv_dp.bs.AND.kp=dv_dp.tab FOR pr_spr='0'.AND.ndep=dv_dp.nrd.AND.!DELETE()
    f_bk=.T.
    fsm=fsm-sm
ENDSCAN
f_bkar=.F.
IF fsm>0
    SELECT 0
    USE bk_arc
    SET ORDER TO kp
    SET EXACT OFF
    SEEK dv_dp.tab
    SET EXACT ON
    SCAN REST WHILE kp=dv_dp.tab FOR pr_spr='0'.AND.ndep=dv_dp.nrd.AND.kor=dv_dp.bs.AND.;
                (RIGHT(STR(YEAR(dat),4),2)+STR(MONTH(dat),2))>=(dv_dp.god+dv_dp.ms).AND.!DELETE()
         fsm=fsm-sm
         f_bkar=.T.
    ENDSCAN
    USE
ENDIF
SELECT dv_dp
IF fsm>0
    DEFINE WINDOW Zapros FROM 11,25 TO 15,66 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,1 SAY "Номер расходного ордера" GET fnrd VALID !EMPTY(fnrd).OR.Nom_docp()
    @ 1,1 SAY "Дата ордера............" GET fdati
    @ 2,1 SAY "Сумма.................." GET fsm PICTURE '999,999,999.99'
    READ
    RELEASE WINDOW Zapros
    ACTIVATE SCREEN
ELSE
    DO CASE
    CASE f_bk.AND.f_bkar
         DO Net_n WITH 10,' Депонент оплачен ранее и уже выписан в текущем месяце...'
    CASE f_bk
         DO Net_n WITH 10,' Расходный ордер уже сформирован в кассе...'
    CASE f_bkar
         DO Net_n WITH 10,' Депонент оплачен ранее...'
    ENDCASE
ENDIF
IF LASTKEY()=27.OR.fsm<=0
    RELEASE ALL LIKE tek_b_??
    RETURN
ENDIF
SELECT bk
APPEND BLANK
REPLACE vo WITH '1',pr_spr WITH '0',kp WITH dv_dp.tab,nrd WITH fnrd,dati WITH fdati,;
       kor WITH dv_dp.bs,nzk WITH tek_b_44,wid_d WITH 4,wid_t WITH 1,text_1 WITH dv_dp.text,;
        sm WITH fsm,ndep WITH dv_dp.nrd
RELEASE ALL LIKE tek_b_??
DO Net_n WITH 10,' Расходный ордер сформирован в кассе...'
SELECT dv_dp
RETURN
*
PROCEDURE F6dp
SELECT 0
USE bkr EXCLUSIVE
ZAP
SET DELETED ON
APPEND FROM bk FOR kor=dv_dp.bs.AND.kp=dv_dp.tab.AND.pr_spr='0'.AND.ndep=dv_dp.nrd
APPEND FROM bk_arc FOR kp=dv_dp.tab.AND.pr_spr='0'.AND.ndep=dv_dp.nrd.AND.kor=dv_dp.bs.AND.;
                (RIGHT(STR(YEAR(dat),4),2)+STR(MONTH(dat),2))>=(dv_dp.god+dv_dp.ms)
SET DELETED OFF
RESTORE FROM tek_b ADDITIVE
gfbs=tek_b_44
RELEASE ALL LIKE tek_b_??
GO TOP
DO Vvodn WITH "Chapba","Strsayba","",.F.,.F.,.F.,.F.,".F.","","","","","","","","","","prplat","",.T.
ZAP
USE
SELECT dv_dp
RETURN
*
PROCEDURE Nom_docp
PRIVATE ffnrd
IF nastf_a=1
    SELECT 0
    USE spr_nrd
    SET ORDER TO nrd
    SET EXACT OFF
    SEEK tek_b_44+'1'
    SET EXACT ON
    ffnrd=nrd+1
    REPLACE nrd WITH ffnrd
    USE
    fnrd=LEFT(LTRIM(STR(ffnrd,6))+SPACE(6),6)
ENDIF
RETURN .T.
*
*
PROCEDURE Chapba
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=22
ncoll=1
step=1
npolscrm=1
ncolr=78
SET COLOR TO &color4
@ nstrv-11,ncoll-1,nstrv+11,ncolr+1 BOX "╔═╗║╝═╚║ "
@ nstrv-10,ncoll-1 SAY '║         Движение денежных средств по балансовому счету'
@ nstrv-9 ,ncoll-1 SAY '╟──────────────────────────────────────────────────────────────────────────────╢'
@ nstrv-8 ,ncoll-1 SAY '║ Операция:'
@ nstrv-7 ,ncoll-1 SAY '║ Орган-ия:                                '+IIF(nastf_11=0,'','Кому')
@ nstrv-6 ,ncoll-1 SAY '║ Документ:'
@ nstrv-5 ,ncoll-1 SAY '╟───┬───┬─────┬───────┬──────┬────────┬────────┬────┬──────────────────┬───┬───╢'
@ nstrv-4 ,ncoll-1 SAY '║Вид│Вид│Hомер│ Код   │Hомер │  Дата  │  Дата  │Корр│       Сумма      │Вид│Вид'
@ nstrv-3 ,ncoll-1 SAY '║опе│спр│исход│организ│банк. │докумен-│ оплаты │счет│                  │док│тек'
@ nstrv-2 ,ncoll-1 SAY '║рац│1/0│ящий │(работ)│докум.│   та   │        │    │                  │ум.│ста'
@ nstrv-1 ,ncoll-1 SAY '╟───┴───┴─────┴───────┴──────┴────────┴────────┴────┴──────────────────┴───┴───╢'
@ nstrv+11,ncoll-1 SAY '╚═ F10 - печать '
RETURN
*
PROCEDURE Strsayba
PARAMETERS color,nstr,npolscr
PRIVATE n_str
IF !pr_v_pr
    SET COLOR TO &color21
    @ 2,57 SAY nzk
    @ 4,12 SAY IIF(vo='0','Приход','Расход')
    @ 5,12 SAY Spr_nam(pr_spr,kp,30)
    IF nastf_11=1
         @ 5,48 SAY pr_sprk
         @ 5,50 SAY kpp
         @ 5,57 SAY Spr_nam(pr_sprk,kpp,22)
    ENDIF
    SELECT sprnaz
    SEEK bkr.wid_d
    @ 6,12 SAY sprnaz.nam
    SELECT bkr
ENDIF
SET COLOR TO &color
@ nstr,2  SAY vo
@ nstr,6  SAY pr_spr
@ nstr,9  SAY nvx
@ nstr,15 SAY kp
@ nstr,23 SAY nrd
@ nstr,30 SAY dati
@ nstr,39 SAY dat
@ nstr,48 SAY kor
@ nstr,53 SAY sm PICTURE '999,999,999,999.99'
@ nstr,72 SAY wid_d
@ nstr,76 SAY wid_t
RETURN
*
PROCEDURE Vyxfdp
PARAMETERS ch1
PRIVATE scr
SAVE SCREEN TO scr
chg12=0
IF ch1#3
*
    fname="out.txt        "
    nlist=1
    pr_otk=.F.
    DO Pr_file WITH chg12,fname,nlist,.T.,pr_otk
    IF pr_otk
         RETURN
    ENDIF
    SET DEVICE TO SCREEN
*
    ffgod=nastf_b
    ffms=ntmec
    DO CASE
    CASE ch1=1
         DEFINE WINDOW Zapros FROM 12,48 TO 15,59 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Год.." GET ffgod
         @ 1,0 SAY " Месяц" GET ffms PICTURE '99' VALID ffms>0.AND.ffms<13 ERROR 'Hет такого месяца...'
    CASE ch1=2
         ffgodn=nastf_b
         ffmsn=ntmec
         DEFINE WINDOW Zapros FROM 12,44 TO 17,65 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Период с года.." GET ffgodn
         @ 1,0 SAY "          месяца" GET ffmsn PICTURE '99' VALID ffmsn>0.AND.ffmsn<13 ERROR 'Hет такого месяца...'
         @ 2,0 SAY "        по год.." GET ffgod
         @ 3,0 SAY "           месяц" GET ffms PICTURE '99' VALID ffms>0.AND.ffms<13 ERROR 'Hет такого месяца...'
    ENDCASE
    READ
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
         RETURN
    ENDIF
    SET DEVICE TO SCREEN
    ACTIVATE WINDOW Pogal
    SET COLOR TO &color15
    @ 0,0 SAY '░'
    SET COLOR TO &color13
    @ 0,1 SAY "Пожалуйста, подождите..."
    @ 1,2 SAY ' Всего записей:       '
    @ 2,2 SAY ' Текущая запись:      '
    SET COLOR TO &color14
ENDIF
SET ESCAPE ON
ON ESCAPE DO Stop_esc
SET DELETED ON
DO CASE
CASE ch1=1
    SELECT 0
    USE dv_dp
    SET ORDER TO tab
    GO TOP
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Dep_mec
    SELECT dv_dp
    USE
CASE ch1=2
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
    INDEX ON kor+kp+DTOC(dat,1) TAG rab
    SET DELETED ON
    APPEND FROM bk FOR kor=nastf__.AND.pr_spr='0'
    APPEND FROM bk_arc FOR pr_spr='0'.AND.kor=nastf__
    SET DELETED OFF
    SELECT 0
    USE dv_dp
    SET ORDER TO god
    GO TOP
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    GO TOP
    DO Dep_god
    USE
    SELECT bkr
    DELETE TAG rab
    ZAP
CASE ch1=3
    DO Prvyx
ENDCASE
SET DELETED OFF
SET ESCAPE OFF
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN
*
PROCEDURE Dep_mec
DIMENSION mkor(100,3)
PRIVATE ii
n1=1
n2=5
n3=11
n4=47
n5=52
n6=59
n7=68
n8=87
n9=92
n10=99
n11=108
klkor=0
mkor=0
nnstr=0
ffsumd=0
ffsumk=0
nstr=kolstr+1
ii=0
koldpp=0
DO WHILE !EOF()
    fsumd=0
    fsumk=0
    ftab=tab
    pr_per=.T.
    koldp=0
    SCAN REST WHILE ftab=tab FOR !DELETE()
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         koll=0
         IF ms=STR(ntmec,2).AND.god=nastf_b
              koll=1
              koldp=koldp+1
              koldpp=koldpp+1
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
                   pr_per=.T.
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY koldpp PICTURE '999'
                   IF pr_per
                        @ nstr,n2 SAY ftab
                        @ nstr,n3 SAY Spr_nam('0',ftab,35)
                        pr_per=.F.
                   ENDIF
                   @ nstr,n4 SAY kor
                   @ nstr,n5 SAY nrd
                   @ nstr,n6 SAY dat
                   @ nstr,n7 SAY summa PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
              FOR i=1 TO klkor
                   IF mkor(i,1)=kor
                        EXIT
                   ENDIF
              ENDFOR
              IF i>klkor
                   klkor=i
                   mkor(i,1)=kor
              ENDIF
              mkor(i,2)=mkor(i,2)+summa
              fsumd=fsumd+summa
         ENDIF
         SELECT bk
         SET ORDER TO bk2
         SET EXACT OFF
         SEEK nastf__+ftab
         SET EXACT ON
         kolbk=0
         SCAN WHILE kor=nastf__.AND.LEFT(kp,6)=ftab FOR pr_spr='0'.AND.ndep=dv_dp.nrd.AND.MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b.AND.!DELETE()
              IF koll=0
                   koldp=koldp+1
                   koldpp=koldpp+1
              ENDIF
              kolbk=kolbk+1
              IF kolbk>1.OR.koll=0
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                        pr_per=.T.
                   ENDIF
                   nstr=nstr+1
              ENDIF
              IF nnstr>=nlist
              	   IF kolbk>1.OR.koll=0
                        @ nstr,n1 SAY koldpp PICTURE '999'
                   ENDIF
                   IF pr_per
                        @ nstr,n2 SAY ftab
                        @ nstr,n3 SAY Spr_nam('0',ftab,35)
                        pr_per=.F.
                   ENDIF
                   IF vo='0'
                        @ nstr,n7 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
                   @ nstr,n8  SAY nzk
                   @ nstr,n9  SAY nrd
                   @ nstr,n10 SAY dat
                   IF vo='1'
                        @ nstr,n11 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
              ENDIF
              FOR i=1 TO klkor
                   IF mkor(i,1)=nzk
                        EXIT
                   ENDIF
              ENDFOR
              IF i>klkor
                   klkor=i
                   mkor(i,1)=nzk
              ENDIF
              IF vo='0'
                   mkor(i,2)=mkor(i,2)+sm
                   fsumd=fsumd+sm
              ELSE
                   mkor(i,3)=mkor(i,3)+sm
                   fsumk=fsumk+sm
              ENDIF
         ENDSCAN
    ENDSCAN
    IF (fsumd#0.OR.fsumk#0).AND.koldp>1
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n2  SAY 'Итого'
              @ nstr,n7  SAY fsumd PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n11 SAY fsumk PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
    ENDIF
    IF koldp>0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY REPLICATE('-',126)
         ENDIF
    ENDIF
    SELECT dv_dp
    ffsumd=ffsumd+fsumd
    ffsumk=ffsumk+fsumk
ENDDO
* сортировка массива
DIMENSION mkorr(100,3)
mkorr=0
FOR j=1 TO klkor
    fmin='9999'
    imin=0
    FOR i=1 TO klkor
         IF fmin>mkor(i,1)
              fmin=mkor(i,1)
              imin=i
         ENDIF
    ENDFOR
    mkorr(j,1)=mkor(imin,1)
    mkorr(j,2)=mkor(imin,2)
    mkorr(j,3)=mkor(imin,3)
    mkor(imin,1)='9999'
    mkor(imin,2)=0
    mkor(imin,3)=0
ENDFOR
FOR i=1 TO klkor
    mkor(i,1)=mkorr(i,1)
    mkor(i,2)=mkorr(i,2)
    mkor(i,3)=mkorr(i,3)
ENDFOR
* конец сортировки
nstr=nstr+1
IF nnstr>=nlist
     @ nstr,n2  SAY "Всего"
     @ nstr,n7  SAY ffsumd PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n11 SAY ffsumk PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
pr_per=.T.
FOR i=1 TO klkor
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         IF pr_per
              @ nstr,n1+9 SAY "в т.ч. по кор.счету "
              pr_per=.F.
         ENDIF
         @ nstr,n4  SAY mkor(i,1)
         @ nstr,n7  SAY mkor(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n11 SAY mkor(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDFOR
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,0 SAY "Лист "+STR(nst,2)+'.'
    @ 0,9 SAY "Ведомость движения депонентов по бал.счету "+nastf__+' за месяц '+tmec+' '+nastf_b+' г.'
    @ 1,0 SAY REPLICATE('-',127)
    @ 2,0 SAY "| N |Табел|            Фамилия И.О.           |Коpp| Номер|  Дата  |   Отнесено на    |Коpp| Номер|  Дата  |      Выдано      |"
    @ 3,0 SAY "|п/п|номер|                                   |счет|депон.|        |     депонент     |счет|докум.|        |    депонентов    |"
    @ 4,0 SAY REPLICATE('-',127)
ENDIF
nstr=4
RETURN
*
PROCEDURE Dep_god
DIMENSION mkor(100,3)
PRIVATE ii
n1=1
n2=5
n3=9
n4=15
n5=51
n6=56
n7=63
n8=72
n9=91
n10=96
n11=103
n12=112
klkor=0
mkor=0
nnstr=0
ffffsumd=0
ffffsumk=0
nstr=kolstr+1
ii=0
koldpp=0
DO WHILE !EOF()
    fffsumd=0
    fffsumk=0
    fgod=god
    DO WHILE fgod=god.AND.!EOF()
         ffsumd=0
         ffsumk=0
         fms=ms
         DO WHILE fms=ms.AND.fgod=god.AND.!EOF()
              fsumd=0
              fsumk=0
              ftab=tab
              pr_per=.T.
              koldp=0
              SCAN REST WHILE fms=ms.AND.fgod=god.AND.ftab=tab FOR !DELETE()
                   koldp=koldp+1
                   ii=ii+1
                   ?? ii PICTURE '999999' AT 18
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap2 WITH nnstr,nstr,nlist
                        pr_per=.T.
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY god
                        @ nstr,n2 SAY ms
                        IF pr_per
                             @ nstr,n3 SAY ftab
                             @ nstr,n4 SAY Spr_nam('0',ftab,35)
                             pr_per=.F.
                        ENDIF
                        @ nstr,n5 SAY kor
                        @ nstr,n6 SAY nrd
                        @ nstr,n7 SAY dat
                        @ nstr,n8 SAY summa PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
                   FOR i=1 TO klkor
                        IF mkor(i,1)=kor
                             EXIT
                        ENDIF
                   ENDFOR
                   IF i>klkor
                        klkor=i
                        mkor(i,1)=kor
                   ENDIF
                   mkor(i,2)=mkor(i,2)+summa
                   fsumd=fsumd+summa
                   SELECT bkr
                   SET EXACT OFF
                   SEEK nastf__+ftab
                   SET EXACT ON
                   kolbk=0
                   SCAN WHILE kor=nastf__.AND.LEFT(kp,6)=ftab FOR pr_spr='0'.AND.ndep=dv_dp.nrd.AND.!DELETE()
                        kolbk=kolbk+1
                        IF kolbk>1
                             IF nstr>kolstr
                                  nnstr=nnstr+1
                                  DO Chap2 WITH nnstr,nstr,nlist
                                  pr_per=.T.
                             ENDIF
                             nstr=nstr+1
                             koldp=koldp+1
                        ENDIF
                        IF nnstr>=nlist
                             IF pr_per
                                  @ nstr,n3 SAY ftab
                                  @ nstr,n4 SAY Spr_nam('0',ftab,35)
                                  pr_per=.F.
                             ENDIF
                             IF vo='0'
                                  @ nstr,n8 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
                             ENDIF
                             @ nstr,n9  SAY nzk
                             @ nstr,n10 SAY nrd
                             @ nstr,n11 SAY dat
                             IF vo='1'
                                  @ nstr,n12 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
                             ENDIF
                        ENDIF
                        FOR i=1 TO klkor
                             IF mkor(i,1)=nzk
                                  EXIT
                             ENDIF
                        ENDFOR
                        IF i>klkor
                             klkor=i
                             mkor(i,1)=nzk
                        ENDIF
                        IF vo='0'
                             mkor(i,2)=mkor(i,2)+sm
                             fsumd=fsumd+sm
                        ELSE
                             mkor(i,3)=mkor(i,3)+sm
                             fsumk=fsumk+sm
                        ENDIF
                   ENDSCAN
              ENDSCAN
              IF (fsumd#0.OR.fsumk#0).AND.koldp>1
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap2 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n2  SAY 'Итого по '+ftab
                        @ nstr,n8  SAY fsumd PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n12 SAY fsumk PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
              ENDIF
              IF koldp>0
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY REPLICATE('-',129)
                   ENDIF
              ENDIF
              SELECT dv_dp
              ffsumd=ffsumd+fsumd
              ffsumk=ffsumk+fsumk
         ENDDO
         IF ffsumd#0.OR.ffsumk#0
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap2 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n2  SAY 'Итого за '+name_mec(VAL(fms))+' 19'+fgod+' г.'
                   @ nstr,n8  SAY ffsumd PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n12 SAY ffsumk PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n2 SAY REPLICATE('-',125)
              ENDIF
         ENDIF
         fffsumd=fffsumd+ffsumd
         fffsumk=fffsumk+ffsumk
    ENDDO
    IF fffsumd#0.OR.fffsumk#0
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap2 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n2  SAY 'Итого за 19'+fgod+' г.'
              @ nstr,n8  SAY fffsumd PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n12 SAY fffsumk PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY REPLICATE('=',129)
         ENDIF
    ENDIF
    ffffsumd=ffffsumd+fffsumd
    ffffsumk=ffffsumk+fffsumk
ENDDO
* сортировка массива
DIMENSION mkorr(100,3)
mkorr=0
FOR j=1 TO klkor
    fmin='9999'
    imin=0
    FOR i=1 TO klkor
         IF fmin>mkor(i,1)
              fmin=mkor(i,1)
              imin=i
         ENDIF
    ENDFOR
    mkorr(j,1)=mkor(imin,1)
    mkorr(j,2)=mkor(imin,2)
    mkorr(j,3)=mkor(imin,3)
    mkor(imin,1)='9999'
    mkor(imin,2)=0
    mkor(imin,3)=0
ENDFOR
FOR i=1 TO klkor
    mkor(i,1)=mkorr(i,1)
    mkor(i,2)=mkorr(i,2)
    mkor(i,3)=mkorr(i,3)
ENDFOR
* конец сортировки
nstr=nstr+1
IF nnstr>=nlist
     @ nstr,n2  SAY "Всего"
     @ nstr,n8  SAY ffffsumd PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n12 SAY ffffsumk PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
pr_per=.T.
FOR i=1 TO klkor
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         IF pr_per
              @ nstr,n1+9 SAY "в т.ч. по кор.счету "
              pr_per=.F.
         ENDIF
         @ nstr,n5  SAY mkor(i,1)
         @ nstr,n8  SAY mkor(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n12 SAY mkor(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDFOR
EJECT
RETURN
*
PROCEDURE Chap2
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,0 SAY "Лист "+STR(nst,2)+'.'
    @ 0,9 SAY "Ведомость движения депонентов по бал.счету "+nastf__+' за период с '+STR(ffmsn,2)+'.'+ffgodn+' по '+STR(ffms,2)+'.'+ffgod
    @ 1,0 SAY REPLICATE('-',131)
    @ 2,0 SAY "|Год|Ме-|Табел|            Фамилия И.О.           |Коpp| Номер|  Дата  |   Отнесено на    |Коpp| Номер|  Дата  |      Выдано      |"
    @ 3,0 SAY "|   |сяц|номер|                                   |счет|депон.|        |     депонент     |счет|докум.|        |    депонентов    |"
    @ 4,0 SAY REPLICATE('-',131)
ENDIF
nstr=4
RETURN