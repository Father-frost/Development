* ведомость для расчетного отдела
PARAMETERS fdat1,fdat2,fnzk
PRIVATE nlist,fname,chg12,nstr,nnstr,nlist
nnstr=0
nstr=kolstr+1
nom=0
fsum=0
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
DO WHILE nzk=fnzk.AND.!EOF()
   smk=0
   ftab=LEFT(kp,5)
   nom=nom+1
   ftext_1= text_1
   SCAN REST WHILE ftab=kp FOR !DELETE()
        IF dat>=fdat1.AND.dat<=fdat2
           smk=smk+sm
        ENDIF
   ENDSCAN
   IF smk#0
      IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1 WITH nnstr,nstr,nlist
      ENDIF
      nstr=nstr+1
      IF nnstr>=nlist
         @ nstr,0  SAY '|'+Str(nom,2)+'   |'
         @ nstr,7  SAY ftab+'|'
           SELECT sprrab
           SEEK ftab
           SELECT bk
         @ nstr,13 SAY LEFT(sprrab.fio,30)+'|'
         @ nstr,44 SAY smk PICTURE "999,999,999,999.99"+'|'
         @ nstr,66 SAY ftext_1
         IF tek_b_12=1.AND.!EMPTY(text_2)
            IF nstr>kolstr
               nnstr=nnstr+1
               DO Chap1 WITH nnstr,nstr,nlist
            ENDIF
            nstr=nstr+1
            IF nnstr>=nlist
               @ nstr,64 SAY text_2
            ENDIF
         ENDIF
         IF tek_b_12=1.AND.!EMPTY(text_3)
            IF nstr>kolstr
               nnstr=nnstr+1
               DO Chap1 WITH nnstr,nstr,nlist
            ENDIF
            nstr=nstr+1
            IF nnstr>=nlist
               @ nstr,64 SAY text_3
            ENDIF
         ENDIF
         IF tek_b_12=1.AND.!EMPTY(text_4)
            IF nstr>kolstr
               nnstr=nnstr+1
               DO Chap1 WITH nnstr,nstr,nlist
            ENDIF
            nstr=nstr+1
            IF nnstr>=nlist
               @ nstr,64 SAY text_4
            ENDIF
         ENDIF
      ENDIF
      fsum=fsum+smk
      DO Chap2 WITH nnstr,nstr,nlist
   ENDIF
ENDDO
nstr=nstr+1
@ nstr,1  SAY "Итого по ведомости"
@ nstr,44 SAY fsum PICTURE "999,999,999,999.99"
RELEASE ALL LIKE tek_b_??
EJECT
SET PRINTER TO
SET DEVICE TO SCREEN
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN

PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
     @ 0,0 SAY "Ведомость для выплаты командировочных расходов по счету "+fnzk+" с "+DTOC(fdat1)+" по "+DTOC(fdat2)
     @ 1,0 SAY REPLICATE('-',104)
     @ 2,0 SAY "|Поряд|Табел|       Ф.И.О. pаботника       |       Сумма      |        Текст                           |"
     @ 3,0 SAY "|номер|номер|                              |                  |                                        |"
     @ 4,0 SAY REPLICATE('-',104)
ENDIF
nstr=4
RETURN

PROCEDURE Chap2
PARAMETERS nst,nstr,nlist
nstr=nstr+1
IF nst>=nlist
    @ nstr,0 SAY REPLICATE('-',104)
ENDIF
RETURN