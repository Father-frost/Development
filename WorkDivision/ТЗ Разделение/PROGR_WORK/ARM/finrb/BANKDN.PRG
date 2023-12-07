PRIVATE fsum,ii
DIMENSION mkor(200),msm(200)
p_form='PICTURE "'+RIGHT('999999999999.99',FSIZE('sm'))+'"'
n1=1
n2=10
n3=20
n4=27
i=0
IF gpr_val
    i=27
    n4a=46
    n4b=57
ENDIF
n5=46+i
n6=54+i
n7=85+i
msm=0
kolkor=0
fsum=0
nnstr=0
nstr=kolstr+1
ii=0
DO WHILE !EOF()
    fnvx=nvx
    sum1=0
    SCAN REST WHILE fnvx=nvx
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
                   @ 0,1  SAY "Лист "+STR(nnstr,2)+"."
                   @ 0,10 SAY "Bедомость по "+IIF(fvo='0','приходу','расходу')+" по счету "+gfbs+" за "+DTOC(fdat1)
                   @ 1,0 SAY REPLICATE('-',IIF(tek_b_10=1,134,85))+IIF(gpr_val,REPLICATE('-',27),'')
                   @ 2,0 SAY '|N входящ| N докум |Кор.сч|     Сумма        |'+IIF(gpr_val,'Вид валюты| Сумма в валюте|','')+'  Код  |   Hаименование организации   |'+IIF(tek_b_10=1,SPACE(20)+'Текст'+SPACE(25),'')
                   @ 3,0 SAY REPLICATE('-',IIF(tek_b_10=1,134,85))+IIF(gpr_val,REPLICATE('-',27),'')
                   nstr=3
              ENDIF
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY nvx
              @ nstr,n2 SAY nrd
              @ nstr,n3 SAY kor
              @ nstr,n4 SAY sm PICTURE '999,999,999,999.99'
              IF gpr_val
                   @ nstr,n4a SAY vid_val
                   @ nstr,n4b SAY sm_val PICTURE '999999999999.99'
              ENDIF
              @ nstr,n5 SAY kp
              @ nstr,n6 SAY Spr_nam(pr_spr,kp,30)
              IF tek_b_10=1
                   @ nstr,n7 SAY text_1
              ENDIF
         ENDIF
         IF tek_b_10=1.AND.!EMPTY(text_2)
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n7 SAY text_2
              ENDIF
         ENDIF
         IF tek_b_10=1.AND.!EMPTY(text_3)
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n7 SAY text_3
              ENDIF
         ENDIF
         IF tek_b_10=1.AND.!EMPTY(text_4)
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n7 SAY text_4
              ENDIF
         ENDIF
         FOR i=1 TO kolkor
              IF mkor(i)=kor
                   EXIT
              ENDIF
         ENDFOR
         IF i>kolkor
              kolkor=i
              mkor(i)=kor
         ENDIF
         msm(i)=msm(i)+sm+Delta
         sum1=sum1+sm+Delta
    ENDSCAN
    fsum=fsum+sum1+Delta
    IF sum1#0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,1  SAY "Итого по "+fnvx
              @ nstr,n4 SAY sum1 PICTURE '999,999,999,999.99'
         ENDIF
    ENDIF
ENDDO
IF fsum#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,1  SAY "Всего по ведомости"
         @ nstr,n4 SAY fsum PICTURE '999,999,999,999.99'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,5  SAY "в том числе"
    ENDIF
    FOR i=1 TO kolkor
    	 IF i>1
              IF nstr>kolstr
                   nstr=0
              ENDIF
              nstr=nstr+1
         ENDIF
         IF nnstr>=nlist
              @ nstr,n3 SAY mkor(i)
              @ nstr,n4 SAY msm(i) PICTURE '999,999,999,999.99'
         ENDIF
    ENDFOR
ENDIF
RETURN
