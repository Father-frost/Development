PRIVATE nz,sss
SAVE SCREEN
@ 16,40 FILL TO 20,68 COLOR &color20
SET COLOR TO &color13
@ 15,39,19,67 BOX box_2
SET COLOR TO &color14
ff2=nastf_e
@ 17,42 SAY "Hомер счета в банке" GET ff2 VALID Poisk_sc('ff2',.T.,.F.,0,0,0,' ','.F.') ERROR 'Hет такого счета...'
READ
IF LASTKEY()=27.AND.READKEY()#271
    RESTORE SCREEN
    RETURN
ENDIF
@ 11,23 FILL TO 13,50 COLOR &color20
SET COLOR TO &color15
@ 10,22,12,49 BOX "╔═╗║╝═╚║ "
SET COLOR TO &color13
@ 11,24 SAY "Пожалуйста, подождите..."
RESTORE FROM tek_b ADDITIVE
IF ff2#tek_b_6
    DO Pr_avot WITH osdkomr.kp,ff2
    tek_b_6=ff2
    sss=FULLPATH('tek_b.mem')
    SAVE TO &sss ALL LIKE tek_b_??
ENDIF
SELECT avot
SET ORDER TO bs_kp
SELECT osdkom
SET ORDER TO bs_kp
SELECT bk
SET ORDER TO bk2
SET EXACT OFF
SEEK ff2+osdkomr.kp
DO WHILE kor=ff2.AND.kp=osdkomr.kp.AND.!EOF()
    fnrd=nrd
    sm_bk=0
    SCAN REST WHILE kor=ff2.AND.kp=osdkomr.kp.AND.fnrd=nrd FOR MONTH(dat)=ntmec.AND.vo='0'.AND.!DELETE().AND.pr_spr=osdkomr.pr_spr
         sm_bk=sm_bk+bk.sm
         fdat=dat
         fnzk=kor
    ENDSCAN
    IF sm_bk#0
         SELECT avot
         sss=0
         pr_poisk=SEEK(f_l+osdkomr.kp+fnrd).AND.smdo=0
         IF !pr_poisk
              SELECT osdkom
              pr_poisk=SEEK(f_l+osdkomr.kp+fnrd).AND.smdo=0
         ENDIF
         nz=RECNO()
         IF pr_poisk
              SCAN REST WHILE bs=f_l.AND.kp=osdkomr.kp.AND.nrd=fnrd FOR !DELETE().AND.pr_spr=osdkomr.pr_spr
                   sss=sss+IIF(ALIAS()='AVOT',smd,db)
              ENDSCAN
              IF sss=sm_bk
                   IF RECCOUNT()#0
                        GO nz
                   ENDIF
                   SCAN REST WHILE bs=osdkomr.bs.AND.kp=osdkomr.kp.AND.nrd=fnrd FOR !DELETE().AND.pr_spr=osdkomr.pr_spr
                        REPLACE smdo WITH IIF(ALIAS()='AVOT',smd,db),bs_op WITH ff2
                        IF nastf_h=1
                             nam_file=ALIAS()
                             funi=uni
                             fsmdo=smdo
                             SELECT tran_opl
                             SET EXACT OFF
                             IF SEEK(STR(funi,7))
                                  RECALL
                             ELSE
                                  APPEND BLANK
                                  REPLACE uni WITH funi
                             ENDIF
                             SET EXACT ON
                             REPLACE dat WITH fdat,nrd WITH fnrd,ms WITH ntmec
                             REPLACE summa WITH fsmdo,bs WITH ff2,god WITH nastf_b
                             SELECT &nam_file
                        ENDIF
                   ENDSCAN
              ENDIF
         ENDIF
         SELECT bk
    ENDIF
