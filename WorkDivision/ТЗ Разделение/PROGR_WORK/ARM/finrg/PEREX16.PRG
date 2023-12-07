PRIVATE nz,scr
SELECT 0
USE avot EXCLUSIVE
SAVE SCREEN TO scr
IF RECCOUNT()=0
    @ 11,18 FILL TO 14,61 COLOR &color20
    SET COLOR TO &color13
    @ 10,17,13,60 box box_1
    SET COLOR TO &color14
    key=2
    @ 11,19 SAY "Есть подозpение что пеpеход уже выполнен."
    @ 12,19 SAY "Пpодолжать ?"
    @ 12,39 PROMPT " Да  "
    @ 12,49 PROMPT " Hет "
    MENU TO key
    IF key=0.OR.key=2
         USE
         RETURN
    ENDIF
ENDIF
SET COLOR TO &color14
USE
HIDE POPUP ALL
SET CLOCK OFF
CLEAR
sss='!del dbf16_'+LTRIM(STR(ntmec,2))+'.exe'
&sss
sss='!lha a dbf16_'+LTRIM(STR(ntmec,2))+' avot.* osdkom.* avot_arc.* tran_opl.*'
&sss
sss='!lha s dbf16_'+LTRIM(STR(ntmec,2))
&sss
sss='!del dbf16_'+LTRIM(STR(ntmec,2))+'.lzh'
&sss
RESTORE SCREEN FROM scr
SET CLOCK ON
SHOW POPUP Glavn,Proch,Finr_16
USE avot_arc
SET DELETED ON
APPEND FROM avot
REPLACE ms WITH STR(ntmec,2),god WITH nastf_b FOR EMPTY(ms).AND.EMPTY(god)
USE avot EXCLUSIVE
ACTIVATE WINDOW Pog_p
SET COLOR TO &color15
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
SELECT 0
USE osdkomr EXCLUSIVE
ZAP
INDEX ON kp TAG rab
SELECT 0
USE osdkom EXCLUSIVE
SET ORDER TO kp_nrd
DELETE FOR pr_prib='*'
PACK
REPLACE ALL smo WITH kr
SCAN
    SELECT osdkomr
    IF !SEEK(osdkom.kp)
         APPEND BLANK
         REPLACE kp WITH osdkom.kp,pr_spr WITH osdkom.pr_spr
    ENDIF
ENDSCAN
SELECT 0
USE bkr EXCLUSIVE
ZAP
INDEX ON kor+kp+pr_spr+nrd+DTOC(dat,1) TAG rab
APPEND FROM bk FOR (kor=nastf_e.OR.kor=nastf_k).AND.MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(dat),4),4)=nastf_b
SET DELETED OFF
SELECT bk
SCAN FOR (nzk=nastf_e.OR.nzk=nastf_k).AND.MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(dat),4),4)=nastf_b.AND.!DELETE()
     SELECT bkr
     APPEND BLANK
     REPLACE kor WITH bk.nzk,kp WITH bk.kp,pr_spr WITH bk.pr_spr,nzk with bk.kor,text_1 with bk.text_1;
              sm WITH bk.sm,vo WITH IIF(bk.vo='0','1','0'),dat WITH bk.dat,nrd WITH bk.nrd
ENDSCAN
SELECT bkr
REPLACE ALL smo WITH sm FOR vo='0'
SCAN
    SELECT osdkomr
    IF !SEEK(bkr.kp)
         APPEND BLANK
         REPLACE kp WITH bkr.kp,pr_spr WITH bkr.pr_spr
    ENDIF
ENDSCAN
SELECT avot
SET ORDER TO avot1
SCAN FOR !DELETE()
    SELECT osdkomr
    IF !SEEK(avot.kp)
         APPEND BLANK
         REPLACE kp WITH avot.kp,pr_spr WITH avot.pr_spr
    ENDIF
ENDSCAN
IF nastf_h=0
* вычитание оплаченных документов
*  для банка и сальдо
    SCAN FOR !EMPTY(nrd).AND.!DELETE()
         SELECT osdkomr
         SEEK avot.kp
         SELECT avot
         IF bs_op=nastf_e.OR.bs_op=nastf_k
              fsum=avot.smdo
              SELECT bkr
              SET ORDER TO kp_pr
              SET EXACT OFF
              SEEK avot.kp+avot.pr_spr+avot.nrd
              SET EXACT ON
              SCAN REST WHILE kp=avot.kp.AND.pr_spr=avot.pr_spr.AND.nrd=avot.nrd.AND.fsum>0 FOR vo='0'
                   IF smo>fsum
                        IF kor=nastf_k
                             REPLACE osdkomr.smko WITH osdkomr.smko+fsum
                        ENDIF
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                       IF kor=nastf_k
                             REPLACE osdkomr.smko WITH osdkomr.smko+smo
                        ENDIF
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
              SELECT osdkom
              SEEK avot.kp+avot.nrd
              SCAN REST WHILE kp=avot.kp.AND.nrd=avot.nrd.AND.fsum>0 FOR bs=nastf_k
                   IF smo>fsum
                        IF avot.bs_op=nastf_k
                             REPLACE osdkomr.smko WITH osdkomr.smko+fsum
                        ENDIF
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        IF avot.bs_op=nastf_k
                             REPLACE osdkomr.smko WITH osdkomr.smko+smo
                        ENDIF
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
         ENDIF
    ENDSCAN
    SELECT osdkom
    SCAN FOR !EMPTY(nrd).AND.(bs_op=nastf_e.OR.bs_op=nastf_k).AND.!DELETE()
         nz=RECNO()
         fnrd=nrd
         fkp=kp
         fpr_spr=pr_spr
         fbs_op=bs_op
         SELECT osdkomr
         SEEK fkp
         fsum=osdkom.smdo
         SELECT bkr
         SET EXACT OFF
         SEEK fkp+fpr_spr+fnrd
         SET EXACT ON
         SCAN REST WHILE kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.AND.fsum>0 FOR vo='0'
              IF smo>fsum
                   IF kor=nastf_k
                        REPLACE osdkomr.smko WITH osdkomr.smko+fsum
                   ENDIF
                   REPLACE smo WITH smo-fsum
                   fsum=0
              ELSE
                   IF kor=nastf_k
                        REPLACE osdkomr.smko WITH osdkomr.smko+smo
                   ENDIF
                   fsum=fsum-smo
                   REPLACE smo WITH 0
              ENDIF
         ENDSCAN
         SELECT osdkom
         SEEK fkp+fnrd
         SCAN REST WHILE kp=fkp.AND.nrd=fnrd.AND.fsum>0 FOR !DELETE()
              IF bs=nastf_k
                   IF smo>fsum
                        IF fbs_op=nastf_k
                             REPLACE osdkomr.smko WITH osdkomr.smko+fsum
                        ENDIF
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        IF fbs_op=nastf_k
                             REPLACE osdkomr.smko WITH osdkomr.smko+smo
                        ENDIF
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDIF
         ENDSCAN
         SELECT osdkom
         GO nz
    ENDSCAN
* получение остатка, закpытого авансами
    SET EXACT OFF
    SELECT osdkomr
    SCAN
         fsum=0
         SELECT avot
         SEEK osdkomr.kp
         SCAN REST WHILE kp=osdkomr.kp FOR bs_op=nastf_k.AND.!DELETE()
              fsum=fsum+smdo
         ENDSCAN
         SELECT osdkom
         SEEK osdkomr.kp
         SCAN REST WHILE kp=osdkomr.kp FOR bs_op=nastf_k.AND.!DELETE()
              fsum=fsum+smdo
         ENDSCAN
* возвpащенные деньги
         SELECT bkr
         SEEK osdkomr.kp
         SCAN REST WHILE kp=osdkomr.kp FOR kor=nastf_k.AND.vo='1'
              fsum=fsum+sm
         ENDSCAN
         fsum=fsum-osdkomr.smko
* опpеделено использование аванса - fsum
         IF fsum>0
* pаспpеделение использования
              SELECT osdkom
              SEEK osdkomr.kp
              SCAN REST WHILE kp=osdkomr.kp.AND.fsum>0 FOR bs=nastf_k.AND.smo#0.AND.!DELETE()
                   IF fsum>smo
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ELSE
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ENDIF
              ENDSCAN
              SELECT bkr
              SEEK osdkomr.kp
              SCAN REST WHILE kp=osdkomr.kp.AND.fsum>0 FOR kor=nastf_k.AND.vo='0'.AND.smo#0
                   IF fsum>smo
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ELSE
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ENDIF
              ENDSCAN
         ENDIF
         IF fsum>0
* пеpебоp аванса
              SELECT osdkom
              APPEND BLANK
              REPLACE kp WITH osdkomr.kp,pr_spr WITH osdkomr.pr_spr,bs WITH nastf_k
              REPLACE db WITH fsum
         ENDIF
* пеpенос авансов из банка
         SELECT bkr
         SEEK osdkomr.kp
         SCAN REST WHILE kp=osdkomr.kp FOR kor=nastf_k.AND.smo>0.AND.vo='0'
              SELECT osdkom
              SET ORDER TO bs_kp
              SEEK(nastf_k+osdkomr.kp)
              SCAN REST WHILE bs=nastf_k.AND.kp=osdkomr.kp FOR db>0.AND.!DELETE()
                   IF db>bkr.smo
                        REPLACE db WITH db-bkr.smo
                        REPLACE bkr.smo WITH 0
                   ELSE
                        REPLACE bkr.smo WITH bkr.smo-db
                        REPLACE db WITH 0
                   ENDIF
              ENDSCAN
              IF !SEEK(nastf_k+osdkomr.kp).OR.bkr.smo>0
                   APPEND BLANK
                   REPLACE kp WITH bkr.kp,pr_spr WITH bkr.pr_spr,nrd WITH bkr.nrd,bs WITH bkr.kor,;
                          smo WITH bkr.smo,dat WITH bkr.dat
              ENDIF
              SET ORDER TO kp_nrd
         ENDSCAN
    ENDSCAN
    SET EXACT ON
* замена db и smd на pазницу
    SELECT osdkom
    SET ORDER TO bs_kp
    REPLACE db WITH db-smdo FOR bs#nastf_k
    REPLACE kr WITH smo FOR bs=nastf_k
    REPLACE ALL smdo WITH 0
    SELECT avot
    REPLACE ALL smd WITH smd-smdo
* пеpевод отгpузки в остатки
    SCAN FOR !DELETE()
         SELECT osdkom
         APPEND BLANK
         REPLACE bs WITH avot.bs,kp WITH avot.kp,nrd WITH avot.nrd,kor WITH avot.kor,nvx WITH avot.nvx,;
             pr_spr WITH avot.pr_spr,nsk WITH avot.nsk,nzk WITH avot.nzk,db WITH avot.smd,dat WITH avot.dat,;
                npp WITH avot.npp
         SELECT avot
    ENDSCAN
