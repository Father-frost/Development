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
    nammec=nammec+'�'
ELSE
    nammec=LEFT(nammec,LEN(nammec)-1)+'�'
ENDIF
namo=RTRIM(name_mec(MONTH(fdat)))
IF MONTH(fdat)=3.OR.MONTH(fdat)=8
    namo=namo+'�'
ELSE
    namo=LEFT(namo,LEN(namo)-1)+'�'
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
    @ nstr+ 2,0 SAY '| ���⠢騪 '+nschn1
    @ nstr+2,63 SAY '|'
    @ nstr+ 3,0 SAY '|'+spr_bs.scho1
    @ nstr+3,44 SAY '-------------------|'
    @ nstr+ 4,0 SAY '|'+LEFT(spr_bs.scho2,43)
    @ nstr+4,44 SAY '|   �ப �।��   |'
    @ nstr+ 5,0 SAY '|                                           |                  |'
    @ nstr+ 6,0 SAY '| �. '+spr_bs.schg
    @ nstr+6,44 SAY '|------------------|'
    @ nstr+ 7,0 SAY '|                                           |N ��� ���⠢騪�|'
    @ nstr+ 8,0 SAY '|                                           |    '+spr_bs.schl
    @ nstr+8,63 SAY '|'
    @ nstr+ 9,0 SAY '|                                           -------------------|'
    @ nstr+10,0 SAY '|   '+STR(DAY(fdatr),2)+' '+nammec+' '+STR(YEAR(fdatr),4)+' �.   ������ N '+fnrd
    @ nstr+10,63 SAY '|'
    @ nstr+11,0 SAY '|                                                              |'
    @ nstr+12,0 SAY '|       �।�⠢�塞 �� �⮬ �� ������                       |'
    @ nstr+13,0 SAY '|    '+STR(j,3)+' ���⥦��� �ॡ������ �� ⮢�ࠬ,   -------------------|'
    @ nstr+14,0 SAY '|  ���饭�� ��稭�� � '+STR(DAY(fdat),2)+' '+namo+' '+STR(YEAR(fdat),4)+' �.'
    @ nstr+14,44 SAY '|      �㬬�       |'
    @ nstr+15,0 SAY '|          �� �㬬�                         |'+TRANSFORM(fsum,'999,999,999,999.99')+'|'
    @ nstr+16,0 SAY '|--------------------------------------------------------------|'
    @ nstr+17,0 SAY '| ����� ����|      �㬬�       | ����� ����.|      �㬬�       |'
    @ nstr+18,0 SAY '| �ॡ������|                  | �ॡ������ |                  |'
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
    @ nstr+2,0 SAY '| ����� � ������ ���⠢騪� (�� 1-� ���.)      �஢�����     |'
    @ nstr+3,0 SAY '|                                                 ������       |'
    @ nstr+4,0 SAY '|                                                              |'
    @ nstr+5,0 SAY '|                                                ������       |'
    @ nstr+6,0 SAY '----------------------------------------------------------------'
ENDFOR
RETURN