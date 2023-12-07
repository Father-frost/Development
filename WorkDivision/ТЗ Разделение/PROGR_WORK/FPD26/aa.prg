*:*****************************************************************************
*:
*:        Program: D:\FPD26\AA.PRG
*:
*:         System: 
*:         Author: 
*:      Copyright (c) 1910, 
*:  Last modified: 16/03/103     15:51
*:
*:          Calls: MSO.PRG
*:               : FORM99.PRG
*:               : PROCKU16.PRG
*:               : M0601061.PRG
*:               : MSOZ.PRG
*:
*:           Uses: &IF_D              
*:               : &IF_D10            
*:
*:        Indexes: &IF_I              
*:               : &IF_I101           
*:
*:    Other Files: &WWFIL
*:               : DBF
*:               : &WWFILD
*:
*:      Documented 09.03.10 at 14:26               FoxDoc  version 2.10f
*:*****************************************************************************
*m0601029
PARA sstr,ccol,q4nf,d_df
SET DEVI TO SCRE
IF .NOT. (FILE('&if_d10') .AND. FILE('&if_i101'))
   DO mso WITH 'Файл печати не сформирован.',9
   RETU
ENDIF
kler_15=0
SELE 1
if_d=pa_d+'spfond.dbf'
if_i=pa_d+'ispfond1.idx,'+pa_d+'ispfond2.idx'
USE &if_d INDE &if_i
IF kler_15=1
   CLOSE DATA
   RETU
ENDIF
SELE 2
USE &if_d10 INDE &if_i101
SELE 4
if_d=pa_d+'ls.dbf'
if_i=pa_d+'ils1.idx,'+pa_d+'ils2.idx,'+pa_d+'ils3.idx'
USE &if_d INDE &if_i
IF kler_15=1
   CLOSE DATA
   RETU
ENDIF
SET ORDER TO 3
DO WHILE .T.
   SELE 5
   kl_99=0
   DO form99
   IF kl_99=1
      UNLO ALL
      CLOSE DATA
      RETU
   ENDIF
   vd=0
   klku=0
   rku=0
   DO procku16
   IF klku=1
      CLOSE DATA
      RETU
   ENDIF
   wwfil='vv'+SUBS(STR(rku+10000,5),2,4)+'.txt'
   wwfild='a:vv'+SUBS(STR(rku+10000,5),2,4)+'.txt'
   klkuz=0
   
   @ 6,13 CLEA TO 17,66
   IF d_df=1
      @ 8,16 SAY 'ВЫГРУЗКА ЗАРАБОТ ОЙ ПЛАТЫ ПО БРИГАДЕ(ВИ ЧЕСТЕР)'
   ELSE
      @ 8,16 SAY ' ВЫГРУЗКА ЗАРАБОТ ОЙ ПЛАТЫ ПО БРИГАДЕ(ДИСКЕТУ)'
   ENDIF
   @ 10,17 SAY 'Для выгрузки зарплаты - Hажмите любую клавишу'
   @ 12,17 SAY '                Выход - ESC                  '
   READ
   IF READKEY()=12 .OR. READKEY()=268
      EXIT
   ENDIF
   SELE 1
   SEEK STR(rku,4)
   IF FOUND()
      nku=TRIM(ad)
   ELSE
      nku=' '
   ENDIF
   SAVE SCRE TO scr029
   z5fa=SPACE(20)
   DO m0601061 WITH sstr,ccol
   REST SCRE FROM scr029
   SET DEVI TO SCRE
   IF klkuz=1
      SELE 5
      GO TOP
      IF d_df=1
         COPY TO &wwfil TYPE SDF
      ELSE
         COPY TO &wwfil TYPE SDF
         SAVE SCRE TO eeer
         DO WHILE .T.
            klvv=0
            CLEAR
            xxx=1
            @ 11,30 SAY 'Выберите режим работы '
            @ 13,31 PROMPT 'Копирование '
            @ 13,45 PROMPT 'Выход '
            MENU TO xxx
            DO CASE
            CASE xxx=1
               CLEAR
               @ 1,14 SAY "********* КОПИРОВАHИЕ ФАЙЛА "+wwfil+" ************"
               @ 4,19 SAY "  УСТАHОВИТЕ HА УСТРОЙСТВО А: ДИСКЕТУ "
               @ 5,8 SAY "Hажмите любую клавишу для начала копиpования. Выход - ESC."
               READ
               IF READKEY()=12 .OR. READKEY()=268
                  klvv=1
                  EXIT
               ENDIF
               @ 4,0
               @ 5,0
               IF FILE('&wwfild')
                  klmso=2
                  DO msoz WITH 'Дублиpование файла '+wwfild+' на дискете.',9
                  IF klmso=2
                     LOOP
                  ELSE
                     DELETE FILE &wwfild
                  ENDIF
               ENDIF
               COPY TO &wwfild TYPE SDF
               EXIT
            CASE xxx=2
               EXIT
            ENDCASE
         ENDDO
         REST SCRE FROM eeer
      ENDIF
   ENDIF
ENDDO
CLOSE DATA
RETURN
*: EOF: AA.PRG
