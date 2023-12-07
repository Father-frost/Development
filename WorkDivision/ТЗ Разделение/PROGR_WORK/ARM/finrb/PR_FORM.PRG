PRIVATE scr,ii
SAVE SCREEN TO scr
*  запрос вводимых значений
SELECT form_ot
SET EXACT OFF
SEEK ffnf
SET EXACT ON
nstr=1
pr_read=.F.
SCAN REST WHILE nf=ffnf
    pr_zap=.F.
    i=1
    j=0
    ntek=1
    DO WHILE !EMPTY(AT('',text,i))
         j=j+1
         SELECT razm_ot
         SEEK ffnf+form_ot.npp
         jj=0
         SCAN REST WHILE nf=ffnf.AND.npp=form_ot.npp
              jj=jj+1
              IF jj=j
                   EXIT
              ENDIF
         ENDSCAN
         IF vid_f='0'
              pr_zap=.T.
              fff1=nam
              &fff1=0
              SELECT form_ot
              @ nstr,ntek SAY SUBSTR(text,ntek,AT('',text,i)-1)
              ntek=AT('',text,i)
              @ nstr,ntek GET &fff1 PICTURE RTRIM(razm_ot.formt) FUNCTION 'Z'
              ntek=ntek+LEN(RTRIM(razm_ot.formt))
         ENDIF
         i=i+2
         SELECT form_ot
    ENDDO
    IF pr_zap
         pr_read=.T.
         @ nstr,ntek SAY SUBSTR(text,ntek,100)
         nstr=nstr+1
    ENDIF
    SELECT form_ot
ENDSCAN
IF pr_read
    @ 0,0 TO nstr,79 DOUBLE
    READ
    RESTORE SCREEN FROM scr
    IF LASTKEY()=27
         RETURN
    ENDIF
ENDIF
*
SELECT form_ot
SET EXACT OFF
SEEK ffnf
SET EXACT ON
nstr=0
SCAN REST WHILE nf=ffnf
    i=1
    j=0
    ntek=1
    nstr=nstr+1
    DO WHILE !EMPTY(AT('',text,i))
         @ nstr,ntek SAY SUBSTR(text,ntek,AT('',text,i)-ntek)
         ntek=AT('',text,i)
         i=i+2
         j=j+1
         SELECT razm_ot
         SEEK ffnf+form_ot.npp
         jj=0
         SCAN REST WHILE nf=ffnf.AND.npp=form_ot.npp
              jj=jj+1
              IF jj=j
                   EXIT
              ENDIF
         ENDSCAN
         sss=0
         fff1=nam
         IF vid_f='1'
              fff2=formula
              IF EMPTY(fff2)
                   &fff1=0
              ELSE
                   &fff1=&fff2
              ENDIF
         ENDIF
         IF !EMPTY(fff1)
              sss=&fff1
         ENDIF
         SELECT form_ot
         IF LEFT(razm_ot.formt,1)#'X'
              IF TYPE('sss')='C'
                   @ nstr,ntek SAY sss
              ELSE
                   @ nstr,ntek SAY sss PICTURE RTRIM(razm_ot.formt) FUNCTION 'Z'
              ENDIF
         ENDIF
         ntek=ntek+LEN(RTRIM(razm_ot.formt))
    ENDDO
    @ nstr,ntek SAY RTRIM(SUBSTR(text,ntek,128))
    SELECT form_ot
ENDSCAN
EJECT
