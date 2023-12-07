DIMENSION mbs(100,3)
PRIVATE n1,n2,n3,n4,n5,n6,m1,m2,ii
n1=1
n2=9
n3=40
n4=59
nnstr=0
ii=0
GO TOP
nstr=kolstr+1
kolbs=0
mbs=0
jj=0
SCAN FOR MONTH(bkr.dat)=ntmec.AND.bkr.nzk=gfbs.AND.summa#0.AND.!DELETE()
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    FOR i=1 TO kolbs
         IF mbs(i,1)=nsk
              EXIT
         ENDIF
    ENDFOR
    IF i>kolbs
         kolbs=i
         mbs(i,1)=nsk
		IF nsk=tek_b_37
			jj=i
		ENDIF
    ENDIF
    IF bkr.vo='0'
         mbs(i,2)=mbs(i,2)+summa
    ELSE
         mbs(i,3)=mbs(i,3)+summa
    ENDIF
ENDSCAN
ms1=0
ms2=0
FOR i=1 TO kolbs
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+'.'+" Сводная ведомость по подразделениям за месяц "+RTRIM(tmec)+' по счету '+gfbs
@ 1,0 SAY REPLICATE('-',78)
@ 2,0 SAY "|Код под|   Hаименование подpазделения |    Поступление   |      Расход      |"
@ 3,0 SAY REPLICATE('-',78)
         ENDIF
         nstr=3
    ENDIF
	IF i#jj
    	nstr=nstr+1
    	IF nnstr>=nlist
         	@ nstr,n1 SAY mbs(i,1)
         	@ nstr,n2 SAY Spr_nam('2',mbs(i,1),30)
         	@ nstr,n3 SAY mbs(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         	@ nstr,n4 SAY mbs(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    	ENDIF
    	ms1=ms1+mbs(i,2)
    	ms2=ms2+mbs(i,3)
	ENDIF
ENDFOR
IF jj#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY REPLICATE('-',78)
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY 'Итого'
         @ nstr,n3 SAY ms1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n4 SAY ms2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY REPLICATE('-',78)
    ENDIF
	nstr=nstr+1
	IF nnstr>=nlist
     	@ nstr,n1 SAY mbs(jj,1)
     	@ nstr,n2 SAY Spr_nam('2',mbs(jj,1),30)
     	@ nstr,n3 SAY mbs(jj,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
     	@ nstr,n4 SAY mbs(jj,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
	ENDIF
	ms1=ms1+mbs(jj,2)
	ms2=ms2+mbs(jj,3)
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY REPLICATE('=',78)
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY 'Всего'
    @ nstr,n3 SAY ms1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n4 SAY ms2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
EJECT
RETURN
