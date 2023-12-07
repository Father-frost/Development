PARAMETERS ch1
chg12=0
IF ch1<14
    RESTORE FROM tek_b ADDITIVE
    fdat1=DATE()
    fdat2=DATE()
    ffkor=SPACE(4)
    fvo=''
    SET COLOR TO &color13
    DO CASE
    CASE ch1<3
         DEFINE WINDOW Zapros FROM 15,40 TO 17,70 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Коppеспондирующий счет" GET ffkor
         READ
         IF LASTKEY()#27.AND.ch1=1.AND.!EMPTY(ffkor)
              RELEASE WINDOW Zapros
              DEFINE POPUP Tekm FROM 10,60 COLOR SCHEME 19 SHADOW
              DEFINE BAR 1 OF Tekm PROMPT " Р\<азвернутая "
              DEFINE BAR 2 OF Tekm PROMPT " П\<о дням     "
              ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
              ACTIVATE POPUP Tekm
              menu_v=BAR()
              IF menu_v=0
                   RETURN
              ENDIF
         ENDIF
    CASE ch1=3
         DEFINE POPUP Tekm FROM 10,60 COLOR SCHEME 19 SHADOW
         DEFINE BAR 1 OF Tekm PROMPT " И\<тоговая "
         DEFINE BAR 2 OF Tekm PROMPT " П\<о дням  "
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         menu_v=BAR()
         IF menu_v=0
              RETURN
         ENDIF
    CASE ch1=4.OR.ch1=5
         DEFINE WINDOW Zapros FROM 15,40 TO 17,70 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " За какое число..." GET fdat1
         READ
    CASE ch1=6
         fkol=1
         IF nastf_v=0
              DEFINE WINDOW Zapros FROM 13,40 TO 18,75 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
         ELSE
              DEFINE WINDOW Zapros FROM 13,40 TO 19,75 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
         ENDIF
         SET COLOR TO &color14
         @ 0,0 SAY " Количество экземпляpов" GET fkol PICTURE "9"
         IF nastf_v=0
              @ 1,0 SAY " За какое число........" GET fdat1
         ELSE
              @ 1,0 SAY " Период: с числа......." GET fdat1
              @ 2,0 SAY "        по число......." GET fdat2 VALID fdat2>=fdat1 ERROR 'Hевеpен пеpиод...'
         ENDIF
         READ
    CASE ch1=9
         ffreg=SPACE(LEN(spr_reg.kod))
         DEFINE WINDOW Zapros FROM 15,40 TO 19,67 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Код pегиона..." GET ffreg
         @ 1,0 SAY " С какого числа" GET fdat1
         @ 2,0 SAY " По какое число" GET fdat2
         READ
    CASE ch1=10
         DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
         DEFINE BAR 1 OF Tekm PROMPT " В\<едомости              "
         DEFINE BAR 2 OF Tekm PROMPT " С\<вод по подразделениям "
         DEFINE BAR 3 OF Tekm PROMPT " К\<онтрольная ведомость  "
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         menu_v=BAR()
         IF menu_v=0
              RETURN
         ENDIF
         DO CASE
         CASE menu_v=1
              ffbs=SPACE(4)
              ffnsk=SPACE(5)
              DEFINE WINDOW Zapros FROM 15,40 TO 18,71 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,0 SAY " Коppеспондиpующий счет" GET ffbs
              @ 1,0 SAY " Подразделение........." GET ffnsk
              READ
              IF EMPTY(ffbs)
                   RELEASE WINDOW Zapros
                   RETURN
              ENDIF
         CASE menu_v=3
              ffbs=SPACE(4)
              DEFINE WINDOW Zapros FROM 15,40 TO 17,71 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,0 SAY " Коppеспондиpующий счет" GET ffbs
              READ
              IF EMPTY(ffbs)
                   RELEASE WINDOW Zapros
                   RETURN
              ENDIF
         ENDCASE
    CASE ch1=11
         fvo=' '
         ffnrd1=SPACE(6)
         ffnrd2=SPACE(6)
         fkol=1
         fwid_d=4
         DEFINE WINDOW Zapros FROM 14,40 TO 20,72 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Вид операции.........." GET fvo VALID fvo='0'.OR.fvo='1' ERROR '0 - приход, 1 - расход...'
         @ 1,0 SAY " Начальный номер докум." GET ffnrd1
         @ 2,0 SAY " Конечный номер докум.." GET ffnrd2
         @ 3,0 SAY " Количество экземпляров" GET fkol   PICTURE '9'
         @ 4,0 SAY " Вид документа........." GET fwid_d PICTURE '99'
         READ
         IF LASTKEY()=27
              RETURN
         ENDIF
         IF fwid_d=1.AND.fvo='0'
              RESTORE SCREEN FROM scr
              @ 15,19 FILL TO 21,77 COLOR &color20
              SET COLOR TO &color13
              @ 14,18,20,76 BOX '╔═╗║╝═╚║ '
              SET COLOR TO &color14
              fftext=SPACE(50)
              ffspos=SPACE(39)
              ffcen=SPACE(40)
              ffdot=DATE()
              ffdov=SPACE(25)
              @ 15,19 SAY ' Текст' GET fftext
              @ 16,19 SAY ' Вид отгрузки ' GET ffspos
              @ 17,19 SAY ' Дата отгрузки' GET ffdot
              @ 18,19 SAY ' Доверенность ' GET ffdov
              @ 19,19 SAY ' Цена         ' GET ffcen
              READ
         ENDIF
    CASE ch1=12
         fnrd=SPACE(5)
         fdat=DATE()
         fdatr=DATE()
         fkol=1
         DEFINE WINDOW Zapros FROM 13,35 TO 18,70 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Номер реестра........." GET fnrd
         @ 1,0 SAY " Дата реестра.........." GET fdatr
         @ 2,0 SAY " С какого числа........" GET fdat
         @ 3,0 SAY " Количество экземпляров" GET fkol PICTURE '9'
         READ
         IF EMPTY(fnrd).OR.EMPTY(fdatr)
              RELEASE WINDOW Zapros
              RETURN
         ENDIF
    CASE ch1=13
         DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
         DEFINE BAR 1 OF Tekm PROMPT " И\<нформация по налогам " SKIP FOR tek_b_30=0.AND.tek_b_31=0
         DEFINE BAR 2 OF Tekm PROMPT " П\<латежи по договорам  " SKIP FOR nastf_w=0
         DEFINE BAR 3 OF Tekm PROMPT " К\<онтрольная ведомость " SKIP FOR tek_b_38=0
         DEFINE BAR 4 OF Tekm PROMPT " В\<заимоплатежи         "
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         menu_v=BAR()
         IF menu_v=0
              RETURN
         ENDIF
         ffbs=SPACE(4)
         DO CASE
         CASE menu_v=1
              fsnds=SPACE(4)
              fssn=SPACE(4)
              DEFINE WINDOW Zapros FROM 15,40 TO 17+IIF(tek_b_30=0,0,1)+IIF(tek_b_31=0,0,1),71 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              i=0
              @ 0,0 SAY " Коppеспондиpующий счет" GET ffbs
              IF tek_b_30#0
                   i=i+1
                   @ i,0 SAY " Счет НДС.............." GET fsnds
              ENDIF
              IF tek_b_31#0
                   i=i+1
                   @ i,0 SAY " Счет спецналога......." GET fssn
              ENDIF
         CASE menu_v=2
              ffdog=SPACE(10)
              ffkp=SPACE(7)
              ffbs=gfbs
              fdat1=CTOD('  /  /  ')
              fdat2=fdat1
              DEFINE WINDOW Zapros FROM 15,40 TO 21,69 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,0 SAY " Балансовый счет" GET ffbs
              @ 1,0 SAY " Номер договора." GET ffdog
              @ 2,0 SAY " Код организации" GET ffkp
              @ 3,0 SAY " Период с числа." GET fdat1
              @ 4,0 SAY "       до числа." GET fdat2
         CASE menu_v=3
              DEFINE WINDOW Zapros FROM 15,40 TO 17,70 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,0 SAY " Коppеспондирующий счет" GET ffbs
         CASE menu_v=4
              ffbs=gfbs
              ffkp=SPACE(7)
              fdat1=CTOD('  /  /  ')
              fdat2=fdat1
              ffpr=0
              DEFINE WINDOW Zapros FROM 15,40 TO 21,72 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,0 SAY " Код организации...." GET ffkp VALID Poisk_kl('ffkp',.T.,0,0,0) ERROR 'Hет такого кода...'
              @ 1,0 SAY " Балансовый счет...." GET ffbs
              @ 2,0 SAY " Полная (1), нет (0)" GET ffpr PICTURE '9' VALID ffpr=0.OR.ffpr=1 ERROR '0 - только по взаимоплатежам, 1 - полная...'
              @ 3,0 SAY " Период с числа....." GET fdat1
              @ 4,0 SAY "       до числа....." GET fdat2
         ENDCASE
         READ
         IF EMPTY(ffbs).AND.(menu_v=1.OR.menu_v=3).OR.menu_v=2.AND.LASTKEY()=27.OR.menu_v=4.AND.(EMPTY(ffkp).OR.LASTKEY()=27)
              RELEASE WINDOW Zapros
              RETURN
         ENDIF
    ENDCASE
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
         RETURN
    ENDIF
    DO CASE
    CASE ch1=1.OR.ch1=4.OR.ch1=8.OR.ch1=12
         fvo='0'
    CASE ch1=2.OR.ch1=5.OR.ch1=7
         fvo='1'
    ENDCASE
