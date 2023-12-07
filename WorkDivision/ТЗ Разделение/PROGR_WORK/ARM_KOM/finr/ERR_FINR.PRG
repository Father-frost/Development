PARAMETERS nerr,namerr,nstrerr
DEFINE WINDOW Error_ob FROM 0,0 TO 4,79 COLOR w/r
DEFINE WINDOW Err_set FROM 0,0 TO 3,79 COLOR w+/b
PRIVATE set_devi,ssss,i,pr_retu,ntek,nam_file
set_devi=.F.
IF SET('DEVICE')='PRINT'
     SET DEVICE TO SCREEN
     set_devi=.T.
ENDIF
pr_retu=.F.
DO CASE
CASE nerr=108.OR.nerr=1705
    i=2
    ACTIVATE WINDOW Err_set
    SET COLOR TO w+/b,w+/n
    @ 0,20 SAY " Файл недоступен. Что делать дальше  ?"
    @ 1,27 PROMPT ' Повтоpить '
    @ 1,41 PROMPT ' Игноpиpовать '
    MENU TO i
    RELEASE WINDOW Err_set
    IF i=1
         RETRY
    ELSE
         ssss=UPPER(LTRIM(MESSAGE(1)))
         ssss=LEFT(ssss,AT(' ',ssss,2))
         IF EMPTY(ssss)
              pr_retu=.T.
         ELSE
              &ssss
         ENDIF
    ENDIF
CASE nerr=109
    ACTIVATE WINDOW Err_set
    SET COLOR TO w+/b,w+/n
    @ 0,20 SAY " Запись заблокиpована. Что делать дальше  ?"
    @ 1,17 PROMPT ' Повтоpить '
    @ 1,33 PROMPT ' Игноpиpовать '
    @ 1,51 PROMPT ' Пpекpатить '
    MENU TO i
    RELEASE WINDOW Err_set
    DO CASE
    CASE i=1
         RETRY
    CASE i=0.OR.i=3
         pr_retu=.T.
    ENDCASE
CASE nerr=110
    i=2
    ACTIVATE WINDOW Err_set
    SET COLOR TO w+/b,w+/n
    @ 0,15 SAY " Файл откpыт немонопольно. Что делать дальше  ?"
    @ 1,27 PROMPT ' Повтоpить '
    @ 1,41 PROMPT ' Игноpиpовать '
    MENU TO i
    RELEASE WINDOW Err_set
    IF i=1
         RETRY
    ENDIF
CASE nerr=125
    ACTIVATE WINDOW Error_ob
    SET COLOR TO w+/r,w+/n
    @ 1,10 SAY " Принтер не готов. Продолжить работу ?"
    @ 2,52 PROMPT ' Да  '
    @ 2,61 PROMPT ' Hет '
    MENU TO i
    RELEASE WINDOW Error_ob
    IF i=0.OR.i=2
         pr_retu=.T.
    ELSE
         SET DEVICE TO PRINT
         RETRY
    ENDIF
CASE nerr=1707
    IF set_devi
         SET DEVICE TO PRINT
    ENDIF
    RETRY
