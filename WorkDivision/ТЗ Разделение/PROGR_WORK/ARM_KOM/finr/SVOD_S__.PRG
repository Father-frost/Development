* Сводная ведомость по командировочным расходам по счету 26
PRIVATE ii,sum1
n1=0
n2=8
n3=38
n4=57
nnstr=0
nstr=kolstr+1
ii=0
fsmk1=0
fsmk2=0
DO WHILE kor=ffkor.AND.!EOF()
   smk1=0
   smk2=0
   sum1=0
   ftab=tab
   ffio=LEFT(sprrab.fio,29)
   SCAN REST WHILE ftab=tab
        ii=ii+1
        ?? ii PICTURE '999999' AT 18
           IF LEFT(nzk,1)='1'.OR.LEFT(nzk,1)='9'
              IF vid_val#'      '
                 IF ssut_val#0
                        * DO K_val WITH 'avotr.vid_val',avotr.dat,'avotr.ssut_val','sum1'
                  DO Repl_sum WITH sum1,vid_val,ssut_val,dat
                     smk1=smk1+sum1
                     smk2=smk2+sum1
                     sum1=0
                 ENDIF
                 IF skvart_val#0
                        * DO K_val WITH 'avotr.vid_val',avotr.dat,'avotr.skvart_val','sum1'
                  DO Repl_sum WITH sum1,vid_val,skvart_val,dat
                     smk1=smk1+sum1
                     sum1=0
                 ENDIF
                 IF sproez_val#0
                        * DO K_val WITH 'avotr.vid_val',avotr.dat,'avotr.sproez_val','sum1'
                  DO Repl_sum WITH sum1,vid_val,sproez_val,dat
                     smk1=smk1+sum1
                     sum1=0
                 ENDIF
              ELSE
                 smk1=smk1+ssut+sproezd+skvart
                 smk2=smk2+ssut
              ENDIF
           ENDIF
           IF LEFT(nzk,1)='6'
              IF vid_val#'      '
                 IF sproch_val#0
                        * DO K_val WITH 'avotr.vid_val',avotr.dat,'avotr.sproch_val','sum1'
                  DO Repl_sum WITH sum1,vid_val,sproch_val,dat
                     smk2=smk2+sum1
                     sum1=0
                 ENDIF
              ELSE
                 smk2=smk2+sproch
              ENDIF
           ENDIF
    ENDSCAN
    IF smk1#0.OR.smk2#0
       IF nstr>kolstr
          nnstr=nnstr+1
          DO Chap1 WITH nnstr,nstr,nlist
       ENDIF
       nstr=nstr+1
       IF nnstr>=nlist
          @ nstr,n1 SAY '|'+LEFT(ftab,5)+'|'
          @ nstr,n2 SAY ffio+'|'
          @ nstr,n3 SAY smk1 PICTURE '999999999.99'+'      |'
          @ nstr,n4 SAY smk2 PICTURE '999999999.99'+'      |'

          fsmk1=fsmk1+smk1
          fsmk2=fsmk2+smk2
          DO Chap2 WITH nnstr,nstr,nlist
       ENDIF
    ENDIF
       * nstr=nstr+1
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "|Итого:                              |"
    @ nstr,n3 SAY fsmk1 PICTURE '999,999,999.99'+'    |'
    @ nstr,n4 SAY fsmk2 PICTURE '999,999,999.99'+'    |'
ENDIF
DO Chap2 WITH nnstr,nstr,nlist
EJECT
RETURN
*
PROCEDURE Chap1
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,0  SAY "Лист "+STR(nst,2)
    @ 0,12 SAY "Сводная ведомость по кор.счету 26" +' за '+RTRIM(tmec)+' месяц  '+nastf_b+' г.'
    @ 1,0  SAY REPLICATE('-',76)
    @ 2,0  SAY '|Табел|   Фамилия, имя, отчество     |      Сумма       |      Сумма       |'
    @ 3,0  SAY '|номер|                              |(сут.+проезд+гост)|(суточн.+ подъемн)|'
    @ 5,0  SAY REPLICATE('-',76)
ENDIF
nstr=5
RETURN
*
PROCEDURE Chap2
PARAMETERS nst,nstr,nlist
nstr=nstr+1
IF nst>=nlist
    @ nstr,0 SAY REPLICATE('-',76)
ENDIF
RETURN
*
*PROCEDURE k_val             && перевод суточных в валюте в бел. руб
*PARAMETERS kval,datval,sumval,summar
*PRIVATE nam_file
*nam_file=ALIAS()
*IF &sumval#0
*    SELECT kurs_val
*    SET NEAR ON
*    SEEK &kval+DTOC(datval,1)
*    SET NEAR OFF
*    IF !FOUND()
*         SKIP -1
*    ENDIF
*    IF &kval=kod.AND.kurs_val.kurs#0
*         IF LEN(nam_file)#0
*              SELECT &nam_file
*         ENDIF
*                 REPLACE &summar WITH ROUND(&sumval*kurs_val.summa/kurs_val.kurs,0)
*        sum1= ROUND(&sumval*kurs_val.summa/kurs_val.kurs,0)
*    ENDIF
*    IF LEN(nam_file)#0
*         SELECT &nam_file
*    ENDIF
*ELSE
         * REPLACE &summar WITH 0
*     sum1=0
*ENDIF
*RETURN

PROCEDURE Repl_sum   && перевод суточных в валюте в бел. руб
PARAMETERS fsum1,fvid_val,fsm_val,fdat
fsum1=Kurs_dat(fvid_val,fdat,fsm_val)
RETURN .T.