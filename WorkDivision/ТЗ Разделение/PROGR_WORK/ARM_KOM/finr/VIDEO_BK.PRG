DEFINE POPUP Video FROM 8,34 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Video PROMPT " C\<альдо по балансовым счетам           "
DEFINE BAR 2 OF Video PROMPT " Е\<жедневная обоpотка по счету          "
DEFINE BAR 3 OF Video PROMPT " Р\<езультиpующая обоpотка по бал.счетам "
DEFINE BAR 4 OF Video PROMPT " Ка\<pточка организации                  "
DEFINE BAR 5 OF Video PROMPT " Аp\<хив входной информации              "
DEFINE BAR 6 OF Video PROMPT " В\<заимозачеты по организациям          "
DEFINE BAR 7 OF Video PROMPT " В\<едомость выплаты командировочных     "
ON SELECTION POPUP Video DO Video WITH BAR()
ACTIVATE POPUP Video
RETURN
*
PROCEDURE Video
PARAMETERS ch1
PRIVATE nz,nzz
DO CASE
CASE ch1=1
    fdat=DATE()
    DEFINE WINDOW Zapros FROM 12,40 TO 14,66 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " За какое число" GET fdat
    READ
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
         ACTIVATE SCREEN
         RETURN
    ENDIF
    ACTIVATE WINDOW Pog_p
    SET COLOR TO &color15
    @ 0,0 SAY '░'
    SET COLOR TO &color13
    @ 0,1 SAY "Пожалуйста, подождите..."
    RESTORE FROM tek_b ADDITIVE
    SELECT bk
    SET ORDER TO bk3
    SELECT spr_bs
    SET ORDER TO grup
    SET EXACT OFF
    SEEK tek_b_25
    SET EXACT ON
    fsumn=0
    fsum1=0
    fsum2=0
    fsumk=0
    SET NEAR ON
    SET EXACT OFF
    SCAN REST WHILE grup=tek_b_25 FOR !DELETE()
         fnzk=spr_bs.bs
         REPLACE sald WITH saldm
         SELECT bk
         SET ORDER TO bk3
         SEEK fnzk
         sum1=0
         sum2=0
         fsum=0
         SCAN REST WHILE nzk=fnzk FOR !DELETE()
              IF EMPTY(dat)
                   IF vo='0'
                        sum1=sum1+sm
                   ELSE
                        sum2=sum2+sm
                   ENDIF
              ENDIF
              IF MONTH(dat)=ntmec.AND.dat<fdat.AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b
                   fsum=fsum+IIF(vo='0',sm,-sm)
              ENDIF
         ENDSCAN
         SET ORDER TO bk2
         SEEK fnzk
         SCAN REST WHILE kor=fnzk FOR !DELETE()
              IF EMPTY(dat)
                   IF vo='1'
                        sum1=sum1+sm
                   ELSE
                        sum2=sum2+sm
                   ENDIF
              ENDIF
              IF MONTH(dat)=ntmec.AND.dat<fdat.AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b
                   fsum=fsum+IIF(vo='1',sm,-sm)
              ENDIF
         ENDSCAN
         SELECT spr_bs
         REPLACE sald WITH sald+fsum,sum_pr WITH sum1,sum_rx WITH sum2
         fsumn=fsumn+sald+Delta
         fsum1=fsum1+sum_pr
         fsum2=fsum2+sum_rx
         fsumk=fsumk+sald+sum_pr-sum_rx+Delta
    ENDSCAN
    SET NEAR OFF
    SET EXACT OFF
    SEEK tek_b_25
    SET EXACT ON
    HIDE WINDOW ALL
    HIDE POPUP ALL
    ACTIVATE SCREEN
    ON KEY LABEL Alt-F9 DO Menu_spr
    DO Vvodn WITH "Chapsd","Strsaysd","Strgetsd",.F.,.T.,.F.,.T.,"tek_b_25#grup",'',;
                  '',"F3sd","F4sd",'','','','','',"F10sd",'',.T.
    ON KEY LABEL Alt-F9
    SHOW POPUP Glavn,Bank,Video
    RELEASE ALL LIKE tek_b_??
CASE ch1=2
    fdat1=DATE()
    fdat2=DATE()
    SET COLOR TO &color13
    IF nastf_v=0
         DEFINE WINDOW Zapros FROM 12,45 TO 14,71 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " За какое число" GET fdat1
         READ
         fdat2=fdat1
    ELSE
         DEFINE WINDOW Zapros FROM 12,45 TO 15,72 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " С какого числа" GET fdat1
         @ 1,0 SAY " По какое число" GET fdat2 VALID fdat2>=fdat1 ERROR 'Hевеpен пеpиод...'
         READ
    ENDIF
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
         ACTIVATE SCREEN
         RETURN
    ENDIF
    IF fdat2<fdat1
         fdat2=fdat1
    ENDIF
    ACTIVATE WINDOW Pog_p
    SET COLOR TO &color15
    @ 0,0 SAY '░'
    SET COLOR TO &color13
    @ 0,1 SAY "Пожалуйста, подождите..."
      * tgod=1900+VAL(nastf_b)
      * tgod=2000+VAL(nastf_b)
      tgod=VAL(nastf_b)
    SELECT spr_bs
    SET ORDER TO bs
    SEEK gfbs
    SELECT 0
    USE bkr EXCLUSIVE
    SET ORDER TO nzk
    ZAP
    SELECT bk
    SET ORDER TO kp
    SET EXACT OFF
    SEEK gfbs
    DO WHILE nzk=gfbs.AND.!EOF()
         IF dat>=fdat1.AND.dat<=fdat2
              fsum=0
              fkp=kp
              fnrd=nrd
              fpr_spr=pr_spr
              fdat=dat
              fvo=vo
              nz=RECNO()
              SCAN REST WHILE fkp=kp.AND.fnrd=nrd.AND.fpr_spr=pr_spr.AND.fdat=dat.AND.fvo=vo.AND.nzk=gfbs
                   fsum=fsum+sm
              ENDSCAN
              GO nz
              SCAN REST WHILE fkp=kp.AND.fnrd=nrd.AND.fpr_spr=pr_spr.AND.fdat=dat.AND.fvo=vo.AND.nzk=gfbs
                   REPLACE smo WITH fsum
              ENDSCAN
         ELSE
              SKIP
         ENDIF
    ENDDO
    SET ORDER TO bk3
    SEEK gfbs
    fsum=0
    SCAN REST WHILE nzk=gfbs FOR !DELETE()
         IF dat>=fdat1.AND.dat<=fdat2
              nz=RECNO()
              SELECT bkr
              APPEND BLANK
              REPLACE nzk WITH bk.nzk,vo WITH bk.vo,dat WITH bk.dat,;
                      nrd WITH bk.nrd,kor WITH bk.kor,sm WITH bk.sm,kp WITH bk.kp,nvx WITH bk.nvx,;
                   pr_spr WITH bk.pr_spr,nzap WITH nz,text_1 WITH bk.text_1,text_2 WITH bk.text_2,text_3 WITH bk.text_3,text_4 WITH bk.text_4,;
                      smo WITH bk.smo,sm_val WITH bk.sm_val,vid_val WITH bk.vid_val
              SELECT bk
         ENDIF
         IF MONTH(dat)=ntmec.AND.dat<fdat1.AND.YEAR(dat)=tgod
              fsum=fsum+IIF(gpr_val,IIF(vo='0',sm_val,-sm_val),IIF(vo='0',sm,-sm))
         ENDIF
    ENDSCAN
    SET ORDER TO bk2
    SEEK gfbs
    DO WHILE kor=gfbs.AND.!EOF()
         IF dat>=fdat1.AND.dat<=fdat2
              ffsum=0
              fkp=kp
              fnrd=nrd
              fpr_spr=pr_spr
              fdat=dat
              fvo=vo
              nz=RECNO()
              SCAN REST WHILE fkp=kp.AND.fnrd=nrd.AND.fpr_spr=pr_spr.AND.fdat=dat.AND.fvo=vo.AND.kor=gfbs
                   ffsum=ffsum+sm
              ENDSCAN
              GO nz
              SCAN REST WHILE fkp=kp.AND.fnrd=nrd.AND.fpr_spr=pr_spr.AND.fdat=dat.AND.fvo=vo.AND.kor=gfbs
                   REPLACE smo WITH ffsum
              ENDSCAN
         ELSE
              SKIP
         ENDIF
    ENDDO
    SEEK gfbs
    SCAN REST WHILE kor=gfbs FOR !DELETE()
         IF dat>=fdat1.AND.dat<=fdat2
              nz=RECNO()
              SELECT bkr
              APPEND BLANK
              REPLACE nzk WITH bk.kor,vo WITH IIF(bk.vo='0','1','0'),dat WITH bk.dat,;
                      nrd WITH bk.nrd,kor WITH bk.nzk,sm WITH bk.sm,kp WITH bk.kp,nvx WITH bk.nvx,;
                   pr_spr WITH bk.pr_spr,nzap WITH nz,text_1 WITH bk.text_1,text_2 WITH bk.text_2,text_3 WITH bk.text_3,text_4 WITH bk.text_4,;
                      smo WITH bk.smo,sm_val WITH bk.sm_val,vid_val WITH bk.vid_val
              SELECT bk
         ENDIF
         IF MONTH(dat)=ntmec.AND.dat<fdat1.AND.YEAR(dat)=tgod
              fsum=fsum+IIF(gpr_val,IIF(vo='1',sm_val,-sm_val),IIF(vo='1',sm,-sm))
         ENDIF
    ENDSCAN
    SET EXACT ON
    SELECT spr_bs
    IF gpr_val
         REPLACE sm_valt WITH sm_val+fsum
    ELSE
         REPLACE sald WITH saldm+fsum
    ENDIF
    SELECT bkr
    DO Obor_dn WITH fdat1,fdat2,gfbs
    USE
