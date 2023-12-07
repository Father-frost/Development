PRIVATE n1,n2,n3,n4,n5,n6,mbs1,mbs2,mbs3,mbs4,mbs5,ii,nz
n1=1
n2=6
n3=32
n4=51
n5=70
n6=89
n7=108
n8=127
mbs1=0
mbs2=0
mbs3=0
mbs4=0
mbs5=0
mbs6=0
nnstr=0
kolbs=0
mbs=0
nstr=kolstr+1
ii=0
DO WHILE !EOF()
    fkor=kor
    ms1=0
    ms2=0
    ms3=0
    ms4=0
    msi3=0
    msi4=0
    ms5=0
    ms6=0
    kolbss=0
    mbss=0
    SCAN REST WHILE fkor=kor
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         ms1=ms1+db
         ms2=ms2+kr
         ms5=ms5+db
         ms6=ms6+kr-smko
    ENDSCAN
    nz=RECNO()
    SET ORDER TO rab2
    SEEK fkor
    SCAN REST WHILE fkor=bs_op
         IF fkor#ffbs
              ms3=ms3+smko
         ELSE
              msi4=msi4+smko
              ms5=ms5-smko
         ENDIF
    ENDSCAN
    SET ORDER TO rab1
    IF nz>RECCOUNT()
         IF !EOF()
              GO BOTTOM
              SKIP
         ENDIF
    ELSE
         GO nz
    ENDIF
    SELECT avotrr
    SEEK fkor
    SCAN REST WHILE fkor=kor
         ms4=ms4+smk
         ms6=ms6+smk-smko
    ENDSCAN
    nz=RECNO()
    SET ORDER TO rab2
    SEEK fkor
    SCAN REST WHILE fkor=bs_op
         IF fkor#ffbs
              ms3=ms3+smko
         ELSE
              msi4=msi4+smko
              ms5=ms5-smko
         ENDIF
    ENDSCAN
    SET ORDER TO rab1
    IF nz>RECCOUNT()
         IF !EOF()
              GO BOTTOM
              SKIP
         ENDIF
    ELSE
         GO nz
    ENDIF
    SELECT bkr
    SEEK fkor
    SCAN REST WHILE fkor=nzk
         IF vo='1'
              ms3=ms3+sm
              ms5=ms5+sm
         ELSE
              ms4=ms4+sm
              ms5=ms5-sm
         ENDIF
    ENDSCAN
    IF ms1#0.OR.ms2#0.OR.ms3#0.OR.ms4#0.OR.msi3#0.OR.msi4#0
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "Лист "+str(nnstr,2)
@ 0,20 SAY "Ведомость поступления пpодукции по счету "+ffbs+' за месяц '+tmec+SPACE(5)+DTOC(DATE())
@ 1,0 SAY REPLICATE('-',146)
@ 2,0 SAY "|    |                         |      Сальдо   на   начало           |               Обоpот                |         Сальдо   на  конец          |"
@ 3,0 SAY "|К/сч|    Hаименование счета   |-------------------------------------|-------------------------------------|-------------------------------------|"
@ 4,0 SAY "|    |                         |       Дебет      |     Кpедит       |      Дебет       |      Кpедит      |      Дебет       |      Кpедит      |"
@ 5,0 SAY REPLICATE('-',146)
              ENDIF
              nstr=5
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY fkor
              SELECT spr_bs
              SEEK fkor
              SELECT osdkomr
              @ nstr,n2 SAY spr_bs.nam
              @ nstr,n3 SAY ms1      PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n4 SAY ms2      PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n5 SAY ms3+msi3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n6 SAY ms4+msi4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n7 SAY ms5      PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n8 SAY ms6      PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         mbs1=mbs1+ms1
         mbs2=mbs2+ms2
         mbs3=mbs3+ms3
         mbs4=mbs4+ms4
         mbs5=mbs5+ms5
         mbs6=mbs6+ms6
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('-',146)
         ENDIF
    ENDIF
    SELECT osdkomr
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "Итог"
    @ nstr,n3 SAY mbs1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n4 SAY mbs2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n5 SAY mbs3 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n6 SAY mbs4 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n7 SAY mbs5 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,n8 SAY mbs6 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,0 SAY REPLICATE('-',146)
ENDIF
EJECT
RETURN