*
ELSE
*
*   оплата по документам
*
    SET EXACT OFF
    SELECT 0
    USE tran_opl
    SET ORDER TO uni
    SELECT osdkom
    SCAN FOR bs=nastf_l.AND.smdo#0.AND.!EMPTY(kor).AND.!EMPTY(uni)
         nz=RECNO()
         funi=uni
         fkp=kp
         fpr_spr=pr_spr
         SELECT tran_opl
         SEEK STR(funi,7)
         SCAN REST WHILE uni=funi FOR ms=ntmec.AND.god=nastf_b.AND.pr_doc=0.AND.!DELETE()
              fnrd=nrd
              fdat=dat
              fsum=summa
              SELECT osdkom
              SET ORDER TO bs_kp
              SEEK nastf_k+fkp+fnrd
              SCAN REST WHILE bs=nastf_k.AND.kp=fkp.AND.nrd=fnrd.AND.fsum>0 FOR smo>0.AND.dat=fdat
                   IF smo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
              IF fsum#0
                   SELECT bkr
                   SET ORDER TO rab
                   SEEK nastf_e+fkp+fpr_spr+fnrd+DTOC(fdat,1)
                   SCAN REST WHILE kor=nastf_e.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.AND.dat=fdat.AND.fsum>0 FOR smo>0
                        IF smo>fsum
                             REPLACE smo WITH smo-fsum
                             fsum=0
                        ELSE
                             fsum=fsum-smo
                             REPLACE smo WITH 0
                        ENDIF
                   ENDSCAN
              ENDIF
              IF fsum#0
                   SELECT bkr
                   SET ORDER TO rab
                   SEEK nastf_k+fkp+fpr_spr+fnrd+DTOC(fdat,1)
                   SCAN REST WHILE kor=nastf_k.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.AND.fdat=dat.AND.fsum>0 FOR smo>0.AND.!DELETE()
                        IF smo>fsum
                             REPLACE smo WITH smo-fsum
                             fsum=0
                        ELSE
                             fsum=fsum-smo
                             REPLACE smo WITH 0
                        ENDIF
                   ENDSCAN
              ENDIF
              IF fsum#0     && не найден документ (справка)
                   SELECT bkr
                   SET ORDER TO rab
                   IF !SEEK(nastf_k+fkp+fpr_spr+fnrd+DTOC(fdat,1))
                        APPEND BLANK
                        REPLACE kor WITH nastf_k,kp WITH fkp,pr_spr WITH fpr_spr,;
                                vo WITH '0',dat WITH fdat,nrd WITH fnrd
                   ENDIF
                   REPLACE smo WITH smo-fsum
              ENDIF
         ENDSCAN
         SELECT osdkom
         SET ORDER TO kp_nrd
         GO nz
    ENDSCAN
    SELECT avot
    SCAN FOR bs=nastf_l.AND.smdo#0.AND.!EMPTY(kor).AND.!DELETE().AND.!EMPTY(uni)
         funi=uni
         fkp=kp
         fpr_spr=pr_spr
         SELECT tran_opl
         SEEK STR(funi,7)
         SCAN REST WHILE uni=funi FOR ms=ntmec.AND.god=nastf_b.AND.pr_doc=0.AND.!DELETE()
              fnrd=nrd
              fdat=dat
              fsum=summa
              SELECT osdkom
              SET ORDER TO bs_kp
              SEEK nastf_k+fkp+fnrd
              SCAN REST WHILE bs=nastf_k.AND.kp=fkp.AND.nrd=fnrd.AND.fsum>0 FOR dat=fdat.AND.smo>0.AND.!DELETE()
                   IF smo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
              IF fsum#0
                   SELECT bkr
                   SET ORDER TO rab
                   SEEK nastf_e+fkp+fpr_spr+fnrd+DTOC(fdat,1)
                   SCAN REST WHILE kor=nastf_e.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.AND.fdat=dat.AND.fsum>0 FOR smo>0
                        IF smo>fsum
                             REPLACE smo WITH smo-fsum
                             fsum=0
                        ELSE
                             fsum=fsum-smo
                             REPLACE smo WITH 0
                        ENDIF
                   ENDSCAN
              ENDIF
              IF fsum#0
                   SELECT bkr
                   SET ORDER TO rab
                   SEEK nastf_k+fkp+fpr_spr+fnrd+DTOC(fdat,1)
                   SCAN REST WHILE kor=nastf_k.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.AND.dat=fdat.AND.fsum>0 FOR smo>0
                        IF smo>fsum
                             REPLACE smo WITH smo-fsum
                             fsum=0
                        ELSE
                             fsum=fsum-smo
                             REPLACE smo WITH 0
                        ENDIF
                   ENDSCAN
              ENDIF
              IF fsum#0     && не найден документ (справка)
                   SELECT bkr
                   SET ORDER TO rab
                   IF !SEEK(nastf_k+fkp+fpr_spr+fnrd+DTOC(fdat,1))
                        APPEND BLANK
                        REPLACE kor WITH nastf_k,kp WITH fkp,pr_spr WITH fpr_spr,;
                                vo WITH '0',dat WITH fdat,nrd WITH fnrd
                   ENDIF
                   REPLACE smo WITH smo-fsum
              ENDIF
         ENDSCAN
    ENDSCAN
*     определение остатка авансов
    SELECT osdkomr
    SCAN
*        определение возврата авансов
         fkp=kp
         fpr_spr=pr_spr
         SELECT bkr
         SUM sm TO fsum FOR vo='1'.AND.kp=fkp.AND.fpr_spr=pr_spr
         IF fsum#0
              SELECT osdkom
              SET ORDER TO bs_kp
              SEEK nastf_k+fkp
              SCAN REST WHILE bs=nastf_k.AND.kp=fkp.AND.fsum>0 FOR smo>0.AND.pr_spr=fpr_spr.AND.!DELETE()
                   fnrd=nrd
                   fdat=dat
                   fsmo=smo
                   nz=RECNO()
*                  проверка использования аванса (там, где пустой к/счет)
                   SEEK nastf_l+fkp
                   SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR EMPTY(kor).AND.smdo#0.AND.(bs_op=nastf_e.OR.bs_op=nastf_k).AND.!DELETE()
                        SELECT tran_opl
                        SEEK STR(osdkom.uni,7)
                        SCAN REST WHILE uni=osdkom.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.god=nastf_b.AND.pr_doc=0.AND.!DELETE()
                             fsmo=fsmo-summa
                        ENDSCAN
                   ENDSCAN
                   SELECT avot
                   SET ORDER TO bs_kp
                   SEEK nastf_l+fkp
                   SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR EMPTY(kor).AND.smdo#0.AND.(bs_op=nastf_e.OR.bs_op=nastf_k).AND.!DELETE()
                        SELECT tran_opl
                        SEEK STR(avot.uni,7)
                        SCAN REST WHILE uni=avot.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.god=nastf_b.AND.pr_doc=0.AND.!DELETE()
                             fsmo=fsmo-summa
                        ENDSCAN
                   ENDSCAN
*                  аванс не используется в размере fsmo
                   SELECT osdkom
                   GO nz
                   IF fsmo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-fsmo
                        REPLACE smo WITH smo-fsmo
                   ENDIF
              ENDSCAN
              SELECT bkr
              SET ORDER TO rab
              SEEK nastf_e+fkp+fpr_spr
              SCAN REST WHILE kor=nastf_e.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.fsum>0 FOR vo='0'.AND.smo>0
                   fnrd=nrd
                   fdat=dat
                   fsmo=smo
*                  проверка использования аванса (там, где пустой к/счет)
                   SELECT osdkom
                   SEEK nastf_l+fkp
                   SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR EMPTY(kor).AND.smdo#0.AND.(bs_op=nastf_e.OR.bs_op=nastf_k).AND.!DELETE()
                        SELECT tran_opl
                        SEEK STR(osdkom.uni,7)
                        SCAN REST WHILE uni=osdkom.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.pr_doc=0.AND.!DELETE()
                             fsmo=fsmo-summa
                        ENDSCAN
                   ENDSCAN
                   SELECT avot
                   SET ORDER TO bs_kp
                   SEEK nastf_l+fkp
                   SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR EMPTY(kor).AND.smdo#0.AND.(bs_op=nastf_e.OR.bs_op=nastf_k).AND.!DELETE()
                        SELECT tran_opl
                        SEEK STR(avot.uni,7)
                        SCAN REST WHILE uni=avot.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.pr_doc=0.AND.!DELETE()
                             fsmo=fsmo-summa
                        ENDSCAN
                   ENDSCAN
*                  аванс не используется в размере fsmo
                   SELECT bkr
                   IF fsmo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-fsmo
                        REPLACE smo WITH smo-fsmo
                   ENDIF
              ENDSCAN
              SEEK nastf_k+fkp+fpr_spr
              SCAN REST WHILE kor=nastf_k.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.fsum>0 FOR vo='0'.AND.smo>0
                   fnrd=nrd
                   fdat=dat
                   fsmo=smo
*                  проверка использования аванса (там, где пустой к/счет)
                   SELECT osdkom
                   SEEK nastf_l+fkp
                   SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR EMPTY(kor).AND.smdo#0.AND.(bs_op=nastf_e.OR.bs_op=nastf_k).AND.!DELETE()
                        SELECT tran_opl
                        SEEK STR(osdkom.uni,7)
                        SCAN REST WHILE uni=osdkom.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.pr_doc=0.AND.!DELETE()
                             fsmo=fsmo-summa
                        ENDSCAN
                   ENDSCAN
                   SELECT avot
                   SET ORDER TO bs_kp
                   SEEK nastf_l+fkp
                   SCAN REST WHILE bs=nastf_l.AND.kp=fkp FOR EMPTY(kor).AND.smdo#0.AND.(bs_op=nastf_e.OR.bs_op=nastf_k).AND.!DELETE()
                        SELECT tran_opl
                        SEEK STR(avot.uni,7)
                        SCAN REST WHILE uni=avot.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.pr_doc=0.AND.!DELETE()
                             fsmo=fsmo-summa
                        ENDSCAN
                   ENDSCAN
*                  аванс не используется в размере fsmo
                   SELECT bkr
                   IF fsmo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-fsmo
                        REPLACE smo WITH smo-fsmo
                   ENDIF
              ENDSCAN
              IF fsum>0
