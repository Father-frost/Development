IF RECCOUNT()=0
    RETURN
ENDIF
PRIVATE fsum,i,ii,j,nammec
RESTORE FROM nsch ADDITIVE
fsum=0
j=0
SCAN
    fsum=fsum+sm
    j=j+1
ENDSCAN
nammec=RTRIM(name_mec(MONTH(fdatr)))
IF MONTH(fdatr)=3.OR.MONTH(fdatr)=8
    nammec=nammec+'а'
ELSE
    nammec=LEFT(nammec,LEN(nammec)-1)+'я'
ENDIF
namo=RTRIM(name_mec(MONTH(fdat)))
IF MONTH(fdat)=3.OR.MONTH(fdat)=8
    namo=namo+'а'
ELSE
    namo=LEFT(namo,LEN(namo)-1)+'я'
ENDIF
FOR ii=1 TO fkol
    ?? ii PICTURE '999999' AT 18
    IF nastf_n=0
         nstr=0
    ELSE
         nstr=PROW()+nastf_6
    ENDIF
    @ nstr   ,0 SAY '|                                                |   0401014   |'
    @ nstr+ 1,0 SAY '|                                                --------------|'
    @ nstr+ 2,0 SAY '| Поставщик '+nschn1
    @ nstr+2,63 SAY '|'
    @ nstr+ 3,0 SAY '|'+spr_bs.scho1
    @ nstr+3,44 SAY '-------------------|'
    @ nstr+ 4,0 SAY '|'+LEFT(spr_bs.scho2,43)
    @ nstr+4,44 SAY '|   Срок кредита   |'
    @ nstr+ 5,0 SAY '|                                           |                  |'
    @ nstr+ 6,0 SAY '| г. '+spr_bs.schg
    @ nstr+6,44 SAY '|------------------|'
    @ nstr+ 7,0 SAY '|                                           |N счета поставщика|'
    @ nstr+ 8,0 SAY '|                                           |    '+spr_bs.schl
    @ nstr+8,63 SAY '|'
    @ nstr+ 9,0 SAY '|                                           -------------------|'
    @ nstr+10,0 SAY '|   '+STR(DAY(fdatr),2)+' '+nammec+' '+STR(YEAR(fdatr),4)+' г.   РЕЕСТР N '+fnrd
    @ nstr+10,63 SAY '|'
    @ nstr+11,0 SAY '|                                                              |'
    @ nstr+12,0 SAY '|       Представляем при этом на инкассо                       |'
    @ nstr+13,0 SAY '|    '+STR(j,3)+' платежных требований по товарам,   -------------------|'
    @ nstr+14,0 SAY '|  отпущенным начиная с '+STR(DAY(fdat),2)+' '+namo+' '+STR(YEAR(fdat),4)+' г.'
    @ nstr+14,44 SAY '|      Сумма       |'
    @ nstr+15,0 SAY '|          на сумму                         |'+TRANSFORM(fsum,'999,999,999,999.99')+'|'
    @ nstr+16,0 SAY '|--------------------------------------------------------------|'
    @ nstr+17,0 SAY '| Номер плат|      Сумма       | Номер плат.|      Сумма       |'
    @ nstr+18,0 SAY '| требования|                  | требования |                  |'
    @ nstr+19,0 SAY '|-----------|------------------|------------|------------------|'
    nstr=nstr+19
    SCAN
         nstr=nstr+1
         @ nstr,0 SAY '|   '+bkr.nrd+'  |'+TRANSFORM(bkr.sm,'999,999,999,999.99')+'|'
         SKIP
         IF EOF()
              @ nstr,44 SAY '|'+SPACE(18)+'|'
         ELSE
              @ nstr,35 SAY bkr.nrd+'   |'+TRANSFORM(bkr.sm,'999,999,999,999.99')+'|'
         ENDIF
    ENDSCAN
    @ nstr+1,0 SAY '|--------------------------------------------------------------|'
    @ nstr+2,0 SAY '| Печать и подписи поставщика (на 1-м экз.)      Проведено     |'
    @ nstr+3,0 SAY '|                                                 банком       |'
    @ nstr+4,0 SAY '|                                                              |'
    @ nstr+5,0 SAY '|                                                Подписи       |'
    @ nstr+6,0 SAY '----------------------------------------------------------------'
ENDFOR
RETURN