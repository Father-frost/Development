PARAMETERS fdat1,fdat2,fnzk
SELECT bkr
SET ORDER TO nzk
sum1=0
sum2=0
sumv1=0
sumv2=0
SET EXACT OFF
SEEK fnzk
IF gpr_val
    fsum=Kurs_dat(spr_bs.vid_val,fdat1-1,spr_bs.sm_valt)
ELSE
    fsum=spr_bs.sald
ENDIF
SCAN REST WHILE nzk=fnzk FOR !DELETE()
    IF vo='0'
         sum1=sum1+bkr.sm
         IF gpr_val
              sumv1=sumv1+bkr.sm_val
         ENDIF
    ELSE
         sum2=sum2+bkr.sm
         IF gpr_val
              sumv2=sumv2+bkr.sm_val
         ENDIF
    ENDIF
ENDSCAN
SEEK fnzk
SET EXACT ON
HIDE WINDOW ALL
HIDE POPUP ALL
ACTIVATE SCREEN
DO Vvodn WITH "Chapob","Strsayob","Strgetob",.F.,.T.,.F.,.T.,"(nzk#fnzk)",;
              " "," "," "," "," "," "," "," "," ","pr_sver"," ",.T.
RETURN
