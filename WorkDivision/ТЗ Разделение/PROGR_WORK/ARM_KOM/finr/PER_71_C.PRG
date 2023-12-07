PRIVATE scr
SELECT 0
USE ostrk EXCLUSIVE
SELECT 0
USE avotr EXCLUSIVE
SAVE SCREEN TO scr
IF RECCOUNT()=0
    DEFINE WINDOW Zapros FROM 10,17 TO 13,60 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    key=2
    @ 0,1 SAY "Есть подозpение что пеpеход уже выполнен."
    @ 1,1 SAY "Пpодолжать ?"
    @ 1,21 PROMPT " Да  "
    @ 1,31 PROMPT " Hет "
    MENU TO key
    RELEASE WINDOW Zapros
    ACTIVATE SCREEN
    IF key=0.OR.key=2
         USE
         SELECT ostrk
         USE
         RETURN
    ENDIF
ENDIF
USE
SELECT ostrk
USE
SET CLOCK OFF
HIDE POPUP ALL
SET COLOR TO &color14
CLEAR
sss='!del dbf71_'+LTRIM(STR(ntmec,2))+'.exe'
&sss
sss='!lha a dbf71_'+LTRIM(STR(ntmec,2))+' avotr.* ostrk.* vn_71.* yd_71.* avtr_arc.*'
&sss
sss='!lha s dbf71_'+LTRIM(STR(ntmec,2))
&sss
sss='!del dbf71_'+LTRIM(STR(ntmec,2))+'.lzh'
&sss
RESTORE SCREEN FROM scr
SHOW POPUP Glavn,Proch,Finr_71
SET CLOCK ON
USE ostrk EXCLUSIVE
SET ORDER TO bs_tab
SELECT 0
USE avtr_arc
SET DELETED ON
APPEND FROM avotr
SET DELETED OFF
REPLACE ms WITH STR(ntmec,2),god WITH nastf_b FOR EMPTY(ms).AND.EMPTY(god)
USE avotr EXCLUSIVE
SET ORDER TO bs_tab
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
@ 1,2 SAY ' Всего записей:       '
@ 2,2 SAY ' Текущая запись:      '
SET COLOR TO &color14
SCAN FOR !DELETE()
    SELECT ostrk
    IF !SEEK(avotr.bs+avotr.tab)
         APPEND BLANK
         REPLACE tab WITH avotr.tab,bs WITH avotr.bs,vid_val WITH avotr.vid_val
    ENDIF
    SELECT avotr
ENDSCAN
SELECT 0
USE yd_71 EXCLUSIVE
SET ORDER TO bs_tbn
SCAN FOR !DELETE()
    SELECT ostrk
    IF !SEEK(yd_71.bs+yd_71.tbn)
         APPEND BLANK
         REPLACE tab WITH yd_71.tbn,bs WITH yd_71.bs
    ENDIF
    SELECT yd_71
ENDSCAN
SELECT 0
USE vn_71 EXCLUSIVE
SET ORDER TO bs_tabo
SCAN FOR !DELETE()
    SELECT ostrk
    IF !SEEK(vn_71.bs+vn_71.tabo)
         APPEND BLANK
         REPLACE tab WITH vn_71.tabo,bs WITH vn_71.bs,vid_val WITH vn_71.vid_val
    ENDIF
    IF !SEEK(vn_71.bs+vn_71.tabp)
         APPEND BLANK
         REPLACE tab WITH vn_71.tabp,bs WITH vn_71.bs,vid_val WITH vn_71.vid_val
    ENDIF
    SELECT vn_71
ENDSCAN
  * tgod=1900+VAL(nastf_b)
  * tgod=2000+VAL(nastf_b)
  tgod=VAL(nastf_b)
SELECT 0
USE bkr EXCLUSIVE
ZAP
SET DELETED ON
APPEND FROM bk FOR MONTH(dat)=ntmec.AND.YEAR(dat)=tgod.AND.pr_spr='0'
SET DELETED OFF
INDEX ON kor+kp TAG rab
   *INDEX ON nzk+kp TAG rab1
RESTORE FROM tek_b ADDITIVE
DIMENSION mbs(100)
mbs=0
i=1
ntek=1
DO WHILE !EMPTY(AT(',',tek_b_24,i))
    mbs(i)=SUBSTR(tek_b_24,ntek,AT(',',tek_b_24,i)-ntek)
    ntek=AT(',',tek_b_24,i)+1
    i=i+1
ENDDO
kolbs=i
mbs(i)=RTRIM(SUBSTR(tek_b_24,ntek,30))
RELEASE ALL LIKE tek_b_??
SCAN
    pr_poisk=.F.
    FOR i=1 TO kolbs
         IF LEFT(kor,LEN(mbs(i)))=mbs(i)
              pr_poisk=.T.
              EXIT
         ENDIF
    ENDFOR
    IF pr_poisk
         SELECT ostrk
         IF !SEEK(bkr.kor+LEFT(bkr.kp,6))
              APPEND BLANK
              REPLACE tab WITH LEFT(bkr.kp,6),bs WITH bkr.kor,vid_val WITH bkr.vid_val
         ENDIF
    ENDIF
      *pr_poisk=.F.
    *FOR i=1 TO kolbs
    *     IF LEFT(bkr.nzk,LEN(mbs(i)))=mbs(i)
    *          pr_poisk=.T.
    *          EXIT
    *     ENDIF
    *ENDFOR
    *IF pr_poisk
    *     SELECT ostrk
    *     IF !SEEK(bkr.nzk+LEFT(bkr.kp,6))
    *          APPEND BLANK
    *          REPLACE tab WITH LEFT(bkr.kp,6),bs WITH bkr.nzk,vid_val WITH bkr.vid_val
    *     ENDIF
    *ENDIF
ENDSCAN
SELECT ostrk
@ 1,18 SAY RECCOUNT() PICTURE '999999'
ii=0
fprval=.F.
SCAN FOR !DELETE()
    ii=ii+1
    @ 2,18 SAY ii PICTURE '999999'
    ftab=tab
    fbs=bs
    IF nastf_8=1
         SELECT spr_bs
         SET ORDER TO bs
         SEEK fbs
         fprval=IIF(spr_bs.pr_val='1',.T.,.F.)
    ENDIF
    sumprs=0
    sumrxs=0
    sumprv=0
    sumrxv=0
    SELECT bkr
    SET ORDER TO rab
    SEEK fbs+ftab+' '
    SCAN REST WHILE kor=fbs.AND.kp=ftab+' '
         IF vo='0'
              IF fprval
                   sumrxv=sumrxv+sm_val
              ELSE
                   sumrxs=sumrxs+sm
              ENDIF
         ELSE
              IF fprval
                   sumprv=sumprv+sm_val
              ELSE
                   sumprs=sumprs+sm
              ENDIF
         ENDIF
    ENDSCAN
   * SET ORDER TO rab1
   * SEEK fbs+ftab+' '
   * SCAN REST WHILE nzk=fbs.AND.kp=ftab+' '
   *      IF vo='1'
   *           IF fprval
   *                sumrxv=sumrxv+sm_val
   *           ELSE
   *                sumrxs=sumrxs+sm
   *           ENDIF
   *      ELSE
   *           IF fprval
   *                sumprv=sumprv+sm_val
   *           ELSE
   *                sumprs=sumprs+sm
   *           ENDIF
   *      ENDIF
   * ENDSCAN
    SELECT avotr
    SET EXACT OFF
    SEEK fbs+ftab
    SET EXACT ON
    SCAN REST WHILE bs=fbs.AND.ftab=tab FOR !DELETE()
         IF fprval
              sumrxv=sumrxv+sm_val
         ELSE
              sumrxs=sumrxs+smk
         ENDIF
    ENDSCAN
    SELECT vn_71
    SET ORDER TO bs_tabo
    SET EXACT OFF
    SEEK fbs+ftab
    SET EXACT ON
    SCAN REST WHILE bs=fbs.AND.ftab=tabo FOR !DELETE()
         IF fprval
              sumrxv=sumrxv+sm_val
         ELSE
              sumrxs=sumrxs+summa
         ENDIF
    ENDSCAN
    SET ORDER TO bs_tabp
    SET EXACT OFF
    SEEK fbs+ftab
    SET EXACT ON
    SCAN REST WHILE bs=fbs.AND.ftab=tabp FOR !DELETE()
         IF fprval
              sumprv=sumprv+sm_val
         ELSE
              sumprs=sumprs+summa
         ENDIF
    ENDSCAN
    SELECT yd_71
    SEEK fbs+ftab
    SCAN REST WHILE bs=fbs.AND.ftab=tbn FOR !DELETE()
         sumrxs=sumrxs+symk
    ENDSCAN
    SELECT ostrk
    IF fprval
         saldv=db_val-kr_val+sumprv-sumrxv
         IF saldv>=0
              REPLACE db_val WITH saldv,kr_val WITH 0
              REPLACE db WITH Kurs_dat(vid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,db_val),kr WITH 0
         ELSE
              REPLACE kr_val WITH -saldv,db_val WITH 0
              REPLACE kr WITH Kurs_dat(vid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,kr_val),db WITH 0
         ENDIF
    ELSE
         sald=db-kr+sumprs-sumrxs
         IF sald>=0
              REPLACE db WITH sald,kr WITH 0
         ELSE
              REPLACE kr WITH -sald,db WITH 0
         ENDIF
    ENDIF
ENDSCAN
SELECT bkr
DELETE TAG rab
*DELETE TAG rab1
ZAP
USE
SELECT ostrk
DELETE FOR db=0.AND.kr=0.AND.db_val=0.AND.kr_val=0
PACK
SELECT avotr
ZAP
USE
SELECT vn_71
ZAP
USE
SELECT yd_71
ZAP
USE
SELECT ostrk
USE kas_71 EXCLUSIVE
ZAP
USE
SELECT 0
USE spr_nrd EXCLUSIVE
REPLACE ALL NRD WITH 0
USE
HIDE WINDOW Pogal
ACTIVATE SCREEN
RETURN