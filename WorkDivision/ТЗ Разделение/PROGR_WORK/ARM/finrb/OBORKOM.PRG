DIMENSION mkor(100,3)
PRIVATE ii
n1=1
n2=9
n3=40
n4=51
n5=60
i=0
fprval=.F.
IF nastf_8=1.AND.spr_bs.pr_val='1'
    fprval=.T.
    i=7
    n5a=67
ENDIF
n6=67+i
n7=86+i
n8=105+i
n9=124+i
n10=143+i
n11=162+i
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
fdbv=0
fkrv=0
mkor=0
nnstr=0
nstr=kolstr+1
ii=0
fvid_val=vid_val
DO WHILE !EOF()
    mkl1=0
    mkl2=0
    mkl3=0
    mkl4=0
    mkl5=0
    mkl6=0
    ms1_val=0
    ms2_val=0
    ms3_val=0
    ms4_val=0
    ms5_val=0
    ms6_val=0
    ffdbv=0
    ffkrv=0
    fkp=kp
    pr_per=.T.
    pr_kp=.T.
    fpr_spr=pr_spr
    DO WHILE fkp=kp.AND.!EOF()
         IF EMPTY(fvid_val)
              fvid_val=vid_val
         ENDIF
         fdog=dog
         ml1=0
         ml2=0
         ml3=0
         ml4=0
         ml5=0
         ml6=0
         m1_val=0
         m2_val=0
         m3_val=0
         m4_val=0
         m5_val=0
         m6_val=0
         SCAN REST WHILE fkp=kp.AND.IIF(tek_b_15=1,.T.,fdog=dog)
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              SELECT bkr
              SET EXACT OFF
              IF tek_b_15=1
                   SEEK fkp
              ELSE
                   SEEK fkp+fdog
              ENDIF
              SET EXACT ON
              SCAN REST WHILE fkp=kp.AND.IIF(tek_b_15=1,.T.,fdog=dog)
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        IF pr_kp=.T.
                             @ nstr,n1 SAY kp
                             @ nstr,n2 SAY Spr_nam(pr_spr,kp,30)
                             pr_kp=.F.
                        ENDIF
                        @ nstr,n3 SAY dog
                        @ nstr,n4 SAY dat
                        @ nstr,n5 SAY IIF(ff=kor,nzk,kor)
                        IF vo='0'.AND.ff=kor.OR.vo='1'.AND.ff=nzk
                             @ nstr,n9 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        ELSE
                             @ nstr,n8 SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        ENDIF
                   ENDIF
                   IF fprval
                        IF EMPTY(fvid_val)
                             fvid_val=vid_val
                        ENDIF
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n5a SAY vid_val
                             @ nstr,IIF(vo='0'.AND.ff=kor.OR.vo='1'.AND.ff=nzk,n9,n8) SAY sm_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        ENDIF
                   ENDIF
                   IF vo='0'.AND.ff=kor.OR.vo='1'.AND.ff=nzk
                        ml4=ml4+sm+Delta
                        m4_val=m4_val+sm_val
                   ELSE
                        ml3=ml3+sm+Delta
                        m3_val=m3_val+sm_val
                   ENDIF
                   FOR i=1 TO klkor
                        IF mkor(i,1)=LEFT(nzk,4)
                             EXIT
                        ENDIF
                   ENDFOR
                   IF i>klkor
                        klkor=i
                        mkor(i,1)=LEFT(nzk,4)
                   ENDIF
                   IF vo='0'.AND.ff=kor.OR.vo='1'.AND.ff=nzk
                        mkor(i,3)=mkor(i,3)+sm+Delta
                   ELSE
                        mkor(i,2)=mkor(i,2)+sm+Delta
                   ENDIF
              ENDSCAN
              SELECT dv_pr
              SET ORDER TO bs_kp
              SET EXACT OFF
              IF tek_b_15=1
                   SEEK ff+fkp
              ELSE
                   SEEK ff+fkp+fdog
              ENDIF
              SET EXACT ON
              SCAN REST WHILE ff=bs.AND.fkp=kp.AND.IIF(tek_b_15=1,.T.,fdog=dog) FOR !DELETE()
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        IF pr_kp=.T.
                             @ nstr,n1 SAY kp
                             @ nstr,n2 SAY Spr_nam(pr_spr,kp,30)
                             pr_kp=.F.
                        ENDIF
                        @ nstr,n3 SAY dog
                        @ nstr,n4 SAY dat
                        @ nstr,n5 SAY kor
                        @ nstr,n8 SAY smd PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n9 SAY smk PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        IF nastf_0=1
                             @ nstr,n10 SAY text
                        ENDIF
                        IF fprval
                             IF EMPTY(fvid_val)
                                  fvid_val=vid_val
                             ENDIF
                             nstr=nstr+1
                             IF nnstr>=nlist
                                  @ nstr,n5a SAY vid_val
                                  @ nstr,n8  SAY sm_vald PICTURE '999,999,999,999.99' FUNCTION 'Z'
                                  @ nstr,n9  SAY sm_valk PICTURE '999,999,999,999.99' FUNCTION 'Z'
                             ENDIF
                        ENDIF
                   ENDIF
                   ml3=ml3+smd
                   m3_val=m3_val+sm_vald
                   ml4=ml4+smk
                   m4_val=m4_val+sm_valk
                   FOR i=1 TO klkor
                        IF mkor(i,1)=kor
                             EXIT
                        ENDIF
                   ENDFOR
                   IF i>klkor
                        klkor=i
                        mkor(i,1)=kor
                   ENDIF
                   mkor(i,2)=mkor(i,2)+smd
                   mkor(i,3)=mkor(i,3)+smk
              ENDSCAN
              SET ORDER TO kor_kp
              SET EXACT OFF
              IF tek_b_15=1
                   SEEK ff+fkp
              ELSE
                   SEEK ff+fkp+fdog
              ENDIF
              SET EXACT ON
              SCAN REST WHILE ff=kor.AND.fkp=kp.AND.IIF(tek_b_15=1,.T.,fdog=dog) FOR !DELETE()
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        IF pr_kp=.T.
                             @ nstr,n1 SAY kp
                             @ nstr,n2 SAY Spr_nam(pr_spr,kp,30)
                             pr_kp=.F.
                        ENDIF
                        @ nstr,n3 SAY dog
                        @ nstr,n4 SAY dat
                        @ nstr,n5 SAY bs
                        @ nstr,n8 SAY smk PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n9 SAY smd PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        IF nastf_0=1
                             @ nstr,n10 SAY text
                        ENDIF
                        IF fprval
                             IF EMPTY(fvid_val)
                                  fvid_val=vid_val
                             ENDIF
                             nstr=nstr+1
                             IF nnstr>=nlist
                                  @ nstr,n5a SAY vid_val
                                  @ nstr,n8  SAY sm_valk PICTURE '999,999,999,999.99' FUNCTION 'Z'
                                  @ nstr,n9  SAY sm_vald PICTURE '999,999,999,999.99' FUNCTION 'Z'
                             ENDIF
                        ENDIF
                   ENDIF
                   ml3=ml3+smk
                   m3_val=m3_val+sm_valk
                   ml4=ml4+smd
                   m4_val=m4_val+sm_vald
                   FOR i=1 TO klkor
                        IF mkor(i,1)=bs
                             EXIT
                        ENDIF
                   ENDFOR
                   IF i>klkor
                        klkor=i
                        mkor(i,1)=bs
                   ENDIF
                   mkor(i,2)=mkor(i,2)+smk
                   mkor(i,3)=mkor(i,3)+smd
              ENDSCAN
              SELECT osd_prr
              sald=db-kr+ml3-ml4
              ml1=ml1+db
              ml2=ml2+kr
              IF sald>0
                   ml5=ml5+sald
              ELSE
                   ml6=ml6-sald
              ENDIF
              IF fprval
                   sald_val=sm_vald-sm_valk+m3_val-m4_val
                   m1_val=m1_val+sm_vald
                   m2_val=m2_val+sm_valk
                   IF sald_val>0
                        m5_val=m5_val+sald_val
                   ELSE
                        m6_val=m6_val-sald_val
                   ENDIF
              ENDIF
         ENDSCAN
         ffdb=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,m5_val)
         ffkr=Kurs_dat(fvid_val,GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,m6_val)
         IF tek_b_15=0
              IF ml3#0.OR.ml4#0
                   DO Chap2 WITH nnstr,nstr,nlist
              ENDIF
              pr_per=.F.
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1  SAY "Итого по договору N "+fdog
                   @ nstr,n6  SAY ml1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n7  SAY ml2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n8  SAY ml3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n9  SAY ml4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n10 SAY ml5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n11 SAY ml6 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
              IF fprval
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n5a SAY fvid_val
                        @ nstr,n6  SAY m1_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n7  SAY m2_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n8  SAY m3_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n9  SAY m4_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n10 SAY m5_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n11 SAY m6_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n4  SAY 'на конец месяца'
                        @ nstr,n10 SAY ffdb PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n11 SAY ffkr PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
              ENDIF
              DO Chap2 WITH nnstr,nstr,nlist
         ENDIF
         mkl1=mkl1+ml1
         mkl2=mkl2+ml2
         mkl3=mkl3+ml3
         mkl4=mkl4+ml4
         mkl5=mkl5+ml5
         mkl6=mkl6+ml6
         IF fprval
              ms1_val=ms1_val+m1_val
              ms2_val=ms2_val+m2_val
              ms3_val=ms3_val+m3_val
              ms4_val=ms4_val+m4_val
              ms5_val=ms5_val+m5_val
              ms6_val=ms6_val+m6_val
              ffdbv=ffdbv+ffdb
              ffkrv=ffkrv+ffkr
         ENDIF
    ENDDO
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
    ENDIF
    IF tek_b_15=1.AND.!pr_kp
         DO Chap2 WITH nnstr,nstr,nlist
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1  SAY "Итого по организации "+fkp+" "+Spr_nam(fpr_spr,fkp,30)
         @ nstr,n6  SAY mkl1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n7  SAY mkl2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n8  SAY mkl3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n9  SAY mkl4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n10 SAY mkl5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n11 SAY mkl6 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    IF fprval
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n5a SAY fvid_val
              @ nstr,n6  SAY ms1_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n7  SAY ms2_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n8  SAY ms3_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n9  SAY ms4_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n10 SAY ms5_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n11 SAY ms6_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n4  SAY 'на конец месяца'
              @ nstr,n10 SAY ffdbv PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n11 SAY ffkrv PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('=',180)+IIF(fprval,'=======','')
    ENDIF
    mbs1=mbs1+mkl1
    mbs2=mbs2+mkl2
    mbs3=mbs3+mkl3
    mbs4=mbs4+mkl4
    mbs5=mbs5+mkl5
    mbs6=mbs6+mkl6
    IF fprval
         mbs1_val=mbs1_val+ms1_val
         mbs2_val=mbs2_val+ms2_val
         mbs3_val=mbs3_val+ms3_val
         mbs4_val=mbs4_val+ms4_val
         mbs5_val=mbs5_val+ms5_val
         mbs6_val=mbs6_val+ms6_val
         fdbv=fdbv+ffdbv
         fkrv=fkrv+ffkrv
    ENDIF
ENDDO
* сортировка массива
DIMENSION mkorr(100,3)
mkorr=0
FOR j=1 TO klkor
    fmin='9999'
    imin=0
    FOR i=1 TO klkor
         IF fmin>mkor(i,1)
              fmin=mkor(i,1)
              imin=i
         ENDIF
    ENDFOR
    mkorr(j,1)=mkor(imin,1)
    mkorr(j,2)=mkor(imin,2)
    mkorr(j,3)=mkor(imin,3)
    mkor(imin,1)='9999'
    mkor(imin,2)=0
    mkor(imin,3)=0
ENDFOR
FOR i=1 TO klkor
    mkor(i,1)=mkorr(i,1)
    mkor(i,2)=mkorr(i,2)
    mkor(i,3)=mkorr(i,3)
ENDFOR
* конец сортировки
nstr=nstr+1
IF nnstr>=nlist
     @ nstr,n1  SAY "Всего по "+ff
     @ nstr,n6  SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n7  SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n8  SAY mbs3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n9  SAY mbs4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n10 SAY mbs5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
     @ nstr,n11 SAY mbs6 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
IF fprval
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n5a SAY fvid_val
         @ nstr,n6  SAY mbs1_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n7  SAY mbs2_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n8  SAY mbs3_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n9  SAY mbs4_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n10 SAY mbs5_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n11 SAY mbs6_val PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1  SAY 'Дооценка на конец месяца'
         @ nstr,n10 SAY fdbv-mbs5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n11 SAY fkrv-mbs6 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         sss=fdbv-mbs5-fkrv+mbs6
         @ nstr,n4 SAY tek_b_23
         IF sss>0
              @ nstr,n10 SAY  sss PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ELSE
              @ nstr,n11 SAY -sss PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
    ENDIF
ENDIF
IF klkor>0
    fkr=LEFT(mkor(1,1),2)
ENDIF
fsumd=0
fsumk=0
kol_kr=0
pr_per=.T.
FOR i=1 TO klkor
    IF fkr#LEFT(mkor(i,1),2)
         IF kol_kr>1
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n2+15 SAY 'всего по'
                   @ nstr,n4 SAY fkr
                   @ nstr,n8 SAY fsumd PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n9 SAY fsumk PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
         ENDIF
         fkr=LEFT(mkor(i,1),2)
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
         @ nstr,n4 SAY mkor(i,1)
         @ nstr,n8 SAY mkor(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n9 SAY mkor(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    kol_kr=kol_kr+1
    fsumd=fsumd+mkor(i,2)
    fsumk=fsumk+mkor(i,3)
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
              @ nstr,n3 SAY fkr
              @ nstr,n4 SAY fsumd PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n5 SAY fsumk PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
    ENDIF
ENDIF
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,2 SAY "Лист "+STR(nst,2)
    @ 0,30 SAY "Оборотная ведомость движения денежных средств по бал.счету "+ff+' за месяц '+tmec
    @ 1,0 SAY REPLICATE('-',181)+IIF(fprval,'-------','')
    @ 2,0 SAY '|       |                              |          |        |      |'+IIF(fprval,'      |','')+'         Сальдо   на   начало        |               Оборот                |         Сальдо   на    конец        |'
    @ 3,0 SAY '|  Код  |   Hаименование организации   |   Hомер  |  Дата  | Hомер|'+IIF(fprval,' Вид  |','')+'-------------------------------------|-------------------------------------|-------------------------------------|'
    @ 4,0 SAY '|организ|                              | договора |        | cчета|'+IIF(fprval,'валюты|','')+'       Дебет      |      Кредит      |      Дебет       |      Кредит      |       Дебет      |      Кредит      |'
    @ 5,0 SAY REPLICATE('-',181)+IIF(fprval,'-------','')
ENDIF
nstr=5
RETURN
*
PROCEDURE Chap2
PARAMETERS nst,nstr,nlist
nstr=nstr+1
IF nst>=nlist
    @ nstr,0 SAY REPLICATE('-',180)+IIF(fprval,'-------','')
ENDIF
RETURN
