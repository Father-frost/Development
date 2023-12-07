PARAMETERS sum_prop,n1,n2,n3,n4
PRIVATE i,ii,iii,ntek,j,jj,ssss
sum_prop=sum_prop+' '
sss=''
ntek=1
jj=1
FOR i=1 TO 4
    ii=STR(i,1)
    FOR j=jj TO n&ii
         IF AT(' ',sum_prop,j)>=(ntek+n&ii).OR.EMPTY(AT(' ',sum_prop,j))
              j=j-1
              EXIT
         ENDIF
    ENDFOR
    ssss=SUBSTR(sum_prop,ntek,AT(' ',sum_prop,j)-ntek)
    sss=sss+ssss+SPACE(n&ii-LEN(ssss))
    ntek=AT(' ',sum_prop,j)+1
    jj=j
ENDFOR
RETURN sss
