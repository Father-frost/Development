IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE nz,nlist,fname,chg12,nstr,nnstr,nlist
DEFINE POPUP Tekm FROM 10,54 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Tekm PROMPT " Д\<ебет  "
DEFINE BAR 2 OF Tekm PROMPT " К\<редит "
ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
ACTIVATE POPUP Tekm
menu_v=BAR()
IF menu_v=0
    RETURN
ENDIF
IF menu_v=2
  SAVE SCREEN
  @ 16,40 FILL TO 20,72 COLOR &color20
  SET COLOR TO &color13
  @ 15,39,19,71 BOX box_2
  SET COLOR TO &color14
  ff2='    '
  @ 17,42 SAY "Балансовый счет оплаты " GET ff2
 READ
ENDIF
nz=RECNO()
nnstr=0
nstr=kolstr+1
*
chg12=0
fname="out.txt        "
nlist=1
pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.T.,pr_otk
IF pr_otk
    RETURN
ENDIF
*
fsum=0
s_64=0
s_60=0
s_76=0
SCAN FOR IIF(menu_v=1,bs=nastf_l,bs=nastf_k.and.(EMPTY(ff2).or.ff2=nzk)).AND.!DELETE()
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+" Сальдо по организациям на "+name_mec(ntmec)+' 19'+nastf_b+' г.'
@ 1,0 SAY IIF(menu_v=2,REPLICATE('-',88),REPLICATE('-',80))
@ 2,0 SAY "|  Код  |      Наименование организации     | Номер|  Дата  |       Сумма      |"+IIF(menu_v=2,'сч.опл.|','')
@ 3,0 SAY "|организ|                                   |докум.|докумен.|      "+IIF(menu_v=1,'дебет ','кредит')+"      |"+IIF(menu_v=2,'       |','')
@ 4,0 SAY IIF(menu_v=2,REPLICATE('-',88),REPLICATE('-',80))
*@ 4,0 SAY REPLICATE('-',80)
         ENDIF
         nstr=4
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr, 1 SAY kp
         @ nstr, 9 SAY Spr_nam(pr_spr,kp,30)
         @ nstr,45 SAY nrd
         @ nstr,52 SAY dat
         @ nstr,61 SAY IIF(menu_v=1,db-kr,kr-db) PICTURE '999,999,999,999.99'
         if menu_v=2
          @ nstr,85 SAY nzk
           if nzk='64'
             s_64=s_64+IIF(menu_v=1,db-kr,kr-db)
           endif
           if nzk='76'
             s_76=s_76+IIF(menu_v=1,db-kr,kr-db)
           endif
           if nzk='60'
             s_60=s_60+IIF(menu_v=1,db-kr,kr-db)
           endif
         endif
    ENDIF
    fsum=fsum+IIF(menu_v=1,db-kr,kr-db)
ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,1 SAY IIF(menu_v=2,REPLICATE('-',88),REPLICATE('-',80))
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr, 1 SAY 'Итого'
    @ nstr,61 SAY fsum PICTURE '999,999,999,999.99'
ENDIF
nstr=nstr+1
IF ff2='    '
IF nnstr>=nlist
    @ nstr,45 SAY 'в т.ч. сч.64 '
    @ nstr,61 SAY s_64 PICTURE '999,999,999,999.99'
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,45 SAY '       сч.60 '
    @ nstr,61 SAY s_60 PICTURE '999,999,999,999.99'
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,45 SAY '       сч.76 '
    @ nstr,61 SAY s_76 PICTURE '999,999,999,999.99'
ENDIF
ENDIF
fsum=fsum+IIF(menu_v=1,db-kr,kr-db)
EJECT
SET PRINTER TO
SET DEVICE TO SCREEN
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
GO nz
RETURN