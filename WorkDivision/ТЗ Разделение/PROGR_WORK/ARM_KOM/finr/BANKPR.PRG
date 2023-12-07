DIMENSION mval(100,3),mvalv(100,3)
PRIVATE ii,i,sss,fost,ffost
RESTORE FROM nsch ADDITIVE
n1=1
n2=6
n3=25
i=0
IF gpr_val
    i=27
    n3a=44
    n3b=55
ENDIF
n4=44+i
IF gpr_val
    i=i+27
    n4a=90
    n4b=101
ENDIF
n5=63+i
nstr=kolstr+1
ffsum1=0
ffsum2=0
nnstr=0
GO TOP
ii=0
mvalv=0
kolvalv=0
DO WHILE !EOF()
    fkr=LEFT(kor,2)
    fsum1=0
    fsum2=0
    kol_sc=0
    DO WHILE fkr=LEFT(kor,2).AND.!EOF()
         kol_sc=kol_sc+1
         fkor=kor
         sum1=0
         sum2=0
         mval=0
         kolval=0
         SCAN REST WHILE fkor=kor
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              IF vo='0'
                   sum1=sum1+sm+Delta
              ELSE
                   sum2=sum2+sm+Delta
              ENDIF
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
                   IF vo='0'
                        mval(i,2)=mval(i,2)+sm_val
                   ELSE
                        mval(i,3)=mval(i,3)+sm_val
                   ENDIF
                   FOR i=1 TO kolvalv
                        IF mvalv(i,1)=vid_val
                             EXIT
                        ENDIF
                   ENDFOR
                   IF i>kolvalv
                        kolvalv=i
                        mvalv(i,1)=vid_val
                   ENDIF
                   IF vo='0'
                        mvalv(i,2)=mvalv(i,2)+sm_val
                   ELSE
                        mvalv(i,3)=mvalv(i,3)+sm_val
                   ENDIF
              ENDIF
         ENDSCAN
         IF sum1#0.OR.sum2#0
              pr_per=.F.
              IF nstr>kolstr
                   nnstr=nnstr+1
                   IF nnstr>=nlist
                        @ 0,0 SAY nschn1
                        @ 1,0 SAY "Сводная ведомость движения по балансовому счету "+gfbs+' за месяц '+tmec+' 19'+nastf_b+' г.'
                        @ 2,0 SAY REPLICATE('-',82)+IIF(gpr_val,REPLICATE('-',54),'')
                        @ 3,0 SAY '|Коpp|    Сальдо на     |'+IIF(gpr_val,SPACE(38),SPACE(11))+'Обоpот за месяц'+IIF(gpr_val,SPACE(38),SPACE(11))+'|    Сальдо на     |'
                        @ 4,0 SAY '|счет|  начало месяца   |-------------------------------------'+IIF(gpr_val,REPLICATE('-',54),'')+'|   конец месяца   |'
                        @ 5,0 SAY '|    |                  |      Дебет       |'+IIF(gpr_val,'Вид валюты| Сумма в валюте|','')+'      Кpедит      |'+IIF(gpr_val,'Вид валюты| Сумма в валюте|','')+'                  |'
                        @ 6,0 SAY REPLICATE('-',82)+IIF(gpr_val,REPLICATE('-',54),'')
                   ENDIF
                   nstr=6
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY fkor
                   @ nstr,n3 SAY sum1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   IF gpr_val.AND.mval(1,2)#0
                        @ nstr,n3a SAY mval(1,1)
                        @ nstr,n3b SAY mval(1,2) PICTURE '999999999999.99'
                   ENDIF
                   @ nstr,n4 SAY sum2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   IF gpr_val.AND.mval(1,3)#0
                        @ nstr,n4a SAY mval(1,1)
                        @ nstr,n4b SAY mval(1,3) PICTURE '999999999999.99'
                   ENDIF
              ENDIF
              FOR i=2 TO kolval
                   nstr=nstr+1
                   IF nnstr>=nlist
                        IF gpr_val.AND.mval(i,2)#0
                             @ nstr,n3a SAY mval(i,1)
                             @ nstr,n3b SAY mval(i,2) PICTURE '999999999999.99'
                        ENDIF
                        IF gpr_val.AND.mval(i,3)#0
                             @ nstr,n4a SAY mval(i,1)
                             @ nstr,n4b SAY mval(i,3) PICTURE '999999999999.99'
                        ENDIF
                   ENDIF
              ENDFOR
              fsum1=fsum1+sum1+Delta
              fsum2=fsum2+sum2+Delta
         ENDIF
    ENDDO
    ffsum1=ffsum1+fsum1
    ffsum2=ffsum2+fsum2
    IF kol_sc>1.AND.(fsum1#0.OR.fsum2#0)
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fkr+'**'
              @ nstr,n3 SAY fsum1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n4 SAY fsum2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
    ENDIF
ENDDO
ffost=spr_bs.saldm+ffsum1-ffsum2
frub=0
IF ffost#0.OR.ffsum1#0.OR.ffsum2#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0  SAY 'Итого'
         @ nstr,n2 SAY spr_bs.saldm PICTURE '999,999,999,999.99'
         @ nstr,n3 SAY ffsum1       PICTURE '999,999,999,999.99'
         @ nstr,n4 SAY ffsum2       PICTURE '999,999,999,999.99'
         @ nstr,n5 SAY ffost        PICTURE '999,999,999,999.99'
    ENDIF
    FOR i=1 TO kolvalv
         sss=spr_bs.sm_val+mvalv(i,2)-mvalv(i,3)
         nstr=nstr+1
         IF nnstr>=nlist
              IF spr_bs.vid_val=mvalv(i,1)
                   @ nstr,n1   SAY mvalv(i,1)
                   @ nstr,n2+2 SAY spr_bs.sm_val PICTURE '9,999,999,999.99'
              ENDIF
              IF mvalv(i,2)#0
                   @ nstr,n3a SAY mvalv(i,1)
                   @ nstr,n3b SAY mvalv(i,2) PICTURE '999999999999.99'
              ENDIF
              IF mvalv(i,3)#0
                   @ nstr,n4a SAY mvalv(i,1)
                   @ nstr,n4b SAY mvalv(i,3) PICTURE '999999999999.99'
              ENDIF
              IF sss#0
                   @ nstr,n5 SAY sss PICTURE '999,999,999,999.99'
              ENDIF
         ENDIF
         frub=frub+Kurs_dat(mvalv(i,1),GOMONTH(CTOD('01/'+STR(ntmec,2)+'/'+nastf_b),1)-1,sss)
    ENDFOR
    IF kolvalv#0.AND.ffost#frub
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0  SAY 'Дооценка по итогам месяца'
              @ nstr,n5 SAY frub-ffost PICTURE '999,999,999,999.99'
         ENDIF
    ENDIF
ENDIF
RETURN
