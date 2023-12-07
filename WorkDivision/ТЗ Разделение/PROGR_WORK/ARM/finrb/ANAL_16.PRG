PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii
n1=1
n2=9
n3=40
n4=59
n5=78
n6=97
n7=116
n8=135
mbs1=0
mbs2=0
mbs3=0
mbs4=0
nnstr=0
nstr=kolstr+1
ii=0
GO TOP
DO WHILE !EOF()
    fkp=kp
    ms1=0
    ms5=0
    mk1=0
    mk2=0
    fdat=DATE()
* опpеделение суммы аванса из остатков и из банка
    SELECT osdkom
    SET EXACT OFF
    SEEK nastf_k+fkp
    SET EXACT ON
    SCAN REST WHILE nastf_k=bs.AND.fkp=kp FOR !DELETE()
         ms5=ms5+kr-db
    ENDSCAN
    SELECT bk
    SET ORDER TO bk2
    SET EXACT OFF
    SEEK nastf_k+fkp
    SCAN REST WHILE nastf_k=kor.AND.fkp=kp FOR MONTH(dat)=ntmec.AND.!DELETE()
         ms5=ms5+IIF(vo='0',sm,-sm)
    ENDSCAN
    SET ORDER TO kp
    SEEK nastf_k+fkp
    SET EXACT ON
    SCAN REST WHILE nastf_k=nzk.AND.fkp=kp FOR MONTH(dat)=ntmec.AND.!DELETE()
         ms5=ms5+IIF(vo='1',sm,-sm)
    ENDSCAN
    SELECT skl
    SEEK fkp
    SELECT osdkomr
    SCAN REST WHILE fkp=kp
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         IF db>smdo.AND.!EMPTY(dat).AND.(fdat-dat)>=skl.kol_dn
              IF nastf_k#bs
                   ms1=ms1+db-smdo
                   IF dat<fdat2
                        mk1=mk1+db-smdo
                   ENDIF
                   IF dat<fdat1
                        mk2=mk2+db-smdo
                   ENDIF
              ENDIF
         ENDIF
         IF bs_op=nastf_k
              ms5=ms5-smdo
         ENDIF
    ENDSCAN
*
    SELECT avot
    SET EXACT OFF
    SEEK ffbs+fkp
    SET EXACT ON
    SCAN REST WHILE ffbs=bs.AND.fkp=kp FOR !DELETE()
         IF !EMPTY(dat).AND.smd>smdo.AND.(fdat-dat)>=skl.kol_dn
              ms1=ms1+smd-smdo
              IF dat<fdat2
                   mk1=mk1+smd-smdo
              ENDIF
              IF dat<fdat1
                   mk2=mk2+smd-smdo
              ENDIF
         ENDIF
         IF bs_op=nastf_k
              ms5=ms5-smdo
         ENDIF
    ENDSCAN
    IF ms1>=cfsum
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,2 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Ведомость по анализу задолженности: сумма >= "+LTRIM(STR(cfsum,15,2))+SPACE(12)+DTOC(DATE())
@ 1,0 SAY REPLICATE('-',135)+IIF(chg12=1,REPLICATE('-',31),'')
@ 2,0 SAY '|Код оp.|   Hаименование оpганизации   |    Hа '+DTOC(fdat2)+'   |    Hа '+DTOC(fdat1)+'   |По документообopот| Осталось авансов |       + / -      |'+IIF(chg12=1,'   Hаименование оpганизации   |','')
@ 3,0 SAY REPLICATE('-',135)+IIF(chg12=1,REPLICATE('-',31),'')
              ENDIF
              nstr=3
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fkp
              @ nstr,n2 SAY Spr_nam(osdkomr.pr_spr,fkp,30)
              @ nstr,n3 SAY mk1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n4 SAY mk2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n5 SAY ms1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n6 SAY ms5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n7 SAY ms1-ms5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              IF chg12=1
                   @ nstr,n8 SAY Spr_nam(osdkomr.pr_spr,fkp,30)
              ENDIF
         ENDIF
         mbs1=mbs1+mk1
         mbs2=mbs2+mk2
         mbs3=mbs3+ms1
         mbs4=mbs4+ms5
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',134)
         ENDIF
    ENDIF
    SELECT osdkomr
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "Итого"
    @ nstr,n3 SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n4 SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n5 SAY mbs3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n6 SAY mbs4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n7 SAY mbs3-mbs4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',134)
ENDIF
EJECT
RETURN
