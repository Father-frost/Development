PRIVATE n1,n2,n3,n4,n5,n6,n7,n8,ii
n1=1
n2=8
n3=17
n4=24
n5=29
n6=55
n7=74
n8=93
n9=112
nnstr=0
nstr=0
ii=0
SCAN
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    fkp=kp
    pr_kl=.T.
    nstr_o=kolstr+1
    fnam=Spr_nam(pr_spr,fkp,30)
    ffopl=0
    ffost=0
    ffotgr=0
    ffbk=0
    ffkon=0
    SELECT osdkom1
    SET EXACT OFF
    SEEK nastf_1+fkp
    SET EXACT ON
    DO WHILE bs=nastf_1.AND.kp=fkp.AND.!EOF()
         fost=0
         fotgr=0
         fnrd=nrd
         kol_nvx=0
         DO WHILE bs=nastf_1.AND.kp=fkp.AND.nrd=fnrd.AND.!EOF()
              sfost=0
              sfotgr=0
              fnvx=nvx
              kolnn=0
              SCAN REST WHILE bs=nastf_1.AND.kp=fkp.AND.nrd=fnrd.AND.nvx=fnvx FOR kr#0.AND.!DELETE()
                   IF nstr_o>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   nstr_o=nstr_o+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY nrd
                        @ nstr,n2 SAY dat
                        @ nstr,n3 SAY nvx
                        @ nstr,n4 SAY kor
                        SELECT spr_bs
                        SEEK osdkom1.kor
                        SELECT osdkom1
                        @ nstr,n5 SAY spr_bs.nam
                        @ nstr,n6 SAY kr   PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n8 SAY smko PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
                   sfost=sfost+kr
                   sfotgr=sfotgr+smko
                   IF bs_op=nastf_2
                        ffopl=ffopl+smko
                   ENDIF
                   kolnn=kolnn+1
              ENDSCAN
              kol_nvx=kol_nvx+1
              fost=fost+sfost
              fotgr=fotgr+sfotgr
              IF bs=nastf_1.AND.kp=fkp.AND.nrd=fnrd.OR.kol_nvx>1
                   IF kolnn>1
                        nstr=nstr+1
                        nstr_o=nstr_o+1
                        IF nnstr>=nlist
                             @ nstr,n5 SAY "итого по TTH "+fnvx
                             @ nstr,n6 SAY sfost        PICTURE '999,999,999,999.99' FUNCTION 'Z'
                             @ nstr,n8 SAY sfotgr       PICTURE '999,999,999,999.99' FUNCTION 'Z'
                             @ nstr,n9 SAY sfost-sfotgr PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        ENDIF
                   ENDIF
                   IF kolnn>0
                        nstr=nstr+1
                        nstr_o=nstr_o+1
                        IF nnstr>=nlist
                             @ nstr,n6 SAY REPLICATE('-',75)
                        ENDIF
                   ENDIF
              ENDIF
         ENDDO
         IF fost#0.OR.fotgr#0
              nstr=nstr+1
              nstr_o=nstr_o+1
              IF nnstr>=nlist
                   @ nstr,n5 SAY "итого по документу "+fnrd
                   @ nstr,n6 SAY fost       PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n8 SAY fotgr      PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n9 SAY fost-fotgr PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
              nstr=nstr+1
              nstr_o=nstr_o+1
              IF nnstr>=nlist
                   @ nstr,n6 SAY REPLICATE('-',75)
              ENDIF
         ENDIF
         ffost=ffost+fost
         ffbk=ffbk+fotgr
         ffkon=ffkon+fost-fotgr
    ENDDO
    SELECT avotrr
    SET EXACT OFF
    SEEK nastf_1+osdkomr.KP
    SET EXACT ON
    DO WHILE bs=nastf_1.AND.kp=fkp.AND.!EOF()
         fost=0
         fotgr=0
         fnrd=nrd
         kol_nvx=0
         DO WHILE bs=nastf_1.AND.kp=fkp.AND.nrd=fnrd.AND.!EOF()
              sfost=0
              sfotgr=0
              fnvx=nvx
              kolnn=0
              SCAN REST WHILE bs=nastf_1.AND.kp=fkp.AND.nrd=fnrd.AND.nvx=fnvx
                   IF nstr_o>kolstr
                        nnstr=nnstr+1
                        DO Chap1 WITH nnstr,nstr,nlist
                   ENDIF
                   nstr=nstr+1
                   nstr_o=nstr_o+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY nrd
                        @ nstr,n2 SAY dat
                        @ nstr,n3 SAY nvx
                        @ nstr,n4 SAY kor
                        SELECT spr_bs
                        SEEK avotrr.kor
                        SELECT avotrr
                        @ nstr,n5 SAY spr_bs.nam
                        @ nstr,n7 SAY smk  PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n8 SAY smko PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
                   sfost=sfost+smk
                   sfotgr=sfotgr+smko
                   IF bs_op=nastf_2
                        ffopl=ffopl+smko
                   ENDIF
                   kolnn=kolnn+1
              ENDSCAN
              IF sfost#0.OR.sfotgr#0
                   kol_nvx=kol_nvx+1
                   fost=fost+sfost
                   fotgr=fotgr+sfotgr
                   IF bs=nastf_1.AND.kp=osdkomr.kp.AND.nrd=fnrd.OR.kol_nvx>1
                        IF kolnn>1
                             nstr=nstr+1
                             nstr_o=nstr_o+1
                             IF nnstr>=nlist
                                  @ nstr,n5 SAY "итого по TTH "+fnvx
                                  @ nstr,n7 SAY sfost        PICTURE '999,999,999,999.99' FUNCTION 'Z'
                                  @ nstr,n8 SAY sfotgr       PICTURE '999,999,999,999.99' FUNCTION 'Z'
                                  @ nstr,n9 SAY sfost-sfotgr PICTURE '999,999,999,999.99' FUNCTION 'Z'
                             ENDIF
                        ENDIF
                        IF kolnn>0
                             nstr=nstr+1
                             nstr_o=nstr_o+1
                             IF nnstr>=nlist
                                  @ nstr,n6 SAY REPLICATE('-',75)
                             ENDIF
                        ENDIF
                   ENDIF
              ENDIF
         ENDDO
         nstr=nstr+1
         nstr_o=nstr_o+1
         IF nnstr>=nlist
              @ nstr,n5 SAY "итого по документу "+fnrd
              @ nstr,n7 SAY fost       PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n8 SAY fotgr      PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n9 SAY fost-fotgr PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         nstr=nstr+1
         nstr_o=nstr_o+1
         IF nnstr>=nlist
              @ nstr,n7 SAY REPLICATE('-',56)
         ENDIF
         ffotgr=ffotgr+fost
         ffbk=ffbk+fotgr
         ffkon=ffkon+fost-fotgr
    ENDDO
    IF ffost#0.OR.ffotgr#0.OR.ffbk#0
         IF nstr_o>kolstr
              nnstr=nnstr+1
              DO Chap1 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         nstr_o=nstr_o+1
         IF nnstr>=nlist
              @ nstr,n1 SAY "Всего по документам"
              @ nstr,n6 SAY ffost  PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n7 SAY ffotgr PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n8 SAY ffbk   PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n9 SAY ffkon  PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         nstr=nstr+1
         nstr_o=nstr_o+1
         IF nnstr>=nlist
              @ nstr,n1 SAY REPLICATE('-',129)
         ENDIF
    ENDIF
    SELECT osdkom1
    SET EXACT OFF
    SEEK nastf_2+osdkomr.kp
    SET EXACT ON
    fost=0
    pr_chap=.T.
    SCAN REST WHILE bs=nastf_2.AND.kp=osdkomr.kp FOR db#0.AND.!DELETE()
         IF nstr_o>kolstr.OR.pr_chap
              IF !pr_chap
                   nnstr=nnstr+1
                   IF nastf_n=0
                        nstr=0
                   ELSE
                        nstr=PROW()+nastf_6
                   ENDIF
                   nstr_o=0
              ENDIF
              DO Chap2 WITH nnstr,nstr,nlist
              pr_chap=.F.
         ENDIF
         nstr=nstr+1
         nstr_o=nstr_o+1
         IF nnstr>=nlist
              @ nstr,n1 SAY nrd
              @ nstr,n2 SAY dat
              @ nstr,n6 SAY db PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         fost=fost+db
    ENDSCAN
    SELECT bkr
    SEEK nastf_2+osdkomr.kp
    fotgr=0
    fnzk='****'
    SCAN REST WHILE kor=nastf_2.AND.kp=osdkomr.kp
         IF nstr_o>kolstr.OR.pr_chap
              IF !pr_chap
                   nnstr=nnstr+1
                   IF nastf_n=0
                        nstr=0
                   ELSE
                        nstr=PROW()+nastf_6
                   ENDIF
                   nstr_o=0
              ENDIF
              DO Chap2 WITH nnstr,nstr,nlist
              pr_chap=.F.
         ENDIF
         nstr=nstr+1
         nstr_o=nstr_o+1
         IF nnstr>=nlist
              @ nstr,n1 SAY nrd
              @ nstr,n2 SAY dat
              @ nstr,n4 SAY nzk
              IF fnzk#nzk
                   fnzk=nzk
                   @ nstr,n5 SAY Spr_sc(nzk,25)
              ENDIF
              @ nstr,IIF(vo='1',n7,n8) SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         IF vo='1'
              fotgr=fotgr+sm
         ELSE
              ffopl=ffopl+sm
         ENDIF
    ENDSCAN
    IF fost#0.OR.fotgr#0.OR.ffopl#0
         IF nstr_o>kolstr
              nnstr=nnstr+1
              DO Chap2 WITH nnstr,nstr,nlist
         ENDIF
         nstr=nstr+1
         nstr_o=nstr_o+1
         IF nnstr>=nlist
              @ nstr,n5 SAY "итого по авансам"
              @ nstr,n6 SAY fost             PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n7 SAY fotgr            PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n8 SAY ffopl            PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n9 SAY fost+fotgr-ffopl PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         nstr=nstr+1
         nstr_o=nstr_o+1
         IF nnstr>=nlist
              @ nstr,n1 SAY REPLICATE('-',129)
         ENDIF
    ENDIF
    ffost=fost-ffost
    ffkon=fost+fotgr-ffopl-ffkon
    IF ffost#0.OR.ffkon#0
         nstr=nstr+1
         nstr_o=nstr_o+1
         IF nnstr>=nlist
              @ nstr,n1 SAY "Итого по "+osdkomr.kp+' '+fnam
              DO CASE
              CASE ffost>0
                   @ nstr,n6-7 SAY 'дебет'
                   @ nstr,n6 SAY ffost PICTURE '999,999,999,999.99' FUNCTION 'Z'
              CASE ffost<0
                   @ nstr,n6-7 SAY 'кpедит'
                   @ nstr,n6 SAY -ffost PICTURE '999,999,999,999.99' FUNCTION 'Z'
              OTHERWISE
                   @ nstr,n6 SAY ffost PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDCASE
              DO CASE
              CASE ffkon>0
                   @ nstr,n9-7 SAY 'дебет'
                   @ nstr,n9 SAY ffkon PICTURE '999,999,999,999.99' FUNCTION 'Z'
              CASE ffkon<0
                   @ nstr,n9-7 SAY 'кpедит'
                   @ nstr,n9 SAY -ffkon PICTURE '999,999,999,999.99' FUNCTION 'Z'
              OTHERWISE
                   @ nstr,n9 SAY ffkon PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDCASE
         ENDIF
         nstr=nstr+1
         nstr_o=nstr_o+1
         IF nnstr>=nlist
              @ nstr,n1 SAY REPLICATE('=',129)
         ENDIF
    ENDIF
    SELECT osdkomr
ENDSCAN
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nnstr,nstr,nlist
pr_kl=.F.
IF nastf_n=0
    nstr=0
ELSE
    nstr=PROW()+nastf_6
ENDIF
IF nnstr>=nlist
@ nstr+0,0 SAY "Лист "+STR(nnstr,2)+'.  Инфоpмация по оpганизации '+osdkomr.kp+' '+fnam+' за месяц '+tmec+SPACE(5)+DTOC(DATE())
@ nstr+1,0 SAY REPLICATE('-',131)
@ nstr+2,0 SAY '|N плат|  Дата  |'+tek_b_7+'|Коpp|    Hаименование счета   |     Сальдо на    |     Получено     |     Оплачено     |  Сальдо на конец |'
@ nstr+3,0 SAY '|докум.|документ|'+tek_b_8+'|счет|                         |   начало месяца  |    матеpиалов    |    матеpиалов    |      месяца      |'
@ nstr+4,0 SAY REPLICATE('-',131)
ENDIF
nstr=nstr+4
nstr_o=4
RETURN
*
PROCEDURE Chap2
PARAMETERS nnstr,nstr,nlist
IF pr_kl
    nnstr=nnstr+1
    IF nastf_n=0
         nstr=0
    ELSE
         nstr=PROW()+nastf_6
    ENDIF
    nstr_o=0
    nstr=nstr+1
    nstr_o=nstr_o+1
    IF nnstr>=nlist
         @ nstr+0,0 SAY "Лист "+STR(nnstr,2)+'.  Инфоpмация по оpганизации '+osdkomr.kp+' '+fnam+' за месяц '+tmec+SPACE(5)+DTOC(DATE())
    ENDIF
ENDIF
nstr=nstr+1
IF nnstr>=nlist
@ nstr+0,0 SAY REPLICATE('-',131)
@ nstr+1,0 SAY '|N плат|  Дата  |'+tek_b_7+'|Коpp|    Hаименование счета   |     Сальдо на    |      Выдано      |   Использовано   |  Сальдо на конец |'
@ nstr+2,0 SAY '|докум.|документ|'+tek_b_8+'|счет|                         |   начало месяца  |     авансов      |      авансов     |      месяца      |'
@ nstr+3,0 SAY REPLICATE('-',131)
ENDIF
nstr=nstr+3
nstr_o=nstr_o+4
RETURN