*
    fname="out.txt        "
    nlist=1
    pr_otks=.F.
    DO Pr_file WITH chg12,fname,nlist,.T.,pr_otks
    IF pr_otks
         RETURN
    ENDIF
*
    SET DEVICE TO SCREEN
    ACTIVATE WINDOW Pogal
    SET COLOR TO &color15
    @ 0,0 SAY '░'
    SET COLOR TO &color13
    @ 0,1 SAY "Пожалуйста, подождите..."
    @ 1,2 SAY ' Всего записей:       '
    @ 2,2 SAY ' Текущая запись:      '
    SET COLOR TO &color14
    SELECT spr_bs
    SET ORDER TO bs
    SEEK gfbs
    SELECT skl
    SET ORDER TO kkl
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
*    ftekg=1900+VAL(nastf_b)
    ftekg=VAL(nastf_b)
    SET DELETED ON
    DO CASE
    CASE ch1=1.OR.ch1=2
         APPEND FROM bk FOR vo#fvo.AND.MONTH(dat)=ntmec.AND.kor=gfbs.AND.(EMPTY(ffkor).OR.nzk=ffkor).AND.YEAR(dat)=ftekg
         REPLACE ALL vo WITH IIF(vo='0','1','0'),kor WITH nzk,nzk WITH gfbs
         APPEND FROM bk FOR vo=fvo.AND.MONTH(dat)=ntmec.AND.nzk=gfbs.AND.(EMPTY(ffkor).OR.kor=ffkor).AND.YEAR(dat)=ftekg
         INDEX ON kor+DTOC(dat,1) TAG rab
    CASE ch1=3
         APPEND FROM bk FOR MONTH(dat)=ntmec.AND.kor=gfbs.AND.YEAR(dat)=ftekg
         REPLACE ALL vo WITH IIF(vo='0','1','0'),kor WITH nzk,nzk WITH gfbs
         APPEND FROM bk FOR MONTH(dat)=ntmec.AND.nzk=gfbs.AND.YEAR(dat)=ftekg
         INDEX ON kor TAG rab
    CASE ch1=4.OR.ch1=5
         APPEND FROM bk FOR vo#fvo.AND.dat=fdat1.AND.kor=gfbs
         REPLACE ALL vo WITH IIF(vo='0','1','0'),kor WITH nzk,nzk WITH gfbs
         APPEND FROM bk FOR vo=fvo.AND.dat=fdat1.AND.nzk=gfbs
         INDEX ON nvx+kor+nrd TAG rab
    CASE ch1=6
         SELECT bk
         SET ORDER TO kp
         SET EXACT OFF
         SEEK gfbs
         fsum=0
         SCAN REST WHILE nzk=gfbs FOR MONTH(dat)=ntmec.AND.dat<fdat1.AND.YEAR(dat)=ftekg
              fsum=fsum+IIF(vo='0',sm,-sm)
         ENDSCAN
         SET ORDER TO bk2
         SEEK gfbs
         SCAN REST WHILE kor=gfbs FOR MONTH(dat)=ntmec.AND.dat<fdat1.AND.YEAR(dat)=ftekg
              fsum=fsum+IIF(vo='0',-sm,sm)
         ENDSCAN
         SET EXACT ON
         fost=spr_bs.saldm+fsum
         SELECT bkr
         IF nastf_v=0
              fdat2=fdat1
         ENDIF
         APPEND FROM bk FOR kor=gfbs.AND.dat>=fdat1.AND.dat<=fdat2
         REPLACE ALL vo WITH IIF(vo='0','1','0'),kor WITH nzk,nzk WITH gfbs
         APPEND FROM bk FOR nzk=gfbs.AND.dat>=fdat1.AND.dat<=fdat2
         INDEX ON DTOC(dat,1)+vo+STR(VAL(nrd),6) TAG rab
    CASE ch1=7.OR.ch1=8
         APPEND FROM bk FOR vo#fvo.AND.MONTH(dat)=ntmec.AND.kor=gfbs.AND.YEAR(dat)=ftekg
         REPLACE ALL vo WITH IIF(vo='0','1','0'),kor WITH nzk,nzk WITH gfbs
         APPEND FROM bk FOR vo=fvo.AND.MONTH(dat)=ntmec.AND.nzk=gfbs.AND.YEAR(dat)=ftekg
         INDEX ON kor TAG rab
    CASE ch1=9
         APPEND FROM bk FOR dat>=fdat1.AND.dat<=fdat2
         SET RELATION TO kp INTO skl
         INDEX ON skl.pr_reg+kp+DTOC(dat,1) TAG rab
    CASE ch1=10
         DO CASE
         CASE menu_v=1
              APPEND FROM bk FOR MONTH(dat)=ntmec.AND.LEFT(kor,LEN(RTRIM(ffbs)))=RTRIM(ffbs).AND.nzk=gfbs.AND.YEAR(dat)=ftekg
         CASE menu_v=2
              APPEND FROM bk FOR MONTH(dat)=ntmec.AND.nzk=gfbs.AND.YEAR(dat)=ftekg
         CASE menu_v=3
              APPEND FROM bk FOR MONTH(dat)=ntmec.AND.LEFT(kor,LEN(RTRIM(ffbs)))=RTRIM(ffbs).AND.nzk=gfbs.AND.YEAR(dat)=ftekg
         ENDCASE
         INDEX ON kp+nrd+kor+nzk+vo+DTOC(dat,1) TAG rab
         SELECT 0
         USE lim_nsk EXCLUSIVE
         SET ORDER TO kp_nrd
         SET RELATION TO nsk INTO sch
         DO CASE
         CASE menu_v=1.OR.menu_v=2
              SET RELATION TO kp+nrd+kor+nzk+vo+DTOC(dat,1) INTO bkr ADDITIVE
              INDEX ON STR(VAL(nsk),5)+kor TAG rab
         CASE menu_v=3
              SELECT bkr
         ENDCASE
    CASE ch1=12
         APPEND FROM bk FOR vo#fvo.AND.dati>=fdat.AND.nazn_pl=fnrd.AND.kor=gfbs
         REPLACE ALL vo WITH IIF(vo='0','1','0'),kor WITH nzk,nzk WITH gfbs
         APPEND FROM bk FOR vo=fvo.AND.dati>=fdat.AND.nazn_pl=fnrd.AND.nzk=gfbs
         INDEX ON VAL(nrd) TAG rab
    CASE ch1=13
         SELECT bk
         DO CASE
         CASE menu_v=1
              SET ORDER TO kp
              SELECT bkr
              APPEND FROM bk FOR MONTH(dat)=ntmec.AND.kor=ffbs.AND.nzk=gfbs.AND.YEAR(dat)=ftekg
              INDEX ON kp+nrd+kor TAG rab
         CASE menu_v=2
              SELECT bkr
              APPEND FROM bk FOR (EMPTY(ffdog).OR.dog=ffdog).AND.(EMPTY(fdat1).AND.EMPTY(fdat2).AND.MONTH(dat)=ntmec.OR.dat>=fdat1.AND.dat<=fdat2).AND.(EMPTY(ffkp).OR.kp=ffkp).AND.(EMPTY(ffbs).OR.ffbs=nzk)
              APPEND FROM bk_arc FOR (EMPTY(ffdog).OR.dog=ffdog).AND.(EMPTY(fdat1).AND.EMPTY(fdat2).OR.dat>=fdat1.AND.dat<=fdat2).AND.(EMPTY(ffkp).OR.kp=ffkp).AND.(EMPTY(ffbs).OR.ffbs=nzk)
              INDEX ON nzk+dog+kp TAG rab
         CASE menu_v=3
              SET ORDER TO kp_dat
              SELECT bkr
              APPEND FROM bk FOR MONTH(dat)=ntmec.AND.nzk=ffbs.AND.YEAR(dat)=ftekg
              INDEX ON kp+nrd+DTOC(dat,1) TAG rab
              SELECT bk
         CASE menu_v=4
              SELECT bkr
              APPEND FROM bk FOR (EMPTY(ffbs).OR.nzk=ffbs).AND.(ffkp=kpp.AND.pr_sprk='1'.OR.ffpr=1.AND.ffkp=kp.AND.pr_spr='1');
                            .AND.(EMPTY(fdat1).OR.dat>=fdat1).AND.(EMPTY(fdat2).OR.dat<=fdat2)
              APPEND FROM bk_arc FOR (EMPTY(ffbs).OR.nzk=ffbs).AND.(ffkp=kpp.AND.pr_sprk='1'.OR.ffpr=1.AND.ffkp=kp.AND.pr_spr='1');
                            .AND.(EMPTY(fdat1).OR.dat>=fdat1).AND.(EMPTY(fdat2).OR.dat<=fdat2)
         ENDCASE
    ENDCASE
    SET DELETED OFF
    IF ch1=11
         SELECT bk
    ENDIF
    IF ch1=12
         @ 1,18 SAY fkol PICTURE '999999'
    ELSE
         @ 1,18 SAY RECCOUNT() PICTURE '999999'
    ENDIF
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
ENDIF
SET ESCAPE ON
ON ESCAPE DO Stop_esc
DO CASE
CASE ch1<3
    DO CASE
    CASE tek_b_10=1
         @ PROW(),0 SAY &sgat1
    CASE tek_b_10=0
         @ PROW(),0 SAY &sgat2
    ENDCASE
    IF ch1=1.AND.!EMPTY(ffkor).AND.menu_v=2
         DO Bankpd
    ELSE
         DO Bankprd
    ENDIF
    EJECT
CASE ch1=3
    DO CASE
    CASE gpr_val.OR.menu_v=1
         @ PROW(),0 SAY &sgat1
    ENDCASE
    IF menu_v=1
         DO Bankpr
    ELSE
         fsmd=0
         fvo='0'
         DO Bankmes
         fvo='1'
         DO Bankmes
    ENDIF
    EJECT
CASE ch1=4.OR.ch1=5
    DO CASE
    CASE tek_b_10=1
         @ PROW(),0 SAY &sgat1
    CASE tek_b_10=0
         @ PROW(),0 SAY &sgat2
    ENDCASE
    DO Bankdn
    EJECT
CASE ch1=6
    IF !EMPTY(sgat4)
         @ PROW(),0 SAY &sgat4
    ENDIF
    @ PROW(),0 SAY &sgat2
    IF tek_b_49=0.OR.nastf_v=0.OR.fdat1=fdat2
         DO Prkas
    ELSE
         DO Prkasn
    ENDIF
CASE ch1=7.OR.ch1=8
    @ PROW(),0 SAY &sgat1
    DO Bankmes
    EJECT
CASE ch1=9
    DO Bank_reg
CASE ch1=10
    DO CASE
    CASE menu_v=1
         DO CASE
         CASE tek_b_35=1
              @ PROW(),0 SAY &sgat1
         CASE tek_b_35=0
              @ PROW(),0 SAY &sgat2
         ENDCASE
         DO Bank_nsk
    CASE menu_v=2
         DO Svod_nsk
    CASE menu_v=3
         DO Contr_ns
    ENDCASE
    SELECT lim_nsk
    IF menu_v<3
         DELETE TAG rab
    ENDIF
    USE
    SELECT bkr
CASE ch1=11
    DO Pr_plat
    SELECT bkr
    USE
CASE ch1=12
    DO R_treb
    EJECT
CASE ch1=13
    DO CASE
    CASE menu_v=1
         @ PROW(),0 SAY &sgat1
         DO Banknal
    CASE menu_v=2
         DO Sved_dog
    CASE menu_v=3
         DO Cont_raz
         SELECT bkr
    CASE menu_v=4
         DO Sved_vz
    ENDCASE
    EJECT
CASE ch1=14
    DO Prvyx
ENDCASE
IF ch1<11.OR.ch1=12.OR.ch1=13
	IF ch1#13.OR.menu_v#4
         DELETE TAG rab
    ENDIF
    USE
ENDIF
SET ESCAPE OFF
RELEASE ALL LIKE tek_b_??
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN