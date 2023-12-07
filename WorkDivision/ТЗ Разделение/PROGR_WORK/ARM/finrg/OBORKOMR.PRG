DIMENSION mkor(100),msaldd(100),msaldk(100),mcex(100,3)
PRIVATE ii,i,fprval;
SET PROCEDURE TO oborkomr
RESTORE FROM tek_b ADDITIVE
  *n1=0
  *n2=7
  *n3=38
  *n4=49
  *n5=55
  *i=0
  *fprval=.F.
  *IF nastf_8=1.AND.spr_bs.pr_val='1'
     * fprval=.T.
     * i=7
     * n5a=62
  *ENDIF
  *n6=62+i
  *n7=78+i
  *n8=94+i
  *n9=110+i
  *n10=126+i
  *n11=142+i
n1=0
n2=7
n3=33
n4=44
n5=50
i=0
fprval=.F.
IF nastf_8=1.AND.spr_bs.pr_val='1'
    fprval=.T.
    i=7
    n5a=57
ENDIF
n6=57+i
n7=68+i
n8=79+i
n9=90+i
n10=101+i
n11=112+i

msaldd=0
msaldk=0
klkor=0
mbs1=0
mbs2=0
mbs3=0
mbs4=0
mbs5=0
mbs6=0
mbs1_val=0
mbs2_val=0
mbs3_val=0
mbs4_val=0
mbs5_val=0
mbs6_val=0
mbs1_val_R=0
mbs2_val_R=0
mbs3_val_R=0
mbs4_val_R=0
mbs5_val_R=0
mbs6_val_R=0
mkor=0
nnstr=0
nstr=kolstr+1
fdbv=0
fkrv=0
ii=0
sum_av=0
sum_xozd=0
sum_xozk=0
ftab=''
GO TOP
  *fvid_val=vid_val