ENDDO
SET EXACT ON
SELECT 0
USE dv_kp EXCLUSIVE
SET ORDER TO dat_nrd
ZAP
sss=0
SELECT avot
SET EXACT OFF
SEEK osdkomr.bs+osdkomr.kp
SET EXACT ON
SCAN REST WHILE osdkomr.bs=bs.AND.osdkomr.kp=kp FOR !DELETE().AND.pr_spr=osdkomr.pr_spr
    IF nastf_h=0
         sss=sss+1
         REPLACE unid WITH sss
    ENDIF
    SELECT dv_kp
    APPEND BLANK
    REPLACE dat WITH avot.dat,nvx WITH avot.nvx,pr_spr WITH avot.pr_spr,;
            kor WITH avot.kor,pr_otk WITH 'д',bs_op WITH avot.bs_op,nrd WITH avot.nrd
    REPLACE smd WITH smd+avot.smd,smdo WITH smdo+avot.smdo,uni WITH IIF(nastf_h=0,sss,avot.uni)
    IF nastf_h=1
         REPLACE nrd_op WITH avot.nrd_op,dat_op WITH avot.dat_op
    ENDIF
ENDSCAN
SELECT osdkom
SET ORDER TO bs_kp
SET EXACT OFF
SEEK osdkomr.bs+osdkomr.kp
SET EXACT ON
SCAN REST WHILE osdkomr.bs=bs.AND.osdkomr.kp=kp FOR !DELETE().AND.pr_spr=osdkomr.pr_spr
    IF nastf_h=0
         sss=sss+1
         REPLACE unid WITH sss
    ENDIF
    SELECT dv_kp
    APPEND BLANK
    REPLACE dat WITH osdkom.dat,nvx WITH osdkom.nvx,pr_spr WITH osdkom.pr_spr,;
            kor WITH osdkom.kor,pr_otk WITH 'с',bs_op WITH osdkom.bs_op,nrd WITH osdkom.nrd
    REPLACE smd WITH smd+osdkom.db,smk WITH smk+osdkom.kr,;
           smdo WITH smdo+osdkom.smdo,uni WITH IIF(nastf_h=0,sss,osdkom.uni)
    IF nastf_h=1
         REPLACE nrd_op WITH osdkom.nrd_op,dat_op WITH osdkom.dat_op
    ENDIF
ENDSCAN
* получение оплат по документам
SELECT 0
USE bkr EXCLUSIVE
ZAP
SET ORDER TO kp_dat
* получение авансов
SET DELETED ON
APPEND FROM bk FOR kp=osdkomr.kp.AND.kor=ff2.AND.MONTH(dat)=ntmec.AND.pr_spr=osdkomr.pr_spr
SET DELETED OFF
SELECT bk
SET ORDER TO kp
SET EXACT OFF
SEEK ff2+osdkomr.kp
SET EXACT ON
SCAN REST WHILE nzk=ff2.AND.kp=osdkomr.kp FOR MONTH(dat)=ntmec.AND.pr_spr=osdkomr.pr_spr.AND.!DELETE()
    SELECT bkr
    APPEND BLANK
    REPLACE dat WITH bk.dat,kor WITH ff2,kp WITH bk.kp,nrd WITH bk.nrd,pr_spr WITH bk.pr_spr,;
             sm WITH bk.sm,vo WITH IIF(bk.vo='0','1','0'),nzk with bk.kor,text_1 with bk.text_1
ENDSCAN
SELECT bkr
REPLACE ALL pr_otk WITH 'д',smo WITH 0
SELECT osdkom
SET EXACT OFF
SEEK ff2+osdkomr.kp
SET EXACT ON
SCAN REST WHILE bs=ff2.AND.kp=osdkomr.kp FOR !DELETE().AND.pr_spr=osdkomr.pr_spr
    SELECT bkr
    APPEND BLANK
    REPLACE pr_otk WITH 'с',pr_spr WITH osdkom.pr_spr,dat WITH osdkom.dat,text_1 with osdkom.text_1;
               nrd WITH osdkom.nrd,kor WITH ff2,kp WITH osdkom.kp,nzk with osdkom.nzk
    REPLACE sm WITH IIF(osdkom.kr#0,osdkom.kr,osdkom.db),vo WITH IIF(osdkom.kr#0,'0','1')
ENDSCAN
SELECT dv_kp
fsum=0
fsumv=0
sopl=0
del_sum=0
klnrd=SPACE(6)
ON KEY LABEL Tab DO Doc_opl
IF nastf_h=1
	ON KEY LABEL Alt-F3 DO Alt3dd
	ON KEY LABEL Alt-F4 DO Alt4dd
	ON KEY LABEL Alt-F5 DO Alt5dd
    ON KEY LABEL Alt-F7 DO Alt7dd
ENDIF
DO Vvodn WITH "Chapdd","Strsaydd","Strgetdd",.F.,.T.,.F.,.T.,".F.",;
              "F1dd","F2dd","F3dd","F4dd","F5dd","F6dd","F7dd","F8dd","F9dd","F10dd","",.T.
ON KEY LABEL Tab
ON KEY LABEL Alt-F3
ON KEY LABEL Alt-F4
ON KEY LABEL Alt-F5
ON KEY LABEL Alt-F7
RELEASE ALL LIKE tek_b_??
SELECT bkr
*ZAP
USE
SELECT osdkomr
REPLACE smdo WITH 0
SELECT dv_kp
SCAN FOR !DELETE()
    IF pr_otk='с'
         SELECT osdkom
    ELSE
         SELECT avot
    ENDIF
    IF nastf_h=0
         SEEK osdkomr.bs+osdkomr.kp+dv_kp.nrd+dv_kp.kor
         SCAN REST WHILE osdkomr.bs=bs.AND.osdkomr.kp=kp.AND.dv_kp.nrd=nrd.AND.dv_kp.kor=kor FOR dv_kp.uni=unid.AND.!DELETE()
              REPLACE smdo WITH dv_kp.smdo,bs_op WITH dv_kp.bs_op,;
              osdkomr.smdo WITH osdkomr.smdo+dv_kp.smdo
         ENDSCAN
    ELSE
         SET ORDER TO uni
         IF SEEK(dv_kp.uni)
              REPLACE smdo WITH dv_kp.smdo,bs_op WITH dv_kp.bs_op
              REPLACE nrd_op WITH dv_kp.nrd_op,dat_op WITH dv_kp.dat_op,;
                osdkomr.smdo WITH osdkomr.smdo+dv_kp.smdo
         ENDIF
    ENDIF
ENDSCAN
USE
SELECT osdkomr
REPLACE pr_prib WITH IIF(smdo<(kr+smk).AND.(db+smd)#smdo,'*',' ')
RETURN
*
PROCEDURE F1dd
PUSH KEY
ON KEY
SET COLOR TO gr+/n
DEFINE WINDOW Zap_help FROM 0,19 TO 19+IIF(nastf_h=1,5,0),64 SHADOW
ACTIVATE WINDOW Zap_help
i=0
@  0,0 SAY "           - предыдущая строка"
@  1,0 SAY "           - следующая строка"
@  2,0 SAY " PageUp     - предыдущий экран"
@  3,0 SAY " PageDown   - следующий экран"
@  4,0 SAY " Ctrl+Home  - в начало файла"
@  5,0 SAY " Ctrl+End   - в конец файла"
@  6,0 SAY " Alt+F1     - контекстная помощь"
@  7,0 SAY " Esc        - выход"
@  8,0 SAY " Enter      - ручная оплата"
@  9,0 SAY " Tab        - другое окно"
@ 10,0 SAY " F3         - итог по документу"
@ 11,0 SAY " F4         - оплата всего документа"
@ 12,0 SAY " F5         - оплата текущей строки"
@ 13,0 SAY " F6         - банк по организации"
@ 14,0 SAY " F7         - сброс оплат"
@ 15,0 SAY " F8         - сброс остатка денег"
IF nastf_h=1
    @ 16,0 SAY " F9         - разбивка по оплатам"
    i=i+1
ENDIF
@ 16+i,0 SAY " F10        - печать"
IF nastf_h=1
    @ 17+i,0 SAY " Alt+F3     - автоматическая оплата"
    @ 18+i,0 SAY " Alt+F4     - проверка разбивки по F9"
    @ 19+i,0 SAY " Alt+F5     - просмотр оплаты документов"
    @ 20+i,0 SAY " Alt+F7     - отмена оплаты с текущей записи"
    i=i+4
ENDIF
@ 17+i,0 SAY " Alt+F9     - справочники"
READ
DEACTIVATE WINDOW Zap_help
POP KEY
RETURN
*
PROCEDURE F2dd
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk1,fpoisk2,nz
nz=RECNO()
@ 10,36 FILL TO 12,61 COLOR &color20
SET COLOR TO &color13
@ 9,35,11,60 BOX "╔═╗║╝═╚║ "
SET COLOR TO &color14
fpoisk=0
@ 10,36 SAY " Cумма " GET fpoisk PICTURE '999999999999.99'
READ
IF LASTKEY()=27
    RETURN
ENDIF
GO TOP
SCAN WHILE fpoisk#smd
ENDSCAN
IF EOF()
    DO Net_n WITH 10," Hет такого значения. Повторите... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F3dd
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,fsum,fsum1,fsum2,fkp,fnrd
nz=RECNO()
SET ORDER TO nrd_kor
fkp=osdkomr.kp
fnrd=dv_kp.nrd
SET EXACT OFF
SEEK fnrd
SET EXACT ON
IF FOUND()
	fsum1=0
    SELECT bk
    SET ORDER TO kp_kor
    SEEK fkp+fnrd+ff2
    SCAN REST WHILE fkp=kp.AND.fnrd=nrd.AND.kor=ff2 FOR MONTH(dat)=ntmec.AND.!DELETE()
         IF vo='0'
              fsum1=fsum1+sm
         ELSE
              fsum1=fsum1-sm
         ENDIF
    ENDSCAN
    SELECT dv_kp
    fsum=0
    fsum2=0
    SCAN REST WHILE fnrd=nrd FOR !DELETE()
         fsum=fsum+dv_kp.smd
         fsum2=fsum2+dv_kp.smdo
    ENDSCAN
    del_sum=fsum1-fsum2
    DO Net_n WITH 6," Итого по "+fnrd+". Сумма "+STR(fsum,15,2)+"."+" Остаток "+STR(fsum1-fsum2,15,2)
ENDIF
GO nz
SET ORDER TO dat_nrd
RETURN
*
PROCEDURE F4dd
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fsmdo,nz,fkp,fnrd,fkey
SET ORDER TO nrd_kor
nz=RECNO()
fkp=osdkomr.kp
fnrd=nrd
SET EXACT OFF
SEEK fnrd
SET EXACT ON
SCAN REST WHILE fnrd=nrd FOR smd#smdo
    fsmdo=smdo
    REPLACE smdo WITH smd
    fkey=0
    IF fsmdo#smdo
         IF nastf_h=1
              DO Opl_tran
              fkey=LASTKEY()
              KEYBOARD CHR(13)
         ENDIF
         fsum=fsum-fsmdo+smdo
         fsumv=fsumv-fsmdo+smdo
    ENDIF
    REPLACE bs_op WITH IIF(smdo=0,'    ',ff2)
    IF fkey=27
         EXIT
    ENDIF
ENDSCAN
CLEAR TYPEAHEAD
SET ORDER TO dat_nrd
GO nz
RETURN
*
PROCEDURE F5dd
IF !EMPTY(bs_op).AND.bs_op#ff2
    RETURN
ENDIF
PRIVATE fsmdo,fnrd,fdat
fsmdo=smdo
IF smdo=0.OR.nastf_h=1
    REPLACE smdo WITH smd
ENDIF
IF fsmdo#smdo
    IF nastf_h=1
         DO Opl_tran
    ENDIF
    fsum=fsum-fsmdo+smdo
    fsumv=fsumv-fsmdo+smdo
ENDIF
REPLACE bs_op WITH IIF(smdo=0,'    ',ff2)
RETURN
*
PROCEDURE F6dd
PUSH KEY
ON KEY
SELECT bk
gfbs=''
gpr_val=IIF(nastf_8=0,.F.,.T.)
SET ORDER TO kp_kor
SET EXACT OFF
SEEK osdkomr.kp
SET EXACT ON
DO Vvodn WITH "Chapbk","Strsaybk","Strgetbk",.F.,.F.,.F.,.F.,"osdkomr.kp#kp","",;
              "","","","","","","","","","",.F.
SELECT dv_kp
POP KEY
RETURN
*
PROCEDURE F7dd
IF !EMPTY(bs_op).AND.bs_op#ff2
    RETURN
ENDIF
PRIVATE fsmdo
fsmdo=smdo
IF nastf_h=0
    REPLACE smdo WITH del_sum
ELSE
    REPLACE smdo WITH 0
ENDIF
IF fsmdo#smdo
    IF nastf_h=1
         DO Opl_tran
    ENDIF
    fsum=fsum-fsmdo+smdo
    fsumv=fsumv-fsmdo+smdo
ENDIF
REPLACE bs_op WITH IIF(smdo=0,'    ',ff2)
RETURN
*
PROCEDURE F9dd
IF nastf_h=0
    RETURN
ENDIF
ffuni=uni
SELECT tran_opl
SET EXACT OFF
SEEK STR(ffuni,7)
SET EXACT ON
DO Vvodn WITH "Chapop","Strsayop","Strgetop",.T.,.T.,.T.,.F.,"ffuni#uni","",;
              "","F3op","","","","","","","","",.T.
SELECT dv_kp
RETURN
*
PROCEDURE Alt3dd
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE ffsum,nz,nzz
PUSH KEY
ON KEY
* автоматическая оплата по документам
nzz=RECNO()
SELECT bkr
REPLACE ALL smo WITH 0
SELECT dv_kp
* получение использования авансов
SET EXACT OFF
SCAN
    SELECT tran_opl
    SEEK STR(dv_kp.uni,7)
    SCAN REST WHILE uni=dv_kp.uni FOR ms=ntmec.AND.god=nastf_b.AND.pr_doc=0.AND.!DELETE()
         SELECT bkr
         IF !SEEK(osdkomr.kp+DTOC(tran_opl.dat,1)+tran_opl.nrd)
              APPEND BLANK
              REPLACE kp WITH osdkomr.kp,dat WITH tran_opl.dat,nrd WITH tran_opl.nrd
         ENDIF
         REPLACE smo WITH smo+tran_opl.summa
    ENDSCAN
ENDSCAN
*
SELECT bkr
GO TOP
SELECT dv_kp
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
@ 1,2 SAY ' Всего записей:       '
@ 2,2 SAY ' Текущая запись:      '
SET COLOR TO &color14
@ 1,18 SAY RECCOUNT() PICTURE '999999'
@ 2,18 SAY ' '
ii=0
GO nzz
SCAN REST FOR smdo#smd.AND.smd#0.AND.(sopl-fsum)>0
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    DO WHILE smdo#smd.AND.smd#0.AND.(sopl-fsum)>0
         ffsum=0
         SELECT bkr
         SCAN REST FOR vo='0'.AND.!DELETE()
              ffsum=sm-smo
              IF ffsum>0
                   EXIT
              ENDIF
         ENDSCAN
         SELECT dv_kp
         IF EOF('BKR').OR.ffsum=0
              EXIT
         ENDIF
         ffsum=IIF(ffsum>smd-smdo,smd-smdo,ffsum)
         ffsum=IIF(ffsum>sopl-fsum,sopl-fsum,ffsum)
         REPLACE smdo WITH smdo+ffsum,bs_op WITH ff2
         REPLACE bkr.smo WITH bkr.smo+ffsum
         fsum=fsum+ffsum
         fsumv=fsumv+ffsum
         SELECT tran_opl
         IF !SEEK(STR(dv_kp.uni,7)+DTOC(bkr.dat,1)+bkr.nrd)
              APPEND BLANK
              REPLACE uni WITH dv_kp.uni,dat WITH bkr.dat,nrd WITH bkr.nrd,ms WITH ntmec,god WITH nastf_b
         ELSE
              IF DELETE()
                   RECALL
                   REPLACE summa WITH 0
              ENDIF
         ENDIF
         REPLACE summa WITH summa+ffsum,bs WITH ff2,nzk with bkr.nzk,kp with bkr.kp,text_1 with bkr.text_1
         SELECT dv_kp
    ENDDO
    IF EOF('BKR')
         EXIT
    ENDIF
ENDSCAN
HIDE WINDOW Pogal
ACTIVATE SCREEN
SET EXACT ON
SELECT bkr
DELETE FOR sm=0
REPLACE ALL smo WITH 0
SCAN FOR DELETE()
    PACK
    EXIT
ENDSCAN
GO TOP
SELECT dv_kp
GO nzz
ntek=1
nstr=nstrv
nzkvvodv=RECNO()
IF !(EOF().OR.&usl)
    DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
          ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
ENDIF
color=IIF(DELETE(),colorv4,colorv2)
pr_pusto=RECCOUNT()#0.AND.!&usl
IF pr_pusto
    pr_v_pr=.F.
    DO &Strsay WITH color,nstr,npolscr
    pr_v_pr=.T.
ENDIF
POP KEY
RETURN
*
PROCEDURE Alt4dd
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fsum
* получение оплат по документам
PUSH KEY
ON KEY
fsum=0
SELECT tran_opl
SET ORDER TO uni
SET EXACT OFF
SEEK STR(dv_kp.uni,7)
SET EXACT ON
SCAN REST WHILE uni=dv_kp.uni FOR ms=ntmec.AND.god=nastf_b.AND.pr_doc=0.AND.!DELETE()
    fsum=fsum+summa
ENDSCAN
SELECT dv_kp
DO Net_n WITH 11,'Оплата - '+LTRIM(TRANSFORM(smdo,'999,999,999,999.99'))+', F9 - '+LTRIM(TRANSFORM(fsum,'999,999,999,999.99'))+', разница - '+LTRIM(TRANSFORM(smdo-fsum,'999,999,999,999.99'))
POP KEY
=SYS(2002)
RETURN
*
PROCEDURE Doc_opl
PUSH KEY
ON KEY
@ nstr,ncoll FILL TO nstr,ncolr-1 COLOR w+/bg
SELECT bkr
ON KEY LABEL Tab DO Ex_vvodn
DO Vvodn WITH "Chapbkr","Strbkr","",.F.,.F.,.F.,.F.,".F.","","","","","","","","","","","",.F.
@ nstr,ncoll FILL TO nstr,ncolr-1 COLOR w+/n
SET COLOR TO &color21
@ nstr, 2 SAY ' '
@ nstr, 9 SAY ' '
@ nstr,18 SAY ' '
@ nstr,23 SAY ' '
@ nstr,39 SAY ' '
POP KEY
=SYS(2002)
SELECT dv_kp
RETURN
*
PROCEDURE Ex_vvodn
KEYBOARD CHR(27)
@ nstr,ncoll FILL TO nstr,ncolr COLOR w+/bg
SAVE SCREEN TO vscr
RETURN
*
PROCEDURE Chapbkr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=7
nstrn=21
ncoll=56
step=1
npolscrm=1
ncolr=78
RETURN
*
PROCEDURE Strbkr
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,56 SAY pr_otk
@ nstr,58 SAY nrd
@ nstr,64 SAY IIF(vo='0',sm,-sm) PICTURE '999999999999.99'
RETURN
*
PROCEDURE Alt5dd
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz
nz=RECNO()
PUSH KEY
ON KEY
* получение использования авансов
SELECT bkr
SET ORDER TO kp_dat
SELECT dv_kp
SET EXACT OFF
SCAN FOR bs_op=ff2
    SELECT tran_opl
    SEEK STR(dv_kp.uni,7)
    SCAN REST WHILE uni=dv_kp.uni FOR ms=ntmec.AND.god=nastf_b.AND.pr_doc=0.AND.!DELETE()
         SELECT bkr
         IF !SEEK(osdkomr.kp+DTOC(tran_opl.dat,1)+tran_opl.nrd)
              APPEND BLANK
              REPLACE kp WITH osdkomr.kp,dat WITH tran_opl.dat,nrd WITH tran_opl.nrd
         ENDIF
         REPLACE smo WITH smo+tran_opl.summa
    ENDSCAN
ENDSCAN
SET EXACT ON
SELECT bkr
GO TOP
DO Vvodn WITH "Chappp","Strsaypp","",.F.,.F.,.F.,.F.,".F.","","","","","","","","","","","",.T.
SELECT bkr
DELETE FOR sm=0
REPLACE ALL smo WITH 0
SCAN FOR DELETE()
    PACK
    EXIT
ENDSCAN
SELECT dv_kp
GO nz
POP KEY
=SYS(2002)
RETURN
*
PROCEDURE Alt7dd
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,fsmko
PUSH KEY
ON KEY
nz=RECNO()
SELECT dv_kp
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
@ 1,2 SAY ' Всего записей:       '
@ 2,2 SAY ' Текущая запись:      '
SET COLOR TO &color14
@ 1,18 SAY RECCOUNT() PICTURE '999999'
@ 2,18 SAY ' '
ii=0
SCAN REST FOR EMPTY(bs_op).OR.bs_op=ff2
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    fsmdo=smdo
    REPLACE smdo WITH 0
    IF fsmdo#smdo
         DO Opl_tran
         fsum=fsum-fsmdo+smdo
         fsumv=fsumv-fsmdo+smdo
    ENDIF
    REPLACE bs_op WITH IIF(smdo=0,'    ',ff2)
ENDSCAN
GO nz
HIDE WINDOW Pogal
ACTIVATE SCREEN
ntek=1
nstr=nstrv
nzkvvodv=RECNO()
IF !(EOF().OR.&usl)
    DO Pscrs WITH RECNO(),prbof,preof,nstr,nstrn,nstrv,ncoll,ncolr,step,;
          ntek,kolzap,nzkvvodv,Strsay,npolscr,colorv1,colorv2,colorv3
ENDIF
color=IIF(DELETE(),colorv4,colorv2)
pr_pusto=RECCOUNT()#0.AND.!&usl
IF pr_pusto
    pr_v_pr=.F.
    DO &Strsay WITH color,nstr,npolscr
    pr_v_pr=.T.
ENDIF
POP KEY
=SYS(2002)
RETURN
*
*
PROCEDURE Chappp
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=14
nstrn=22
*ncoll=23
ncoll=1
ncolr=78
step=1
npolscrm=1
@ nstrv-3,ncoll FILL TO nstrv+9,ncolr+2 COLOR &color20
SET COLOR TO &color4
@ nstrv-4,ncoll-1,nstrv+8,ncolr+1 BOX "╔═╗║╝═╚║ "
@ nstrv-4,ncoll-1 SAY "╔══════════╤══════╤════╤══════════════════╤══════════════════╤═════════════════╢"
@ nstrv-3,ncoll-1 SAY "║   Дата   │ Номер│Счет│  Сумма документа │       Сумма      │  Остаток        "
@ nstrv-2,ncoll-1 SAY "║ докумен. │докум.│опл.│приход(+),расх.(-)│      оплаты      │                 "
@ nstrv-1,ncoll-1 SAY "╟──────────┴──────┴────┴──────────────────┴──────────────────┴─────────────────╢"
RETURN
*
PROCEDURE Strsaypp
PARAMETERS color,nstr,npolscr
SET COLOR TO &color
@ nstr,1 SAY dat
@ nstr,12 SAY nrd
@ nstr,19 SAY nzk
@ nstr,24 SAY IIF(vo='0',sm,-sm) PICTURE '999,999,999,999.99'
@ nstr,43 SAY smo PICTURE '999,999,999,999.99'
@ nstr,62 SAY IIF(vo='0',sm,-sm)-smo PICTURE '99,999,999,999.99'
*@ nstr,23 SAY dat
*@ nstr,32 SAY nrd
*@ nstr,39 SAY IIF(vo='0',sm,-sm) PICTURE '999,999,999,999.99'
*@ nstr,58 SAY smo PICTURE '999,999,999,999.99'
RETURN