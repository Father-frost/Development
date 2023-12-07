DIMENSION mgod(20,13)
PRIVATE n1,n2,n3,n4,n5,n6,ii
n1=1
n2=9
n3=40
n4=47
n5=52
n6=61
n7=70
n8=79
n9=88
n10=97
n11=106
n12=115
n13=124
n14=133
n15=142
n16=151
n17=160
n18=169
ffffsum=0
nnstr=0
nstr=kolstr+1
mgod=0
kol_god=0
ii=0
GO TOP
DO WHILE !EOF()
    fkp=kp
    pr_per=.T.
    fffsum=0
    DO WHILE fkp=kp.AND.!EOF()
         pr_god=.T.
         pr_nrd=.T.
         fgod=YEAR(dat)
         ffsum=0
         DO WHILE fgod=YEAR(dat).AND.fkp=kp.AND.!EOF()
              fms=MONTH(dat)
              fsum=0
              fnrd=''
              SCAN REST WHILE fms=MONTH(dat).AND.fgod=YEAR(dat).AND.fkp=kp
                   ii=ii+1
                   ?? ii PICTURE '999999' AT 18
                   fsum=fsum+kr
                   fnrd=nrd
              ENDSCAN
              FOR i=1 TO kol_god
                   IF mgod(i,1)=fgod
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kol_god
                   kol_god=i
                   mgod(i,1)=fgod
              ENDIF
              mgod(i,IIF(fms=0,2,fms+1))=mgod(i,IIF(fms=0,2,fms+1))+fsum
              ffsum=ffsum+fsum
              fsum=ROUND(fsum,-3)/1000.0
              IF fsum#0
                   IF pr_god
                        IF nstr>kolstr
                             nnstr=nnstr+1
                             IF nnstr>=nlist
@ 0,2 SAY "Лист "+STR(nnstr,2)+". Ведомость по задолженности поставщикам на "+DTOC(ffdat) +" в тыс.руб."
@ 1,0 SAY REPLICATE('-',178)
@ 2,0 SAY '|       |                              |      |    |                                           М е с я ц ы                                                                       |'
@ 3,0 SAY '|  Код  |   Hаименование оpганизации   | Hомеp| Год|-----------------------------------------------------------------------------------------------------------------------------|'
@ 4,0 SAY '|       |                              | счета|    |    1   |    2   |    3   |    4   |    5   |    6   |    7   |    8   |    9   |   10   |   11   |   12   | Итого  | Всего  |'
@ 5,0 SAY REPLICATE('-',178)
                             ENDIF
                             nstr=5
                        ENDIF
                        nstr=nstr+1
                        pr_god=.F.
                   ENDIF
                   IF nnstr>=nlist
                        IF pr_per
                             @ nstr,n1 SAY fkp
                             pr_per=.F.
                             @ nstr,n2 SAY Spr_nam('1',fkp,30)
                             *@ nstr,n2 SAY Spr_nam(pr_spr,fkp,30)
                        ENDIF
                        npoz=IIF(fms=0,'5',LTRIM(STR(fms+4,2)))
                        IF pr_nrd
                             @ nstr,n3 SAY fnrd
                             @ nstr,n4 SAY fgod PICTURE '9999' FUNCTION 'Z'
                             pr_nrd=.F.
                        ENDIF
                        @ nstr,n&npoz SAY fsum PICTURE '99999999'
                   ENDIF
              ENDIF
         ENDDO
         fffsum=fffsum+ffsum
         ffsum=ROUND(ffsum,-3)/1000.0
         IF ffsum#0
              IF nnstr>=nlist
                   @ nstr,n17 SAY ffsum PICTURE '99999999'
              ENDIF
         ENDIF
    ENDDO
    ffffsum=ffffsum+fffsum
    fffsum=ROUND(fffsum,-3)/1000.0
    IF fffsum#0
         IF nnstr>=nlist
              @ nstr,n18 SAY fffsum PICTURE '99999999'
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',178)
         ENDIF
    ENDIF
ENDDO
IF fkkl=' '
    ffffsum=ROUND(ffffsum,-3)/1000.0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Итого"
         @ nstr,n18 SAY ffffsum PICTURE '99999999'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('=',178)
    ENDIF
    FOR i=1 TO kol_god
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr, n4 SAY mgod(i,1) PICTURE '9999'
              @ nstr, n5 SAY ROUND(mgod(i,2)/1000.0,0)  PICTURE '99999999' FUNCTION 'Z'
              @ nstr, n6 SAY ROUND(mgod(i,3)/1000.0,0)  PICTURE '99999999' FUNCTION 'Z'
              @ nstr, n7 SAY ROUND(mgod(i,4)/1000.0,0)  PICTURE '99999999' FUNCTION 'Z'
              @ nstr, n8 SAY ROUND(mgod(i,5)/1000.0,0)  PICTURE '99999999' FUNCTION 'Z'
              @ nstr, n9 SAY ROUND(mgod(i,6)/1000.0,0)  PICTURE '99999999' FUNCTION 'Z'
              @ nstr,n10 SAY ROUND(mgod(i,7)/1000.0,0)  PICTURE '99999999' FUNCTION 'Z'
              @ nstr,n11 SAY ROUND(mgod(i,8)/1000.0,0)  PICTURE '99999999' FUNCTION 'Z'
              @ nstr,n12 SAY ROUND(mgod(i,9)/1000.0,0)  PICTURE '99999999' FUNCTION 'Z'
              @ nstr,n13 SAY ROUND(mgod(i,10)/1000.0,0) PICTURE '99999999' FUNCTION 'Z'
              @ nstr,n14 SAY ROUND(mgod(i,11)/1000.0,0) PICTURE '99999999' FUNCTION 'Z'
              @ nstr,n15 SAY ROUND(mgod(i,12)/1000.0,0) PICTURE '99999999' FUNCTION 'Z'
              @ nstr,n16 SAY ROUND(mgod(i,13)/1000.0,0) PICTURE '99999999' FUNCTION 'Z'
              @ nstr,n18 SAY ROUND((mgod(i,2)+mgod(i,3)+mgod(i,4)+mgod(i,5)+mgod(i,6)+mgod(i,7)+mgod(i,8)+mgod(i,9)+mgod(i,10)+mgod(i,11)+mgod(i,12)+mgod(i,13))/1000.0,0) PICTURE '99999999' FUNCTION 'Z'
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',178)
         ENDIF
    ENDFOR
ENDIF
EJECT
RETURN