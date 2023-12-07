PRIVATE nz,scr
SELECT 0
USE atot EXCLUSIVE
SAVE SCREEN TO scr
IF RECCOUNT()=0
    @ 11,18 FILL TO 14,61 COLOR &color20
    SET COLOR TO &color13
    @ 10,17,13,60 BOX box_1
    SET COLOR TO &color14
    key=2
    @ 11,19 SAY "Есть подозpение что пеpеход уже выполнен."
    @ 12,19 SAY "Пpодолжать ?"
    @ 12,39 PROMPT " Да  "
    @ 12,49 PROMPT " Hет "
    MENU TO key
    IF key=0.OR.key=2
         RESTORE SCREEN FROM scr
         SELECT atot
         USE
         RETURN
    ENDIF
ENDIF
SET COLOR TO &color14
USE
HIDE POPUP ALL
SET CLOCK OFF
CLEAR
sss='!del dbf6_'+LTRIM(STR(ntmec,2))+'.exe'
&sss
sss='!lha a dbf6_'+LTRIM(STR(ntmec,2))+' atot.* osdkom1.* atot_arc.* tran_pos.*'
&sss
sss='!lha s dbf6_'+LTRIM(STR(ntmec,2))
&sss
sss='!del dbf6_'+LTRIM(STR(ntmec,2))+'.lzh'
&sss
USE atot_arc
SET DELETED ON
APPEND FROM atot
SET DELETED OFF
REPLACE ms WITH STR(ntmec,2),god WITH nastf_b FOR EMPTY(ms).AND.EMPTY(god)
USE atot EXCLUSIVE
RESTORE SCREEN FROM scr
SET CLOCK ON
SHOW POPUP Glavn,Proch,Finr_6,Ras_6
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
USE osdkom1 EXCLUSIVE
SET ORDER TO kp_nrd
REPLACE ALL smo WITH db
SCAN FOR !DELETE()
    SELECT osdkomr
    IF !SEEK(osdkom1.kp)
         APPEND BLANK
         REPLACE kp WITH osdkom1.kp
    ENDIF
ENDSCAN
ftekg=1900+VAL(nastf_b)
SELECT 0
USE bkr EXCLUSIVE
ZAP
INDEX ON kor+kp TAG rab
SET ORDER TO kp
SET DELETED ON
APPEND FROM bk FOR (kor=nastf_1.OR.kor=nastf_2).AND.MONTH(dat)=ntmec.AND.YEAR(dat)=ftekg
SET DELETED OFF
SELECT bk
SCAN FOR !DELETE().AND.MONTH(dat)=ntmec.AND.(nzk=nastf_1.OR.nzk=nastf_2).AND.YEAR(dat)=ftekg
    SELECT bkr
    APPEND BLANK
    REPLACE nzk WITH bk.kor,kor WITH bk.nzk,vo WITH IIF(bk.vo='0','1','0'),;
             kp WITH bk.kp,pr_spr WITH bk.pr_spr,sm WITH bk.sm,;
            nrd WITH bk.nrd,dat WITH bk.dat,text_1 WITH bk.text_1
ENDSCAN
SELECT bkr
REPLACE smo WITH sm FOR vo='1'
SCAN
    SELECT osdkomr
    IF !SEEK(bkr.kp)
         APPEND BLANK
         REPLACE kp WITH bkr.kp
    ENDIF
ENDSCAN
SELECT atot
SET ORDER TO avot1
SCAN FOR !DELETE()
    SELECT osdkomr
    IF !SEEK(atot.kp)
         APPEND BLANK
         REPLACE kp WITH atot.kp
    ENDIF
