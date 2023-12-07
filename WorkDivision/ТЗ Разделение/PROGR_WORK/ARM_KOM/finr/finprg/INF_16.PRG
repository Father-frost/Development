PRIVATE n1,n2,n3,n4,n5,n6,n7,n8,ii,fkp,fpr_spr
n1=1
n1a=8
n2=17
n3=24
n4=29
n5=55
n6=71
n7=87
n8=103
fffkon=0
nnstr=0
nstr=kolstr+1
ii=0
SCAN
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    fkp=kp
    fpr_spr=pr_spr
    fnam=Spr_nam(pr_spr,kp,30)
    ffopl=0
    ffost=0
    ffotgr=0
    ffbk=0
    ffkon=0
    SELECT osdkomr
    SET EXACT OFF
    SEEK nastf_l+fkp+fpr_spr
    SET EXACT ON
    DO WHILE bs=nastf_l.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.!EOF()
         fost=0
         fotgr=0
         fnrd=nrd
         kol_nvx=0
         DO WHILE bs=nastf_l.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.AND.!EOF()
              sfost=0
              sfotgr=0
              fnvx=nvx
              fnsk=nsk
              SCAN REST WHILE bs=nastf_l.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.AND.nvx=fnvx
                   IF EMPTY(ffdat).AND.(ch1=4.OR.ch1=8.AND.((DATE()-dat)>=skl.kol_dn.OR.EMPTY(dat)).AND.(menu_w=1.OR.menu_w=2.AND.smdo<db)).OR.!EMPTY(ffdat).AND.dat<=ffdat
                        IF nstr>kolstr
                             nnstr=nnstr+1
                             DO Chap1 WITH nnstr,nstr,nlist
                        ENDIF
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n1  SAY nrd
                             @ nstr,n1a SAY dat
                             @ nstr,n2  SAY nvx
                             @ nstr,n3  SAY kor
                             @ nstr,n4 SAY Spr_sc(kor,25)
                             @ nstr,n5 SAY db
                             IF EMPTY(ffdat)
                                  @ nstr,n7 SAY smdo
                             ENDIF
                        ENDIF
                        sfost=sfost+db
                        sfotgr=sfotgr+smdo
                        IF bs_op=nastf_k
                             ffopl=ffopl+smdo
                        ENDIF
                   ENDIF
              ENDSCAN
              kol_nvx=kol_nvx+1
              fost=fost+sfost
              fotgr=fotgr+sfotgr
              IF sfost#0.OR.sfotgr#0
                 *  IF bs=nastf_l.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.OR.kol_nvx>1
                 *       IF nstr>kolstr
                 *            nnstr=nnstr+1
                 *            DO Chap1 WITH nnstr,nstr,nlist
                 *       ENDIF
                 *       nstr=nstr+1
                 *       IF nnstr>=nlist
                 *            IF nastf_g=1
                 *                 @ nstr,n2 SAY fnsk
                 *            ENDIF
                 *            @ nstr,n4 SAY "итого по TTH "+fnvx
                 *            @ nstr,n5 SAY sfost PICTURE '999999999999.99' FUNCTION 'Z'
                 *            IF EMPTY(ffdat)
                 *                 @ nstr,n7 SAY sfotgr PICTURE '999999999999.99' FUNCTION 'Z'
                 *                 @ nstr,n8 SAY sfost-sfotgr PICTURE '999999999999.99' FUNCTION 'Z'
                 *            ENDIF
                 *       ENDIF
                 *       IF nstr>kolstr
                 *            nnstr=nnstr+1
                 *            DO Chap1 WITH nnstr,nstr,nlist
                 *       ENDIF
                 *       nstr=nstr+1
                 *       IF nnstr>=nlist
                 *            @ nstr,n5 SAY IIF(EMPTY(ffdat),REPLICATE('-',63),REPLICATE('-',31))
                 *       ENDIF
                 *  ENDIF
              ENDIF
         ENDDO
         IF fost#0.OR.fotgr#0
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF nastf_g=1.AND.kol_nvx<2
                        @ nstr,n2 SAY fnsk
                   ENDIF
                   @ nstr,n4 SAY "итого по документу "+fnrd
                   @ nstr,n5 SAY fost PICTURE '999999999999.99' FUNCTION 'Z'
                   IF EMPTY(ffdat)
                        @ nstr,n7 SAY fotgr      PICTURE '999999999999.99' FUNCTION 'Z'
                        @ nstr,n8 SAY fost-fotgr PICTURE '999999999999.99' FUNCTION 'Z'
                   ENDIF
              ENDIF
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n5 SAY IIF(EMPTY(ffdat),REPLICATE('-',63),REPLICATE('-',31))
              ENDIF
              ffost=ffost+fost
              ffbk=ffbk+fotgr
              ffkon=ffkon+fost-fotgr
         ENDIF
    ENDDO
    SELECT avotrr
    SET EXACT OFF
    SEEK fkp+fpr_spr
    SET EXACT ON
    DO WHILE kp=bkr.kp.AND.pr_spr=fpr_spr.AND.!EOF()
         fost=0
         fotgr=0
         fnrd=nrd
         kol_nvx=0
         DO WHILE kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.AND.!EOF()
              sfost=0
              sfotgr=0
              fnvx=nvx
              fnsk=nsk
              SCAN REST WHILE kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.AND.nvx=fnvx
                   IF EMPTY(ffdat).AND.(ch1=4.OR.ch1=8.AND.((DATE()-dat)>=skl.kol_dn.OR.EMPTY(dat)).AND.(menu_w=1.OR.menu_w=2.AND.smdo<smd)).OR.!EMPTY(ffdat).AND.dat<=ffdat
                        IF nstr>kolstr
                             nnstr=nnstr+1
                             DO Chap1 WITH nnstr,nstr,nlist
                        ENDIF
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n1  SAY nrd
                             @ nstr,n1a SAY dat
                             @ nstr,n2  SAY nvx
                             @ nstr,n3  SAY kor
                             @ nstr,n4 SAY Spr_sc(kor,25)
                             @ nstr,n6 SAY smd
                             IF EMPTY(ffdat)
                                  @ nstr,n7 SAY smdo
                             ENDIF
                        ENDIF
                        sfost=sfost+smd
                        sfotgr=sfotgr+smdo
                        IF bs_op=nastf_k
                             ffopl=ffopl+smdo
                        ENDIF
                   ENDIF
              ENDSCAN
              IF sfost#0.OR.sfotgr#0
                   kol_nvx=kol_nvx+1
                   fost=fost+sfost
                   fotgr=fotgr+sfotgr
               *    IF bs=nastf_l.AND.kp=fkp.AND.pr_spr=fpr_spr.AND.nrd=fnrd.OR.kol_nvx>1
               *         IF nstr>kolstr
               *              nnstr=nnstr+1
               *              DO Chap1 WITH nnstr,nstr,nlist
               *         ENDIF
               *         nstr=nstr+1
               *         IF nnstr>=nlist
               *              IF nastf_g=1
               *                   @ nstr,n2 SAY fnsk
               *              ENDIF
               *              @ nstr,n4 SAY "итого по TTH "+fnvx
               *              @ nstr,n6 SAY sfost PICTURE '999999999999.99' FUNCTION 'Z'
               *              IF EMPTY(ffdat)
               *                   @ nstr,n7 SAY sfotgr PICTURE '999999999999.99' FUNCTION 'Z'
               *                   @ nstr,n8 SAY sfost-sfotgr PICTURE '999999999999.99' FUNCTION 'Z'
               *              ENDIF
               *         ENDIF
               *         IF nstr>kolstr
               *              nnstr=nnstr+1
               *              DO Chap1 WITH nnstr,nstr,nlist
               *         ENDIF
               *         nstr=nstr+1
               *         IF nnstr>=nlist
               *              @ nstr,n5 SAY IIF(EMPTY(ffdat),REPLICATE('-',63),REPLICATE('-',31))
               *         ENDIF
               *    ENDIF
              ENDIF
         ENDDO
         IF fost#0.OR.fotgr#0
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF nastf_g=1.AND.kol_nvx<2
                        @ nstr,n2 SAY fnsk
                   ENDIF
                   @ nstr,n4 SAY "итого по документу "+fnrd
                   @ nstr,n6 SAY fost PICTURE '999999999999.99' FUNCTION 'Z'
                   IF EMPTY(ffdat)
                        @ nstr,n7 SAY fotgr PICTURE '999999999999.99' FUNCTION 'Z'
                        @ nstr,n8 SAY fost-fotgr PICTURE '999999999999.99' FUNCTION 'Z'
                   ENDIF
              ENDIF
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n6 SAY IIF(EMPTY(ffdat),REPLICATE('-',47),REPLICATE('-',15))
              ENDIF
              ffotgr=ffotgr+fost
              ffbk=ffbk+fotgr
              ffkon=ffkon+fost-fotgr
         ENDIF
    ENDDO
    IF ffost#0.OR.ffotgr#0.OR.ffbk#0
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY "Всего по документам"
              @ nstr,n5 SAY ffost  PICTURE '999999999999.99' FUNCTION 'Z'
              @ nstr,n6 SAY ffotgr PICTURE '999999999999.99' FUNCTION 'Z'
              IF EMPTY(ffdat)
                   @ nstr,n7 SAY ffbk   PICTURE '999999999999.99' FUNCTION 'Z'
                   @ nstr,n8 SAY ffkon  PICTURE '999999999999.99' FUNCTION 'Z'
              ENDIF
         ENDIF
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY IIF(EMPTY(ffdat),REPLICATE('-',117),REPLICATE('-',85))
         ENDIF
    ENDIF
    SELECT osdkomr
    SET EXACT OFF
    SEEK nastf_k+fkp+fpr_spr
    SET EXACT ON
    fost=0
    fotgr=0
    IF EMPTY(ffdat)
         SCAN REST WHILE bs=nastf_k.AND.kp=fkp.AND.pr_spr=fpr_spr
              fost=fost+db-kr
         ENDSCAN
         SELECT bk
         SET ORDER TO bk2
         SET EXACT OFF
         SEEK nastf_k+fkp
         SCAN REST WHILE kor=nastf_k.AND.kp=fkp FOR MONTH(dat)=ntmec.AND.!DELETE().AND.pr_spr=fpr_spr
              IF vo='0'
                   fotgr=fotgr+sm
              ELSE
                   ffopl=ffopl+sm
              ENDIF
         ENDSCAN
         SET ORDER TO kp
         SEEK nastf_k+fkp
         SET EXACT ON
         SCAN REST WHILE nzk=nastf_k.AND.kp=fkp FOR MONTH(dat)=ntmec.AND.!DELETE().AND.pr_spr=fpr_spr
              IF vo='1'
                   fotgr=fotgr+sm
              ELSE
                   ffopl=ffopl+sm
              ENDIF
         ENDSCAN
         IF (fost#0.OR.fotgr#0.OR.ffopl#0).AND.(ch1=4.OR.ch1=8.AND.menu_w=1)
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n4 SAY "авансиpование"
                   @ nstr,n5 SAY -fost            PICTURE '999999999999.99' FUNCTION 'Z'
                   @ nstr,n6 SAY fotgr            PICTURE '999999999999.99' FUNCTION 'Z'
                   @ nstr,n7 SAY ffopl            PICTURE '999999999999.99' FUNCTION 'Z'
                   @ nstr,n8 SAY fotgr-fost-ffopl PICTURE '999999999999.99' FUNCTION 'Z'
              ENDIF
              IF nstr>kolstr
                   nnstr=nnstr+1
                   DO Chap1 WITH nnstr,nstr,nlist
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY IIF(EMPTY(ffdat),REPLICATE('-',117),REPLICATE('-',85))
              ENDIF
         ENDIF
    ENDIF
    ffost=ffost+fost
    IF !(ch1=8.AND.menu_w=2)
         ffotgr=ffotgr-fotgr
    ENDIF
    ffbk=ffopl-ffbk
    ffkon=ffost+ffotgr+ffbk
    IF ((ffost>0.AND.ch1=8.AND.menu_v=2).OR.ffost#0.AND.(ch1#8.OR.ch1=8.AND.menu_v=1)).OR.ffotgr#0.OR.ffbk#0)).AND.(ch1=4.OR.ch1=8.AND.menu_w=1)
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY "Итого по "+bkr.kp+' '+fnam
              @ nstr,n5 SAY ffost  PICTURE '999999999999.99' FUNCTION 'Z'
              @ nstr,n6 SAY ffotgr PICTURE '999999999999.99' FUNCTION 'Z'
              IF EMPTY(ffdat)
                   @ nstr,n7 SAY ffbk  PICTURE '999999999999.99' FUNCTION 'Z'
                   @ nstr,n8 SAY ffkon PICTURE '999999999999.99' FUNCTION 'Z'
              ENDIF
         ENDIF
         IF nstr>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY IIF(EMPTY(ffdat),REPLICATE('=',115),REPLICATE('=',85))
         ENDIF
    ENDIF
    fffkon=fffkon+ffkon
ENDSCAN
IF EMPTY(fkkl)
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Всего"
         @ nstr,n8 SAY fffkon PICTURE '999999999999.99' FUNCTION 'Z'
    ENDIF
ENDIF
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nnstr,nstr,nlist
IF nstr>kolstr
    IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+'.'
@ 0,10 SAY "Инфоpмация по оpганизации "+IIF(ch1=4,SPACE(15),'с учетом документообоpота ')+SPACE(35)+DTOC(DATE())
@ 1,0 SAY IIF(EMPTY(ffdat),REPLICATE('-',119),REPLICATE('-',87))
@ 2,0 SAY '|N плат|  Дата  |'+tek_b_7+'|Коpp|    Hаименование счета   |   Сальдо на   |   Отгpужено / |'+IIF(EMPTY(ffdat),'   Оплачено /  |Сальдо на конец|','')
@ 3,0 SAY '|докум.|документ|'+tek_b_8+'|счет|                         | начало месяца |получено аванс.|'+IIF(EMPTY(ffdat),'использ.авансов|    месяца     |','')
@ 4,0 SAY IIF(EMPTY(ffdat),REPLICATE('-',119),REPLICATE('-',87))
    ENDIF
    nstr=4
ENDIF
RETURN