CASE ch1=3
    fdat1=DATE()
    fdat2=DATE()
    SET COLOR TO &color13
    IF nastf_v=0
         DEFINE WINDOW Zapros FROM 12,45 TO 14,71 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " За какое число" GET fdat1
         READ
         fdat2=fdat1
    ELSE
         DEFINE WINDOW Zapros FROM 12,45 TO 15,72 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " С какого числа" GET fdat1
         @ 1,0 SAY " По какое число" GET fdat2 VALID fdat2>=fdat1 ERROR 'Hевеpен пеpиод...'
         READ
    ENDIF
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
         ACTIVATE SCREEN
         RETURN
    ENDIF
    IF fdat2<fdat1
         fdat2=fdat1
    ENDIF
    ACTIVATE WINDOW Pog_p
    SET COLOR TO &color15
    @ 0,0 SAY '░'
    SET COLOR TO &color13
    @ 0,1 SAY "Пожалуйста, подождите..."
    SELECT 0
    USE bkr EXCLUSIVE
    SET ORDER TO nzk
    ZAP
    SELECT spr_bs
    SET ORDER TO bs
    SELECT bk
    SET ORDER TO kp
    SET EXACT OFF
    GO TOP
    DO WHILE !EOF()
         fnzk=nzk
         fsum=0
         SCAN REST WHILE nzk=fnzk FOR MONTH(dat)=ntmec.AND.!DELETE().AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b
              IF dat>=fdat1.AND.dat<=fdat2
                   nz=RECNO()
                   SELECT bkr
                   APPEND BLANK
                   REPLACE nzk WITH bk.nzk,vo WITH bk.vo,dat WITH bk.dat,;
                           nrd WITH bk.nrd,kor WITH bk.kor,sm WITH bk.sm,kp WITH bk.kp,nvx WITH bk.nvx,;
                        pr_spr WITH bk.pr_spr,nzap WITH nz,smo WITH bk.sm
                   SELECT bk
              ENDIF
              IF dat<fdat1
                   fsum=fsum+IIF(vo='0',sm,-sm)
              ENDIF
         ENDSCAN
         IF EOF()
              nzz=0
         ELSE
              nzz=RECNO()
         ENDIF
         SET ORDER TO bk2
         SEEK fnzk
         SCAN REST WHILE kor=fnzk FOR MONTH(dat)=ntmec.AND.!DELETE().AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b
              IF dat>=fdat1.AND.dat<=fdat2
                   nz=RECNO()
                   SELECT bkr
                   APPEND BLANK
                   REPLACE nzk WITH bk.kor,vo WITH IIF(bk.vo='0','1','0'),dat WITH bk.dat,;
                           nrd WITH bk.nrd,kor WITH bk.nzk,sm WITH bk.sm,kp WITH bk.kp,nvx WITH bk.nvx,;
                        pr_spr WITH bk.pr_spr,nzap WITH nz,smo WITH bk.sm
                   SELECT bk
              ENDIF
              IF dat<fdat1
                   fsum=fsum+IIF(vo='1',sm,-sm)
              ENDIF
         ENDSCAN
         SELECT spr_bs
         SEEK fnzk
         REPLACE sald WITH saldm+fsum
         SELECT bk
         SET ORDER TO kp
         IF nzz=0
              GO BOTTOM
              SKIP
         ELSE
              GO nzz
         ENDIF
    ENDDO
    RESTORE FROM tek_b ADDITIVE
    SELECT spr_bs
    SET ORDER TO grup
    SEEK tek_b_25
    fsumn=0
    fsum1=0
    fsum2=0
    fsumk=0
    SCAN REST WHILE grup=tek_b_25 FOR !DELETE()
         fnzk=spr_bs.bs
         SELECT bkr
         sum1=0
         sum2=0
         SEEK fnzk
         SCAN REST WHILE fnzk=nzk
              IF vo='0'
                   sum1=sum1+bkr.sm+Delta
              ELSE
                   sum2=sum2+bkr.sm+Delta
              ENDIF
         ENDSCAN
         SELECT spr_bs
         REPLACE sum_pr WITH sum1,sum_rx WITH sum2
         fsumn=fsumn+spr_bs.sald+Delta
         fsum1=fsum1+sum_pr+Delta
         fsum2=fsum2+sum_rx+Delta
         fsumk=fsumk+sald+sum_pr-sum_rx+Delta
    ENDSCAN
    SEEK tek_b_25
    SET EXACT ON
    HIDE WINDOW ALL
    HIDE POPUP ALL
    ACTIVATE SCREEN
    DO Vvodn WITH "Chapdr","Strsaydr",'',.F.,.F.,.F.,.T.,"tek_b_25#grup",'',;
                  "F2dr",'','','','','','','','','',.T.
    SELECT bkr
    USE
    RELEASE ALL LIKE tek_b_??
CASE ch1=4
    fdat1=CTOD('01'+RIGHT(DTOC(DATE()),6))
    fdat2=DATE()
    fnzk='    '
    fpr='2'
    DEFINE WINDOW Zapros FROM 13,45 TO 18,72 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " Hомер счета..." GET fnzk
    @ 1,0 SAY " С какого числа" GET fdat1
    @ 2,0 SAY " По какое число" GET fdat2 VALID fdat2>=fdat1 ERROR 'Hевеpен пеpиод...'
    @ 3,0 SAY " Все-2,пpиход-0,pасход-1" GET fpr VALID fpr='0'.OR.fpr='1'.OR.fpr='2' ERROR ' 0 - пpиход, 1 - pасход,  2 - все...'
    READ
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
         ACTIVATE SCREEN
         RETURN
    ENDIF
    SELECT 0
    USE bkr EXCLUSIVE
    SET ORDER TO kp_dat
    ZAP
    SELECT 0
    USE bk_arc
    SET ORDER TO kp
    SELECT skl
    HIDE POPUP ALL
    ACTIVATE SCREEN
    DO Vvodn WITH "Chapks","Strsayks","",.F.,.F.,.F.,.T.,".F.","",;
         "F2sk","F3sk","F4sk","F5sk","F6ks","","","",'','',.T.
    SELECT bkr
    ZAP
    USE
    SELECT bk_arc
    USE
CASE ch1=5
    SELECT 0
    USE bk_arc
    SET ORDER TO nzk_kp
    SET EXACT OFF
    SEEK gfbs
    SET EXACT ON
    HIDE POPUP ALL
    DO Vvodn WITH "Chapbr","Strsaybr","Strgetbr",.F.,.T.,.F.,.F.,"nzk#gfbs","",;
                  "F2br","F3br","F4br","F5br","F6br","","","","F10br","",.T.
    USE
    SHOW POPUP Glavn,Bank
CASE ch1=6
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    SET ORDER TO kp_pr
* подготовка входной карточки
    ACTIVATE WINDOW Pog_p
    SET COLOR TO &color15
    @ 0,0 SAY '░'
    SET COLOR TO &color13
    @ 0,1 SAY "Пожалуйста, подождите..."
*   поставщики
    SET EXACT OFF
    SELECT 0
    USE osdkom1
    SCAN FOR !DELETE()
         SELECT osdkomr
         IF !SEEK(osdkom1.bs+osdkom1.kp+osdkom1.pr_spr)
              INSERT INTO osdkomr.dbf (kp, bs, pr_spr);
                     VALUES (osdkom1.kp, osdkom1.bs, osdkom1.pr_spr)
         ENDIF
         REPLACE db WITH db+osdkom1.db,kr WITH kr+osdkom1.kr
    ENDSCAN
    USE atot
    SCAN FOR !DELETE()
         SELECT osdkomr
         IF !SEEK(atot.bs+atot.kp+atot.pr_spr)
              INSERT INTO osdkomr.dbf (kp, bs, pr_spr);
                   VALUES (atot.kp, atot.bs, atot.pr_spr)
         ENDIF
         REPLACE smk WITH smk+atot.smk
    ENDSCAN
*   покупатели
    USE osdkom
    SCAN FOR !DELETE()
         IF bs=nastf_e.OR.bs=nastf_k
              fbs=nastf_l
         ELSE
              fbs=bs
         ENDIF
         SELECT osdkomr
         IF !SEEK(fbs+osdkom.kp+osdkom.pr_spr)
              APPEND BLANK
              REPLACE kp WITH osdkom.kp,bs WITH fbs,pr_spr WITH osdkom.pr_spr
         ENDIF
         REPLACE db WITH db+osdkom.db,kr WITH kr+osdkom.kr
    ENDSCAN
    USE avot
    SCAN FOR !DELETE()
         SELECT osdkomr
         IF !SEEK(avot.bs+avot.kp+avot.pr_spr)
              APPEND BLANK
              REPLACE kp WITH avot.kp,bs WITH avot.bs,pr_spr WITH avot.pr_spr
         ENDIF
         REPLACE smd WITH smd+avot.smd
    ENDSCAN
*  прочие дебиторы-кредиторы
    USE osd_pr
    SCAN FOR !DELETE()
         SELECT osdkomr
         IF !SEEK(osd_pr.bs+osd_pr.kp+osd_pr.pr_spr)
              APPEND BLANK
              REPLACE kp WITH osd_pr.kp,bs WITH osd_pr.bs,pr_spr WITH osd_pr.pr_spr
         ENDIF
         REPLACE db WITH db+osd_pr.db,kr WITH kr+osd_pr.kr
    ENDSCAN
    USE dv_pr
    SCAN FOR !DELETE()
         SELECT osdkomr
         IF !SEEK(dv_pr.bs+dv_pr.kp+dv_pr.pr_spr)
              APPEND BLANK
              REPLACE kp WITH dv_pr.kp,bs WITH dv_pr.bs,pr_spr WITH dv_pr.pr_spr
         ENDIF
         REPLACE smk WITH smk+dv_pr.smk,smd WITH smd+dv_pr.smd
    ENDSCAN
    USE
*  банк
*     формирование списка счетов из прочих дебиторов-кредиторов
    DIMENSION mbs(100)
    mbs=0
    i=1
    ntek=1
    RESTORE FROM tek_b ADDITIVE
    DO WHILE !EMPTY(AT(',',tek_b_4,i))
         mbs(i)=SUBSTR(tek_b_4,ntek,AT(',',tek_b_4,i)-ntek)
         ntek=AT(',',tek_b_4,i)+1
         i=i+1
    ENDDO
    kolbs=i
    mbs(i)=RTRIM(SUBSTR(tek_b_4,ntek,30))
    RELEASE ALL LIKE tek_b_??
*     формирование списка счетов из поставщиков
    FOR i=1 TO kolbs
         IF LEFT(nastf_1,LEN(mbs(i)))=mbs(i)
              EXIT
         ENDIF
    ENDFOR
    IF i>kolbs
         kolbs=i
         mbs(i)=nastf_1
    ENDIF
    FOR i=1 TO kolbs
         IF LEFT(nastf_2,LEN(mbs(i)))=mbs(i)
              EXIT
         ENDIF
    ENDFOR
    IF i>kolbs
         kolbs=i
         mbs(i)=nastf_2
    ENDIF
*     формирование списка счетов из покупателей
    FOR i=1 TO kolbs
         IF LEFT(nastf_l,LEN(mbs(i)))=mbs(i)
              EXIT
         ENDIF
    ENDFOR
    IF i>kolbs
         kolbs=i
         mbs(i)=nastf_l
    ENDIF
    SELECT bk
    SCAN FOR MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b.AND.!DELETE()
         IF kor=nastf_e.OR.kor=nastf_k
              fkor=nastf_l
         ELSE
              fkor=kor
         ENDIF
         pr_poisk=.F.
         FOR i=1 TO kolbs
              IF LEFT(fkor,LEN(mbs(i)))=mbs(i)
                   pr_poisk=.T.
                   EXIT
              ENDIF
         ENDFOR
         IF pr_poisk
              SELECT osdkomr
              IF !SEEK(fkor+bk.kp+bk.pr_spr)
                   APPEND BLANK
                   REPLACE kp WITH bk.kp,bs WITH fkor,pr_spr WITH bk.pr_spr
              ENDIF
              IF bk.vo='0'
                   REPLACE smk WITH smk+bk.sm
              ELSE
                   REPLACE smd WITH smd+bk.sm
              ENDIF
              SELECT bk
         ENDIF
         IF nzk=nastf_e.OR.nzk=nastf_k
              fnzk=nastf_l
         ELSE
              fnzk=nzk
         ENDIF
         pr_poisk=.F.
         FOR i=1 TO kolbs
              IF LEFT(fnzk,LEN(mbs(i)))=mbs(i)
                   pr_poisk=.T.
                   EXIT
              ENDIF
         ENDFOR
         IF pr_poisk
              SELECT osdkomr
              IF !SEEK(fnzk+bk.kp+bk.pr_spr)
                   APPEND BLANK
                   REPLACE kp WITH bk.kp,bs WITH fnzk,pr_spr WITH bk.pr_spr
              ENDIF
              IF bk.vo='1'
                   REPLACE smk WITH smk+bk.sm
              ELSE
                   REPLACE smd WITH smd+bk.sm
              ENDIF
         ENDIF
    ENDSCAN
    SELECT osdkomr
* конец подготовки
    SET EXACT ON
    HIDE WINDOW Pog_p
    ACTIVATE SCREEN
    HIDE POPUP ALL
* свод по организациям
    SELECT 0
    USE avotrr EXCLUSIVE
    ZAP
    INDEX ON pr_spr+kp TAG rab
    SELECT osdkomr
    SCAN
         sss=db-kr+smd-smk
         SELECT avotrr
         IF !SEEK(osdkomr.pr_spr+osdkomr.kp)
              APPEND BLANK
              REPLACE pr_spr WITH osdkomr.pr_spr,kp WITH osdkomr.kp
         ENDIF
         IF sss>0
              REPLACE smd WITH smd+sss
         ELSE
              REPLACE smk WITH smk-sss
         ENDIF
    ENDSCAN
    SELECT avotrr
*
    DO Vvodn WITH "Chapvo","Strsayvo","",.F.,.F.,.F.,.F.,".F.","",;
         "F2vo","","","F5vo","","","","","","",.F.
    SELECT avotrr
    ZAP
    USE
    SELECT osdkomr
    ZAP
    USE
CASE ch1=7
    fdat1=DATE()
    fdat2=DATE()
    SET COLOR TO &color13
    IF nastf_v=0
         DEFINE WINDOW Zapros FROM 12,45 TO 14,71 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " За какое число" GET fdat1
         READ
         fdat2=fdat1
    ELSE
         DEFINE WINDOW Zapros FROM 12,45 TO 15,72 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " С какого числа" GET fdat1
         @ 1,0 SAY " По какое число" GET fdat2 VALID fdat2>=fdat1 ERROR 'Hевеpен пеpиод...'
         READ
    ENDIF
    RELEASE WINDOW Zapros
    IF LASTKEY()=27
         ACTIVATE SCREEN
         RETURN
    ENDIF
    IF fdat2<fdat1
         fdat2=fdat1
    ENDIF
          * ACTIVATE WINDOW Pog_p
          * SET COLOR TO &color15
          * @ 0,0 SAY '░'
          * SET COLOR TO &color13
          * @ 0,1 SAY "Пожалуйста, подождите..."
      tgod=VAL(nastf_b)
    RESTORE FROM tek_b ADDITIVE
    SELECT sprrab
    SET ORDER TO tab
    SELECT bk
    INDEX ON nzk+kp+str(wid_d,2) TO rab
    SET EXACT OFF
    SEEK gfbs
    SET EXACT ON
    DO spis_70 WITH fdat1,fdat2,gfbs
    DELETE TAG rab
ENDCASE
SHOW POPUP Glavn,Bank,Video
RETURN
*
*
PROCEDURE Chapbr
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
step=1
npolscrm=1
ncolr=78
SET COLOR TO &color4
@ nstrv-11,ncoll-1,nstrv+11,ncolr+1 BOX "╔═╗║╝═╚║ "
@ nstrv-10,ncoll-1 SAY '║         А р х и в   д в и ж е н и я   д е н е ж н ы х   с р е д с т в'
@ nstrv- 9,ncoll-1 SAY '╟──────────────────────────────────────────────────────────────────────────────╢'
@ nstrv- 8,ncoll-1 SAY '║ Операция:'
@ nstrv- 7,ncoll-1 SAY '║ Организация:                                '+IIF(nastf_11=0,'','Кому')
@ nstrv-6 ,ncoll-1 SAY '║ Документ:'
@ nstrv-5 ,ncoll-1 SAY '╟────┬───┬───┬─────┬───────┬──────┬──────────┬──────────┬────┬─────────────────╢'
@ nstrv-4 ,ncoll-1 SAY '║Бал.│Вид│Вид│Hомер│ Код   │Hомер │   Дата   │  Дата    │Корр│      Сумма      '
@ nstrv-3 ,ncoll-1 SAY '║ сч.│опе│спр│исход│организ│банк. │документа │ оплаты   │счет│валюта           '
@ nstrv-2 ,ncoll-1 SAY '║    │рац│1/0│ящий │(работ)│докум.│          │          │    │                 '
@ nstrv-1 ,ncoll-1 SAY '╟────┴───┴───┴─────┴───────┴──────┴──────────┴──────────┴────┴─────────────────╢'
@ nstrv+11,ncoll-1 SAY '╚ Поиск: F2-организация,F3-документ,F4-сумма,F5-дата ═ F6 - экран ═ F10-печать '
RETURN
*
PROCEDURE Strsaybr
PARAMETERS color,nstr,npolscr
SET COLOR TO &color21
IF !pr_v_pr
    SET COLOR TO &color21
    @ 4,12 SAY IIF(vo='0','Приход','Расход')
    @ 5,15 SAY Spr_nam(pr_spr,kp,30)
    SELECT sprnaz
    SEEK bk_arc.wid_d
    @ 6,12 SAY sprnaz.nam
    SELECT bk_arc
    IF nastf_11=1
         @ 5,51 SAY pr_sprk
         @ 5,53 SAY kpp
         @ 6,48 SAY Spr_nam(pr_sprk,kpp,30)
    ENDIF
    @  9,68 SAY vid_val
    @ 10,62 SAY sm_val PICTURE '99,999,999,999.99'
