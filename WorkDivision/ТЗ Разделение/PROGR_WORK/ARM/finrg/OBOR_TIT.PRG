DIMENSION mkor(100),msaldd(100),msaldk(100)
PRIVATE i,fprval;
SET PROCEDURE TO obor_tit
RESTORE FROM tek_b ADDITIVE
i=0
fprval=.F.
IF nastf_8=1.AND.spr_bs.pr_val='1'
    fprval=.T.
ENDIF
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
ftab=''
GO TOP
 *fvid_val=vid_val
fvid_val=''
DO WHILE !EOF()
   sumprs=0
   sumrxs=0
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
   ftab=tab
     SELECT bk
     SET ORDER TO bk2
     SET EXACT OFF
     SEEK ff+ftab
     SET EXACT ON
     SCAN REST WHILE ff=kor.AND.ftab=LEFT(kp,6) FOR MONTH(dat)=ntmec.AND.YEAR(dat)=tgod.AND.pr_spr='0'.AND.!DELETE()
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
           sumrxs=sumrxs+sm+Delta
           IF fprval
              IF bk.vid_val='USD'
                 sumr_val=sumr_val+sm_val
              ELSE
                 IF bk.vid_val='RUR'
                    sumr_val_R=sumr_val_R+sm_val
                 ENDIF
              ENDIF
           ENDIF
        ELSE
           msaldd(i)=msaldd(i)+sm+Delta
           sumprs=sumprs+sm+Delta
           IF fprval
              IF bk.vid_val='USD'
                 sump_val=sump_val+sm_val
              ELSE
                 IF bk.vid_val='RUR'
                    sump_val_R=sump_val_R+sm_val
                 ENDIF
              ENDIF
           ENDIF
        ENDIF
     ENDSCAN

     SET ORDER TO kp
     SET EXACT OFF
     SEEK ff+ftab
     SET EXACT ON
     SCAN REST WHILE ff=nzk.AND.ftab=LEFT(kp,6) FOR MONTH(dat)=ntmec.AND.YEAR(dat)=tgod.AND.pr_spr='0'.AND.!DELETE()
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
           sumrxs=sumrxs+sm+Delta
           IF fprval
              IF bk.vid_val='USD'
                 sumr_val=sumr_val+sm_val
              ELSE
                 IF bk.vid_val='RUR'
                    sumr_val_R=sumr_val_R+sm_val
                 ENDIF
              ENDIF
           ENDIF
        ELSE
           msaldd(i)=msaldd(i)+sm+Delta
           sumprs=sumprs+sm+Delta
           IF fprval
              IF bk.vid_val='USD'
                 sump_val=sump_val+sm_val
              ELSE
                 IF bk.vid_val='RUR'
                    sump_val_R=sump_val_R+sm_val
                 ENDIF
              ENDIF
           ENDIF
        ENDIF
     ENDSCAN

     SELECT avotr
     SET EXACT OFF
     SEEK ff+ftab
     SET EXACT ON
     SCAN REST WHILE ff=bs.AND.ftab=tab FOR !DELETE()
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
        sumrxs=sumrxs+smk
        IF fprval
           IF avotr.vid_val='USD'
              sumr_val=sumr_val+sm_val
           ELSE
              IF avotr.vid_val='RUR'
                 sumr_val_R=sumr_val_R+sm_val
              ENDIF
           ENDIF
        ENDIF
     ENDSCAN

     SELECT yd_71
     SET EXACT OFF
     SEEK ff+ftab
     SET EXACT ON
     SCAN REST WHILE ff=bs.AND.ftab=tbn FOR !DELETE()
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
           sumrxs=sumrxs+symk
        ELSE
           msaldd(i)=msaldd(i)-symk
           sumprs=sumprs-symk
        ENDIF
     ENDSCAN

     SELECT vn_71
     SET EXACT OFF
     SEEK ff+ftab
     SET EXACT ON
       SCAN REST WHILE ff=bs.AND.ftab=tabo FOR !DELETE()
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
          sumrxs=sumrxs+summa
          IF fprval
             IF vn_71.vid_val='USD'
                sumr_val=sumr_val+sm_val
             ELSE
                IF vn_71.vid_val='RUR'
                   sumr_val_R=sumr_val_R+sm_val
                ENDIF
             ENDIF
          ENDIF
       ENDSCAN

       SET ORDER TO bs_tabp
       SET EXACT OFF
       SEEK ff+ftab
       SET EXACT ON
       SCAN REST WHILE ff=bs.AND.ftab=tabp FOR !DELETE()
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
          sumprs=sumprs+summa
          IF fprval
             IF vn_71.vid_val='USD'
                sump_val=sump_val+sm_val
             ELSE
                IF vn_71.vid_val='RUR'
                    sump_val_R=sump_val_R+sm_val
                 ENDIF
              ENDIF
          ENDIF
       ENDSCAN

       SELECT ostrkr
         sald_U=0
         sald_R=0
         db1=0
         kr1=0
         IF fprval
            SCAN REST WHILE ff=bs.AND.ftab=LEFT(tab,6)
               IF vid_val = 'USD'
                    db_val_U =db_val_U+db_val   && остатки на начало месяца есть в RUR,USD
                    kr_val_U =kr_val_U+kr_val
                    db_val=0
                    kr_val=0
               ELSE
                    db_val_R =db_val_R+db_val
                    kr_val_R =kr_val_R+kr_val
                    db_val=0
                    kr_val=0
               ENDIF
               db1=db1+db
               kr1=kr1+kr
            ENDSCAN
            SKIP -1
            sald=db1-kr1+sumprs-sumrxs
            sald_val=db_val_U-kr_val_U+sump_val-sumr_val
            sald_val_R=db_val_R-kr_val_R+sump_val_R-sumr_val_R
         ELSE
            sald=db-kr+sumprs-sumrxs
         ENDIF
         IF fprval
            ffdb=0
            ffkr=0
            fdbv=0
            fkrv=0
            sald_83=0
            fvid_val='USD'
            if sald_val#0.or.sald_val_R#0
             DO CASE
                CASE sald_val>0
                  ffdb=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,sald_val)    && на на последний день месяца
                  fdbv=fdbv+ffdb
                CASE sald_val<0
                  ffkr=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,-sald_val)    && на на последний день месяца
                  fkrv=fkrv+ffkr
             ENDCASE
             fvid_val='RUR'
             DO CASE
                CASE sald_val_R>0
                  ffdb=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,sald_val_R)
                  fdbv=fdbv+ffdb
                CASE sald_val_R<0
                  ffkr=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,-sald_val_R)
                  fkrv=fkrv+ffkr
             ENDCASE
            endif
                * sald_83=db1-kr1+sumprs-sumrxs-ffdb+ffkr
            sald_83=db1-kr1+sumprs-sumrxs-fdbv+fkrv       && Разные виды валюты по одному табельному
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
            mbs1=mbs1+db1
            mbs2=mbs2+kr1
         ELSE
            mbs1=mbs1+db
            mbs2=mbs2+kr
         ENDIF
         mbs3=mbs3+sumprs
         mbs4=mbs4+sumrxs
         IF fprval
            IF sald_83<0
               mbs3=mbs3-sald_83
            ELSE
               mbs4=mbs4+sald_83
            ENDIF
         ENDIF
         IF fprval
                * mbs5=mbs5+ffdb  && если один вид валюты
                * mbs6=mbs6+ffkr
            mbs5=mbs5+fdbv
            mbs6=mbs6+fkrv
         ELSE
          IF sald>=0
               mbs5=mbs5+sald
          ELSE
               mbs6=mbs6-sald
          ENDIF
         ENDIF
         IF fprval
              mbs1_val=mbs1_val+db_val_U
              mbs2_val=mbs2_val+kr_val_U
              mbs3_val=mbs3_val+sump_val
              mbs4_val=mbs4_val+sumr_val
              IF sald_val>=0
                   mbs5_val=mbs5_val+sald_val
              ELSE
                   mbs6_val=mbs6_val-sald_val
              ENDIF

              mbs1_val_R=mbs1_val_R+db_val_R
              mbs2_val_R=mbs2_val_R+kr_val_R
              mbs3_val_R=mbs3_val_R+sump_val_R
              mbs4_val_R=mbs4_val_R+sumr_val_R
              IF sald_val_R>=0
                   mbs5_val_R=mbs5_val_R+sald_val_R
               ELSE
                   mbs6_val_R=mbs6_val_R-sald_val_R
              ENDIF
         ENDIF
         skip
ENDDO
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
* вывод по корреспондирующим счетам
n1=2
n2=7
n3=26
n4=45
n5=64
n6=83
n7=102
 @ 07,0 SAY "Сводная ведомость движения по балансовому счету "+ff+' за месяц '+tmec+' '+nastf_b+' г.'
 ?
 ?
 @ 10,0 SAY REPLICATE('-',119)
 @ 11,0 SAY '|Коpp|      Сальдо на начало месяца        |'+SPACE(11)+'Обоpот за месяц'+SPACE(11)+'|       Сальдо на  конец месяца      |'
 @ 12,0 SAY '|счет|-------------------------------------|-------------------------------------|'+'------------------------------------|'
 @ 13,0 SAY '|    |      Дебет       |      Кредит      |      Дебет       |'+'      Кpедит      |'+'      Дебет       |      Кредит      '
 @ 14,0 SAY REPLICATE('-',119)
 nstr=14
nstr=nstr+1
FOR i=1 TO klkor
    @ nstr,n1 SAY mkor(i)+ REPLICATE('.',38)
    @ nstr,n4 SAY msaldd(i) PICTURE '999999999999.99' FUNCTION 'Z'
    @ nstr,n5 SAY msaldk(i) PICTURE '999999999999.99' FUNCTION 'Z'
    nstr=nstr+1
ENDFOR
nstr=nstr+1
  @ nstr,0 SAY REPLICATE('-',119)
nstr=nstr+1
  @ nstr,n1  SAY "Всего по "+ff
nstr=nstr+1
  @ nstr,n2  SAY mbs1 PICTURE '999999999999.99' FUNCTION 'Z'
  @ nstr,n3  SAY mbs2 PICTURE '999999999999.99' FUNCTION 'Z'
  @ nstr,n4  SAY mbs3 PICTURE '999999999999.99' FUNCTION 'Z'
  @ nstr,n5  SAY mbs4 PICTURE '999999999999.99' FUNCTION 'Z'
  @ nstr,n6  SAY mbs5 PICTURE '999999999999.99' FUNCTION 'Z'
  @ nstr,n7  SAY mbs6 PICTURE '999999999999.99' FUNCTION 'Z'
IF fprval
    nstr=nstr+1
    IF mbs1_val#0.OR.mbs2_val#0.OR.mbs3_val#0.OR.mbs4_val#0.OR.mbs5_val#0.OR.;
       mbs6_val#0
          @ nstr,n1  SAY 'USD'
          @ nstr,n2  SAY mbs1_val PICTURE '999999999999.99' FUNCTION 'Z'
          @ nstr,n3  SAY mbs2_val PICTURE '999999999999.99' FUNCTION 'Z'
          @ nstr,n4  SAY mbs3_val PICTURE '999999999999.99' FUNCTION 'Z'
          @ nstr,n5  SAY mbs4_val PICTURE '999999999999.99' FUNCTION 'Z'
          @ nstr,n6  SAY mbs5_val PICTURE '999999999999.99' FUNCTION 'Z'
          @ nstr,n7  SAY mbs6_val PICTURE '999999999999.99' FUNCTION 'Z'
     ENDIF
     nstr=nstr+1
     IF mbs1_val_R#0.OR.mbs2_val_R#0.OR.mbs3_val_R#0.OR.mbs4_val_R#0.OR.mbs5_val_R#0.OR.;
        mbs6_val_R#0
         @ nstr,n1  SAY 'RUR'
         @ nstr,n2  SAY mbs1_val_R PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n3  SAY mbs2_val_R PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n4  SAY mbs3_val_R PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n5  SAY mbs4_val_R PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n6  SAY mbs5_val_R PICTURE '999999999999.99' FUNCTION 'Z'
         @ nstr,n7  SAY mbs6_val_R PICTURE '999999999999.99' FUNCTION 'Z'
     ENDIF
ENDIF
RELEASE ALL LIKE tek_b_??
EJECT
RETURN
*