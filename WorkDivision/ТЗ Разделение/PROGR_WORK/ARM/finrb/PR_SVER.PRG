PRIVATE fsumpr,fsumrx,nz,pr_per,pr_otk
DIMENSION mbs(100,3)
*
chg12=0
fname="out.txt        "
nlist=1
pr_otks=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,pr_otks
IF pr_otks
     RETURN
ENDIF
*
RESTORE FROM tek_b ADDITIVE
SET EXACT OFF
SEEK fnzk
SET EXACT ON
fvid_val=vid_val
@ 0,0 SAY &sgat1
n1=1
n2=10
n3=17
n4=22
n5=41
n6=60
n7=68
n8=99
kbs=0
mbs=0
fsumpr=0
fsumrx=0
fsumprv=0
fsumrxv=0
nz=RECNO()
nnstr=0
nstr=kolstr+1
DO WHILE fnzk=nzk
    fvo=vo
    fsmo=smo
    fnrd=nrd
    ii=0
    SCAN REST WHILE fnzk=nzk.AND.fvo=vo.AND.fsmo=smo.AND.fnrd=nrd
         ii=ii+1
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
                   IF nastf_v=0
                        @ 0,0 SAY " Обоpотная ведомость движения денежных средств по счету "+fnzk+" за "+DTOC(fdat1)
                   ELSE
                        @ 0,0 SAY "Ведомость движения денежных средств по счету "+fnzk+" с "+DTOC(fdat1)+" по "+DTOC(fdat2)
                   ENDIF
                   @ 1,0 SAY REPLICATE('-',IIF(tek_b_12=0,99,152))
                   @ 2,0 SAY '| '+IIF(nastf_v=0,"Hомер",'     ')+"  |Hомер |Коpp|      Сумма       |      Сумма       | Код   |    Hазвание оpганизации      |"
                   @ 3,0 SAY '|'+IIF(nastf_v=0,"входящий",'  Дата  ')+"|докум.|счет|     пpихода      |     pасхода      |организ|    (Ф.И.О. pаботника)        |"+IIF(tek_b_12=1,'     Текст','')
                   @ 4,0 SAY "|        |      |    |                  |                  |(работ)|                              |"
                   @ 5,0 SAY REPLICATE('-',IIF(tek_b_12=0,99,152))
              ENDIF
              nstr=5
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY IIF(nastf_v=0,nvx,dat)
              @ nstr,n2 SAY nrd
              @ nstr,n3 SAY kor
              @ nstr,IIF(fvo='0',n4,n5) SAY sm PICTURE "999,999,999,999.99"
              @ nstr,n6 SAY kp
              @ nstr,n7 SAY Spr_nam(pr_spr,kp,30)
              IF tek_b_12=1
                   @ nstr,n8 SAY text_1
              ENDIF
         ENDIF
         IF tek_b_12=1.AND.!EMPTY(text_2)
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n8 SAY text_2
              ENDIF
         ENDIF
         IF tek_b_12=1.AND.!EMPTY(text_3)
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n8 SAY text_3
              ENDIF
         ENDIF
         IF tek_b_12=1.AND.!EMPTY(text_4)
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n8 SAY text_4
              ENDIF
         ENDIF
         IF gpr_val
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY fvid_val
                   @ nstr,IIF(fvo='0',n4,n5) SAY sm_val PICTURE "999,999,999,999.99"
              ENDIF
         ENDIF
         FOR i=1 TO kbs
              IF mbs(i,1)=bkr.kor
                   EXIT
              ENDIF
         ENDFOR
         IF i>kbs
              kbs=i
              mbs(i,1)=bkr.kor
         ENDIF
         IF vo='0'
              fsumpr=fsumpr+bkr.sm
              IF gpr_val
                   fsumprv=fsumprv+bkr.sm_val
              ENDIF
              mbs(i,2)=mbs(i,2)+bkr.sm
         ELSE
              fsumrx=fsumrx+bkr.sm
              mbs(i,3)=mbs(i,3)+bkr.sm
              IF gpr_val
                   fsumrxv=fsumrxv+bkr.sm_val
              ENDIF
         ENDIF
    ENDSCAN
    IF ii>1
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,IIF(fvo='0',n4,n5) SAY REPLICATE('-',18)
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,IIF(fvo='0',n4,n5) SAY fsmo PICTURE "999,999,999,999.99"
         ENDIF
    ENDIF
ENDDO
nstr=nstr+3
IF nnstr>=nlist
    @ nstr-2,0 SAY REPLICATE('-',77)
    @ nstr-1,n1 SAY "Сальдо на начало"
    @ nstr-1,n6 SAY "Сальдо на конец"
    @ nstr,n1 SAY fsum               PICTURE "999,999,999,999.99"
    @ nstr,n4 SAY fsumpr             PICTURE "999,999,999,999.99"
    @ nstr,n5 SAY fsumrx             PICTURE "999,999,999,999.99"
    @ nstr,n6 SAY fsum+fsumpr-fsumrx PICTURE "999,999,999,999.99"
ENDIF
IF gpr_val
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY 'с дооценкой на конец месяца'
         @ nstr,n6 SAY Kurs_dat(fvid_val,fdat2,spr_bs.sm_valt+fsumprv-fsumrxv) PICTURE "999,999,999,999.99"
    ENDIF
    nstr=nstr+2
    IF nnstr>=nlist
         @ nstr-1,n1 SAY "Вид валюты "+fvid_val
         @ nstr,n1 SAY spr_bs.sm_valt     PICTURE "999,999,999,999.99"
         @ nstr,n4 SAY fsumprv            PICTURE "999,999,999,999.99"
         @ nstr,n5 SAY fsumrxv            PICTURE "999,999,999,999.99"
         @ nstr,n6 SAY spr_bs.sm_valt+fsumprv-fsumrxv PICTURE "999,999,999,999.99"
    ENDIF
ENDIF
* сортировка массива
DIMENSION mkorr(100,3)
mkorr=0
FOR j=1 TO kbs
    fmin='9999'
    imin=0
    FOR i=1 TO kbs
         IF fmin>mbs(i,1)
              fmin=mbs(i,1)
              imin=i
         ENDIF
    ENDFOR
    mkorr(j,1)=mbs(imin,1)
    mkorr(j,2)=mbs(imin,2)
    mkorr(j,3)=mbs(imin,3)
    mbs(imin,1)='9999'
    mbs(imin,2)=0
    mbs(imin,3)=0
ENDFOR
FOR i=1 TO kbs
    mbs(i,1)=mkorr(i,1)
    mbs(i,2)=mkorr(i,2)
    mbs(i,3)=mkorr(i,3)
ENDFOR
* конец сортировки
pr_per=.T.
FOR i=1 TO kbs
    nstr=nstr+1
    IF nnstr>=nlist
         IF pr_per
              @ nstr,n1 SAY 'в т.ч.'
              pr_per=.F.
         ENDIF
         @ nstr,n3 SAY mbs(i,1)
         @ nstr,n4 SAY mbs(i,2) PICTURE "999,999,999,999.99"
         @ nstr,n5 SAY mbs(i,3) PICTURE "999,999,999,999.99"
    ENDIF
ENDFOR
SET EXACT OFF
SEEK fnzk
SET EXACT ON
RELEASE ALL LIKE tek_b_??
EJECT
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN
