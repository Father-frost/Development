PRIVATE ffile,ffile1
ffile=fpath+"bk.dbf"
ffile1=fpath+"lim_nsk.dbf"
SET PATH TO
IF !FILE(ffile)
    SET PATH TO &nastf_p
    SELECT bk
    COPY STRUCTURE TO &ffile
ENDIF
SET PATH TO
IF !FILE(ffile1)
    SET PATH TO &nastf_p
    SELECT 0
    USE lim_nsk
    COPY STRUCTURE TO &ffile1
    USE
ENDIF
SET PATH TO &nastf_p
SELECT 0
USE lim_nsk
SET ORDER TO kp_nrd
SELECT 0
USE &ffile EXCLUSIVE ALIAS bk79
ZAP
SELECT 0
USE &ffile1 EXCLUSIVE ALIAS lim79
ZAP
SELECT bk
SET ORDER TO
@ 1,18 SAY RECCOUNT() PICTURE '999999'
SCAN FOR MONTH(dat)=ntmec.AND.LEFT(kor,2)=nastf_u.AND.!DELETE()
     @ 2,18 SAY RECNO() PICTURE '999999'
     SELECT lim_nsk
     SEEK bk.kp+bk.nrd+bk.kor+bk.nzk+bk.vo+DTOC(bk.dat,1)
     SCAN REST WHILE kp=bk.kp.AND.nrd=bk.nrd.AND.kor=bk.kor.AND.nzk=bk.nzk.AND.vo=bk.vo.AND.dat=bk.dat FOR knsk=nsk.AND.!DELETE()
          SELECT bk79
          APPEND BLANK
          REPLACE nzk WITH bk.nzk,dat WITH bk.dat,vo WITH bk.vo,pr_usl WITH bk.pr_usl,;
                 dati WITH bk.dati,kp WITH bk.kp
          REPLACE dat_tov WITH bk.dat_tov,dog WITH bk.dog,wid_d WITH bk.wid_d,nrd WITH bk.nrd,;
                      nvx WITH bk.nvx,nazn_pl WITH bk.nazn_pl,pr_spr WITH bk.pr_spr,sm WITH lim_nsk.summa,;
                    wid_t WITH bk.wid_t,sm_val WITH bk.sm_val,text_1 WITH bk.text_1
          REPLACE text_2 WITH bk.text_2,text_3 WITH bk.text_3,text_4 WITH bk.text_4,vid_op WITH bk.vid_op,;
                 vid_val WITH bk.vid_val,kor WITH bk.kor
          SELECT lim79
          APPEND BLANK
          REPLACE nzk WITH bk.nzk,dat WITH bk.dat,vo WITH bk.vo,kp WITH bk.kp,;
                  nrd WITH bk.nrd,summa WITH lim_nsk.summa,nsk WITH lim_nsk.nsk,;
                  kor WITH bk.kor
          SELECT lim_nsk
     ENDSCAN
     SELECT bk
ENDSCAN
SELECT bk79
USE
SELECT lim79
USE
SELECT lim_nsk
USE
RETURN