fvid_val=''
DO WHILE !EOF()
    fcex=nsk
    ms1=0
    ms2=0
    ms3=0
    ms4=0
    ms5=0
    ms6=0
    ms1_val=0
    ms2_val=0
    ms3_val=0
    ms4_val=0
    ms5_val=0
    ms6_val=0
    ms1_val_R=0
    ms2_val_R=0
    ms3_val_R=0
    ms4_val_R=0
    ms5_val_R=0
    ms6_val_R=0
    mcex=0
    kolcex=0
    SCAN REST WHILE nsk=fcex
                * IF EMPTY(fvid_val)
                * fvid_val=ALLTRIM(vid_val)
                * ENDIF
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         ftab=tab
         pr_per=.T.
         sumprs=0
         sumrxs=0
         sald=0
         sump_val=0
         sumr_val=0
         sump_val_R=0
         sumr_val_R=0
         db_val_U=0
         kr_val_U=0
         db_val_R=0
         kr_val_R=0
         sald_val=0
         sald_val_R=0
         sm_av=0
         sm_av_val=0
         bk_val_U=0
         bk_val_R=0
         fvid_val=''

         SELECT bk
         SET ORDER TO bk2
         SET EXACT OFF
         SEEK ff+ftab
         SET EXACT ON
         SCAN REST WHILE ff=kor.AND.ftab=LEFT(kp,6) FOR MONTH(dat)=ntmec.AND.YEAR(dat)=tgod.AND.pr_spr='0'.AND.!DELETE()
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF pr_per
                        @ nstr,n1 SAY kp
                        @ nstr,n2 SAY LEFT(sprrab.fio,25)
                        pr_per=.F.
                   ENDIF
                   @ nstr,n3 SAY dat
                   @ nstr,n4 SAY nrd
                   IF WID_T=93.OR.WID_T=94
                      @ nstr,n5 SAY nzk+'X'
                      IF vo='0'
                         sum_xozk=sum_xozk+sm
                      ELSE
                         sum_xozd=sum_xozd+sm
                      ENDIF
                   ELSE
                      @ nstr,n5 SAY nzk
                   ENDIF
                   IF vo='0'
                        @ nstr,n9 SAY sm PICTURE '9999999999'
                   ELSE
                        @ nstr,n8 SAY sm PICTURE '9999999999'
                   ENDIF
              ENDIF
              IF fprval
                                      *  IF EMPTY(fvid_val)
                   fvid_val=vid_val
                                      *  ENDIF
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                    IF WID_T#90
                       @ nstr,n5a SAY vid_val
                       IF vo='0'
                          @ nstr,n9 SAY sm_val PICTURE '9999999999'
                       ELSE
                          @ nstr,n8 SAY sm_val PICTURE '9999999999'
                       ENDIF
                    ENDIF
                   ENDIF
              ENDIF
              IF vo='0'
                 sumrxs=sumrxs+sm+Delta
                 IF fvid_val='USD'
                    sumr_val=sumr_val+sm_val
                 ELSE
                    IF fvid_val='RUR'
                       sumr_val_R=sumr_val_R+sm_val
                    ENDIF
                 ENDIF
              ELSE
                 sumprs=sumprs+sm+Delta
                 IF fvid_val='USD'
                    sump_val=sump_val+sm_val
                 ELSE
                    IF fvid_val='RUR'
                       sump_val_R=sump_val_R+sm_val
                    ENDIF
                 ENDIF
              ENDIF
                  * если задолжность в валюте погашаются в рублях РБ
                  *IF ff='71/1'.AND.WID_T=90
                  *   IF sm_val=0
                  *      SELECT kurs_val
                  *      SET NEAR ON
                  *      SEEK bk.vid_val+DTOC(bk.dat,1)
                  *      SET NEAR OFF
                  *      IF !FOUND()
                  *         SKIP -1
                  *      ENDIF
                  *      IF bk.vid_val=kod
                  *      DO CASE
                  *         CASE bk.vid_val='USD'
                  *           bk_val_U=ROUND(bk.sm*kurs_val.kurs/kurs_val.summa,0)
                  *         CASE bk.vid_val='RUR'
                  *           bk_val_R=ROUND(bk.sm*kurs_val.kurs/kurs_val.summa,0)
                  *      ENDCASE
                  *      ENDIF
                  *   ELSE
                  *      DO CASE
                  *         CASE bk.vid_val='USD'
                  *           bk_val_U=bk.sm_val
                  *         CASE bk.vid_val='RUR'
                  *           bk_val_R=bk.sm_val
                  *      ENDCASE
                  *   ENDIF
                  *   SELECT bk
                  *     IF vo='0'
                  *      DO CASE
                  *        CASE vid_val='USD'
                  *            bk_val_U=-bk_val_U          && если приход на счет 50
                  *        CASE vid_val='RUR'
                  *            bk_val_R=-bk_val_R          && если приход на счет 50
                  *      ENDCASE
                  *     ENDIF
                  *ENDIF
                  *
              FOR i=1 TO klkor
                   IF mkor(i)=nzk
                        EXIT
                   ENDIF
              ENDFOR
              IF i>klkor
                   klkor=i
                   mkor(i)=nzk
              ENDIF
              IF vo='0'
                   msaldk(i)=msaldk(i)+sm+Delta
              ELSE
                   msaldd(i)=msaldd(i)+sm+Delta
              ENDIF
              FOR i=1 TO kolcex
                   IF mcex(i,1)=nzk
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolcex
                   kolcex=i
                   mcex(i,1)=nzk
              ENDIF
              IF vo='0'
                   mcex(i,2)=mcex(i,2)+sm+Delta
              ELSE
                   mcex(i,3)=mcex(i,3)+sm+Delta
              ENDIF
         ENDSCAN

         SET ORDER TO kp
         SET EXACT OFF
         SEEK ff+ftab
         SET EXACT ON
         SCAN REST WHILE ff=nzk.AND.ftab=LEFT(kp,6) FOR MONTH(dat)=ntmec.AND.YEAR(dat)=tgod.AND.pr_spr='0'.AND.!DELETE()
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF pr_per
                        @ nstr,n1 SAY kp
                        @ nstr,n2 SAY LEFT(sprrab.fio,25)
                        pr_per=.F.
                   ENDIF
                   @ nstr,n3 SAY dat
                   @ nstr,n4 SAY nrd
                   IF WID_T=93.OR.WID_T=94
                      @ nstr,n5 SAY kor+'X'
                      IF vo='0'
                         sum_xozk=sum_xozk+sm
                      ELSE
                         sum_xozd=sum_xozd+sm
                      ENDIF
                   ELSE
                      @ nstr,n5 SAY kor
                   ENDIF
                   IF vo='1'
                        @ nstr,n9 SAY sm PICTURE '9999999999'
                   ELSE
                        @ nstr,n8 SAY sm PICTURE '9999999999'
                   ENDIF
              ENDIF
              IF fprval
                                   * IF EMPTY(fvid_val)
                   fvid_val=vid_val
                                   * ENDIF
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n5a SAY vid_val
                        IF vo='1'
                             @ nstr,n9 SAY sm_val PICTURE '9999999999'
                        ELSE
                             @ nstr,n8 SAY sm_val PICTURE '9999999999'
                        ENDIF
                   ENDIF
              ENDIF
              IF vo='1'
                   sumrxs=sumrxs+sm+Delta
                   IF fvid_val='USD'
                      sumr_val=sumr_val+sm_val
                   ELSE
                      IF fvid_val='RUR'
                         sumr_val_R=sumr_val_R+sm_val
                      ENDIF
                   ENDIF
              ELSE
                   sumprs=sumprs+sm+Delta
                   IF fvid_val='USD'
                      sump_val=sump_val+sm_val
                   ELSE
                      IF fvid_val='RUR'
                         sump_val_R=sump_val_R+sm_val
                      ENDIF
                   ENDIF
              ENDIF
              FOR i=1 TO klkor
                   IF mkor(i)=kor
                        EXIT
                   ENDIF
              ENDFOR
              IF i>klkor
                   klkor=i
                   mkor(i)=kor
              ENDIF
              IF vo='1'
                   msaldk(i)=msaldk(i)+sm+Delta
              ELSE
                   msaldd(i)=msaldd(i)+sm+Delta
              ENDIF
              FOR i=1 TO kolcex
                   IF mcex(i,1)=kor
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolcex
                   kolcex=i
                   mcex(i,1)=kor
              ENDIF
              IF vo='1'
                   mcex(i,2)=mcex(i,2)+sm+Delta
              ELSE
                   mcex(i,3)=mcex(i,3)+sm+Delta
              ENDIF
         ENDSCAN

         SELECT avotr
         SET EXACT OFF
         SEEK ff+ftab
         SET EXACT ON
         SCAN REST WHILE ff=bs.AND.ftab=tab FOR !DELETE()
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF pr_per
                        @ nstr,n1 SAY tab
                        @ nstr,n2 SAY LEFT(sprrab.fio,25)
                        pr_per=.F.
                   ENDIF
                   @ nstr,n3 SAY dat
                   @ nstr,n4 SAY nvx
                   IF LEFT(nzk,1)='2'
                     @ nstr,n5 SAY kor+'X'
                     sum_xozk=sum_xozk+smk
                   ELSE
                      @ nstr,n5 SAY kor
                   ENDIF
                   @ nstr,n9 SAY smk PICTURE '9999999999'
              ENDIF
              IF fprval
                                     * IF EMPTY(fvid_val)
                 fvid_val=vid_val
                                     * ENDIF
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n5a SAY vid_val
                        @ nstr,n9  SAY sm_val PICTURE '9999999999'
                   ENDIF
              ENDIF
              sumrxs=sumrxs+smk
              If kor#'50'.or.kor#'501'
                    sm_av=sm_av+smk
                    sum_av=sum_av+smk
              ENDIF
              IF fvid_val='USD'
                 sumr_val=sumr_val+sm_val
              ELSE
                 IF fvid_val='RUR'
                    sumr_val_R=sumr_val_R+sm_val
                 ENDIF
              ENDIF
              FOR i=1 TO klkor
                   IF mkor(i)=kor
                        EXIT
                   ENDIF
              ENDFOR
              IF i>klkor
                   klkor=i
                   mkor(i)=kor
              ENDIF
              msaldk(i)=msaldk(i)+smk
              FOR i=1 TO kolcex
                   IF mcex(i,1)=kor
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolcex
                   kolcex=i
                   mcex(i,1)=kor
              ENDIF
              mcex(i,2)=mcex(i,2)+smk
         ENDSCAN

         SELECT yd_71
         SET EXACT OFF
         SEEK ff+ftab
         SET EXACT ON
         SCAN REST WHILE ff=bs.AND.ftab=tbn FOR !DELETE()
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF pr_per
                        @ nstr,n1 SAY tbn
                        @ nstr,n2 SAY LEFT(sprrab.fio,25)
                        pr_per=.F.
                   ENDIF
                   IF LEFT(nzk,1)='2'
                     @ nstr,n5 SAY kor+'X'
                     IF symk>0
                        sum_xozk=sum_xozk+symk
                     ELSE
                        sum_xozd=sum_xozd+symk
                     ENDIF
                   ELSE
                     @ nstr,n5 SAY tek_b_5
                   ENDIF
                   IF symk>0
                        @ nstr,n9 SAY symk PICTURE '9999999999'
                   ELSE
                        @ nstr,n8 SAY -symk PICTURE '9999999999'
                   ENDIF
              ENDIF
              FOR i=1 TO klkor
                   IF mkor(i)=tek_b_5
                        EXIT
                   ENDIF
              ENDFOR
              IF i>klkor
                   klkor=i
                   mkor(i)=tek_b_5
              ENDIF
              IF symk>0
                   msaldk(i)=msaldk(i)+symk
              ELSE
                   msaldd(i)=msaldd(i)-symk
              ENDIF
              FOR i=1 TO kolcex
                   IF mcex(i,1)=tek_b_5
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolcex
                   kolcex=i
                   mcex(i,1)=tek_b_5
              ENDIF
              IF symk>0
                   sumrxs=sumrxs+symk
                   mcex(i,3)=mcex(i,3)+symk
              ELSE
                   sumprs=sumprs-symk
                   mcex(i,2)=mcex(i,2)-symk
              ENDIF
         ENDSCAN

         SELECT vn_71
         SET ORDER TO bs_tabo
         SET EXACT OFF
         SEEK ff+ftab
         SET EXACT ON
         SCAN REST WHILE ff=bs.AND.ftab=tabo FOR !DELETE()
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF pr_per
                        @ nstr,n1 SAY tabo
                        @ nstr,n2 SAY LEFT(sprrab.fio,25)
                        pr_per=.F.
                   ENDIF
                   @ nstr,n3 SAY dat
                   @ nstr,n4 SAY nrd
                   @ nstr,n5 SAY ff
                   @ nstr,n6 SAY 'к '+tabp
                   @ nstr,n9 SAY summa
              ENDIF
              IF fprval
                                       * IF EMPTY(fvid_val)
                 fvid_val=vid_val
                                       * ENDIF
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n5a SAY vid_val
                        @ nstr,n9 SAY sm_val PICTURE '9999999999'
                   ENDIF
              ENDIF
              sumrxs=sumrxs+summa
              IF fvid_val='USD'
                 sumr_val=sumr_val+sm_val
              ELSE
                IF fvid_val='RUR'
                   sumr_val_R=sumr_val_R+sm_val
                ENDIF
              ENDIF
              FOR i=1 TO klkor
                   IF mkor(i)=ff
                        EXIT
                   ENDIF
              ENDFOR
              IF i>klkor
                   klkor=i
                   mkor(i)=ff
              ENDIF
              msaldk(i)=msaldk(i)+summa
              FOR i=1 TO kolcex
                   IF mcex(i,1)=ff
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolcex
                   kolcex=i
                   mcex(i,1)=ff
              ENDIF
              mcex(i,2)=mcex(i,2)+summa
         ENDSCAN

         SET ORDER TO bs_tabp
         SET EXACT OFF
         SEEK ff+ftab
         SET EXACT ON
         SCAN REST WHILE ff=bs.AND.ftab=tabp FOR !DELETE()
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF pr_per
                        @ nstr,n1 SAY tabp
                        @ nstr,n2 SAY LEFT(sprrab.fio,25)
                        pr_per=.F.
                   ENDIF
                   @ nstr,n3 SAY dat
                   @ nstr,n4 SAY nrd
                   @ nstr,n5 SAY ff
                   @ nstr,n6 SAY 'от '+tabo
                   @ nstr,n8 SAY summa
              ENDIF
              IF fprval
                                     * IF EMPTY(fvid_val)
                 fvid_val=vid_val
                                     * ENDIF
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n5a SAY vid_val
                        @ nstr,n8  SAY sm_val PICTURE '9999999999'
                   ENDIF
              ENDIF
              sumprs=sumprs+summa
              IF fvid_val='USD'
                 sump_val=sump_val+sm_val
              ELSE
                 IF fvid_val='RUR'
                    sump_val_R=sump_val_R+sm_val
                 ENDIF
              ENDIF
              FOR i=1 TO klkor
                   IF mkor(i)=ff
                        EXIT
                   ENDIF
              ENDFOR
              IF i>klkor
                   klkor=i
                   mkor(i)=ff
              ENDIF
              msaldd(i)=msaldd(i)+summa
              FOR i=1 TO kolcex
                   IF mcex(i,1)=ff
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolcex
                   kolcex=i
                   mcex(i,1)=ff
              ENDIF
              mcex(i,3)=mcex(i,3)+summa
         ENDSCAN

           SELECT ostrkr
           sald_U=0
           sald_R=0
           db1=0
           kr1=0
           IF fprval
               SCAN REST WHILE ff=bs.AND.ftab=LEFT(tab,6).AND.fcex=nsk
                 IF vid_val = 'USD'
                    db_val_U =db_val   && остатки на начало месяца есть в RUR,USD
                    kr_val_U =kr_val
                    db_val=0
                    kr_val=0
                 ELSE
                    db_val_R =db_val
                    kr_val_R =kr_val
                    db_val=0
                    kr_val=0
                 ENDIF
               db1=db1+db
               kr1=kr1+kr
              ENDSCAN
             SKIP -1
             sald=db1-kr1+sumprs-sumrxs
           ELSE
             sald=db-kr+sumprs-sumrxs
           ENDIF
           IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
           ENDIF
           nstr=nstr+1
                    *IF nnstr>=nlist
                    *   @ nstr,n1 SAY "Итого по авансовым отчетам по таб.номеру N "+ftab+" "+LEFT(sprrab.fio,30)
                    *   @ nstr,n9 SAY sm_av     PICTURE '999999999999.99' FUNCTION 'Z'
                    *ENDIF
           IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
           ENDIF
           nstr=nstr+1
           IF nnstr>=nlist
             IF fprval
                @ nstr,n1 SAY "Итого по таб.номеру N "+ftab+" "+LEFT(sprrab.fio,25)
                @ nstr,n6 SAY db1     PICTURE '9999999999' FUNCTION 'Z'
                @ nstr,n7 SAY kr1     PICTURE '9999999999' FUNCTION 'Z'
                @ nstr,n8 SAY sumprs  PICTURE '9999999999' FUNCTION 'Z'
                @ nstr,n9 SAY sumrxs  PICTURE '9999999999' FUNCTION 'Z'
             ELSE
                @ nstr,n1 SAY "Итого по таб.номеру N "+ftab+" "+LEFT(sprrab.fio,25)
                @ nstr,n6 SAY db     PICTURE '9999999999' FUNCTION 'Z'
                @ nstr,n7 SAY kr     PICTURE '9999999999' FUNCTION 'Z'
                @ nstr,n8 SAY sumprs PICTURE '9999999999' FUNCTION 'Z'
                @ nstr,n9 SAY sumrxs PICTURE '9999999999' FUNCTION 'Z'
                IF sald>=0
                   @ nstr,n10 SAY  sald PICTURE '9999999999' FUNCTION 'Z'
                ELSE
                   @ nstr,n11 SAY -sald PICTURE '9999999999' FUNCTION 'Z'
                ENDIF
             ENDIF
           ENDIF
           IF fprval
                       *IF bk_val_U#0        && если погашается валюта в бел.руб
                       *   sald_val=db_val_U-kr_val_U+sump_val-sumr_val+bk_val_U
                       *ELSE
                  sald_val=db_val_U-kr_val_U+sump_val-sumr_val
                       *ENDIF
                       *IF bk_val_R#0
                       *   sald_val_R=db_val_R-kr_val_R+sump_val_R-sumr_val_R+bk_val_R
                       *ELSE
                  sald_val_R=db_val_R-kr_val_R+sump_val_R-sumr_val_R
                       *ENDIF
               IF db_val_U#0.or.kr_val_U#0.or.sump_val#0.or.sumr_val#0.or.sald_val#0
                               * @ nstr,n5a SAY fvid_val
                  IF nstr>kolstr
                     nnstr=nnstr+1
                     DO Chap1 WITH nnstr,nstr,nlist
                  ENDIF
                  nstr=nstr+1
                  IF nnstr>=nlist
                     @ nstr,n5a SAY 'USD'
                     @ nstr,n6  SAY db_val_U   PICTURE '9999999999' FUNCTION 'Z'
                     @ nstr,n7  SAY kr_val_U   PICTURE '9999999999' FUNCTION 'Z'
                     @ nstr,n8  SAY sump_val   PICTURE '9999999999' FUNCTION 'Z'
                     @ nstr,n9  SAY sumr_val   PICTURE '9999999999' FUNCTION 'Z'
                     IF sald_val>=0
                           @ nstr,n10 SAY  sald_val PICTURE '9999999999' FUNCTION 'Z'
                     ELSE
                           @ nstr,n11 SAY -sald_val PICTURE '9999999999' FUNCTION 'Z'
                     ENDIF
                   ENDIF
               ENDIF
               IF db_val_R#0.or.kr_val_R#0.or.sump_val_R#0.or.sumr_val_R#0.or.sald_val_R#0
                  IF nstr>kolstr
                     nnstr=nnstr+1
                     DO Chap1 WITH nnstr,nstr,nlist
                  ENDIF
                  nstr=nstr+1
                  IF nnstr>=nlist
                                 * @ nstr,n5a SAY fvid_val
                     @ nstr,n5a SAY 'RUR'
                     @ nstr,n6  SAY db_val_R   PICTURE '9999999999' FUNCTION 'Z'
                     @ nstr,n7  SAY kr_val_R   PICTURE '9999999999' FUNCTION 'Z'
                     @ nstr,n8  SAY sump_val_R PICTURE '9999999999' FUNCTION 'Z'
                     @ nstr,n9  SAY sumr_val_R PICTURE '9999999999' FUNCTION 'Z'
                     IF sald_val_R>=0
                           @ nstr,n10 SAY  sald_val_R PICTURE '9999999999' FUNCTION 'Z'
                     ELSE
                           @ nstr,n11 SAY -sald_val_R PICTURE '9999999999' FUNCTION 'Z'
                     ENDIF
                  ENDIF
               ENDIF
               ffdb=0
               ffkr=0
               fdbv=0
               fkrv=0
               sald_83=0
               fvid_val='USD'
                 DO CASE
                    CASE sald_val>0
                              *ffdb=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1),sald_val) && 1-ое число следующего
                       ffdb=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,sald_val)    && на на последний день месяца
                       fdbv=fdbv+ffdb
                    CASE sald_val<0
                              *ffkr=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1),-sald_val) && 1-ое число следующего
                       ffkr=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,-sald_val)    && на на последний день месяца
                       fkrv=fkrv+ffkr
                 ENDCASE
               fvid_val='RUR'
                 DO CASE
                    CASE sald_val_R>0
                              *ffdb=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1),sald_val_R)
                       ffdb=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,sald_val_R)
                       fdbv=fdbv+ffdb
                    CASE sald_val_R<0
                              *  ffkr=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1),-sald_val_R)
                      ffkr=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,-sald_val_R)
                      fkrv=fkrv+ffkr
                 ENDCASE
               IF nstr>kolstr
                  nnstr=nnstr+1
                  DO Chap1 WITH nnstr,nstr,nlist
               ENDIF
               nstr=nstr+1
               IF nnstr>=nlist
                  @ nstr,n4  SAY 'на конец месяца'
                       * @ nstr,n10 SAY ffdb PICTURE '9999999999' FUNCTION 'Z'
                       * @ nstr,n11 SAY ffkr PICTURE '9999999999' FUNCTION 'Z'
                  @ nstr,n10 SAY fdbv PICTURE '9999999999' FUNCTION 'Z'
                  @ nstr,n11 SAY fkrv PICTURE '9999999999' FUNCTION 'Z'
               ENDIF
                     * sald_83=db1-kr1+sumprs-sumrxs-ffdb+ffkr
               sald_83=db1-kr1+sumprs-sumrxs-fdbv+fkrv       && Разные виды валюты по одному табельному
               IF sald_83#0
                  IF nstr>kolstr
                     nnstr=nnstr+1
                     DO Chap1 WITH nnstr,nstr,nlist
                  ENDIF
                  nstr=nstr+1
                  IF nnstr>=nlist
                     @ nstr,n5  SAY tek_b_23
                     IF sald_83<0
                        @ nstr,n8 SAY -sald_83 PICTURE '9999999999' FUNCTION 'Z'
                     ELSE
                        @ nstr,n9 SAY sald_83 PICTURE '9999999999' FUNCTION 'Z'
                     ENDIF
                  ENDIF
               ENDIF
               FOR i=1 TO klkor
                   IF mkor(i)=tek_b_23
                        EXIT
                   ENDIF
               ENDFOR
               IF i>klkor
                   klkor=i
                   mkor(i)=tek_b_23
               ENDIF
               IF sald_83<0
                   msaldd(i)=msaldd(i)-sald_83
               ELSE
                   msaldk(i)=msaldk(i)+sald_83
               ENDIF
           ENDIF
         IF fprval
            ms1=ms1+db1
            ms2=ms2+kr1
         ELSE
            ms1=ms1+db
            ms2=ms2+kr
         ENDIF
         ms3=ms3+sumprs
         ms4=ms4+sumrxs
         IF fprval
                * ms5=ms5+ffdb
                * ms6=ms6+ffkr
            ms5=ms5+fdbv
            ms6=ms6+fkrv
         ELSE
            IF sald>=0
               ms5=ms5+sald
            ELSE
               ms6=ms6-sald
            ENDIF
         ENDIF
         IF fprval
              ms1_val=ms1_val+db_val_U
              ms2_val=ms2_val+kr_val_U
              ms3_val=ms3_val+sump_val
              ms4_val=ms4_val+sumr_val
              IF sald_val>=0
                   ms5_val=ms5_val+sald_val
              ELSE
                   ms6_val=ms6_val-sald_val
              ENDIF

              ms1_val_R=ms1_val_R+db_val_R
              ms2_val_R=ms2_val_R+kr_val_R
              ms3_val_R=ms3_val_R+sump_val_R
              ms4_val_R=ms4_val_R+sumr_val_R
              IF sald_val_R>=0
                   ms5_val_R=ms5_val_R+sald_val_R
               ELSE
                   ms6_val_R=ms6_val_R-sald_val_R
              ENDIF
         ENDIF
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',123)+IIF(fprval,'------','')
         ENDIF
    ENDSCAN
    mbs1=mbs1+ms1
    mbs2=mbs2+ms2
    mbs3=mbs3+ms3
    mbs4=mbs4+ms4
    mbs5=mbs5+ms5
    mbs6=mbs6+ms6
    IF fprval
         mbs1_val=mbs1_val+ms1_val          && в USD
         mbs2_val=mbs2_val+ms2_val
         mbs3_val=mbs3_val+ms3_val
         mbs4_val=mbs4_val+ms4_val
         mbs5_val=mbs5_val+ms5_val
         mbs6_val=mbs6_val+ms6_val

         mbs1_val_R=mbs1_val_R+ms1_val_R
         mbs2_val_R=mbs2_val_R+ms2_val_R
         mbs3_val_R=mbs3_val_R+ms3_val_R
         mbs4_val_R=mbs4_val_R+ms4_val_R
         mbs5_val_R=mbs5_val_R+ms5_val_R
         mbs6_val_R=mbs6_val_R+ms6_val_R
    ENDIF
             *   начало вывода данных по подразделению
             *    IF nstr>kolstr
             *         nnstr=nnstr+1
             *         DO Chap1 WITH nnstr,nstr,nlist
             *    ENDIF
             *    nstr=nstr+1
             *    IF nnstr>=nlist
             *         @ nstr,n1  SAY "Итого по подpазделению "+fcex
             *         @ nstr,n6  SAY ms1 PICTURE '999999999999.99' FUNCTION 'Z'
             *         @ nstr,n7  SAY ms2 PICTURE '999999999999.99' FUNCTION 'Z'
             *         @ nstr,n8  SAY ms3 PICTURE '999999999999.99' FUNCTION 'Z'
             *         @ nstr,n9  SAY ms4 PICTURE '999999999999.99' FUNCTION 'Z'
             *         @ nstr,n10 SAY ms5 PICTURE '999999999999.99' FUNCTION 'Z'
             *         @ nstr,n11 SAY ms6 PICTURE '999999999999.99' FUNCTION 'Z'
             *    ENDIF
             *    IF fprval
             *         IF nstr>kolstr
             *              nnstr=nnstr+1
             *              DO Chap1 WITH nnstr,nstr,nlist
             *         ENDIF
             *         nstr=nstr+1
             *         IF nnstr>=nlist
             *                  * @ nstr,n5a SAY fvid_val
             *              IF ms1_val # 0.or.ms2_val # 0.or.ms3_val # 0.or.ms4_val # 0.or.ms5_val # 0.or.ms6_val # 0
             *              @ nstr,n5a SAY 'USD'
             *              @ nstr,n6  SAY ms1_val PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n7  SAY ms2_val PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n8  SAY ms3_val PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n9  SAY ms4_val PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n10 SAY ms5_val PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n11 SAY ms6_val PICTURE '999999999999.99' FUNCTION 'Z'
             *              ENDIF
             *         ENDIF
             *         IF nstr>kolstr
             *              nnstr=nnstr+1
             *              DO Chap1 WITH nnstr,nstr,nlist
             *         ENDIF
             *         nstr=nstr+1
             *         IF nnstr>=nlist
             *              IF ms1_val_R # 0.or.ms2_val_R # 0.or.ms3_val_R # 0.or.ms4_val_R # 0.or.;
             *                 ms5_val_R # 0.or.ms6_val_R # 0
             *              @ nstr,n5a SAY 'RUR'
             *              @ nstr,n6  SAY ms1_val_R PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n7  SAY ms2_val_R PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n8  SAY ms3_val_R PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n9  SAY ms4_val_R PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n10 SAY ms5_val_R PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n11 SAY ms6_val_R PICTURE '999999999999.99' FUNCTION 'Z'
             *              ENDIF
             *         ENDIF
             *    ENDIF
             *    pr_per=.T.
             *    FOR i=1 TO kolcex
             *         IF nstr>kolstr
             *              nnstr=nnstr+1
             *              DO Chap1 WITH nnstr,nstr,nlist
             *         ENDIF
             *         nstr=nstr+1
             *         IF nnstr>=nlist
             *              IF pr_per
             *                   @ nstr,n1+10 SAY "в т.ч. по кор.счету"
             *                   pr_per=.F.
             *              ENDIF
             *              @ nstr,n3 SAY mcex(i,1)
             *              @ nstr,n8 SAY mcex(i,3) PICTURE '999999999999.99' FUNCTION 'Z'
             *              @ nstr,n9 SAY mcex(i,2) PICTURE '999999999999.99' FUNCTION 'Z'
             *         ENDIF
             *    ENDFOR
             *    IF nstr>kolstr
             *         nnstr=nnstr+1
             *         DO Chap1 WITH nnstr,nstr,nlist
             *    ENDIF
             *    nstr=nstr+1
             *    IF nnstr>=nlist
             *         @ nstr,0 SAY REPLICATE('=',157)+IIF(fprval,'======','')
             *    ENDIF
             *  конец вывода данных по подразделению
    IF ffnsk#' '
         EJECT
         RETURN
    ENDIF