ENDIF
SET COLOR TO &color
@ nstr, 1 SAY nzk
@ nstr, 6 SAY vo
@ nstr,10 SAY pr_spr
@ nstr,14 SAY nvx
@ nstr,20 SAY kp
@ nstr,28 SAY nrd
@ nstr,35 SAY dati
@ nstr,46 SAY dat
@ nstr,57 SAY kor
@ nstr,62 SAY sm PICTURE '99,999,999,999.99'
RETURN
*
PROCEDURE Strgetbr
PARAMETERS nstr,npolscr
@ nstr,10 GET pr_spr VALID pr_spr='0'.OR.pr_spr='1' ERROR 'Значение 0 - pаботник, 1 - оpганизация'
@ nstr,20 GET kp VALID Poisk_kp('bk_arc.kp',pr_spr,5,15,30) ERROR 'Нет такого кода...'
IF nastf_11=1
    @ 5,51 GET pr_sprk VALID pr_sprk='0'.OR.pr_sprk='1' ERROR 'Значение 0 - pаботник, 1 - оpганизация'
    @ 5,53 GET kpp VALID Poisk_kp('bk_arc.kpp',pr_sprk,6,48,30) ERROR 'Нет такого кода...'
ENDIF
READ
RETURN
*
PROCEDURE F2br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnrd,fvo,fdat,nz
nz=RECNO()
@ 11,20 FILL TO 16,48 COLOR &color20
SET COLOR TO &color13
@ 10,19,15,47 BOX box_2
SET COLOR TO &color14
fnrd=SPACE(LEN(nrd))
fkp=SPACE(LEN(kp))
IF pr_spr='0'
    @ 12,21 SAY ' Табельный номер' GET fkp VALID Poisk_ta('fkp',.T.,0,0,0) ERROR 'Hет такого табельного номера...'
ELSE
    @ 12,21 SAY ' Код организации' GET fkp VALID Poisk_kl('fkp',.T.,0,0,0) ERROR 'Hет такого кода...'
ENDIF
@ 13,21 SAY " Hомер документа" GET fnrd
READ
IF EMPTY(fkp)
    RETURN
ENDIF
SET ORDER TO nzk_kp
SET EXACT OFF
IF !SEEK(RTRIM(gfbs+fkp+fnrd))
    DO Net_n WITH 10," Hет такой инфоpмации. Повтоpите... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F3br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fnrd
nz=RECNO()
fnrd=SPACE(LEN(bk.nrd))
DEFINE WINDOW Zapros FROM 12,22 TO 14,48 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " Hомер документа" GET fnrd
READ
RELEASE WINDOW Zapros
IF EMPTY(nrd)
    RETURN
ENDIF
SET ORDER TO nrd
IF !SEEK(gfbs+fnrd)
    DO Net_n WITH 15," Hет такого документа. Повтоpите... "
    GO nz
ENDIF
RETURN
*
PROCEDURE F4br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk
fpoisk=0
DEFINE WINDOW Zapros FROM 11,32 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " Сумма" GET fpoisk PICTURE '999,999,999,999.99'
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    RETURN
ENDIF
SET ORDER TO summa
SET NEAR ON
SEEK gfbs+STR(fpoisk,15,2)
SET NEAR OFF
IF EOF()
    GO BOTTOM
ELSE
    IF !FOUND().AND.nzk#gfbs
         SKIP -1
         IF nzk#gfbs
              SET EXACT OFF
              SEEK gfbs
              SET EXACT ON
         ENDIF
    ENDIF
ENDIF
RETURN
*
PROCEDURE F5br
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk
fpoisk=DATE()
DEFINE WINDOW Zapros FROM 11,43 TO 13,59 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " Дата" GET fpoisk
READ
RELEASE WINDOW Zapros
IF LASTKEY()=27
    RETURN
ENDIF
SET ORDER TO datd
SET NEAR ON
SEEK gfbs+DTOC(fpoisk,1)
SET NEAR OFF
IF EOF()
    GO BOTTOM
ENDIF
RETURN
*
PROCEDURE F6br
IF RECCOUNT()=0
    RETURN
ENDIF
SET COLOR TO &color13
@ 0,0,23,79 BOX "╔═╗║╝═╚║ "
@  4,0 SAY '╟'+REPLICATE('─',78)+'╢'
@ 10,0 SAY '╟'+REPLICATE('─',78)+'╢'
@ 14,0 SAY '╟'+REPLICATE('─',78)+'╢'
@ 17,0 SAY '╟'+REPLICATE('─',78)+'╢'
SET COLOR TO &color14
@  1, 1 SAY 'Вид операции....'+vo
@  1,20 SAY IIF(vo='0','Приход','Расход')
@  2, 1 SAY 'От кого (кому)..'+pr_spr
@  2,19 SAY ' 0 - pаботник, 1 - оpганизация'
@  3, 1 SAY 'Балансовый счет '+nzk
@  3,25 SAY 'Корреспондирующий счет '+kor
@  2,51 SAY 'Номер исходящий (входящий)'
@  3,69 SAY nvx
@  5, 1 SAY 'Код получателя'
@  6, 4 SAY '(плательщика)'
@  7, 6 SAY kp
IF pr_spr='0'
    @  5,25 SAY 'Фамилия И.О. '+sprrab.fio
ELSE
    @  5,25 SAY 'Наименование '+skl.ikl
    @  6,21 SAY 'Доп.наименование '+skl.ikld
    @  7,33 SAY skl.ikldd
    @  8,22 SAY 'Отделение банка '+skl.otd
    @  9,22 SAY 'Расчетный счет  '+skl.sch
    @  9,55 SAY 'Признак региона '+skl.pr_reg
ENDIF
@ 11, 1 SAY 'Номер документа '+nrd
@ 12, 1 SAY 'Дата документа..'+DTOC(dati)
@ 13, 1 SAY 'Дата оплаты.....'+DTOC(dat)
@ 11,40 SAY 'Вид валюты.'+vid_val
@ 11,60 SAY 'Курс'+STR(IIF(sm_val=0,0,ROUND(sm/sm_val,5)),15,5)
@ 12,36 SAY 'Сумма в валюте '+STR(sm_val,15,2)
@ 13,36 SAY 'Сумма в рублях '+STR(sm,15,2)
@ 16, 1 SAY 'Договоp...............'+dog
@ 18, 1 SAY 'Вид документа...'+STR(wid_d,2)
SELECT sprnaz
SEEK bk_arc.wid_d
SELECT bk_arc
@ 18,19 SAY sprnaz.nam
@ 18,51 SAY 'Вид текста......'+STR(wid_t,2)
@ 19, 1 SAY 'Текст документа.'+text_1
@ 20,17 SAY text_2
@ 21,17 SAY text_3
@ 22,17 SAY text_4
READ
RETURN
*
*
PROCEDURE Chapvo
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=6
ncolr=72
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-7,ncoll FILL TO nstrv+12,ncolr+2 COLOR &color20
@ nstrv-8 ,ncoll-1,nstrv+11,ncolr+1 BOX "╔═╗║╝═╚║ "
@ nstrv-7 ,ncoll-1 SAY "║              С в о д     п о    о p г а н и з а ц и я м"
@ nstrv-6 ,ncoll-1 SAY "╟───────────────────────────────────────────────────────────────────╢"
@ nstrv-5 ,ncoll-1 SAY "║ Оpганизация:"
@ nstrv-4 ,ncoll-1 SAY "╟─────────┬──────────────────┬──────────────────┬───────────────────╢"
@ nstrv-3 ,ncoll-1 SAY "║  Код    │       Дебет      │      Кредит      │      Итоговое"
@ nstrv-2 ,ncoll-1 SAY "║оpганизац│                  │                  │       сальдо"
@ nstrv-1 ,ncoll-1 SAY "╟─────────┴──────────────────┴──────────────────┴───────────────────╢"
@ nstrv+11,ncoll-1 SAY "╚═ F2 - поиск ═════ F5 - оборот "
RETURN
*
PROCEDURE Strsayvo
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 7,21 SAY Spr_nam(pr_spr,kp,30)
ENDIF
IF smd#0.AND.smk#0
    SET COLOR TO &color8
    @ nstr,7 SAY '*'
ENDIF
SET COLOR TO &color
@ nstr, 6 SAY pr_spr
@ nstr, 8 SAY kp
@ nstr,16 SAY smd PICTURE '999,999,999,999.99'
@ nstr,35 SAY smk PICTURE '999,999,999,999.99'
sss=smd-smk
IF sss#0
    @ nstr,54 SAY sss PICTURE '9999,999,999,999.99'
ENDIF
RETURN
*
PROCEDURE F2vo
IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fpoisk,nz
nz=RECNO()
@ 14,28 FILL TO 16,53 COLOR &color20
SET COLOR TO &color13
@ 13,26,15,51 BOX box_1
SET COLOR TO &color14
fpoisk=SPACE(LEN(skl.kkl))
@ 14,28 SAY IIF(pr_spr='1',"Код организации","Табельный номер") GET fpoisk VALID IIF(pr_spr='0',Poisk_ta('fpoisk',.T.,0,0,0),Poisk_kl('fpoisk',.T.,0,0,0)) ERROR 'Hет такого кода...'
READ
IF EMPTY(fpoisk)
     RETURN
ENDIF
SET EXACT OFF
IF !SEEK(avotrr.pr_spr+fpoisk)
    DO Net_n WITH 10," Hет такого обоpота. Повторите... "
    GO nz
ENDIF
SET EXACT ON
RETURN
*
PROCEDURE F5vo
SELECT osdkomr
SET ORDER TO kp
SEEK avotrr.pr_spr+avotrr.kp
DO Vvodn WITH "Chapvz","Strsayvz","",.F.,.F.,.F.,.F.,"(pr_spr#avotrr.pr_spr.OR.kp#avotrr.kp)",;
              "","","","","F5vz","F6vz","","","","","",.T.
SELECT avotrr
RETURN
*
*
PROCEDURE Chapvz
PARAMETERS color4,nstrv,nstrn,ncoll,ncolr,step,npolscrm,scr,scr1,scr2,scr3,scr4
nstrv=12
nstrn=23
ncoll=1
ncolr=78
step=1
npolscrm=1
SET COLOR TO &color4
@ nstrv-8 ,ncoll-1,nstrv+11,ncolr+1 BOX "╔═╗║╝═╚║ "
@ nstrv-7 ,ncoll-1 SAY "║                  О б о p о т     п о    о p г а н и з а ц и я м"
@ nstrv-6 ,ncoll-1 SAY "╟──────────────────────────────────────────────────────────────────────────────╢"
@ nstrv-5 ,ncoll-1 SAY "║ Оpганизация:"
@ nstrv-4 ,ncoll-1 SAY "╟─┬────┬──────────────────┬──────────────────┬────────────────┬────────────────╢"
@ nstrv-3 ,ncoll-1 SAY "║ │Бал.│   Общий оборот   │   Общий оборот   │     Сальдо     │     Сальдо"
@ nstrv-2 ,ncoll-1 SAY "║ │счет│    по дебету     │     по кредиту   │     дебет      │     кредит"
@ nstrv-1 ,ncoll-1 SAY "╟─┴────┴──────────────────┴──────────────────┴────────────────┴────────────────╢"
@ nstrv+11,ncoll-1 SAY "╚═ F5 - отметка для взаимозачета ═══ F6 - формирование взаимозачета "
RETURN
*
PROCEDURE Strsayvz
PARAMETERS color,nstr,npolscr
IF !pr_v_pr
    SET COLOR TO &color21
    @ 7,16 SAY Spr_nam(pr_spr,kp,30)
ENDIF
SET COLOR TO &color
s1=db+smd
s2=kr+smk
@ nstr, 1 SAY pr_prib
@ nstr, 3 SAY bs
@ nstr, 8 SAY s1 PICTURE '999,999,999,999.99'
@ nstr,27 SAY s2 PICTURE '999,999,999,999.99'
sss=s1-s2
DO CASE
CASE sss>0
     @ nstr,46 SAY sss PICTURE '999,999,999,999.99'
CASE sss<0
     @ nstr,61 SAY -sss PICTURE '999,999,999,999.99'
ENDCASE
RETURN
*
PROCEDURE F5vz
IF kp#avotrr.kp.OR.pr_spr#avotrr.pr_spr
    RETURN
ENDIF
PRIVATE nz,i,sss
IF EMPTY(pr_prib)
    nz=RECNO()
    SET ORDER TO kp
    SEEK avotrr.pr_spr+avotrr.kp
    i=0
    sss=0
    SCAN REST WHILE kp=avotrr.kp.AND.pr_spr=avotrr.pr_spr FOR !EMPTY(pr_prib)
         i=i+1
         sss=db+smd-kr-smk
    ENDSCAN
    GO nz
    IF i<2
         IF (db+smd-kr-smk)>0.AND.sss>0.OR.(db+smd-kr-smk)<0.AND.sss<0
              DO Net_n WITH 10,'Взаимозачет невозможен - остатки одинаковы...'
         ELSE
              REPLACE pr_prib WITH ''
         ENDIF
    ELSE
         DO Net_n WITH 10,'Уже отмечены два счета...'
    ENDIF
    GO nz
ELSE
    REPLACE pr_prib WITH ' '
ENDIF
RETURN
*
PROCEDURE F6vz
IF kp#avotrr.kp.OR.pr_spr#avotrr.pr_spr
    RETURN
ENDIF
PRIVATE nz,i,sss
nz=RECNO()
SET ORDER TO kp
SEEK avotrr.pr_spr+avotrr.kp
i=0
sss=0
fkr=''
fdb=''
SCAN REST WHILE kp=avotrr.kp.AND.pr_spr=avotrr.pr_spr FOR !EMPTY(pr_prib)
    i=i+1
    IF sss=0
         sss=db+smd-kr-smk
         IF sss>0
              fkr=bs
         ELSE
              fdb=bs
         ENDIF
    ELSE
         sss=MIN(ABS(sss),ABS(db+smd-kr-smk))
         IF EMPTY(fkr)
              fkr=bs
         ELSE
              fdb=bs
         ENDIF
    ENDIF
ENDSCAN
IF i#2
    SET ORDER TO kp
    GO nz
    DO Net_n WITH 10,'Некорректна отметка для взаимозачета...'
    RETURN
ENDIF
fnrd=SPACE(6)
fdat=DATE()
fwid_d=2
fwid_t=99
ftext_1=SPACE(50)
ftext_2=SPACE(50)
ftext_3=SPACE(50)
ftext_4=SPACE(50)
ssss=sss
DEFINE WINDOW Zapros FROM 10,6 TO 14+IIF(nastf_d=1,6,0),75 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,1 SAY 'Номер документа' GET fnrd
@ 1,1 SAY 'Дата документа.' GET fdat VALID nastf_9=0.OR.MONTH(fdat)=ntmec.AND.RIGHT(STR(YEAR(fdat),4),2)=nastf_b ERROR 'Некорректна дата...'
@ 2,1 SAY 'Сумма..........' GET sss PICTURE '999,999,999,999.99' VALID sss<=ssss.AND.sss>=0 ERROR 'Максимальная сумма - '+LTRIM(TRANSFORM(ssss,'999,999,999,999.99'))+'...'
IF nastf_d=1
    @ 3,1 SAY 'Вид документа..' GET fwid_d VALID Poisk_wd('fwid_d',.T.,0,0,0) ERROR 'Hет такого кода...' PICTURE '99'
    @ 4,1 SAY 'Вид текста.....' GET fwid_t VALID Prov_tex() ERROR 'Hет такого кода...' PICTURE '99'
    @ 5,1 SAY 'Текст..........' GET ftext_1
    @ 6,17 GET ftext_2
    @ 7,17 GET ftext_3
    @ 8,17 GET ftext_4
ENDIF
READ
RELEASE WINDOW Zapros
ACTIVATE SCREEN
IF LASTKEY()=27.OR.sss=0
    RETURN
ENDIF
SELECT bk
APPEND BLANK
REPLACE kp WITH avotrr.kp,nrd WITH fnrd,pr_spr WITH avotrr.pr_spr,;
       dat WITH fdat,wid_d WITH fwid_d,wid_t WITH fwid_t,text_1 WITH ftext_1,;
    text_2 WITH ftext_2,text_3 WITH ftext_3,text_4 WITH ftext_4
REPLACE sm WITH sss,vo WITH '0',kor WITH IIF(fkr=nastf_l,nastf_k,fkr),nzk WITH IIF(fdb=nastf_l,nastf_k,fdb)
IF MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b
    SELECT osdkomr
    SET ORDER TO kp_pr
    IF SEEK(fdb+avotrr.kp+avotrr.pr_spr)
         REPLACE smd WITH smd+sss
    ENDIF
    IF SEEK(fkr+avotrr.kp+avotrr.pr_spr)
         REPLACE smk WITH smk+sss
    ENDIF
	SELECT avotrr
	REPLACE smd WITH 0,smk WITH 0
ENDIF
SELECT osdkomr
SET ORDER TO kp
SEEK avotrr.pr_spr+avotrr.kp
SCAN REST WHILE pr_spr=avotrr.pr_spr.AND.kp=avotrr.kp
    sss=db-kr+smd-smk
	IF sss>0
         REPLACE avotrr.smd WITH avotrr.smd+sss
    ELSE
         REPLACE avotrr.smk WITH avotrr.smk-sss
    ENDIF
    REPLACE pr_prib WITH ' '
ENDSCAN
GO nz
RETURN
*
PROCEDURE Prov_tex
ftext_1=sprt.text_1
ftext_2=sprt.text_2
ftext_3=sprt.text_3
ftext_4=sprt.text_4
RETURN Poisk_wt('fwid_t',.T.)