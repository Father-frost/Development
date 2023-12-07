PARAMETERS fpr_spr,fkp,flen
PRIVATE nam_file,fikl
nam_file=ALIAS()
fikl=SPACE(flen)
DO CASE
CASE fpr_spr='0'
    SELECT sprrab
    IF RECCOUNT()=0
         fikl=SPACE(flen)
    ELSE
         SET ORDER TO tab
         IF EOF().OR.BOF()
              GO TOP
         ENDIF
         nz=RECNO()
         IF SEEK(LEFT(fkp,6))
              fikl=LEFT(fio,flen)
         ELSE
              fikl=SPACE(flen)
              GO nz
         ENDIF
    ENDIF
CASE fpr_spr='1'
    SELECT skl
    IF RECCOUNT()=0
         fikl=SPACE(flen)
    ELSE
         SET ORDER TO kkl
         IF EOF().OR.BOF()
              GO TOP
         ENDIF
         nz=RECNO()
         IF SEEK(fkp)
              fikl=LEFT(ikl,flen)
         ELSE
              fikl=SPACE(flen)
              GO nz
         ENDIF
    ENDIF
CASE fpr_spr='2'
    SELECT sch
    IF RECCOUNT()=0
         fikl=SPACE(flen)
    ELSE
         SET ORDER TO sch
         IF EOF().OR.BOF()
              GO TOP
         ENDIF
         nz=RECNO()
         IF SEEK(LEFT(fkp,5))
              fikl=LEFT(icsk,flen)
         ELSE
              fikl=SPACE(flen)
              GO nz
         ENDIF
    ENDIF
ENDCASE
IF !EMPTY(nam_file)
    SELECT &nam_file
ENDIF
RETURN fikl