ENDSCAN
IF nastf_h=0
* вычитание оплаченных документов
*  для банка и сальдо
    SCAN FOR !EMPTY(nrd).AND.!DELETE()
         SELECT osdkomr
         SEEK atot.kp
         SELECT atot
         IF bs_op=nastf_1.OR.bs_op=nastf_2
              fsum=atot.smko
              SELECT bkr
              SET EXACT OFF
              IF SEEK(atot.kp+atot.nrd)
                   SET EXACT ON
                   SCAN REST WHILE kp=atot.kp.AND.nrd=atot.nrd.AND.fsum>0 FOR vo='1'
                        IF smo>fsum
                             IF kor=nastf_2
                                  REPLACE osdkomr.smdo WITH osdkomr.smdo+fsum
                             ENDIF
                             REPLACE smo WITH smo-fsum
                             fsum=0
                        ELSE
                             IF kor=nastf_2
                                  REPLACE osdkomr.smdo WITH osdkomr.smdo+smo
                             ENDIF
                             fsum=fsum-smo
                             REPLACE smo WITH 0
                        ENDIF
                   ENDSCAN
              ENDIF
              SET EXACT ON
              SELECT osdkom1
              IF SEEK(atot.kp+atot.nrd)
                   SCAN REST WHILE kp=atot.kp.AND.nrd=atot.nrd.AND.fsum>0 FOR bs=nastf_2.AND.db#0.AND.!DELETE()
                        IF smo>fsum
                             IF atot.bs_op=nastf_2
                                  REPLACE osdkomr.smdo WITH osdkomr.smdo+fsum
                             ENDIF
                             REPLACE smo WITH smo-fsum
                             fsum=0
                        ELSE
                             IF atot.bs_op=nastf_2
                                  REPLACE osdkomr.smdo WITH osdkomr.smdo+smo
                             ENDIF
                             fsum=fsum-smo
                             REPLACE smo WITH 0
                        ENDIF
                   ENDSCAN
              ENDIF
         ENDIF
    ENDSCAN
    SELECT osdkom1
    SCAN FOR !EMPTY(nrd).AND.(bs_op=nastf_1.OR.bs_op=nastf_2).AND.!DELETE()
         nz=RECNO()
         fnrd=nrd
         fkp=kp
         fbs_op=bs_op
         SELECT osdkomr
         SEEK fkp
         fsum=osdkom1.smko
         SELECT bkr
         SET EXACT OFF
         IF SEEK(fkp+fnrd)
              SET EXACT ON
              SCAN REST WHILE kp=fkp.AND.nrd=fnrd.AND.fsum>0 FOR vo='1'
                   IF smo>fsum
                        IF kor=nastf_2
                             REPLACE osdkomr.smdo WITH osdkomr.smdo+fsum
                        ENDIF
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        IF kor=nastf_2
                             REPLACE osdkomr.smdo WITH osdkomr.smdo+smo
                        ENDIF
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
         ENDIF
         SET EXACT ON
         SELECT osdkom1
         IF SEEK(fkp+fnrd)
              SCAN REST WHILE kp=fkp.AND.nrd=fnrd.AND.fsum>0 FOR bs=nastf_2.AND.db#0.AND.!DELETE()
                   IF smo>fsum
                        IF fbs_op=nastf_2
                             REPLACE osdkomr.smdo WITH osdkomr.smdo+fsum
                        ENDIF
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        IF fbs_op=nastf_2
                             REPLACE osdkomr.smdo WITH osdkomr.smdo+smo
                        ENDIF
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
         ENDIF
         SELECT osdkom1
         GO nz
    ENDSCAN
*
* вычитание оплаченных документов
*  для банка и сальдо по сумме
    SELECT atot
    SCAN FOR EMPTY(nrd).AND.!DELETE()
         SELECT osdkomr
         SEEK atot.kp
         SELECT atot
         IF bs_op=nastf_1.OR.bs_op=nastf_2
              fsum=atot.smko
              SELECT bkr
              SET EXACT OFF
              IF SEEK(atot.kp+atot.nrd)
                   SET EXACT ON
                   SCAN REST WHILE kp=atot.kp.AND.EMPTY(nrd).AND.fsum>0 FOR vo='1'.AND.smo=fsum
                        IF kor=nastf_2
                             REPLACE osdkomr.smdo WITH osdkomr.smdo+smo
                        ENDIF
                        REPLACE smo WITH 0
                        fsum=0
                   ENDSCAN
              ENDIF
              SET EXACT ON
              SELECT osdkom1
              IF SEEK(atot.kp+atot.nrd)
                   SCAN REST WHILE kp=atot.kp.AND.EMPTY(nrd).AND.fsum>0 FOR bs=nastf_2.AND.db#0.AND.smo=fsum.AND.!DELETE()
                        IF atot.bs_op=nastf_2
                             REPLACE osdkomr.smdo WITH osdkomr.smdo+smo
                        ENDIF
                        REPLACE smo WITH 0
                        fsum=0
                   ENDSCAN
              ENDIF
         ENDIF
    ENDSCAN
    SELECT osdkom1
    SCAN FOR EMPTY(nrd).AND.(bs_op=nastf_1.OR.bs_op=nastf_2).AND.!DELETE()
         nz=RECNO()
         fnrd=nrd
         fkp=kp
         fbs_op=bs_op
         SELECT osdkomr
         SEEK fkp
         fsum=osdkom1.smko
         SELECT bkr
         SET EXACT OFF
         IF SEEK(fkp+fnrd)
              SET EXACT ON
              SCAN REST WHILE kp=fkp.AND.EMPTY(nrd).AND.fsum>0 FOR vo='1'.AND.smo=fsum
                   IF kor=nastf_2
                        REPLACE osdkomr.smdo WITH osdkomr.smdo+fsum
                   ENDIF
                   REPLACE smo WITH 0
                   fsum=0
              ENDSCAN
         ENDIF
         SET EXACT ON
         SELECT osdkom1
         IF SEEK(fkp+fnrd)
              SCAN REST WHILE kp=fkp.AND.EMPTY(nrd).AND.fsum>0 FOR bs=nastf_2.AND.db#0.AND.smo=fsum.AND.!DELETE()
                   IF fbs_op=nastf_2
                        REPLACE osdkomr.smdo WITH osdkomr.smdo+smo
                   ENDIF
                   REPLACE smo WITH 0
                   fsum=0
              ENDSCAN
         ENDIF
         SELECT osdkom1
         GO nz
    ENDSCAN
