DIMENSION mbs(100,3)
PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,ii
p_form=RIGHT('999999999999.99',FSIZE('sm','bk'))
n1=1
n2=9
n3=40
n3a=47
n4=58
n5=65
n6=70
n7=86
nnstr=0
SET EXACT OFF
GO TOP
SET EXACT ON
ffsum=0
ffsumo=0
ii=0
DO WHILE !EOF()
    fnsk=nsk
    nstr=kolstr+1
    fkp='*'
    fsum=0
    fsumo=0
    mbs=0
    kolbs=0
    SCAN REST WHILE nsk=fnsk
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         IF (db#0.OR.smdo#0).AND.(menu_v=1.OR.menu_v=6.AND.dat<fdat.AND.(db-smdo)#0)
              IF nstr>kolstr
                   SELECT sch
                   SEEK fnsk
                   SELECT osdkomr
                   nnstr=nnstr+1
                   IF nnstr>=nlist
@ 0,0 SAY "Лист "+STR(nnstr,2)+'.'
@ 0,10 SAY 'Ведомость по '+IIF(menu_v=1,'','пpосpоченным ')+'остаткам '+IIF(menu_v=1,'и pеализации ','')+'по подpазделению '+fnsk+' '+sch.icsk
@ 1,0 SAY REPLICATE('-',IIF(menu_v=1,99,84))
@ 2,0 SAY '|Код оp.|   Hаименование оpганизации   |N тpеб| Дата док.|N TTH |К/сч|'+IIF(menu_v=1,' Сальдо на нач.|    Оплачено   ','    Сумма      ')+'|'
@ 3,0 SAY REPLICATE('-',IIF(menu_v=1,99,84))
                   ENDIF
                   nstr=3
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   IF fkp#kp
                        @ nstr,n1 SAY kp
                        @ nstr,n2 SAY skl.ikl
                        fkp=kp
                   ENDIF
                   @ nstr,n3  SAY nrd
                   @ nstr,n3a SAY dat
                   @ nstr,n4  SAY nvx
                   @ nstr,n5  SAY kor
                   IF menu_v=1
                        @ nstr,n6 SAY db
                        @ nstr,n7 SAY smdo
                   ELSE
                        @ nstr,n6 SAY db-smdo PICTURE p_form
                   ENDIF
              ENDIF
              IF menu_v=1
                   fsum=fsum+db
                   fsumo=fsumo+smdo
              ELSE
                   fsum=fsum+db-smdo
              ENDIF
              IF menu_v=1
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
                   mbs(i,3)=mbs(i,3)+smdo
              ENDIF
         ENDIF
    ENDSCAN
    IF fsum#0.OR.fsumo#0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY "Итого по подpазделению "+fnsk
              @ nstr,n6 SAY fsum  PICTURE p_form
              IF menu_v=1
                   @ nstr,n7 SAY fsumo PICTURE p_form
              ENDIF
         ENDIF
         IF menu_v=1
              FOR i=1 TO kolbs
                   nstr=nstr+1
                   IF nnstr>=nlist
                        IF i=1
                             @ nstr,n2 SAY "в том числе"
                        ENDIF
                        @ nstr,n5 SAY mbs(i,1)
                        @ nstr,n6 SAY mbs(i,2) PICTURE p_form
                        @ nstr,n7 SAY mbs(i,3) PICTURE p_form
                   ENDIF
              ENDFOR
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',IIF(menu_v=1,99,84))
         ENDIF
    ENDIF
    ffsum=ffsum+fsum
    ffsumo=ffsumo+fsumo
ENDDO
IF pskl=' '
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Всего"
         @ nstr,n6 SAY ffsum  PICTURE p_form
         IF menu_v=1
              @ nstr,n7 SAY ffsumo PICTURE p_form
         ENDIF
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',IIF(menu_v=1,99,84))
    ENDIF
ENDIF
EJECT
RETURN