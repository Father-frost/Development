DIMENSION mbs(100,4)
PRIVATE n1,n2,n3,n4,n5,n6,ii
p_form=RIGHT('999999999999.99',FSIZE('sm','bk'))
n1=1
n2=7
n3=38
n4=54
n5=70
n6=86
nnstr=0
GO TOP
fffsum=0
fffsss=0
fffsumo=0
nstr=kolstr+1
ii=0
DO WHILE !EOF()
    ffsum=0
    ffsss=0
    ffsumo=0
    fvid_pr=sch.vid_pr
    DO WHILE fvid_pr=sch.vid_pr.AND.!EOF()
         fnsk=nsk
         ficsk=sch.icsk
         fsum=0
         fsss=0
         fsumo=0
         mbs=0
         kolbs=0
         SCAN REST WHILE fvid_pr=sch.vid_pr.AND.nsk=fnsk
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              IF db#0.OR.smd#0.OR.smdo#0
                   fsum=fsum+db
                   fsss=fsss+smd
                   fsumo=fsumo+smdo
                   IF tek_b_21=1
                        FOR i=1 TO kolbs
                             IF mbs(i,1)=kor
                                  EXIT
                             ENDIF
                        ENDFOR
                        IF i>kolbs
                             kolbs=i
                             mbs(i,1)=kor
                        ENDIF
                        mbs(i,2)=mbs(i,2)+db
                        mbs(i,3)=mbs(i,3)+smd
                        mbs(i,4)=mbs(i,4)+smdo
                   ENDIF
              ENDIF
         ENDSCAN
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)
@ 0,10 SAY "Ведомость pеализации по подpазделениям "+' за месяц '+tmec+SPACE(15)+DTOC(DATE())
@ 1,0 SAY REPLICATE('-',102)
@ 2,0 SAY "|Подp.|  Hаименование подpазделения  | Сальдо на нач.|   Отгpужено   |    Оплачено   |Остаток на кон.|"
@ 3,0 SAY REPLICATE('-',102)
              ENDIF
              nstr=3
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fnsk
              @ nstr,n2 SAY ficsk
              @ nstr,n3 SAY fsum  PICTURE p_form
              @ nstr,n4 SAY fsss  PICTURE p_form
              @ nstr,n5 SAY fsumo PICTURE p_form
              @ nstr,n6 SAY fsum+fsss-fsumo PICTURE p_form
         ENDIF
         ffsum=ffsum+fsum
         ffsss=ffsss+fsss
         ffsumo=ffsumo+fsumo
         IF tek_b_21=1
              pr_per=.T.
              FOR i=1 TO kolbs
                   nstr=nstr+1
                   IF nnstr>=nlist
                        IF pr_per
                             pr_per=.F.
                             @ nstr,n2 SAY 'в том числе'
                        ENDIF
                        @ nstr,n2+12 SAY mbs(i,1)
                        @ nstr,n3 SAY mbs(i,2)  PICTURE p_form
                        @ nstr,n4 SAY mbs(i,3) PICTURE p_form
                        @ nstr,n5 SAY mbs(i,4) PICTURE p_form
                        @ nstr,n6 SAY mbs(i,2)+mbs(i,3)-mbs(i,4) PICTURE p_form
                   ENDIF
              ENDFOR
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,0 SAY REPLICATE('-',102)
              ENDIF
         ENDIF
    ENDDO
    IF ffsum#0.OR.ffsss#0.OR.ffsumo#0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY 'Итого по '+fvid_pr
              @ nstr,n3 SAY ffsum  PICTURE p_form
              @ nstr,n4 SAY ffsss  PICTURE p_form
              @ nstr,n5 SAY ffsumo PICTURE p_form
              @ nstr,n6 SAY ffsum+ffsss-ffsumo PICTURE p_form
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',102)
         ENDIF
         fffsum=fffsum+ffsum
         fffsss=fffsss+ffsss
         fffsumo=fffsumo+ffsumo
    ENDIF
ENDDO
IF fffsum#0.OR.fffsss#0.OR.fffsumo#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Всего"
         @ nstr,n3 SAY fffsum  PICTURE p_form
         @ nstr,n4 SAY fffsss  PICTURE p_form
         @ nstr,n5 SAY fffsumo PICTURE p_form
         @ nstr,n6 SAY fffsum+fffsss-fffsumo PICTURE p_form
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',102)
    ENDIF
ENDIF
EJECT
RETURN
