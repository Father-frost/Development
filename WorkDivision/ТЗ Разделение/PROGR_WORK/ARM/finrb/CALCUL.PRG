PRIVATE name_fil,kol_fiel,pr_pole,cal_i
name_fil=VARREAD()
IF TYPE(name_fil)='N'
    kol_fiel=FCOUNT()
    pr_pole=.F.
    FOR cal_i=1 TO kol_fiel
	     IF FIELD(cal_i)=name_fil
	          pr_pole=.T.
              EXIT
	     ENDIF
    ENDFOR
	IF pr_pole
         REPLACE &name_fil WITH _calcvalue
    ELSE
         &name_fil=_calcvalue
    ENDIF
ENDIF
RETURN