CASE nerr=26.OR.nerr=5.OR.nerr=20.OR.nerr=1683.OR.;
     nerr=12.AND.LEFT(LTRIM(nstrerr),3)='SET'
    DO CASE
    CASE ALIAS()='BK'
         DO Ind_file WITH 1,3
    CASE ALIAS()='SPR_BS'
         DO Ind_file WITH 2,3
    CASE ALIAS()='OSD_PR'
         DO Ind_file WITH 3,3
    CASE ALIAS()='SPRNAZ'
         DO Ind_file WITH 4,3
    CASE ALIAS()='DV_PR'
         DO Ind_file WITH 5,3
    CASE ALIAS()='SPR_GRUP'
         DO Ind_file WITH 6,3
    CASE ALIAS()='PR'
         DO Ind_file WITH 7,3
    CASE ALIAS()='SPRT'
         DO Ind_file WITH 8,3
    CASE ALIAS()='SCH'
         DO Ind_file WITH 9,3
    CASE ALIAS()='SKL'
         DO Ind_file WITH 10,3
    CASE ALIAS()='KREDIT'
         DO Ind_file WITH 11,3
    CASE ALIAS()='SPRRAB'
         DO Ind_file WITH 12,3
    CASE ALIAS()='AVOT'
         DO Ind_file WITH 13,3
    CASE ALIAS()='AVOTR'
         DO Ind_file WITH 14,3
    CASE ALIAS()='OSDKOM'
         DO Ind_file WITH 15,3
    CASE ALIAS()='OSTRK'
         DO Ind_file WITH 16,3
    CASE ALIAS()='MATR'
         DO Ind_file WITH 17,3
    CASE ALIAS()='OSDKOM1'
         DO Ind_file WITH 18,3
    CASE ALIAS()='SPR_REG'
         DO Ind_file WITH 19,3
    CASE ALIAS()='OSD_79'
         DO Ind_file WITH 20,3
    CASE ALIAS()='ATOT'
         DO Ind_file WITH 21,3
    CASE ALIAS()='VN_71'
         DO Ind_file WITH 22,3
    CASE ALIAS()='SPR_VID'
         DO Ind_file WITH 23,3
    CASE ALIAS()='SPR_VAL'
         DO Ind_file WITH 24,3
    CASE ALIAS()='KURS_VAL'
         DO Ind_file WITH 25,3
    CASE ALIAS()='LIM_NSK'
         DO Ind_file WITH 26,3
    CASE ALIAS()='SPR_KART'
         DO Ind_file WITH 27,3
    CASE ALIAS()='YD_71'
         DO Ind_file WITH 28,3
    CASE ALIAS()='FORM_OT'
         DO Ind_file WITH 29,3
    CASE ALIAS()='RAZM_OT'
         DO Ind_file WITH 30,3
    CASE ALIAS()='DV_79'
         DO Ind_file WITH 31,3
    CASE ALIAS()='DV79_ARC'
         DO Ind_file WITH 32,3
    CASE ALIAS()='DV_DP'
         DO Ind_file WITH 33,3
    CASE ALIAS()='KODZK'
         DO Ind_file WITH 34,3
    CASE ALIAS()='SUPAVOT'
         DO Ind_file WITH 39,3
    CASE ALIAS()='DV_KP'
         DO Ind_file WITH 40,3
    CASE ALIAS()='OSD_PRR'
         DO Ind_file WITH 41,3
    CASE ALIAS()='DV_MOL'
         DO Ind_file WITH 42,3
    CASE ALIAS()='SPR_LIM'
         DO Ind_file WITH 43,3
    CASE ALIAS()='SCHR'
         DO Ind_file WITH 44,3
    CASE ALIAS()='AVOTRR'
         DO Ind_file WITH 45,3
    CASE ALIAS()='DV_PRR'
         DO Ind_file WITH 46,3
    CASE ALIAS()='OSTRKR'
         DO Ind_file WITH 47,3
    CASE ALIAS()='BKR'
         DO Ind_file WITH 48,3
    CASE ALIAS()='OSDKOMR'
         DO Ind_file WITH 49,3
    CASE ALIAS()='BK_ARC'
         DO Ind_file WITH 50,3
    CASE ALIAS()='TRAN_OPL'
         DO Ind_file WITH 51,3
    CASE ALIAS()='TRAN_POS'
         DO Ind_file WITH 52,3
    CASE ALIAS()='SPR_NRD'
         DO Ind_file WITH 53,3
    CASE ALIAS()='KAS_71'
         DO Ind_file WITH 54,3
    CASE ALIAS()='ATOT_ARC'
         DO Ind_file WITH 56,3
    CASE ALIAS()='AVOT_ARC'
         DO Ind_file WITH 57,3
    CASE ALIAS()='AVTR_ARC'
         DO Ind_file WITH 58,3
    CASE ALIAS()='DVPR_ARC'
         DO Ind_file WITH 59,3
    ENDCASE
CASE nerr=114.OR.nerr=1104
    ssss=UPPER(LTRIM(MESSAGE(1)))
    ssss=TRIM(SUBSTR(ssss,AT(' ',ssss)+1))
    IF ssss='...'
         ! del *.cdx
         i=1
         ntek=1
         DO WHILE !EMPTY(AT(';',nastf_p,i)))
              ssss='!del '+SUBSTR(nastf_p,ntek,AT(';',nastf_p,i)-ntek)+'\*.cdx'
              &ssss
              ntek=AT(';',nastf_p,i)+1
              i=i+1
         ENDDO
         ssss='!del '+RTRIM(SUBSTR(nastf_p,ntek,LEN(nastf_p)))+'\*.cdx'
         &ssss
         DO Net_n WITH 10,'Были разрушены индексы. Повторно запустите задачу...'
         QUIT
    ELSE
         IF RIGHT(ssss,9)='EXCLUSIVE'
              ssss=TRIM(LEFT(ssss,LEN(ssss)-9))
         ENDIF
		IF RIGHT(ssss,6)='I_ALIA'
         	ssss=I_ALIA
		ENDIF
         ssss='DELETE FILE '+STUFF(FULLPATH(ssss+'.dbf'),LEN(FULLPATH(ssss+'.dbf'))-2,3,'CDX')
         &ssss
    ENDIF
	RETRY
CASE nerr=15
    DO Net_n WITH 10,'Запорчен один из DBF-файлов. Воспользуйтесь "Сервис"->"Поиск ошибки"...'
    pr_retu=.T.
OTHERWISE
    DO CASE
    CASE nerr=12
         namerr=STUFF(namerr,1,8,'Пеpеменная')
         namerr=STUFF(namerr,AT('not',namerr),9,'не найдена')
    OTHERWISE
         nam_file=ALIAS()
         SELECT 0
         USE err_text
         LOCATE FOR kod=nerr
         IF FOUND()
              namerr=text
         ENDIF
         USE
         IF !EMPTY(nam_file)
              SELECT &nam_file
         ENDIF
    ENDCASE
    ACTIVATE WINDOW Error_ob
    SET COLOR TO w+/r
    strzav="Завершение - <Esc>"
    lennamer=MAX(LEN(namerr),LEN(nstrerr))
    IF lennamer<20
         lennamer=20
    ENDIF
    IF lennamer>75
         lennamer=75
         nstrerr=LEFT(nstrerr,75)
    ENDIF
    leftcol=(75-lennamer)/2
    richtcol=leftcol+lennamer+4
    @ 0,leftcol+2 SAY namerr
    @ 1,leftcol+2 SAY nstrerr
    @ 2,leftcol+2 SAY strzav
    READ
    RELEASE WINDOW Error_ob
    IF LASTKEY()=27
         pr_retu=.T.
    ENDIF
ENDCASE
IF pr_retu
    SET ESCAPE OFF
    SET DELETED OFF
    HIDE WINDOW ALL
    ACTIVATE SCREEN
    SET PROCEDURE TO Procgol
    RESTORE SCREEN FROM scrg
    FOR i=1 TO 25
         ssss='SELECT '+STR(i,2)
         &ssss
         IF ALIAS()#'SCH'.AND.ALIAS()#'SPRT'.AND.ALIAS()#'SPRNAZ'.AND.;
            ALIAS()#'SKL'.AND.ALIAS()#'SPRRAB'.AND.;
            ALIAS()#'BK'.AND.ALIAS()#'SPR_BS'.AND.ALIAS()#'SPR_GRUP'.AND.ALIAS()#'SPR_REG'
              IF (nastf_8=0.OR.nastf_8=1.AND.ALIAS()#'SPR_VAL'.AND.ALIAS()#'KURS_VAL')
                   USE
              ENDIF
         ENDIF
    ENDFOR
    ON KEY
    ON KEY LABEL Alt-F9
    RETURN TO MASTER
ENDIF
IF set_devi
     SET DEVICE TO PRINT
ENDIF
RETURN
