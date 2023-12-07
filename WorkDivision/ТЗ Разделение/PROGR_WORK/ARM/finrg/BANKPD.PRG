PRIVATE fsum,ii
RESTORE FROM nsch ADDITIVE
SET EXACT OFF
SEEK RTRIM(ffkor)
SET EXACT ON
n1=1
n2=12
n3=19
n4=38
n5=49
nnstr=0
nstr=0
ii=0
nstr=kolstr+1
fffsum=0
fffsumv=0
DO WHILE !EOF()
    fkor=kor
    ffsum=0
    ffsumv=0
    DO WHILE fkor=kor.AND.!EOF()
         fdat=dat
         fsum=0
         fsumv=0
         fvid_val=SPACE(6)
         SCAN REST WHILE fkor=kor.AND.fdat=dat.AND.!EOF()
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              fsum=fsum+sm
              fsumv=fsumv+sm_val
              IF sm_val#0
                   fvid_val=vid_val
              ENDIF
         ENDSCAN
         IF fsum#0.OR.fsumv#0
              IF nstr>kolstr
                   nnstr=nnstr+1
                   IF nnstr>=nlist
                        @ 0,0 SAY nschn1
                        @ 1,1  SAY "Лист "+STR(nnstr,2)+"."
                        @ 1,10 SAY "Bедомость по "+IIF(fvo='0','приходу','расходу')+" по счету "+gfbs+' за месяц '+tmec+' '+nastf_b+' г.'
                        @ 2,0 SAY REPLICATE('-',36+IIF(gpr_val,30,0))
                        @ 3,0 SAY '|   Дата   |Кор.сч|      Сумма       |'+IIF(gpr_val,'Вид валюты|  Сумма в валюте  |','')
                        @ 4,0 SAY REPLICATE('-',36+IIF(gpr_val,30,0))
                   ENDIF
                   nstr=4
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY fdat
                   @ nstr,n2 SAY fkor
                   @ nstr,n3 SAY fsum PICTURE '999,999,999,999.99'
                   IF gpr_val
                        @ nstr,n4 SAY fvid_val
                        @ nstr,n5 SAY fsumv PICTURE '999,999,999,999.99'
                   ENDIF
              ENDIF
         ENDIF
         ffsum=ffsum+fsum
         ffsumv=ffsumv+fsumv
    ENDDO
    IF ffsum#0.OR.ffsumv#0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1  SAY "Итого"
              @ nstr,n3 SAY ffsum PICTURE '999,999,999,999.99'
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',36)
         ENDIF
    ENDIF
    IF !EMPTY(ffkor)
         RETURN
    ENDIF
    fffsum=fffsum+ffsum
    fffsumv=fffsumv+ffsumv
ENDDO
IF fffsum#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY 'Итого '+IIF(fvo='1','к','д')+'-т сч. '+gfbs
         @ nstr,n3 SAY fffsum PICTURE '999,999,999,999.99'
    ENDIF
ENDIF
RETURN