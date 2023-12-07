PRIVATE nz,pr_otk,fname,chg12,nlist,menu_d,fvo
IF RECCOUNT()=0
    RETURN
ENDIF
DEFINE POPUP Tekm FROM 10,57 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Tekm PROMPT " По \<дебету  "
DEFINE BAR 2 OF Tekm PROMPT " По \<кредиту "
ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
ACTIVATE POPUP Tekm
menu_d=BAR()
IF menu_d=0
     RETURN
ENDIF
RESTORE FROM tek_b ADDITIVE
DO CASE
CASE menu_d=1
    fvo='0'
CASE menu_d=2
    fvo='1'
ENDCASE
RELEASE ALL LIKE tek_b_??
nz=RECNO()
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
n2=13
n3=19
n4=26
n5=31
n5a=50
n6=50+IIF(tek_b_51=1,15,0)
n7=58+IIF(tek_b_51=1,15,0)
n8=89+IIF(tek_b_51=1,15,0)
ffsum=0
ffpen=0
IF nastf_d=1
    @ PROW(),0 SAY &sgat2
ENDIF
nnstr=0
nstr=kolstr+1
fdat=CTOD("  /  /  ")
SELECT 0
USE spr_kart
SET ORDER TO kod
SELECT bk
SET ORDER TO bk3
SET EXACT OFF
SEEK spr_bs.bs+DTOC(fdat,1)+fvo
SET EXACT ON
DO WHILE nzk=spr_bs.bs.AND.vo=fvo.AND.dat=fdat.AND.!EOF()
    ffvid=pr_usl
    fsum=0
    fpen=0
    SCAN REST WHILE nzk=spr_bs.bs.AND.vo=fvo.AND.dat=fdat.AND.(EMPTY(ffvid).OR.pr_usl=ffvid) FOR !DELETE()
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
                   @ 0,0 SAY "Ведомость неоплаченных тpебований на "+DTOC(DATE())+" по счету "+spr_bs.bs+' по опеpации '+IIF(vo='0','прихода','расхода')
                   @ 1,0 SAY "----------------------------------------------------------------------------------------"+IIF(nastf_d=1,REPLICATE('-',50),'')+IIF(tek_b_51=1,REPLICATE('-',15),'')
                   @ 2,0 SAY "|   Дата   |Hомер|Hомер |Коpp|      Сумма       "+IIF(tek_b_51=1,'|     Сумма    ','')+"| Код   |    Hазвание оpганизации      |"
                   @ 3,0 SAY "| документа|входя|докум.|счет|                  "+IIF(tek_b_51=1,'|      пени    ','')+"|организ|    (Ф.И.О. pаботника)        |"+IIF(nastf_d=1,'          Текст','')
                   @ 4,0 SAY "|          | щий |      |    |                  "+IIF(tek_b_51=1,'|              ','')+"|(работ)|                              |"
                   @ 5,0 SAY "----------------------------------------------------------------------------------------"+IIF(nastf_d=1,REPLICATE('-',50),'')+IIF(tek_b_51=1,REPLICATE('-',15),'')
              ENDIF
              nstr=5
         ENDIF
         sss=0
         IF tek_b_51=1.AND.pr_spr='1'
              SELECT skl
              SET ORDER TO kkl
              SEEK bk.kp
              SELECT bk
              sss=ROUND((DATE()-dati-skl.kol_dn)*sm*skl.pr_pen/100.0,2)
         ENDIF
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
              @ nstr,n7 SAY Spr_nam(pr_spr,kp,30)
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
         fsum=fsum+sm
         fpen=fpen+sss
    ENDSCAN
    IF !EMPTY(ffvid)
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',48)+IIF(tek_b_51=1,REPLICATE('-',15),'')
         ENDIF
         nstr=nstr+1
         SELECT spr_kart
         SEEK ffvid
         SELECT bk
         IF nnstr>=nlist
              @ nstr,0 SAY "Итого по "+spr_kart.nam
              @ nstr,n5 SAY fsum PICTURE '999,999,999,999.99'
              IF tek_b_51=1
                   @ nstr,n5a SAY fpen PICTURE '999,999,999.99'
              ENDIF
         ENDIF
    ENDIF
    ffsum=ffsum+fsum
    ffpen=ffpen+fpen
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',48)+IIF(tek_b_51=1,REPLICATE('-',15),'')
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY "Всего"
    @ nstr,n5 SAY ffsum PICTURE '999,999,999,999.99'
    IF tek_b_51=1
         @ nstr,n5a SAY ffpen PICTURE '999,999,999.99'
    ENDIF
ENDIF
SELECT spr_kart
USE
SELECT spr_bs
GO nz
EJECT
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN