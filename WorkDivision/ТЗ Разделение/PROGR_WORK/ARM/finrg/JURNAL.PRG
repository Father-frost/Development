SELECT  0
USE supavot EXCLUSIVE
ZAP
SELECT  0
use osdkomr
ZAP
USE
SELECT  0
use avotrr
ZAP
USE
SELECT 0
USE avot EXCLUSIVE
SET ORDER TO bs_kp
SELECT bk
SET ORDER TO kp
SELECT 0
USE osdkom EXCLUSIVE
SET ORDER TO bs_kp
SET EXACT OFF
IF SEEK(nastf_l)
    DO WHILE bs=nastf_l.AND.!EOF()
         fkp=kp
         fkstr=0
         DO WHILE bs=nastf_l.AND.fkp=kp.AND.!EOF()
              fnrd=nrd
              fnsk=nsk
              fpr_spr=pr_spr
              fdat=dat
              fsum=0
              SCAN REST WHILE bs=nastf_l.AND.fkp=kp.AND.fnrd=nrd FOR !DELETE()
                   fsum=fsum+db
              ENDSCAN
              IF fsum#0
                   SELECT supavot
                   APPEND BLANK
                   fkstr=fkstr+1
                   REPLACE kp WITH fkp,kstr WITH fkstr,ngr WITH 1,nrd WITH fnrd,;
                          dat WITH fdat,pr_spr WITH fpr_spr,sum WITH fsum,nsk WITH fnsk
                   SELECT osdkom
              ENDIF
         ENDDO
    ENDDO
ENDIF
IF SEEK(nastf_k)
    DO WHILE bs=nastf_k.AND.!EOF()
         fkp=kp
         fkstr=0
         DO WHILE bs=nastf_k.AND.fkp=kp.AND.!EOF()
              fnrd=nrd
              fnsk=nsk
              fpr_spr=pr_spr
              fdat=dat
              fsum=0
              SCAN REST WHILE bs=nastf_k.AND.fkp=kp.AND.fnrd=nrd FOR !DELETE()
                   fsum=fsum+kr
              ENDSCAN
              IF fsum#0
                   SELECT supavot
                   APPEND BLANK
                   fkstr=fkstr+1
                   REPLACE kp WITH fkp,kstr WITH fkstr,ngr WITH 2,nrd WITH fnrd,;
                          dat WITH fdat,pr_spr WITH fpr_spr,sum WITH fsum,nsk WITH fnsk
                   SELECT osdkom
              ENDIF
         ENDDO
    ENDDO
ENDIF
IF nastf_k#nastf_e
    IF SEEK(nastf_e)
         DO WHILE bs=nastf_e.AND.!EOF()
              fkp=kp
              fkstr=100
              DO WHILE bs=nastf_e.AND.fkp=kp.AND.!EOF()
                   fnrd=nrd
                   fnsk=nsk
                   fpr_spr=pr_spr
                   fdat=dat
                   fsum=0
                   SCAN REST WHILE bs=nastf_e.AND.fkp=kp.AND.fnrd=nrd FOR !DELETE()
                        fsum=fsum+kr
                   ENDSCAN
                   IF fsum#0
                        SELECT supavot
                        APPEND BLANK
                        fkstr=fkstr+1
                        REPLACE kp WITH fkp,kstr WITH fkstr,ngr WITH 2,nrd WITH fnrd,;
                               dat WITH fdat,pr_spr WITH fpr_spr,sum WITH fsum,nsk WITH fnsk
                        SELECT osdkom
                   ENDIF
              ENDDO
         ENDDO
    ENDIF
ENDIF
SELECT avot
IF SEEK(nastf_l)
    DO WHILE bs=nastf_l.AND.!EOF()
         fkp=kp
         fkstr=0
         DO WHILE bs=nastf_l.AND.fkp=kp.AND.!EOF()
              fnrd=nrd
              fnsk=nsk
              fpr_spr=pr_spr
              fdat=dat
              fsum=0
              SCAN REST WHILE bs=nastf_l.AND.fkp=kp.AND.fnrd=nrd FOR !DELETE()
                   fsum=fsum+smd
              ENDSCAN
              IF fsum#0
                   SELECT supavot
                   APPEND BLANK
                   fkstr=fkstr+1
                   REPLACE kp WITH fkp,kstr WITH fkstr,ngr WITH 4,nrd WITH fnrd,;
                          dat WITH fdat,pr_spr WITH fpr_spr,sum WITH fsum,nsk WITH fnsk
                   SELECT avot
              ENDIF
         ENDDO
    ENDDO
ENDIF
DIMENSION fsumo(10),fbs_op(10)
i_op=0
SELECT avot
SET ORDER TO avot1
SET FILTER TO smdo#0.AND.bs_op#nastf_k.AND.bs_op#nastf_e
GO TOP
SELECT osdkom
SET ORDER TO kp_nrd
SET FILTER TO (smdo#0.AND.bs_op#nastf_k.AND.bs_op#nastf_e).OR.pr_prib='*'
GO TOP
SELECT bk
SET ORDER TO kp_kor
SET FILTER TO !EMPTY(dat).AND.(kor=nastf_e.OR.kor=nastf_k)
GO TOP
DO WHILE !EOF()
    fkp=kp
    fkstr=0
    DO WHILE kp=fkp.AND.!EOF()
         fdat=dat
         fnrd=nrd
         fsum=0
         fpr_spr=pr_spr
         fbs=kor
         SCAN REST WHILE kp=fkp.AND.nrd=fnrd FOR !DELETE()
              IF vo='0'
                   fsum=fsum+sm
              ELSE
                   fsum=fsum-sm
              ENDIF
         ENDSCAN
         IF fsum#0
              fkstr=fkstr+1
              SELECT supavot
              APPEND BLANK
              REPLACE ngr WITH 5,kp WITH fkp,kstr WITH fkstr,nrd WITH fnrd,;
                      dat WITH fdat,pr_spr WITH fpr_spr,sum WITH fsum,bs WITH fbs
              SELECT bk
         ENDIF
    ENDDO
ENDDO
SELECT osdkom
GO TOP
DO WHILE !EOF()
    fkp=kp
    fsumo=0
    i_op=0
    fkstr=300
    DO WHILE !EOF().AND.kp=fkp
         IF pr_prib='*'
              FOR j=1 to i_op
                   IF fbs_op(j)=kor
                        EXIT
                   ENDIF
              ENDFOR
              fsumo(j)=fsumo(j)-kr+db
              IF j>i_op
                   i_op=j
                   fbs_op(j)=kor
              ENDIF
              SKIP
         ELSE
              FOR j=1 to i_op
                   IF fbs_op(j)=bs_op
                        EXIT
                   ENDIF
              ENDFOR
              fsumo(j)=fsumo(j)+smdo
              IF j>i_op
                   i_op=j
                   fbs_op(j)=bs_op
              ENDIF
              SKIP
         ENDIF
    ENDDO
    FOR j=1 to i_op
         IF fsumo(j)#0
              fkstr=fkstr+1
              fsum=fsumo(j)
              fbs=fbs_op(j)
              SELECT supavot
              APPEND BLANK
              REPLACE ngr WITH 5,kp WITH fkp,kstr WITH fkstr,nrd WITH fnrd,;
                      dat WITH fdat,pr_spr WITH fpr_spr,sum WITH fsum,bs WITH fbs
         ENDIF
    ENDFOR
    SELECT osdkom
ENDDO
SELECT avot
DO WHILE !EOF()
    fsumo=0
    i_op=0
    fkp=kp
    fkstr=200
    SCAN REST WHILE kp=fkp FOR !DELETE()
         FOR j=1 to i_op
              IF fbs_op(j)=bs_op
                   EXIT
              ENDIF
         ENDFOR
         fsumo(j)=fsumo(j)+smdo
         IF j>i_op
              i_op=j
              fbs_op(j)=bs_op
         ENDIF
    ENDSCAN
    FOR j=1 to i_op
         IF fsumo(j)#0
              fkstr=fkstr+1
              fsum=fsumo(j)
              fbs=fbs_op(j)
              SELECT supavot
              APPEND BLANK
              REPLACE ngr WITH 5,kp WITH fkp,kstr WITH fkstr,nrd WITH fnrd,;
                      dat WITH fdat,pr_spr WITH fpr_spr,sum WITH fsum,bs WITH fbs
         ENDIF
    ENDFOR
    SELECT avot
ENDDO
SET FILTER TO
SELECT osdkom
USE osdkomr EXCLUSIVE
SET DELETED ON
APPEND FROM osdkom
SET DELETED OFF
INDEX ON kp+nrd+DTOC(dat)+bs_op+kor TAG rab
SELECT avot
USE avotrr EXCLUSIVE
APPEND FROM avot
INDEX ON kp+nrd+DTOC(dat)+bs_op+kor TAG rab
RELEASE fsumo,fbs_op,i_op
SELECT supavot
INDEX ON kp+STR(ngr,2)+STR(kstr,3) TAG supavot
GO TOP
DIMENSION so(4),sv(4),vsch(17),osch(17),obs_op(15),op(15)
DIMENSION n(17),str2(5),sgr1(15),sdat1(15),sgr2(10),sdat2(10),sgr3(15),sgr4(10),sdat4(10),sbs(10),snrd(10)
DIMENSION str1(17),sbs1(17),vop(17),ito(17),itsch(17),ostsch(17),ostv(17)
vop=0
vsch=0
ostv=0
n(1)=20
n(2)=35
n(3)=50
n(4)=65
n(5)=80
n(6)=95
n(7)=110
n(8)=125
n(9)=140
n(10)=155
n(11)=170
n(12)=185
n(13)=200
n(14)=215
n(15)=230
n(16)=245
n(17)=260
shap2='N плат:дата/счет'
ibs=0
nn=0
SELECT avotrr
SCAN FOR kor#' '.AND.!DELETE()
    FOR i=1 TO ibs
         IF sbs1(i)=kor
              EXIT
         ENDIF
    ENDFOR
    IF i>16
         EXIT
    ENDIF
    IF i>ibs
         ibs=i
         sbs1(ibs)=kor
         shap2=shap2+':   '+kor+'     '
    ENDIF
ENDSCAN
SELECT osdkomr
SCAN FOR kor#' '.AND.!DELETE()
    FOR i=1 TO ibs
         IF sbs1(i)=kor
              EXIT
         ENDIF
    ENDFOR
    IF i>16
         EXIT
    ENDIF
    IF i>ibs
         ibs=i
         sbs1(ibs)=kor
         shap2=shap2+':   '+kor+'     '
    ENDIF
ENDSCAN
ibs=ibs+1
shap2=shap2+': Всего'
SELECT supavot
PRIVATE ii
@ 1,18 SAY RECCOUNT() PICTURE '999999'
@ 2,18 SAY ' '
SET DEVICE TO PRINT
nn=0
sv=0
op=0
iop=0
ii=0
DO WHILE !EOF()
    fkp=kp
    so=0
    SELECT skl
    IF SEEK(fkp)
         strk=RTRIM(ikl)+' ('+RTRIM(fkp)+')'
    ELSE
         strk=fkp
    ENDIF
    @ nn,1 SAY ''
    nn=nn+1
    @ nn,10 SAY strk +'            ВЕДОМОСТЬ 5С   за '+tmec+'           '+ DTOC(DATE())
    STORE 0 TO sgr1,sgr2,sgr3,sgr4,igr1,igr2,igr3,igr4
    SELECT supavot
    SCAN REST WHILE kp=fkp
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         DO CASE
         CASE ngr=1.OR.ngr=3
              igr1=igr1+1
              sdat1(igr1)=dat
              sgr1(igr1)=sum
         CASE ngr=2
              igr2=igr2+1
              sdat2(igr2)=dat
              sgr2(igr2)=sum
         CASE ngr=4
              igr3=igr3+1
              sgr3(igr3)=sum
         CASE ngr=5
              igr4=igr4+1
              sgr4(igr4)=sum
              sbs(igr4)=bs
              sdat4(igr4)=dat
              snrd(igr4)=nrd
              FOR j=1 to iop
                   IF obs_op(j)=bs
                        EXIT
                   ENDIF
              ENDFOR
              IF j>iop
                   iop=j
                   obs_op(j)=bs
              ENDIF
              op(j)=op(j)+sum
         ENDCASE
    ENDSCAN
@ nn+1,1 SAY '-------------------------------------------------------------------------------------------------------'
@ nn+2,1 SAY '             Сальдо на начало                  :   Выполнено  :          оплачено             :Сальдо '
@ nn+3,1 SAY ' Дебет(cумма,дата)     :  Авансы(cумма,дата)   :в тек.месяце  :  сумма       :Nплат.:дата:счет:на конец'
@ nn+4,1 SAY '-------------------------------------------------------------------------------------------------------'
    nn=nn+4
    np=max(igr1,igr2,igr3,igr4)
    FOR j=1 to np
         IF igr1>=j
              strk1=STR(sgr1(j),13,2)+' '+dtoc(sdat1(j))+'  '
              so(1)=so(1)+sgr1(j)
         ELSE
              strk1=space(24)
         ENDIF
         IF igr2>=j
              strk2=STR(sgr2(j),13,2)+' '+dtoc(sdat2(j))+'  '
              so(2)=so(2)+sgr2(j)
         ELSE
              strk2=SPACE(24)
         ENDIF
         IF igr3>=j
              strk3=STR(sgr3(j),13,2)+'  '
              so(3)=so(3)+sgr3(j)
         ELSE
              strk3=SPACE(15)
         ENDIF
         IF igr4>=j
              strk4=STR(sgr4(j),13,2)+'  '+snrd(j)+'  '+SUBSTR(DTOC(sdat4(j)),1,5)+' '+sbs(j)
              so(4)=so(4)+sgr4(j)
          ELSE
              strk4=SPACE(31)
         ENDIF
         nn=nn+1
         @ nn,1 SAY strk1+strk2+strk3+strk4
    ENDFOR
    nn=nn+1
    sald=so(1)-so(2)+so(3)-so(4)
    @ nn,1 SAY 'Итого:'
    @ nn+1,1 SAY STR(so(1)-so(2),15,2)+'                               '+STR(so(3),15,2)+' '+STR(so(4),15,2)+space(14)+STR(sald,15,2)
    nn=nn+1
    FOR j=1 to 4
         sv(j)=sv(j)+so(j)
    ENDFOR
    nn=nn+1
    @ nn,1 SAY ' в том числе по бал.счетам'
    @ nn+1,1 SAY shap2
    nn=nn+1
    SELECT osdkomr
    ostsch=0
    itsch=0
    ito=0
    IF SEEK(fkp)
         DO WHILE fkp=kp.AND.!EOF()
              fnrd=nrd
              fdat=dat
              str1=0
              istr2=0
              DO WHILE fkp=kp.AND.fnrd=nrd.AND.fdat=dat
                   IF bs=nastf_l
                        fbs_op=bs_op
                        osch=0
                        SCAN REST WHILE fkp=kp.AND.fnrd=nrd.AND.fdat=dat.AND.fbs_op=bs_op
                             FOR j=1 to ibs-1
                                  IF kor=sbs1(j)
                                       EXIT
                                  ENDIF
                             ENDFOR
                             str1(ibs)=str1(ibs)+db-kr
                             osch(ibs)=osch(ibs)+smdo
                             IF j<ibs
                                  str1(j)=str1(j)+db-kr
                                  osch(j)=osch(j)+smdo
                             ENDIF
                        ENDSCAN
                        IF osch(ibs)#0
                             istr2=istr2+1
                             str2(istr2)='     опл.   '+fbs_op
                             FOR j=1 TO ibs
                                  IF osch(j)#0
                                       str2(istr2)=str2(istr2)+STR(osch(j),13,2)
                                       ito(j)=ito(j)+osch(j)
                                  ELSE
                                       str2(istr2)=str2(istr2)+space(13)
                                  ENDIF
                             ENDFOR
                        ENDIF
                   ELSE
                        SKIP
                   ENDIF
              ENDDO
              strk=fnrd+' '+DTOC(fdat)+' '
              FOR j=1 to ibs
                   IF str1(j)#0
                        strk=strk+STR(str1(j),13,2)
                        ostsch(j)=ostsch(j)+str1(j)
                   ELSE
                        strk=strk+space(13)
                   ENDIF
              ENDFOR
              IF str1(ibs)#0
                   nn=nn+1
                   @ nn,1 SAY strk
                   IF istr2>0
                        FOR j=1 to istr2
                             nn=nn+1
                             @ nn,1 SAY str2(j)
                        ENDFOR
                   ENDIF
              ENDIF
              nn=nn+1
         ENDDO
    ENDIF
    SELECT avotrr
    IF SEEK(fkp)
         DO WHILE !EOF().AND.fkp=kp
              fnrd=nrd
              fdat=dat
              str1=0
              istr2=0
              DO WHILE fkp=kp.AND.fnrd=nrd.AND.fdat=dat
                   IF bs=nastf_l
                        fbs_op=bs_op
                        osch=0
                        DO WHILE fkp=kp.AND.fnrd=nrd.AND.fdat=dat.AND.fbs_op=bs_op
                             FOR j=1 to ibs-1
                                  IF kor=sbs1(j)
                                       EXIT
                                  ENDIF
                             ENDFOR
                             str1(ibs)=str1(ibs)+smd
                             osch(ibs)=osch(ibs)+smdo
                             IF j<ibs
                                  str1(j)=str1(j)+smd
                                  osch(j)=osch(j)+smdo
                             ENDIF
                             SKIP
                        ENDDO
                        IF osch(ibs)#0
                             istr2=istr2+1
                             str2(istr2)='    опл.    '+fbs_op
                             FOR j=1 to ibs
                                  IF osch(j)#0
                                       str2(istr2)=str2(istr2)+STR(osch(j),13,2)
                                       ito(j)=ito(j)+osch(j)
                                  ELSE
                                       str2(istr2)=str2(istr2)+space(13)
                                  ENDIF
                             ENDFOR
                        ENDIF
                   ELSE
                        SKIP
                   ENDIF
              ENDDO
              strk=fnrd+' '+DTOC(fdat)+' '
              FOR j=1 to ibs
                   IF str1(j)#0
                        strk=strk+STR(str1(j),13,2)
                        itsch(j)=itsch(j)+str1(j)
                   ELSE
                        strk=strk+space(13)
                   ENDIF
              ENDFOR
              IF str1(ibs)#0
                   nn=nn+1
                   @ nn,1 SAY strk
              ENDIF
              IF istr2>0
                   FOR j=1 to istr2
                        nn=nn+1
                        @ nn,1 SAY str2(j)
                   ENDFOR
              ENDIF
              nn=nn+1
         ENDDO
    ENDIF
    strk='Выпол.:остаток '
    strk1='    тек.месяц  '
    str2(1)='       оплачено'
    FOR j=1 to ibs
         IF ostsch(j)#0
              strk=strk+STR(ostsch(j),13,0)
              ostv(j)=ostv(j)+ostsch(j)
         ELSE
              strk=strk+space(13)
         ENDIF
         IF itsch(j)#0
              strk1=strk1+STR(itsch(j),13,0)
              vsch(j)=vsch(j)+itsch(j)
         ELSE
              strk1=strk1+space(13)
         ENDIF
         IF ito(j)#0
              str2(1)=str2(1)+STR(ito(j),13,0)
              vop(j)=vop(j)+ito(j)
         ELSE
              str2(1)=str2(1)+space(13)
         ENDIF
    ENDFOR
    IF ostsch(ibs)#0.or.itsch(ibs)#0
         nn=nn+1
         @ nn,1 SAY REPLICATE('.',220)
         @ nn+1,1 SAY strk
         @ nn+2,1 SAY strk1
         @ nn+3,1 SAY str2(1)
         nn=nn+3
    ENDIF
    @ nn+1,1 SAY REPLICATE('=',220)
    @ nn+2,1 SAY ' '
    SELECT supavot
    nn=nn+2
ENDDO
nn=nn+3
sald=sv(1)-sv(2)+sv(3)-sv(4)
@ nn,1 SAY ''
@ nn,3 SAY 'ВСЕГО:                 ВЕДОМОСТЬ 5С   за '+tmec +'               '+DTOC(DATE())
@ nn+1,1 SAY '-------------------------------------------------------------------------------------------------------'
@ nn+2,1 SAY '       Сальдо на начало                        :   Выполнено  :          оплачено             :Сальдо '
@ nn+3,1 SAY '                       :В т.ч. авансы(cумма)   :в тек.месяце  :  сумма       :  счет          :на конец'
@ nn+4,1 SAY '-------------------------------------------------------------------------------------------------------'
nn=nn+4
@ nn+1,1 SAY STR(sv(1)-sv(2),15,2)+'        '+STR(sv(2),15,2)+'        '+STR(sv(3),15,2)+' '+STR(sv(4),15,2)+space(14)+STR(sald,15,2)
@ nn+2,1 SAY 'в том числе '
nn=nn+2
FOR j=1 to iop
    IF op(j)#0
         nn=nn+1
         @ nn,63 SAY STR(op(j),15,2)+'    '+obs_op(j)
    ENDIF
ENDFOR
@ nn+1,1 SAY ' в том числе по счетам:'
@ nn+2,2 SAY shap2
nn=nn+2
strk='Выпол.:остаток '
strk1='    тек.месяц  '
str2(1)='      оплачено '
FOR j=1 to ibs
    IF ostv(j)#0
         strk=strk+STR(ostv(j),13,0)
    ELSE
         strk=strk+SPACE(13)
    ENDIF
    IF vsch(j)#0
         strk1=strk1+STR(vsch(j),13,0)
    ELSE
         strk1=strk1+SPACE(13)
    ENDIF
    IF vop(j)#0
         str2(1)=str2(1)+STR(vop(j),13,0)
    ELSE
         str2(1)=str2(1)+SPACE(13)
    ENDIF
ENDFOR
@nn+3,1 SAY strk
@nn+4,1 SAY strk1
@nn+5,1 SAY str2(1)
nn=nn+6
@ nn,1 SAY REPLICATE('.',220)
strk='Дебет на конец '
strk1='Кpедит на конец'
saldk=sv(2)+sv(4)-vop(ibs)
FOR j=1 TO ibs
    ostv(j)=ostv(j)+vsch(j)-vop(j)
    strk=strk+STR(ostv(j),13)
    IF j<ibs
         strk1=strk1+SPACE(13)
    ELSE
         strk1=strk1+STR(saldk,13,0)
    ENDIF
ENDFOR
@ nn+1,1 SAY strk
@ nn+2,1 SAY strk1
@ nn+3,1 SAY ' '
SELECT supavot
SET EXACT ON
ZAP
USE
SELECT osdkomr
DELETE TAG rab
ZAP
USE
SELECT avotrr
DELETE TAG rab
ZAP
USE
RETURN