*                  перерасход авансов
                   SELECT bkr
                   SET ORDER TO rab
                   SEEK nastf_e+fkp+fpr_spr
                   SCAN REST WHILE kor=nastf_e.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.fsum>0 FOR vo='1'
                        IF sm>fsum
                             fsm=fsum
                             fsum=0
                        ELSE
                             fsum=fsum-sm
                             fsm=sm
                        ENDIF
                        SELECT osdkom
                        APPEND BLANK
                        REPLACE kp WITH bkr.kp,pr_spr WITH bkr.pr_spr,nrd WITH bkr.nrd,bs WITH nastf_k,;
                               smo WITH -fsm,dat WITH bkr.dat,nzk with bkr.nzk,text_1 with bkr.text_1
                   ENDSCAN
                   SEEK nastf_k+fkp+fpr_spr
                   SCAN REST WHILE kor=nastf_k.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.fsum>0 FOR vo='1'.AND.!DELETE()
                        IF sm>fsum
                             fsm=fsum
                             fsum=0
                        ELSE
                             fsum=fsum-sm
                             fsm=sm
                        ENDIF
                        SELECT osdkom
                        APPEND BLANK
                        REPLACE kp WITH bkr.kp,pr_spr WITH bkr.pr_spr,nrd WITH bkr.nrd,bs WITH bkr.kor,;
                               smo WITH -fsm,dat WITH bkr.dat,nzk with bkr.nzk,text_1 with bkr.text_1
                   ENDSCAN
              ENDIF
         ENDIF
    ENDSCAN
    * перевод платежей и справок в авансы
    SELECT bkr
    SCAN FOR vo='0'.AND.(smo>0.OR.(kor=nastf_e.OR.kor=nastf_k).AND.smo<0)
         SELECT osdkom
         APPEND BLANK
         REPLACE kp WITH bkr.kp,pr_spr WITH bkr.pr_spr,nrd WITH bkr.nrd,bs WITH nastf_k,;
                smo WITH bkr.smo,dat WITH bkr.dat,nzk with bkr.nzk,text_1 with bkr.text_1

    ENDSCAN
*      уменьшение сумм на величину оплат
*      замена kr и smd на pазницу
    SELECT osdkom
    SET ORDER TO bs_kp
    REPLACE db WITH db-smdo FOR bs=nastf_l.AND.!EMPTY(kor)
    REPLACE kr WITH smo FOR bs=nastf_k
    REPLACE nzk WITH '6202' FOR nzk='51'.or.nzk='52' .or.nzk='97'.or.nzk='6001'.or.nzk='6201'
    REPLACE ALL smdo WITH 0 FOR !EMPTY(kor)
    SELECT avot
    REPLACE ALL smd WITH smd-smdo FOR bs=nastf_l.AND.!EMPTY(kor)
* пеpевод отгрузки в остатки
    SCAN FOR bs=nastf_l.AND.smd#0.AND.!EMPTY(kor).AND.!DELETE()
         SELECT osdkom
         APPEND BLANK
         REPLACE bs WITH avot.bs,kp WITH avot.kp,nrd WITH avot.nrd,;
                kor WITH avot.kor,nvx WITH avot.nvx,pr_spr WITH avot.pr_spr,;
                nsk WITH avot.nsk,db WITH avot.smd,dat WITH avot.dat,npp WITH avot.npp,uni WITH avot.uni
    ENDSCAN
    SET EXACT ON
ENDIF
SELECT osdkom
DELETE FOR db=0.AND.kr=0
PACK
USE
SELECT osdkomr
 DELETE TAG rab
ZAP
USE
SELECT bkr
DELETE TAG rab
ZAP
USE
SELECT avot
IF nastf_h=0
    ZAP
ELSE
    DELETE FOR !EMPTY(kor)
    PACK
    SCAN FOR smdo#0
         funi=uni
         fkp=kp
         SELECT tran_opl
         SET EXACT OFF
         SEEK STR(funi,7)
         SET EXACT ON
         SCAN REST WHILE uni=funi FOR ms=ntmec.AND.pr_doc=0.AND.!DELETE()
              REPLACE ms WITH IIF(ntmec=12,1,ntmec+1)
              IF ntmec=12
                   REPLACE god WITH STR(VAL(god)+1,4)
              ENDIF
         ENDSCAN
    ENDSCAN
    USE
    SELECT tran_opl
ENDIF
USE
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN