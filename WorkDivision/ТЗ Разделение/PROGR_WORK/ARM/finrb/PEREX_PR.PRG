PRIVATE scr
SELECT 0
USE dv_pr EXCLUSIVE
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
    IF key=0.OR.key=2
         USE
         RETURN
    ENDIF
ENDIF
USE
SET COLOR TO &color14
CLEAR
SET CLOCK OFF
HIDE POPUP ALL
sss='!del dbf76_'+LTRIM(STR(ntmec,2))+'.exe'
&sss
sss='!lha a dbf76_'+LTRIM(STR(ntmec,2))+' dv_pr.* osd_pr.* dvpr_arc.*'
&sss
sss='!lha s dbf76_'+LTRIM(STR(ntmec,2))
&sss
sss='!del dbf76_'+LTRIM(STR(ntmec,2))+'.lzh'
&sss
USE dvpr_arc
SET DELETED ON
APPEND FROM dv_pr
SET DELETED OFF
REPLACE ms WITH STR(ntmec,2),god WITH nastf_b FOR EMPTY(ms).AND.EMPTY(god)
USE dv_pr EXCLUSIVE
RESTORE SCREEN FROM scr
SHOW POPUP Glavn,Proch,Finr_pr
SET CLOCK ON
ACTIVATE WINDOW Pog_p
SET COLOR TO &color15
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
RESTORE FROM tek_b ADDITIVE
SELECT 0
USE osd_pr EXCLUSIVE
SET ORDER TO bs_kp
IF tek_b_15=1
    REPLACE ALL dog WITH SPACE(10)
ENDIF
SELECT 0
USE bkr EXCLUSIVE
ZAP
SET DELETED ON
APPEND FROM bk FOR MONTH(dat)=ntmec.AND.RIGHT(STR(YEAR(dat),4),2)=nastf_b
SET DELETED OFF
IF tek_b_15=1
    REPLACE ALL dog WITH SPACE(10)
ENDIF
INDEX ON kor+kp+dog TAG rab
INDEX ON nzk+kp+dog TAG rab1
DIMENSION mbs(100)
mbs=0
i=1
ntek=1
DO WHILE !EMPTY(AT(',',tek_b_4,i))
    mbs(i)=SUBSTR(tek_b_4,ntek,AT(',',tek_b_4,i)-ntek)
    ntek=AT(',',tek_b_4,i)+1
    i=i+1
ENDDO
kolbs=i
mbs(i)=RTRIM(SUBSTR(tek_b_4,ntek,30))
SCAN
    pr_poisk=.F.
    FOR i=1 TO kolbs
         IF LEFT(kor,LEN(mbs(i)))=mbs(i)
              pr_poisk=.T.
              EXIT
         ENDIF
    ENDFOR
    IF pr_poisk
         SELECT osd_pr
         IF !SEEK(bkr.kor+bkr.kp+bkr.dog)
              APPEND BLANK
              REPLACE dog WITH bkr.dog,kp WITH bkr.kp,bs WITH bkr.kor,dat WITH bkr.dat,;
                   pr_spr WITH bkr.pr_spr,text WITH bkr.text_1
         ENDIF
         SELECT bkr
    ENDIF
    pr_poisk=.F.
    FOR i=1 TO kolbs
         IF LEFT(nzk,LEN(mbs(i)))=mbs(i)
              pr_poisk=.T.
              EXIT
         ENDIF
    ENDFOR
    IF pr_poisk
         SELECT osd_pr
         IF !SEEK(bkr.nzk+bkr.kp+bkr.dog)
              APPEND BLANK
              REPLACE dog WITH bkr.dog,kp WITH bkr.kp,bs WITH bkr.nzk,dat WITH bkr.dat,;
                   pr_spr WITH bkr.pr_spr,text WITH bkr.text_1
         ENDIF
    ENDIF
ENDSCAN
SELECT dv_pr
SET ORDER TO bs_kp
IF tek_b_15=1
    REPLACE ALL dog WITH SPACE(10)
ENDIF
SCAN FOR !DELETE()
    pr_poisk=.F.
    FOR i=1 TO kolbs
         IF LEFT(bs,LEN(mbs(i)))=mbs(i)
              pr_poisk=.T.
              EXIT
         ENDIF
    ENDFOR
    IF pr_poisk
         SELECT osd_pr
         IF !SEEK(dv_pr.bs+dv_pr.kp+dv_pr.dog)
              APPEND BLANK
              REPLACE dog WITH dv_pr.dog,kp WITH dv_pr.kp,bs WITH dv_pr.bs,dat WITH dv_pr.dat,;
                   pr_spr WITH dv_pr.pr_spr,text WITH dv_pr.text
         ENDIF
         SELECT dv_pr
    ENDIF
    pr_poisk=.F.
    FOR i=1 TO kolbs
         IF LEFT(kor,LEN(mbs(i)))=mbs(i)
              pr_poisk=.T.
              EXIT
         ENDIF
    ENDFOR
    IF pr_poisk
         SELECT osd_pr
         IF !SEEK(dv_pr.kor+dv_pr.kp+dv_pr.dog)
              APPEND BLANK
              REPLACE dog WITH dv_pr.dog,kp WITH dv_pr.kp,bs WITH dv_pr.kor,dat WITH dv_pr.dat,;
                   pr_spr WITH dv_pr.pr_spr,text WITH dv_pr.text
         ENDIF
    ENDIF
ENDSCAN
RELEASE ALL LIKE tek_b_??
SELECT osd_pr
fprval=.F.
SCAN FOR !DELETE()
    fbs=bs
    IF nastf_8=1
         SELECT spr_bs
         SET ORDER TO bs
         SEEK fbs
         fprval=IIF(spr_bs.pr_val='1',.T.,.F.)
         SELECT osd_pr
    ENDIF
    fkp=kp
    fdog=dog
    sumprs=0
    sumrxs=0
    sumprv=0
    sumrxv=0
    SELECT bkr
    SET ORDER TO rab
    SEEK fbs+fkp+fdog
    SCAN REST WHILE fbs=kor.AND.fkp=kp.AND.fdog=dog
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
    SET ORDER TO rab1
    SEEK fbs+fkp+fdog
    SCAN REST WHILE fbs=nzk.AND.fkp=kp.AND.fdog=dog
         IF vo='1'
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
    SELECT dv_pr
    SET ORDER TO bs_kp
    SEEK fbs+fkp+fdog
    SCAN REST WHILE fbs=bs.AND.fdog=dog.AND.fkp=kp FOR !DELETE()
         IF fprval
              sumprv=sumprv+sm_vald
              sumrxv=sumrxv+sm_valk
         ELSE
              sumprs=sumprs+smd
              sumrxs=sumrxs+smk
         ENDIF
    ENDSCAN
    SET ORDER TO kor_kp
    SEEK fbs+fkp+fdog
    SCAN REST WHILE fbs=kor.AND.fdog=dog.AND.fkp=kp FOR !DELETE()
         IF fprval
              sumprv=sumprv+sm_valk
              sumrxv=sumrxv+sm_vald
         ELSE
              sumprs=sumprs+smk
              sumrxs=sumrxs+smd
         ENDIF
    ENDSCAN
    SELECT osd_pr
    IF fprval
         saldv=sm_vald-sm_valk+sumprv-sumrxv
         IF saldv>=0
              REPLACE sm_vald WITH saldv,sm_valk WITH 0
              REPLACE db WITH Kurs_dat(vid_val,GOMONTH(CTOD('01/'+STR(ntmec+1,2)+'/'+nastf_b),1)-1,sm_vald),kr WITH 0
         ELSE
              REPLACE sm_valk WITH -saldv,sm_vald WITH 0
              REPLACE kr WITH Kurs_dat(vid_val,GOMONTH(CTOD('01/'+STR(ntmec+1,2)+'/'+nastf_b),1)-1,sm_valk),db WITH 0
         ENDIF
    ELSE
         sald=db-kr+sumprs-sumrxs
         IF sald>=0
              REPLACE db WITH sald,kr WITH 0.0
         ELSE
              REPLACE kr WITH -sald,db WITH 0.0
         ENDIF
    ENDIF
ENDSCAN
DELETE FOR db=0.AND.kr=0.AND.sm_vald=0.AND.sm_valk=0
PACK
USE
SELECT dv_pr
ZAP
USE
SELECT bkr
ZAP
DELETE TAG rab
USE
RETURN