* получение остатка, закpытого авансами
    SET EXACT OFF
    SELECT osdkomr
    SCAN
         fsum=0
         SELECT atot
         SEEK osdkomr.kp
         SCAN REST WHILE kp=osdkomr.kp FOR bs_op=nastf_2.AND.!DELETE()
              fsum=fsum+smko
         ENDSCAN
         SELECT osdkom1
         SEEK osdkomr.kp
         SCAN REST WHILE kp=osdkomr.kp FOR bs_op=nastf_2.AND.!DELETE()
              fsum=fsum+smko
         ENDSCAN
  * возвpащенные деньги
         SELECT bkr
         SEEK osdkomr.kp
         SCAN REST WHILE kp=osdkomr.kp FOR kor=nastf_2.AND.vo='0'
              fsum=fsum+sm
         ENDSCAN
         fsum=fsum-osdkomr.smdo
  * опpеделено использование аванса - fsum
         IF fsum>0
  * pаспpеделение использования
              SELECT osdkom1
              SEEK osdkomr.kp
              SCAN REST WHILE kp=osdkomr.kp.AND.fsum>0 FOR bs=nastf_2.AND.smo#0.AND.!DELETE()
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
              SCAN REST WHILE kp=osdkomr.kp.AND.fsum>0 FOR kor=nastf_2.AND.vo='1'.AND.smo#0
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
              SELECT osdkom1
              APPEND BLANK
              REPLACE kp WITH osdkomr.kp,pr_spr WITH osdkomr.pr_spr,bs WITH nastf_2
              REPLACE kr WITH fsum
         ENDIF
  * пеpенос авансов из банка
         SELECT bkr
         SEEK osdkomr.kp
         SCAN REST WHILE kp=osdkomr.kp FOR kor=nastf_2.AND.smo>0.AND.vo='1'
              SELECT osdkom1
              APPEND BLANK
              REPLACE kp WITH bkr.kp,pr_spr WITH bkr.pr_spr,nrd WITH bkr.nrd,bs WITH bkr.kor,;
                     smo WITH bkr.smo,dat WITH bkr.dat,text WITH bkr.text_1
         ENDSCAN
    ENDSCAN
    SET EXACT ON
*      уменьшение сумм на величину оплат
*     замена kr и smk на pазницу
    SELECT osdkom1
    SET ORDER TO bs_kp
    REPLACE kr WITH kr-smko FOR bs=nastf_1
    REPLACE db WITH smo FOR bs=nastf_2
    REPLACE ALL smko WITH 0
    SELECT atot
    REPLACE ALL smk WITH smk-smko
* пеpевод поступления в остатки
    SCAN FOR smk#0.AND.!DELETE()
         SELECT osdkom1
         APPEND BLANK
         REPLACE bs WITH atot.bs,kp WITH atot.kp,nrd WITH atot.nrd,nzk WITH atot.nzk,;
                kor WITH atot.kor,nvx WITH atot.nvx,pr_spr WITH atot.pr_spr,;
                nsk WITH atot.nsk,kr WITH atot.smk,dat WITH atot.dat,npp WITH atot.npp,text WITH atot.text
    ENDSCAN
