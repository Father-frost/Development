PRIVATE n1,n2,n3,n4,n5,n6,m1,m2,ii
n1=1
n2=9
n3=40
n4=59
n5=78
n6=85
n7=94
n8=102
n9=133
n10=138
m1=0
m2=0
nnstr=0
ii=0
IF EMPTY(ffnsk)
    GO TOP
ELSE
    SET EXACT OFF
    SEEK STR(VAL(ffnsk),5)
    SET EXACT ON
ENDIF
nstr=kolstr+1
DO WHILE !EOF()
    ms1=0
    ms2=0
    fnsk=nsk
    pr_per=.T.
    DO WHILE fnsk=nsk.AND.!EOF()
         fms1=0
         fms2=0
         fstat=kor
         SCAN REST WHILE fnsk=nsk.AND.fstat=kor FOR MONTH(bkr.dat)=ntmec.AND.LEFT(kor,LEN(RTRIM(ffbs)))=RTRIM(ffbs).AND.bkr.nzk=gfbs
              ii=ii+1
              ?? ii PICTURE '999999' AT 18
              IF nstr>kolstr
                   nnstr=nnstr+1
                   IF nnstr>=nlist
@ 0,0 SAY nschn1
@ 1,0 SAY "Лист "+STR(nnstr,2)+'.'+" Ведомость по движению денежных сpедств за месяц "+tmec+' по счету '+gfbs
@ 2,0 SAY REPLICATE('-',IIF(tek_b_35=0,138,188))
@ 3,0 SAY "|Код под|   Hаименование подpазделения |    Поступление   |      Расход      |Докум.|  Дата  |  Код  |   Наименование организации   |Стат|"+IIF(tek_b_35=0,'',SPACE(20)+'Текст')
@ 4,0 SAY REPLICATE('-',IIF(tek_b_35=0,138,188))
                   ENDIF
                   nstr=4
                   pr_per=.T.
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF pr_per
                        @ nstr,n1 SAY nsk
                        @ nstr,n2 SAY sch.icsk
                        pr_per=.F.
                   ENDIF
                   IF bkr.vo='0'
                        @ nstr,n3 SAY summa PICTURE '999,999,999,999.99'
                   ELSE
                        @ nstr,n4 SAY summa PICTURE '999,999,999,999.99'
                   ENDIF
                   @ nstr,n5 SAY bkr.nrd
                   @ nstr,n6 SAY bkr.dat
                   @ nstr,n7 SAY kp
                   @ nstr,n8 SAY Spr_nam(bkr.pr_spr,kp,30)
                   @ nstr,n9 SAY kor
                   IF tek_b_35=1
                        @ nstr,n10 SAY bkr.text_1
                   ENDIF
              ENDIF
              IF tek_b_35=1
				IF !EMPTY(bkr.text_2)
              		nstr=nstr+1
              		IF nnstr>=nlist
                        	@ nstr,n10 SAY bkr.text_2
                   	ENDIF
				ENDIF
				IF !EMPTY(bkr.text_3)
              		nstr=nstr+1
              		IF nnstr>=nlist
                        	@ nstr,n10 SAY bkr.text_3
                   	ENDIF
				ENDIF
				IF !EMPTY(bkr.text_4)
              		nstr=nstr+1
              		IF nnstr>=nlist
                        	@ nstr,n10 SAY bkr.text_4
                   	ENDIF
				ENDIF
              ENDIF
              IF bkr.vo='0'
                   fms1=fms1+summa
              ELSE
                   fms2=fms2+summa
              ENDIF
         ENDSCAN
         ms1=ms1+fms1
         ms2=ms2+fms2
         IF fms1#0.OR.fms2#0
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1+10 SAY 'итого по '+fstat
                   IF ms1#0
                        @ nstr,n3 SAY fms1 PICTURE '999,999,999,999.99'
                   ENDIF
                   IF ms2#0
                        @ nstr,n4 SAY fms2 PICTURE '999,999,999,999.99'
                   ENDIF
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,10 SAY REPLICATE('-',128)
              ENDIF
         ENDIF
    ENDDO
    IF ms1#0.OR.ms2#0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY 'Итого по '+fnsk
              IF ms1#0
                   @ nstr,n3 SAY ms1 PICTURE '999,999,999,999.99'
              ENDIF
              IF ms2#0
                   @ nstr,n4 SAY ms2 PICTURE '999,999,999,999.99'
              ENDIF
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',138)
         ENDIF
    ENDIF
    IF !EMPTY(ffnsk)
         EXIT
    ENDIF
    m1=m1+ms1
    m2=m2+ms2
ENDDO
IF (m1#0.OR.m2#0).AND.EMPTY(ffnsk)
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Всего по "+gfbs
         IF m1#0
              @ nstr,n3 SAY m1 PICTURE '999,999,999,999.99'
         ENDIF
         IF m2#0
              @ nstr,n4 SAY m2 PICTURE '999,999,999,999.99'
         ENDIF
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',138)
    ENDIF
ENDIF
EJECT
RETURN
