SET DELETE ON
SELECT  0
USE supavot EXCLUSIVE
ZAP
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
DIMENSION fsumo(20),fbs_op(20)
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
fmes=100+ntmec
SET FILTER TO !EMPTY(dat).AND.(kor=nastf_e.OR.kor=nastf_k).and.subs(dtoc(dat),4,2)=subs(str(fmes,3),2,2)
GO TOP
    fsumz=0
DO WHILE !EOF()
    fkp=kp
    fkstr=0
    DO WHILE kp=fkp.AND.!EOF()
         fdat=dat
         fnrd=nrd
         fsum=0
         fpr_spr=pr_spr
         fbs1=nzk
        fbs=kor
         SCAN REST WHILE kp=fkp.AND.nrd=fnrd FOR !DELETE()
              IF vo='0'
                   fsum=fsum+sm
                   fsumz=fsumz+sm
              ELSE
                   fsum=fsum-sm
                   fsumz=fsumz-sm
              ENDIF
         ENDSCAN
         IF fsum#0
              fkstr=fkstr+1
              SELECT supavot
              APPEND BLANK
              REPLACE ngr WITH 5,kp WITH fkp,kstr WITH fkstr,nrd WITH fnrd,;
                      dat WITH fdat,pr_spr WITH fpr_spr,sum WITH fsum
              repl  bs WITH fbs1
              SELECT bk
         ENDIF
    ENDDO
ENDDO

SELECT bk
SET ORDER TO kp_kor
SET FILTER TO !EMPTY(dat).AND.(NZK=nastf_e.OR.NZK=nastf_k).and.subs(dtoc(dat),4,2)=subs(str(fmes,3),2,2)
GO TOP
    fsumz=0
DO WHILE !EOF()
    fkp=kp
    fkstr=0
    DO WHILE kp=fkp.AND.!EOF()
         fdat=dat
         fnrd=nrd
         fsum=0
         fpr_spr=pr_spr
         fbs1=nzk
        fbs=kor
         SCAN REST WHILE kp=fkp.AND.nrd=fnrd FOR !DELETE()
              IF vo='1'
                   fsum=fsum+sm
                   fsumz=fsumz+sm
              ELSE
                   fsum=fsum-sm
                   fsumz=fsumz-sm
              ENDIF
         ENDSCAN
         IF fsum#0
              fkstr=fkstr+1
              SELECT supavot
              APPEND BLANK
              REPLACE ngr WITH 5,kp WITH fkp,kstr WITH fkstr,nrd WITH fnrd,;
                      dat WITH fdat,pr_spr WITH fpr_spr,sum WITH fsum
              repl  bs WITH FBS
              SELECT bk
         ENDIF
    ENDDO
ENDDO




sele supavot
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
ZAP
APPEND FROM osdkom
INDEX ON kp+nrd+DTOC(dat)+bs_op+kor TAG rab
SELECT avot
USE avotrr EXCLUSIVE
ZAP
APPEND FROM avot
INDEX ON kp+nrd+DTOC(dat)+bs_op+kor TAG rab
RELEASE fsumo,fbs_op,i_op
SELECT supavot
INDEX ON bs+pr_spr TAG bs
INDEX ON kp+STR(ngr,2)+STR(kstr,3) TAG supavot
set orde to supavot
GO TOP
DIMENSION so(4),sv(4),vsch(17),osch(17),obs_op(20),op(20)
DIMENSION n(17),str2(5),sgr1(15),sdat1(15),sgr2(20),sdat2(20),sgr3(15),sgr4(20),sdat4(20),sbs(20),snrd(20)
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
SET EXACT OFF
shap2='N плат:дата/счет'
ibs=0
nn=0
nnstr=0
nn=kolstr+1
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
sv=0
op=0
iop=0
ii=0
DO WHILE !EOF()
    IF nn>kolstr
       nnstr=nnstr+1
       DO Chap1 WITH nnstr,nn,nlist
    ENDIF
*   nn=nn+1
    fkp=kp
  DO WHILE fkp=kp.AND.!EOF()
    so=0
    strk=fkp+' '+Spr_nam(pr_spr,fkp,30)
    IF EMPTY(strk)
         strk=fkp
    ENDIF
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
    np=max(igr1,igr2,igr3,igr4)
    FOR j=1 to np
         IF igr1>=j
              so(1)=so(1)+sgr1(j)
         ENDIF
         IF igr2>=j
              so(2)=so(2)+sgr2(j)
         ENDIF
         IF igr3>=j
              so(3)=so(3)+sgr3(j)
         ENDIF
         IF igr4>=j
              so(4)=so(4)+sgr4(j)
         ENDIF
    ENDFOR
    skp=0
    sald=so(1)-so(2)+so(3)-so(4)
 if sald<0
    skp=ABS(sald)
    sald=0
 endi
    IF nn>kolstr
       nnstr=nnstr+1
       DO Chap1 WITH nnstr,nn,nlist
    ENDIF
    nn=nn+1
    @ nn,0 SAY strk+'  '+STR(so(1),15,2)+' '+STR(so(2),15,2)+' '+STR(so(3),15,2)+' '+STR(so(4),15,2)+space(1)+STR(sald,15,2)+' '+STR(skp,15,2)
*   nn=nn+1
    FOR j=1 to 4
         sv(j)=sv(j)+so(j)
    ENDFOR
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
              FOR j=1 to ibs
                   IF str1(j)#0
                        strk=strk+STR(str1(j),13,2)
                        ostsch(j)=ostsch(j)+str1(j)
                   ELSE
                        strk=strk+space(13)
                   ENDIF
              ENDFOR
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
              FOR j=1 to ibs
                   IF str1(j)#0
                        strk=strk+STR(str1(j),13,2)
                        itsch(j)=itsch(j)+str1(j)
                   ELSE
                        strk=strk+space(13)
                   ENDIF
              ENDFOR
         ENDDO
    ENDIF
    FOR j=1 to ibs
         IF ostsch(j)#0
              ostv(j)=ostv(j)+ostsch(j)
         ENDIF
         IF itsch(j)#0
              vsch(j)=vsch(j)+itsch(j)
         ENDIF
         IF ito(j)#0
              vop(j)=vop(j)+ito(j)
         ENDIF
    ENDFOR
    SELECT supavot
*** nn=nn+1
    fkp=kp
  ENDDO
ENDDO
nn=nn+3
sald=sv(1)-sv(2)+sv(3)-sv(4)
@ nn,1 SAY ' '
@ nn,3 SAY 'ВСЕГО:              16 ВЕДОМОСТЬ      за '+tmec +'               '+DTOC(DATE())
@ nn+1,1 SAY '--------------------------------------------------------------------------------------------------------------------------------'
@ nn+2,1 SAY '       Сальдо на начало                        :   Выполнено  :          оплачено             :         Сальдо на конец'
@ nn+3,1 SAY '       Дебет           :       Кpедит          :в тек.месяце  :  сумма       :  счет          :       Дебет    :       Кpедит   '
@ nn+4,1 SAY '--------------------------------------------------------------------------------------------------------------------------------'
* nn+4,1 SAY '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012---------------'
* nn+4,1 SAY '0         1         2         3         4         5         6         7         8         9        10        11  ---------------'
nn=nn+4
sd=0
sd=sv(1)-sv(2)+sv(3)-sv(4)      &&+vop(ibs)
sk=0
*sk=fsumz+sv(2)-sv(4)
sk=sv(2)+sv(4)-vop(ibs)
sdsv=sd
if sk#0
sd=sd+sk
endi
*@ nn+1,1 SAY STR(sv(1)-sv(2),15,2)+'        '+STR(sv(2),15,2)+'        '+STR(sv(3),15,2)+' '+STR(sv(4),15,2)+space(14)+STR(sald,15,2)
@ nn+1,1 SAY STR(sv(1),15,2)+'        '+STR(sv(2),15,2)+'        '+STR(sv(3),15,2)+' '+STR(sv(4),15,2)+space(17)+STR(sd,15,2)+" "+STR(sk,15,2)
@ nn+2,1 SAY 'в том числе '
IF sdsv>0
   @ nn+2,95 SAY STR(sdsv,15,2)+' св.'
ELSE
   @ nn+2,111 SAY STR(ABS(sdsv),15,2)+' св.'
ENDIF
nn=nn+2
FOR j=1 to iop
    IF op(j)#0
         nn=nn+1
***********
       IF  obs_op(j)=nastf_e
        SELE supavot
        SET ORDE TO bs
          SET EXACT OFF
           IF SEEK(nastf_e)
             DO WHILE bs=nastf_e.AND.!EOF()
               fsp=pr_spr
              IF fsp="0"
               fch="50"
               ELSE
               fch="51"
              ENDI

               fbs=bs
               fsum=0
                SCAN REST WHILE fbs=bs.AND.fsp=pr_spr
                  fsum=fsum+sum
                ENDSCAN
         @ nn,63 SAY STR(fsum,15,2)+'    '+fch
         ENDDO
       ENDI
     ELSE
         @ nn,63 SAY STR(op(j),15,2)+'    '+obs_op(j)
    ENDIF
*********************
    ENDIF
ENDFOR
    nn=nn+1
*@ nn,35 SAY 'всего поступило по кpедиту'

*        @ nn,63 SAY STR(sv(2),15,2)+'   '+nastf_k
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
*@ nn+1,1 SAY strk
**@ nn+1,1 SAY STR(sd,15,2)
*@ nn+2,1 SAY strk1
**@ nn+2,1 SAY STR(sk,15,2)
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
SET EXACT ON
SET DELETE OFF
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nn,nlist
nn=0
IF nst>=nlist
    @ nn,1 SAY ' '
    nn=nn+1
    @ nn,40 SAY       '         16 ВЕДОМОСТЬ      за '+tmec+'           '+ DTOC(DATE())
    @ nn+1,0 SAY '---------------------------------------------------------------------------------------------------------------------------------------'
    @ nn+2,0 SAY '  Код   :    Наименование оpганизации  :      Сальдо на начало         :    Выполнено  :    оплачено   :         Сальдо на конец'
    @ nn+3,0 SAY ' оpганиз:                              : Дебет(cумма)  : Кpедит(cумма) : в тек.месяце  :     сумма     :       Дебет   :    Кpедит  '
    @ nn+4,0 SAY '---------------------------------------------------------------------------------------------------------------------------------------'
ENDIF
    nn=nn+4
RETURN