ELSE
*
*   оплата по документам
*
    SET EXACT OFF
    SELECT 0
    USE tran_pos
    SET ORDER TO uni
    SELECT osdkom1
    SCAN FOR smko#0.AND.!EMPTY(kor).AND.!DELETE()
         nz=RECNO()
         funi=uni
         fkp=kp
         SELECT tran_pos
         SEEK STR(funi,7)
         SCAN REST WHILE uni=funi FOR ms=ntmec.AND.!DELETE()
              fsum=summa
              SELECT osdkom1
              SET ORDER TO bs_kp
              SEEK nastf_1+fkp+tran_pos.nrd
              SCAN REST WHILE bs=nastf_1.AND.kp=fkp.AND.nrd=tran_pos.nrd.AND.fsum>0 FOR smo>0.AND.!DELETE()
                   IF smo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
              SEEK nastf_2+fkp+tran_pos.nrd
              SCAN REST WHILE bs=nastf_2.AND.kp=fkp.AND.nrd=tran_pos.nrd.AND.fsum>0 FOR smo>0.AND.!DELETE()
                   IF smo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
              SELECT bkr
              SET ORDER TO rab
              SEEK nastf_1+fkp
              SCAN REST WHILE kor=nastf_1.AND.kp=fkp.AND.fsum>0 FOR nrd=tran_pos.nrd.AND.vo='1'.AND.smo>0
                   IF smo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
              SEEK nastf_2+fkp
              SCAN REST WHILE kor=nastf_2.AND.kp=fkp.AND.fsum>0 FOR nrd=tran_pos.nrd.AND.vo='1'.AND.smo>0.AND.!DELETE()
                   IF smo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
         ENDSCAN
         SELECT osdkom1
         SET ORDER TO kp_nrd
         GO nz
    ENDSCAN
    SELECT atot
    SCAN FOR smko#0.AND.!EMPTY(kor).AND.!DELETE()
         funi=uni
         fkp=kp
         SELECT tran_pos
         SEEK STR(funi,7)
         SCAN REST WHILE uni=funi FOR ms=ntmec.AND.!DELETE()
              fsum=summa
              SELECT osdkom1
              SET ORDER TO bs_kp
              SEEK nastf_1+fkp+tran_pos.nrd
              SCAN REST WHILE bs=nastf_1.AND.kp=fkp.AND.nrd=tran_pos.nrd.AND.fsum>0 FOR smo>0.AND.!DELETE()
                   IF smo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
              SEEK nastf_2+fkp+tran_pos.nrd
              SCAN REST WHILE bs=nastf_2.AND.kp=fkp.AND.nrd=tran_pos.nrd.AND.fsum>0 FOR smo>0.AND.!DELETE()
                   IF smo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
              SELECT bkr
              SET ORDER TO rab
              SEEK nastf_1+fkp
              SCAN REST WHILE kor=nastf_1.AND.kp=fkp.AND.fsum>0 FOR nrd=tran_pos.nrd.AND.vo='1'.AND.smo>0.AND.!DELETE()
                   IF smo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
              SEEK nastf_2+fkp
              SCAN REST WHILE kor=nastf_2.AND.kp=fkp.AND.fsum>0 FOR nrd=tran_pos.nrd.AND.vo='1'.AND.smo>0.AND.!DELETE()
                   IF smo>fsum
                        REPLACE smo WITH smo-fsum
                        fsum=0
                   ELSE
                        fsum=fsum-smo
                        REPLACE smo WITH 0
                   ENDIF
              ENDSCAN
         ENDSCAN
    ENDSCAN
*     определение остатка авансов
    SELECT osdkomr
    SCAN
*        определение возврата авансов
         fkp=kp
         SELECT bkr
         SUM TO fsum sm FOR vo='0'.AND.kp=fkp         && обычный возврат авансов
         SUM TO sss sm FOR vo='1'.AND.kp=fkp.AND.sm<0 && возврат авансов через '-'
         fsum=fsum-sss
         IF fsum>0
              SELECT osdkom1
              SET ORDER TO bs_kp
              SEEK nastf_2+fkp
              SCAN REST WHILE bs=nastf_2.AND.kp=fkp.AND.fsum>0 FOR smo>0.AND.!DELETE()
                   fnrd=nrd
                   fdat=dat
                   fsmo=smo
                   nz=RECNO()
