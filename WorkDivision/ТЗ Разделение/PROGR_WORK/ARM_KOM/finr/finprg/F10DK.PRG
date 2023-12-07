PRIVATE nz,pr_otk,fname,chg12,nlist
nz=RECNO()
DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Tekm PROMPT " По \<дням         "
DEFINE BAR 2 OF Tekm PROMPT " По \<организациям "
ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
ACTIVATE POPUP Tekm
menu_v=BAR()
IF menu_v=0
     RETURN
ENDIF
menu_d=1
IF menu_v=2
    DEFINE POPUP Tekm FROM 11,50 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " Р\<азвернутая "
    DEFINE BAR 2 OF Tekm PROMPT " С\<водная     "
    ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
    ACTIVATE POPUP Tekm
    menu_d=BAR()
    IF menu_d=0
          RETURN
    ENDIF
ENDIF
*
chg12=0
fname="out.txt        "
nlist=1
m.pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,m.pr_otk
IF m.pr_otk
     RETURN
ENDIF
*
n1=1
IF menu_d=1
    n2=11
    n3=17
    n4=24
    n5=29
    n5a=48
    n6=48+IIF(tek_b_51=1,15,0)
    n7=56+IIF(tek_b_51=1,15,0)
    n8=87+IIF(tek_b_51=1,15,0)
ELSE
    n2=9
    n3=40
    n5a=59
ENDIF
fsum=0
fpen=0
fzav=0
fusl=0
IF nastf_d=1.AND.menu_d=1
    @ PROW(),0 SAY &sgat2
ENDIF
nnstr=0
nstr=kolstr+1
SELECT 0
USE spr_kart
SET ORDER TO kod
SEEK ffvid
fnamk=nam
USE
SELECT 0
USE bkr EXCLUSIVE
ZAP
IF menu_v=1
    INDEX ON DTOC(dati,1)+kp TAG rab
ELSE
    INDEX ON kp+DTOC(dati,1) TAG rab
ENDIF
SET DELETED ON
APPEND FROM bk FOR nzk=spr_bs.bs.AND.dat=fdat.AND.vo=fvo.AND.(EMPTY(ffvid).OR.pr_usl=ffvid)
SET DELETED OFF
GO TOP
DO WHILE !EOF()
    fkp='*******'
    fkluc=IIF(menu_v=1,dati,kp)
    ffsum=0
    ffpen=0
    fk=0
    fpr_spr=pr_spr
    SCAN REST WHILE fkluc=IIF(menu_v=1,dati,kp)
         IF nstr>kolstr
              nnstr=nnstr+1
              IF menu_d=1
                   IF nnstr>=nlist
                        @ 0,0 SAY 'Лист '+LTRIM(STR(nnstr,3))+". Ведомость неоплаченных тpебований на "+DTOC(DATE())+" по счету "+spr_bs.bs+' по опеpации '+IIF(vo='0','прихода','расхода')+IIF(EMPTY(ffvid),'',' по картотеке '+fnamk)
                        @ 1,0 SAY "---------------------------------------------------------------------------------------"+IIF(nastf_d=1,REPLICATE('-',50),'')+IIF(tek_b_51=1,REPLICATE('-',15),'')
                        @ 2,0 SAY "|  Дата   |Hомер|Hомер |Коpp|                  "+IIF(tek_b_51=1,'|     Сумма    ','')+"| Код   |    Hазвание оpганизации      |"
                        @ 3,0 SAY "|документа|входя|докум.|счет|      Сумма       "+IIF(tek_b_51=1,'|      пени    ','')+"|организ|    (Ф.И.О. pаботника)        |"+IIF(nastf_d=1,'          Текст','')
                        @ 4,0 SAY "|         | щий |      |    |                  "+IIF(tek_b_51=1,'|              ','')+"|(работ)|                              |"
                        @ 5,0 SAY "---------------------------------------------------------------------------------------"+IIF(nastf_d=1,REPLICATE('-',50),'')+IIF(tek_b_51=1,REPLICATE('-',15),'')
                   ENDIF
                   nstr=5
              ELSE
                   IF nnstr>=nlist
                        @ 0,0 SAY 'Лист '+LTRIM(STR(nnstr,3))+". Ведомость неоплаченных тpебований на "+DTOC(DATE())+" по счету "+spr_bs.bs
                        @ 1,0 SAY ' по опеpации '+IIF(vo='0','прихода','расхода')+IIF(EMPTY(ffvid),'',' по картотеке '+fnamk)
                        @ 2,0 SAY "-----------------------------------------------------------"+IIF(tek_b_51=1,REPLICATE('-',15),'')
                        @ 3,0 SAY "| Код   |    Hазвание оpганизации      |                  |"+IIF(tek_b_51=1,'     Сумма    |','')
                        @ 4,0 SAY "|организ|    (Ф.И.О. pаботника)        |      Сумма       |"+IIF(tek_b_51=1,'      пени    |','')
                        @ 5,0 SAY "|(работ)|                              |                  |"+IIF(tek_b_51=1,'              |','')
                        @ 6,0 SAY "-----------------------------------------------------------"+IIF(tek_b_51=1,REPLICATE('-',15),'')
                   ENDIF
                   nstr=6
              ENDIF
              fkp='*******'
         ENDIF
         sss=0
         IF tek_b_51=1.AND.pr_spr='1'
              SELECT skl
              SET ORDER TO kkl
              SEEK bk.kp
              SELECT bkr
              sss=ROUND((DATE()-dati-skl.kol_dn)*sm*skl.pr_pen/100.0,2)
         ENDIF
         IF menu_d=1
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY dati
                   @ nstr,n2 SAY nvx
                   @ nstr,n3 SAY nrd
                   @ nstr,n4 SAY kor
                   @ nstr,n5 SAY sm PICTURE '999,999,999,999.99'
                   IF tek_b_51=1
                        @ nstr,n5a SAY sss PICTURE '999,999,999.99'
                   ENDIF
                   @ nstr,n6 SAY kp
                   IF fkp#kp
                        fkp=kp
                        @ nstr,n7 SAY Spr_nam(pr_spr,kp,30)
                   ENDIF
                   IF nastf_d=1
                        @ nstr,n8 SAY text_1
                   ENDIF
              ENDIF
              IF nastf_d=1.AND.!EMPTY(text_2)
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n8 SAY text_2
                   ENDIF
              ENDIF
              IF nastf_d=1.AND.!EMPTY(text_3)
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n8 SAY text_3
                   ENDIF
              ENDIF
              IF nastf_d=1.AND.!EMPTY(text_4)
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n8 SAY text_4
                   ENDIF
              ENDIF
         ENDIF
         ffsum=ffsum+sm
         ffpen=ffpen+sss
         fk=fk+1
    ENDSCAN
    IF menu_d=1
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',80)+IIF(tek_b_51=1,REPLICATE('-',15),'')
         ENDIF
    ENDIF
    IF fk>1.OR.menu_d=2.AND.fk>0
	     nstr=nstr+1
         IF nnstr>=nlist
              DO CASE
              CASE menu_v=1
                   @ nstr,n1 SAY fkluc
                   @ nstr,n2 SAY '- всего'
                   @ nstr,n5 SAY ffsum PICTURE '999,999,999,999.99'
                   IF tek_b_51=1
                        @ nstr,n5a SAY ffpen PICTURE '999,999,999.99'
                   ENDIF
              CASE menu_v=2.AND.menu_d=1
                   @ nstr,n1 SAY 'Итого'
                   @ nstr,n5 SAY ffsum PICTURE '999,999,999,999.99'
                   IF tek_b_51=1
                        @ nstr,n5a SAY ffpen PICTURE '999,999,999.99'
                   ENDIF
                   @ nstr,n6 SAY fkluc
              CASE menu_v=2.AND.menu_d=2
                   @ nstr,n1 SAY fkluc
                   @ nstr,n2 SAY Spr_nam(fpr_spr,fkluc,30)
                   @ nstr,n3 SAY ffsum PICTURE '999,999,999,999.99'
                   IF tek_b_51=1
                        @ nstr,n5a SAY ffpen PICTURE '999,999,999.99'
                   ENDIF
              ENDCASE
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('=',IIF(menu_d=1,80,59))+IIF(tek_b_51=1,REPLICATE('=',15),'')
         ENDIF
    ENDIF
    fsum=fsum+ffsum
    fpen=fpen+ffpen
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY "Всего"
    @ nstr,IIF(menu_d=1,n5,n3) SAY fsum PICTURE '999,999,999,999.99'
    IF tek_b_51=1
         @ nstr,n5a SAY fpen PICTURE '999,999,999.99'
    ENDIF
ENDIF
ZAP
DELETE TAG rab
USE
SELECT bk
GO nz
EJECT
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN
