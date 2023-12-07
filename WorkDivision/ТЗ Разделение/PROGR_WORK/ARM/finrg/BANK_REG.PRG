PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,ii
n1=1
n2=9
n3=40
n4=59
n5=78
n6=85
n7=96
mbs1=0
mbs2=0
nnstr=0
ffreg=RTRIM(ffreg)
len_reg=LEN(ffreg)
IF ffreg#' '
	SET EXACT OFF
    SEEK ffreg
	SET EXACT ON
ENDIF
ii=0
DO WHILE (EMPTY(ffreg).OR.ffreg=LEFT(skl.pr_reg,len_reg)).AND.!EOF()
    nstr=kolstr+1
    freg=skl.pr_reg
    m1=0
    m2=0
    DO WHILE freg=skl.pr_reg.AND.(EMPTY(ffreg).OR.ffreg=LEFT(skl.pr_reg,len_reg)).AND.!EOF()
         fkp=kp
         ms1=0
         ms2=0
         pr_per=.T.
         fk=0
         SCAN REST WHILE fkp=kp.AND.freg=skl.pr_reg.AND.(EMPTY(ffreg).OR.ffreg=LEFT(skl.pr_reg,len_reg)) FOR sm#0.AND.!DELETE()
              fk=fk+1
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              IF nstr>kolstr
                   nnstr=nnstr+1
                   IF nnstr>=nlist
@ 0,0 SAY nschn1
@ 1,0 SAY "Лист "+STR(nnstr,2)+'.'+" Ведомость по поступлению и возвpату денежных сpедств за пеpиод с "+DTOC(fdat1)+' по '+DTOC(fdat2)
@ 2,0 SAY REPLICATE('-',IIF(tek_b_42=0,94,145))
@ 3,0 SAY "|Код оp.|   Hаименование оpганизации   |    Поступление   |      Возвpат     |Докум.|   Дата   |"+IIF(tek_b_42=0,'',SPACE(20)+'Текст')
@ 4,0 SAY REPLICATE('-',IIF(tek_b_42=0,94,145))
                   ENDIF
                   nstr=4
                   pr_per=.T.
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF pr_per
                        @ nstr,n1 SAY kp
                        @ nstr,n2 SAY skl.ikl
                        pr_per=.F.
                   ENDIF
                   IF vo='0'
                        @ nstr,n3 SAY sm PICTURE '999,999,999,999.99'
                   ELSE
                        @ nstr,n4 SAY sm PICTURE '999,999,999,999.99'
                   ENDIF
                   @ nstr,n5 SAY nrd
                   @ nstr,n6 SAY dat
                   IF tek_b_42=1
                        @ nstr,n7 SAY text_1
                   ENDIF
              ENDIF
              IF tek_b_42=1
                   IF !EMPTY(text_2)
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n7 SAY text_2
                        ENDIF
                   ENDIF
                   IF !EMPTY(text_3)
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n7 SAY text_3
                        ENDIF
                   ENDIF
                   IF !EMPTY(text_4)
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n7 SAY text_4
                        ENDIF
                   ENDIF
              ENDIF
              IF vo='0'
                   ms1=ms1+sm
              ELSE
                   ms2=ms2+sm
              ENDIF
         ENDSCAN
         IF ms1#0.OR.ms2#0
              IF fk>1
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY 'Итого по '+fkp
                        @ nstr,n3 SAY ms1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n4 SAY ms2 PICTURE '999,999,999,999.99'FUNCTION 'Z'
                   ENDIF
              ENDIF
              m1=m1+ms1
              m2=m2+ms2
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,0 SAY REPLICATE('-',94)
              ENDIF
         ENDIF
    ENDDO
    mbs1=mbs1+m1
    mbs2=mbs2+m2
    nstr=nstr+1
    IF nnstr>=nlist
         SELECT spr_reg
         SEEK freg
         SELECT bkr
         @ nstr,n1 SAY 'Итого по '+spr_reg.nam
         @ nstr,n3 SAY m1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n4 SAY m2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',94)
    ENDIF
ENDDO
IF (mbs1#0.OR.mbs2#0).AND.EMPTY(ffreg)
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Всего"
         @ nstr,n3 SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n4 SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',94)
    ENDIF
ENDIF
EJECT
RETURN