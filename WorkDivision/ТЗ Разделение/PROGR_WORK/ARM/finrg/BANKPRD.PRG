DIMENSION mval(100,2),mvalv(100,2)
PRIVATE fsum,ii
RESTORE FROM nsch ADDITIVE
SET EXACT OFF
SEEK RTRIM(ffkor)
SET EXACT ON
n1=1
n2=12
n3=21
n4=29
i=0
IF gpr_val
    n4a=48
    n4b=59
    i=27
ENDIF
n5=48+i
n6=57+i
n7=88+i
nnstr=0
nstr=0
ii=0
mvalv=0
kolvalv=0
nstr=kolstr+1
fsum=0
DO WHILE !EOF()
    mval=0
    kolval=0
    fkor=kor
    sum1=0
    SCAN REST WHILE fkor=kor
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
                   @ 0,0 SAY nschn1
                   @ 1,1  SAY "Лист "+STR(nnstr,2)+"."
                   @ 1,10 SAY "Bедомость по "+IIF(fvo='0','приходу','расходу')+" по счету "+gfbs+' за месяц '+tmec+' '+nastf_b+' г.'
                   @ 2,0 SAY REPLICATE('-',IIF(tek_b_10=1,134,86))+IIF(gpr_val,REPLICATE('-',27),'')
                   @ 3,0 SAY '|   Дата   | N докум |Кор.сч|      Сумма       |'+IIF(gpr_val,'Вид валюты| Сумма в валюте|','')+'  Код   |   Hаименование  организации  |'+IIF(tek_b_10=1,SPACE(20)+'Текст','')
                   @ 4,0 SAY REPLICATE('-',IIF(tek_b_10=1,134,86))+IIF(gpr_val,REPLICATE('-',27),'')
              ENDIF
              nstr=4
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY dat
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
         sum1=sum1+sm+Delta
         IF gpr_val
              FOR i=1 TO kolval
                   IF mval(i,1)=vid_val
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolval
                   kolval=i
                   mval(i,1)=vid_val
              ENDIF
              mval(i,2)=mval(i,2)+sm_val
              FOR i=1 TO kolvalv
                   IF mvalv(i,1)=vid_val
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolvalv
                   kolvalv=i
                   mvalv(i,1)=vid_val
              ENDIF
              mvalv(i,2)=mvalv(i,2)+sm_val
         ENDIF
    ENDSCAN
    fsum=fsum+sum1+Delta
    IF sum1#0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1  SAY "Итого по кор.счету "+fkor
              @ nstr,n4 SAY sum1 PICTURE '999,999,999,999.99'
              IF gpr_val.AND.kolval#0
                   @ nstr,n4a SAY mval(1,1)
                   @ nstr,n4b SAY mval(1,2) PICTURE '999999999999.99' FUNCTION 'Z'
              ENDIF
         ENDIF
         IF gpr_val
              FOR i=2 TO kolval
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n4a SAY mval(i,1)
                        @ nstr,n4b SAY mval(i,2) PICTURE '999999999999.99' FUNCTION 'Z'
                   ENDIF
              ENDFOR
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',IIF(tek_b_10=1,134,86))+IIF(gpr_val,REPLICATE('-',27),'')
         ENDIF
    ENDIF
    IF !EMPTY(ffkor)
         RETURN
    ENDIF
ENDDO
IF fsum#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY 'Итого '+IIF(fvo='1','к','д')+'-т сч. '+gfbs
         @ nstr,n4 SAY fsum PICTURE '999,999,999,999.99'
         IF gpr_val.AND.kolvalv#0
              @ nstr,n4a SAY mvalv(1,1)
              @ nstr,n4b SAY mvalv(1,2) PICTURE '999999999999.99' FUNCTION 'Z'
         ENDIF
    ENDIF
    IF gpr_val
         FOR i=2 TO kolvalv
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n4a SAY mvalv(i,1)
                   @ nstr,n4b SAY mvalv(i,2) PICTURE '999999999999.99' FUNCTION 'Z'
              ENDIF
         ENDFOR
    ENDIF
ENDIF
RETURN