ENDDO
IF nstr>kolstr
     nnstr=nnstr+1
     DO Chap1 WITH nnstr,nstr,nlist
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1  SAY "Всего по "+ff
    @ nstr,n6  SAY mbs1 PICTURE '9999999999' FUNCTION 'Z'
    @ nstr,n7  SAY mbs2 PICTURE '9999999999' FUNCTION 'Z'
    @ nstr,n8  SAY mbs3 PICTURE '9999999999' FUNCTION 'Z'
    @ nstr,n9  SAY mbs4 PICTURE '9999999999' FUNCTION 'Z'
    @ nstr,n10 SAY mbs5 PICTURE '9999999999' FUNCTION 'Z'
    @ nstr,n11 SAY mbs6 PICTURE '9999999999' FUNCTION 'Z'
ENDIF
IF fprval
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
     IF mbs1_val#0.OR.mbs2_val#0.OR.mbs3_val#0.OR.mbs4_val#0.OR.mbs5_val#0.OR.;
        mbs6_val#0
          @ nstr,n5a SAY 'USD'
          @ nstr,n6  SAY mbs1_val PICTURE '9999999999' FUNCTION 'Z'
          @ nstr,n7  SAY mbs2_val PICTURE '9999999999' FUNCTION 'Z'
          @ nstr,n8  SAY mbs3_val PICTURE '9999999999' FUNCTION 'Z'
          @ nstr,n9  SAY mbs4_val PICTURE '9999999999' FUNCTION 'Z'
          @ nstr,n10 SAY mbs5_val PICTURE '9999999999' FUNCTION 'Z'
          @ nstr,n11 SAY mbs6_val PICTURE '9999999999' FUNCTION 'Z'
     ENDIF
    ENDIF
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
     IF mbs1_val_R#0.OR.mbs2_val_R#0.OR.mbs3_val_R#0.OR.mbs4_val_R#0.OR.mbs5_val_R#0.OR.;
        mbs6_val_R#0
         @ nstr,n5a SAY 'RUR'
         @ nstr,n6  SAY mbs1_val_R PICTURE '9999999999' FUNCTION 'Z'
         @ nstr,n7  SAY mbs2_val_R PICTURE '9999999999' FUNCTION 'Z'
         @ nstr,n8  SAY mbs3_val_R PICTURE '9999999999' FUNCTION 'Z'
         @ nstr,n9  SAY mbs4_val_R PICTURE '9999999999' FUNCTION 'Z'
         @ nstr,n10 SAY mbs5_val_R PICTURE '9999999999' FUNCTION 'Z'
         @ nstr,n11 SAY mbs6_val_R PICTURE '9999999999' FUNCTION 'Z'
     ENDIF
    ENDIF
             *   IF nstr>kolstr
             *        nnstr=nnstr+1
             *        DO Chap1 WITH nnstr,nstr,nlist
             *   ENDIF
             *   nstr=nstr+1
             *   IF nnstr>=nlist
             *        @ nstr,n1  SAY 'Дооценка на конец месяца'
             *        @ nstr,n10 SAY fdbv-mbs5 PICTURE '999999999999.99' FUNCTION 'Z'
             *        @ nstr,n11 SAY fkrv-mbs6 PICTURE '999999999999.99' FUNCTION 'Z'
             *   ENDIF
             *   IF nstr>kolstr
             *        nnstr=nnstr+1
             *        DO Chap1 WITH nnstr,nstr,nlist
             *   ENDIF
             *   nstr=nstr+1
             *   IF nnstr>=nlist
             *        sss=fdbv-mbs5-fkrv+mbs6
             *        @ nstr,n4 SAY tek_b_23
             *        IF sss>0
             *             @ nstr,n10 SAY  sss PICTURE '999999999999.99' FUNCTION 'Z'
             *        ELSE
             *             @ nstr,n11 SAY -sss PICTURE '999999999999.99' FUNCTION 'Z'
             *        ENDIF
             *   ENDIF
ENDIF
* сортировка массива
DIMENSION mkorr(100,3)
mkorr=0
FOR j=1 TO klkor
    fmin='9999'
    imin=0
    FOR i=1 TO klkor
         IF fmin>mkor(i)
              fmin=mkor(i)
              imin=i
         ENDIF
    ENDFOR
    mkorr(j,1)=mkor(imin)
    mkorr(j,2)=msaldd(imin)
    mkorr(j,3)=msaldk(imin)
    mkor(imin)='9999'
    msaldd(imin)=0
    msaldk(imin)=0
ENDFOR
FOR i=1 TO klkor
    mkor(i)=mkorr(i,1)
    msaldd(i)=mkorr(i,2)
    msaldk(i)=mkorr(i,3)
ENDFOR
* конец сортировки
IF klkor>0
    fkr=LEFT(mkor(1),2)
ENDIF
fsumd=0
fsumk=0
kol_kr=0
pr_per=.T.
FOR i=1 TO klkor
    IF fkr#LEFT(mkor(i),2)
         IF kol_kr>1
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n2+15 SAY 'всего по'
                   @ nstr,n4 SAY fkr
                   @ nstr,n8 SAY fsumd PICTURE '9999999999' FUNCTION 'Z'
                   @ nstr,n9 SAY fsumk PICTURE '9999999999' FUNCTION 'Z'
              ENDIF
         ENDIF
         fkr=LEFT(mkor(i),2)
         fsumd=0
         fsumk=0
         kol_kr=0
    ENDIF
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
         @ nstr,n4 SAY mkor(i)
         @ nstr,n8 SAY msaldd(i) PICTURE '9999999999' FUNCTION 'Z'
         @ nstr,n9 SAY msaldk(i) PICTURE '9999999999' FUNCTION 'Z'
    ENDIF
    kol_kr=kol_kr+1
    fsumd=fsumd+msaldd(i)
    fsumk=fsumk+msaldk(i)
ENDFOR
IF kol_kr>1
    IF fsumk#0.OR.fsumd#0
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
          ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n2+15 SAY 'всего по'
              @ nstr,n4 SAY fkr
              @ nstr,n8 SAY fsumd PICTURE '9999999999' FUNCTION 'Z'
              @ nstr,n9 SAY fsumk PICTURE '9999999999' FUNCTION 'Z'
         ENDIF
    ENDIF
ENDIF
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
       @ nstr,n2+15 SAY "из них по хоз. расходам"
       @ nstr,n8 SAY sum_xozd PICTURE '9999999999' FUNCTION 'Z'
       @ nstr,n9 SAY sum_xozk PICTURE '9999999999' FUNCTION 'Z'
    ENDIF
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
       @ nstr,n2+15 SAY 'всего по авансовым отчетам'
       @ nstr,n9 SAY sum_av PICTURE '9999999999' FUNCTION 'Z'
    ENDIF
    RELEASE ALL LIKE tek_b_??
EJECT

* вывод по корреспондирующим счетам
*n12=2
*n13=7
*n14=26
*n15=45
*n16=64
*n17=83
*n18=102
*   @ 1,0 SAY "Сводная ведомость движения по балансовому счету "+ff+' за месяц '+tmec+' '+nastf_b+' г.'
*   @ 2,0 SAY REPLICATE('-',119)
*   @ 3,0 SAY '|Коpp|      Сальдо на начало месяца        |'+SPACE(11)+'Обоpот за месяц'+SPACE(11)+'|       Сальдо на  конец месяца      |'
*   @ 4,0 SAY '|счет|-------------------------------------|-------------------------------------|'+'------------------------------------|'
*   @ 5,0 SAY '|    |      Дебет       |      Кредит      |      Дебет       |'+'      Кpедит      |'+'      Дебет       |      Кредит      '
*   @ 6,0 SAY REPLICATE('-',119)
*   nstr=6
*nstr=nstr+1
*FOR i=1 TO klkor
*         @ nstr,n12 SAY mkor(i)+ REPLICATE('.',38)
*         @ nstr,n15 SAY msaldd(i) PICTURE '999999999999.99' FUNCTION 'Z'
*         @ nstr,n16 SAY msaldk(i) PICTURE '999999999999.99' FUNCTION 'Z'
*         nstr=nstr+1
*ENDFOR
*nstr=nstr+1
*@ nstr,0 SAY REPLICATE('-',119)
*nstr=nstr+1
*    @ nstr,n1  SAY "Всего по "+ff
*    @ nstr,n13  SAY mbs1 PICTURE '999999999999.99' FUNCTION 'Z'
*    @ nstr,n14  SAY mbs2 PICTURE '999999999999.99' FUNCTION 'Z'
*    @ nstr,n15  SAY mbs3 PICTURE '999999999999.99' FUNCTION 'Z'
*    @ nstr,n16  SAY mbs4 PICTURE '999999999999.99' FUNCTION 'Z'
*    @ nstr,n17  SAY mbs5 PICTURE '999999999999.99' FUNCTION 'Z'
*    @ nstr,n18  SAY mbs6 PICTURE '999999999999.99' FUNCTION 'Z'
*IF fprval
*    nstr=nstr+1
*    IF mbs1_val#0.OR.mbs2_val#0.OR.mbs3_val#0.OR.mbs4_val#0.OR.mbs5_val#0.OR.;
*       mbs6_val#0
*          @ nstr,n12  SAY 'USD'
*          @ nstr,n13  SAY mbs1_val PICTURE '999999999999.99' FUNCTION 'Z'
*          @ nstr,n14  SAY mbs2_val PICTURE '999999999999.99' FUNCTION 'Z'
*          @ nstr,n15  SAY mbs3_val PICTURE '999999999999.99' FUNCTION 'Z'
*          @ nstr,n16  SAY mbs4_val PICTURE '999999999999.99' FUNCTION 'Z'
*          @ nstr,n17  SAY mbs5_val PICTURE '999999999999.99' FUNCTION 'Z'
*          @ nstr,n18  SAY mbs6_val PICTURE '999999999999.99' FUNCTION 'Z'
*     ENDIF
*     nstr=nstr+1
*     IF mbs1_val_R#0.OR.mbs2_val_R#0.OR.mbs3_val_R#0.OR.mbs4_val_R#0.OR.mbs5_val_R#0.OR.;
*        mbs6_val_R#0
*         @ nstr,n12  SAY 'RUR'
*         @ nstr,n13  SAY mbs1_val_R PICTURE '999999999999.99' FUNCTION 'Z'
*         @ nstr,n14  SAY mbs2_val_R PICTURE '999999999999.99' FUNCTION 'Z'
*         @ nstr,n15  SAY mbs3_val_R PICTURE '999999999999.99' FUNCTION 'Z'
*         @ nstr,n16  SAY mbs4_val_R PICTURE '999999999999.99' FUNCTION 'Z'
*         @ nstr,n17  SAY mbs5_val_R PICTURE '999999999999.99' FUNCTION 'Z'
*         @ nstr,n18  SAY mbs6_val_R PICTURE '999999999999.99' FUNCTION 'Z'
*     ENDIF
*ENDIF
*RELEASE ALL LIKE tek_b_??
*EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 1,2 SAY "Лист "+STR(nst,2)
         *@ 1,30 SAY "Оборотная ведомость движения денежных средств по командировкам по бал.счету "+ff+' за месяц '+tmec +' '+ nastf_b +' г.'
    @ 1,30 SAY "Журнал - ордер № 7  по балансовому счету "+ff+' за месяц '+tmec +' '+ nastf_b +' г.'
    @ 2,0 SAY REPLICATE('-',123)+IIF(fprval,'-------','')
    @ 3,0 SAY '      |                         |          |     |      |'+IIF(fprval,'      |','')+'  Сальдо на начало   |      Оборот         |    Сальдо на конец  |'
    @ 4,0 SAY 'Табел |  Фамилия, имя, отчество |   Дата   |Hомер| Hомер|'+IIF(fprval,' Вид  |','')+'─────────────────────|─────────────────────|─────────────────────|'
    @ 5,0 SAY 'номер |                         |          |докум| счета|'+IIF(fprval,'валюты|','')+'   Дебет  |  Кредит  |  Дебет   |  Кредит  |   Дебет  |  Кредит  |'
    @ 6,0 SAY REPLICATE('-',123)+IIF(fprval,'-------','')
ENDIF
nstr=6
RETURN