ON KEY LABEL Alt-F1 
IF TRIM(PROG(1))='MIKOS'
    IF EMPTY(SYS(18))
         IF PROG(4)='VVODN'
              dof=LEFT(LTRIM(SYS(2007,PROG(3)))+'___',3)+LEFT(ALIAS()+'___',5)+'.DOC'
         ELSE
              dof=LEFT(LTRIM(SYS(2007,PROG(3)))+'___',3)+LEFT(LTRIM(SYS(2007,PROMPT()))+'_____',5)+'.DOC'
         ENDIF
    ELSE
         FOR dof=1 TO FCOUNT()
              IF FIELD(dof)=SYS(18)
                   EXIT
              ENDIF
         ENDFOR
         IF dof<=FCOUNT()
              IF !EMPTY(ALIAS())
                   IF !EMPTY(SYS(18))
                        dof=LEFT(ALIAS()+'__',4)+LEFT(SYS(18)+'__',4)+'.DOC'
                        MODI COMM &dof WINDOW Help_
                   ENDIF
              ENDIF
              ON KEY LABEL Alt-F1 DO Help_mik
              RETURN
         ENDIF
         IF LEFT(SYS(18),3)='NAS'.OR.LEFT(SYS(18),3)='TEK'
              dof=LEFT(LTRIM(SYS(2007,PROG(3)))+'___',3)+LEFT(SUBSTR(SYS(18),4,5)+'_______',5)+'.DOC'
         ELSE
              dof=LEFT(LTRIM(SYS(2007,PROG(3)))+'___',3)+LEFT(SYS(18)+'___',5)+'.DOC'
         ENDIF
    ENDIF
ELSE
    IF EMPTY(SYS(18))
         IF PROG(3)='VVODN'
              dof=LEFT(LTRIM(SYS(2007,PROG(2)))+'___',3)+LEFT(ALIAS()+'___',5)+'.DOC'
         ELSE
              dof=LEFT(LTRIM(SYS(2007,PROG(2)))+'___',3)+LEFT(LTRIM(SYS(2007,PROMPT()))+'_____',5)+'.DOC'
         ENDIF
    ELSE
         FOR dof=1 TO FCOUNT()
              IF FIELD(dof)=SYS(18)
                   EXIT
              ENDIF
         ENDFOR
         IF dof<=FCOUNT()
              IF !EMPTY(ALIAS())
                   IF !EMPTY(SYS(18))
                        dof=LEFT(ALIAS()+'__',4)+LEFT(SYS(18)+'__',4)+'.DOC'
                        MODI COMM &dof WINDOW Help_
                   ENDIF
              ENDIF
              ON KEY LABEL Alt-F1 DO Help_mik
              RETURN
         ENDIF
         IF LEFT(SYS(18),3)='NAS'.OR.LEFT(SYS(18),3)='TEK'
              dof=LEFT(LTRIM(SYS(2007,PROG(2)))+'___',3)+LEFT(SUBSTR(SYS(18),4,5)+'_______',5)+'.DOC'
         ELSE
              dof=LEFT(LTRIM(SYS(2007,PROG(2)))+'___',3)+LEFT(SYS(18)+'___',5)+'.DOC'
         ENDIF
    ENDIF
ENDIF
MODI COMM &dof WINDOW Help_
ON KEY LABEL Alt-F1 DO Help_mik
RETURN