*                  проверка использования аванса (там, где пустой к/счет)
                   SEEK nastf_1+fkp
                   SCAN REST WHILE bs=nastf_1.AND.kp=fkp FOR EMPTY(kor).AND.smko#0.AND.(bs_op=nastf_1.OR.bs_op=nastf_2).AND.!DELETE()
                        SELECT tran_pos
                        SEEK STR(osdkom1.uni,7)
                        SCAN REST WHILE uni=osdkom1.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.!DELETE()
                             fsmo=fsmo-summa
                        ENDSCAN
                   ENDSCAN
                   SELECT atot
                   SET ORDER TO bs_kp
                   SEEK nastf_1+fkp
                   SCAN REST WHILE bs=nastf_1.AND.kp=fkp FOR EMPTY(kor).AND.smko#0.AND.(bs_op=nastf_1.OR.bs_op=nastf_2).AND.!DELETE()
                        SELECT tran_pos
                        SEEK STR(atot.uni,7)
                        SCAN REST WHILE uni=atot.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.!DELETE()
                             fsmo=fsmo-summa
                        ENDSCAN
                   ENDSCAN
*                  аванс не используется в размере fsmo
                   SELECT osdkom1
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
              SEEK nastf_1+fkp
              SCAN REST WHILE kor=nastf_1.AND.kp=fkp.AND.fsum>0 FOR smo>0 && vo='1'.AND.smo>0 исправление 10.09.96
                   fnrd=nrd
                   fdat=dat
                   fsmo=smo
*                  проверка использования аванса (там, где пустой к/счет)
                   SELECT osdkom1
                   SEEK nastf_1+fkp
                   SCAN REST WHILE bs=nastf_1.AND.kp=fkp FOR EMPTY(kor).AND.smko#0.AND.(bs_op=nastf_1.OR.bs_op=nastf_2).AND.!DELETE()
                        SELECT tran_pos
                        SEEK STR(osdkom1.uni,7)
                        SCAN REST WHILE uni=osdkom1.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.!DELETE()
                             fsmo=fsmo+IIF(bkr.vo='1',-summa,summa)       && fsmo=fsmo-summa исправление 10.09.96
                        ENDSCAN
                   ENDSCAN
                   SELECT atot
                   SET ORDER TO bs_kp
                   SEEK nastf_1+fkp
                   SCAN REST WHILE bs=nastf_1.AND.kp=fkp FOR EMPTY(kor).AND.smko#0.AND.(bs_op=nastf_1.OR.bs_op=nastf_2).AND.!DELETE()
                        SELECT tran_pos
                        SEEK STR(atot.uni,7)
                        SCAN REST WHILE uni=atot.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.!DELETE()
                             fsmo=fsmo+IIF(bkr.vo='1',-summa,summa)       && fsmo=fsmo-summa исправление 10.09.96
                        ENDSCAN
                   ENDSCAN
*                  аванс не используется в размере fsmo
                   SELECT bkr
                   IF vo='1'.OR.fsmo#smo
                        IF fsmo>fsum
                             REPLACE smo WITH smo-fsum
                             fsum=0
                        ELSE
                             fsum=fsum-fsmo
                             REPLACE smo WITH smo-fsmo
                        ENDIF
                   ENDIF
              ENDSCAN
              SEEK nastf_2+fkp
              SCAN REST WHILE kor=nastf_2.AND.kp=fkp.AND.fsum>0 FOR smo>0 && vo='1'.AND.smo>0 исправление 10.09.96
                   fnrd=nrd
                   fdat=dat
                   fsmo=smo
*                  проверка использования аванса (там, где пустой к/счет)
                   SELECT osdkom1
                   SEEK nastf_1+fkp
                   SCAN REST WHILE bs=nastf_1.AND.kp=fkp FOR EMPTY(kor).AND.smko#0.AND.(bs_op=nastf_1.OR.bs_op=nastf_2).AND.!DELETE()
                        SELECT tran_pos
                        SEEK STR(osdkom1.uni,7)
                        SCAN REST WHILE uni=osdkom1.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.!DELETE()
                             fsmo=fsmo+IIF(bkr.vo='1',-summa,summa)       && fsmo=fsmo-summa исправление 10.09.96
                        ENDSCAN
                   ENDSCAN
                   SELECT atot
                   SET ORDER TO bs_kp
                   SEEK nastf_1+fkp
                   SCAN REST WHILE bs=nastf_1.AND.kp=fkp FOR EMPTY(kor).AND.smko#0.AND.(bs_op=nastf_1.OR.bs_op=nastf_2).AND.!DELETE()
                        SELECT tran_pos
                        SEEK STR(atot.uni,7)
                        SCAN REST WHILE uni=atot.uni FOR nrd=fnrd.AND.fdat=dat.AND.ms=ntmec.AND.!DELETE()
                             fsmo=fsmo+IIF(bkr.vo='1',-summa,summa)       && fsmo=fsmo-summa исправление 10.09.96
                        ENDSCAN
                   ENDSCAN
*                  аванс не используется в размере fsmo
                   SELECT bkr
                   IF vo='1'.OR.fsmo#smo
                        IF fsmo>fsum
                             REPLACE smo WITH smo-fsum
                             fsum=0
                        ELSE
                             fsum=fsum-fsmo
                             REPLACE smo WITH smo-fsmo
                        ENDIF
                   ENDIF
              ENDSCAN
              IF fsum>0
*                  перерасход авансов
                   SELECT bkr
                   SET ORDER TO rab
                   SEEK nastf_1+fkp
                   SCAN REST WHILE kor=nastf_1.AND.kp=fkp.AND.fsum>0 FOR vo='0'
                        IF sm>fsum
                             fsm=fsum
                             fsum=0
                        ELSE
                             fsum=fsum-sm
                             fsm=sm
                        ENDIF
                        SELECT osdkom1
                        APPEND BLANK
                        REPLACE kp WITH bkr.kp,pr_spr WITH bkr.pr_spr,nrd WITH bkr.nrd,bs WITH bkr.kor,;
                               smo WITH -fsm,dat WITH bkr.dat
                   ENDSCAN
                   SEEK nastf_2+fkp
                   SCAN REST WHILE kor=nastf_2.AND.kp=fkp.AND.fsum>0 FOR vo='0'
                        IF sm>fsum
                             fsm=fsum
                             fsum=0
                        ELSE
                             fsum=fsum-sm
                             fsm=sm
                        ENDIF
                        SELECT osdkom1
                        APPEND BLANK
                        REPLACE kp WITH bkr.kp,pr_spr WITH bkr.pr_spr,nrd WITH bkr.nrd,bs WITH bkr.kor,;
                               smo WITH -fsm,dat WITH bkr.dat
                   ENDSCAN
              ENDIF
         ENDIF
    ENDSCAN
*     перевод платежей в авансы
    SELECT bkr
    SCAN FOR vo='1'.AND.smo>0
         SELECT osdkom1
         APPEND BLANK
         REPLACE kp WITH bkr.kp,pr_spr WITH bkr.pr_spr,nrd WITH bkr.nrd,bs WITH bkr.kor,;
                smo WITH bkr.smo,dat WITH bkr.dat,text WITH bkr.text_1
    ENDSCAN
*     уменьшение сумм на величину оплат
*     замена kr и smk на pазницу
    SELECT osdkom1
    SET ORDER TO bs_kp
    REPLACE kr WITH kr-smko FOR bs=nastf_1.AND.!EMPTY(kor)
    REPLACE db WITH smo FOR bs=nastf_2
    REPLACE ALL smko WITH 0 FOR !EMPTY(kor)
    SELECT atot
    REPLACE ALL smk WITH smk-smko FOR !EMPTY(kor)
* пеpевод поступления в остатки
    SCAN FOR smk#0.AND.!EMPTY(kor).AND.!DELETE()
         SELECT osdkom1
         APPEND BLANK
         REPLACE bs WITH atot.bs,kp WITH atot.kp,nrd WITH atot.nrd,nzk WITH atot.nzk,;
                kor WITH atot.kor,nvx WITH atot.nvx,pr_spr WITH atot.pr_spr,text WITH atot.text,;
                nsk WITH atot.nsk,kr WITH atot.smk,dat WITH atot.dat,npp WITH atot.npp,uni WITH atot.uni
    ENDSCAN
    SET EXACT ON
ENDIF
*
SELECT osdkom1
DELETE FOR db=0.AND.kr=0
PACK
USE
SELECT osdkomr
DELETE TAG rab
USE
SELECT atot
IF nastf_h=0
    ZAP
ELSE
    DELETE FOR !EMPTY(kor)
    PACK
    SCAN FOR smko#0
         funi=uni
         fkp=kp
         SELECT tran_pos
         SET EXACT OFF
         SEEK STR(funi,7)
         SET EXACT ON
         SCAN REST WHILE uni=funi FOR ms=ntmec.AND.!DELETE()
              REPLACE ms WITH IIF(ntmec=12,1,ntmec+1)
              IF ntmec=12
                   REPLACE god WITH STR(VAL(god)+1,2)
              ENDIF
         ENDSCAN
    ENDSCAN
    USE
    SELECT tran_pos
ENDIF
USE
SELECT bkr
ZAP
DELETE TAG rab
USE
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN
