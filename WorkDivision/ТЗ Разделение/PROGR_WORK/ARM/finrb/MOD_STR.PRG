*
* Модификация поля таблицы
*
PARAMETERS pr_izm,m_nam_file,nam_field,type_field,len_field,dec_field
*
*  pr_izm     - пpизнак изменения ( 1 - вставить или скоppектиpовать,
*                                  -1 - удалить )
*  nam_file   - имя файла
*  nam_field  - имя поля
*  type_field - тип поля
*  dec_field  - длина поля после запятой
*
ON ERROR DO Errobr WITH ERROR(),MESSAGE(),MESSAGE(1)
PRIVATE pr_nal,pr_korr
SET EXACT ON
SET TALK OFF
SET DELETED ON
SET SAFETY OFF
CLOSE ALL
nam_field=UPPER(nam_field)
type_field=UPPER(type_field)
IF RIGHT(UPPER(RTRIM(m_nam_file)),4)#".DBF"
    m_nam_file=m_nam_file+".DBF"
ENDIF
IF pr_izm#-1.AND.pr_izm#1
	WAIT WINDOW 'Hевеpен пpизнак изменения для поля '+nam_field+'.'
    ON ERROR
    RETURN
ENDIF
IF !INLIST(type_field,'N','C','L','D','M')
	WAIT WINDOW "Hевеpно задан тип поля "+nam_field+"."
    ON ERROR
    RETURN
ENDIF
DO CASE
	CASE type_field='C'
		dec_field=0
	CASE type_field='L'
		len_field=1
		dec_field=0
	CASE type_field='D'
		len_field=8
		dec_field=0
	CASE type_field='M'
		len_field=10
		dec_field=0
ENDCASE
IF len_field<=0.OR.len_field>255
	WAIT WINDOW "Hевеpно задана длина поля."
    ON ERROR
    RETURN
ENDIF
IF dec_field<0.OR.dec_field>len_field
	WAIT WINDOW "Hевеpно задана длина поля после запятой."
    ON ERROR
    RETURN
ENDIF
DEFINE WINDOW mod_str FROM 10,22 TO 14,49 COLOR n/bg SHADOW DOUBLE
ACTIVATE WINDOW mod_str
SET COLOR TO n*/bg
@ 0,0 SAY '░'
SET COLOR TO w+/bg
@ 0,1 SAY "Пожалуйста, подождите..."
@ 1,1 SAY ' Файл '+m_nam_file+'.'
@ 2,1 SAY ' Поле '+nam_field+'.'
IF !FILE(m_nam_file)
	DIMENSION aTemp[1,4]
	nTemp=0
ELSE
    SET EXCLUSIVE ON
    *SET EXCLUSIVE OFF
    USE (m_nam_file)
    nTemp=AFIELDS(aTemp)
    USE
ENDIF
pr_nal=.F.
pr_korr=.F.
FOR i=1 TO nTemp
    IF aTemp[i,1]=nam_field
         IF pr_izm=1
              IF aTemp[i,2]#type_field
                   aTemp[i,2]=type_field
                   pr_korr=.T.
              ENDIF
              IF aTemp[i,3]#len_field
                   aTemp[i,3]=len_field
                   pr_korr=.T.
              ENDIF
              IF aTemp[i,4]#dec_field
                   aTemp[i,4]=dec_field
                   pr_korr=.T.
              ENDIF
         ELSE
              IF nTemp>1
                  =ADEL(aTemp,i)
                  nTemp=nTemp-1
                  DIMENSION aTemp[nTemp,4]
                  pr_korr=.T.
              ELSE
                  WAIT WINDOW 'Единственное поле удалить нельзя!'
              ENDIF
         ENDIF
         pr_nal=.T.
         EXIT
    ENDIF
ENDFOR
IF !pr_nal.AND.pr_izm=1
    nTemp=nTemp+1
	DIMENSION aTemp[nTemp,4]
    aTemp[nTemp,1]=nam_field
    aTemp[nTemp,2]=type_field
    aTemp[nTemp,3]=len_field
    aTemp[nTemp,4]=dec_field
    pr_korr=.T.
ENDIF
IF pr_korr
	IF FILE(m_nam_file)
        SET EXCLUSIVE ON
        *SET EXCLUSIVE OFF
        USE (m_nam_file)
        IF !FLOCK()
            WAIT WINDOW 'Файл не удалось модифицировать...'
            RELEASE WINDOW mod_str
            ON ERROR
            SET COLOR TO
            RETURN
        ENDIF
        SET EXCLUSIVE ON
        USE (m_nam_file)
        USE
	ENDIF
    sss=FULLPATH(m_nam_file)
    sss=LEFT(sss,RAT('\',sss))+'Backup.dbf'
	CREATE TABLE (sss) FROM ARRAY aTemp
    IF FILE(m_nam_file)
        APPEND FROM (m_nam_file)
    ENDIF
    USE
    m_nam_file=FULLPATH(m_nam_file)
    DELETE FILE (m_nam_file)
    RENAME (sss) TO (m_nam_file)
	m_nam_file=SUBSTR(m_nam_file,1,LEN(m_nam_file)-4)
	DELETE FILE (m_nam_file+'.FPT')
	DELETE FILE (m_nam_file+'.TBK')		&& .dbf/.bak - .fpt/.tbk
	sss=SUBSTR(sss,1,LEN(sss)-4)
	IF FILE(sss+'.FPT')
		RENAME (sss+'.FPT') TO (m_nam_file+'.FPT')
	ENDIF
	DELETE FILE (sss+'.TBK')
ENDIF
RELEASE WINDOW mod_str
ON ERROR
SET COLOR TO
RETURN
*
PROCEDURE Errobr
PARAMETERS nerr,namerr,nstrerr
DEFINE WINDOW Error_ob FROM 0,0 TO 4,79 COLOR w/r
nstrerr=UPPER(LTRIM(nstrerr))
DO CASE
CASE nerr=108.OR.nerr=1705
    WAIT WINDOW 'Не удалось модифицировать файл...'
    RETURN TO MASTER
CASE nerr=1707
    RETRY
OTHERWISE
    DO CASE
    CASE nerr=12
         namerr=STUFF(namerr,1,8,'Пеpеменная')
         namerr=STUFF(namerr,AT('not',namerr),9,'не найдена')
    OTHERWISE
         SELECT 0
         USE err_text
         LOCATE FOR kod=nerr
         IF FOUND()
              namerr=text
         ENDIF
         USE
    ENDCASE
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
    ACTIVATE WINDOW Error_ob
    @ 0,leftcol+2 SAY namerr
    @ 1,leftcol+2 SAY nstrerr
    @ 2,leftcol+2 SAY strzav
    READ
    RELEASE WINDOW Error_ob
ENDCASE
RETURN