IF !EMPTY(bs_op).AND.bs_op#ff2
    RETURN
ENDIF
PRIVATE fsmdo,nz,fnrd,ffsmd,ffsmdo,k_per
IF RECCOUNT()=0.OR.sopl-fsum=0
    RETURN
ENDIF
IF tek_b_22=1
    nz=RECNO()
    SET ORDER TO nrd_kor
    ffsmd=0
    ffsmdo=0
    ffnrd=nrd
    SET EXACT OFF
    SEEK ffnrd
    SET EXACT ON
    SCAN REST WHILE nrd=ffnrd FOR bs_op=ff2.OR.EMPTY(bs_op)
         ffsmd=ffsmd+smd
         ffsmdo=ffsmdo+smdo
    ENDSCAN
    IF nastf_h=0
         ffsmdo=ffsmdo+sopl-fsum
         k_per=ROUND(ffsmdo/ffsmd,5)
         SET EXACT OFF
         SEEK fnrd
         SET EXACT ON
         SCAN REST WHILE nrd=fnrd.AND.smdo<smd
              REPLACE smdo WITH ROUND(smd*k_per,2),bs_op WITH ff2
              ffsmdo=ffsmdo-smdo
         ENDSCAN
         IF ffsmdo#0
              SKIP -1
              REPLACE smdo WITH smdo+ffsmdo
         ENDIF
         fsumv=fsumv+sopl-fsum
         fsum=fsum+sopl-fsum
         GO nz
    ELSE
* работа документ в документ
*  запрос номера документа и расчет остатка
         GO nz
         fnrd=klnrd
         fdat=CTOD('  /  /  ')
         DEFINE WINDOW Zapros FROM 11,29 TO 13,53 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " Номер документа" GET fnrd
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27
              RETURN
         ENDIF
         * поиск документа
         fffsum=0
         SELECT bk
         SET ORDER TO kp_kor
         SET EXACT OFF
         SEEK osdkomr.kp+fnrd
         SET EXACT ON
         SCAN REST WHILE kp=osdkomr.kp.AND.nrd=fnrd FOR MONTH(dat)=ntmec.AND.kor=ff2.AND.vo='0'.AND.!DELETE()
              fdat=dat
              fffsum=sm
              EXIT
         ENDSCAN
         IF EMPTY(fdat)
              SELECT osdkom
              SET ORDER TO bs_kp
              SET EXACT OFF
              SEEK ff2+osdkomr.kp+fnrd
              SET EXACT ON
              SCAN REST WHILE bs=ff2.AND.kp=osdkomr.kp.AND.nrd=fnrd FOR kr>0.AND.!DELETE()
                   fdat=dat
                   fffsum=kr
                   EXIT
              ENDSCAN
         ENDIF
         SELECT dv_kp
         IF EMPTY(fdat)
              pr_new=.T.
              fdat=dv_kp.dat_op
              DEFINE WINDOW Zapros FROM 11,32 TO 13,50 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,0 SAY " Дата " GET fdat
              READ
              RELEASE WINDOW Zapros
              IF LASTKEY()=27
                   RETURN
              ENDIF
              fffsum=sopl-fsum
         ELSE
* документ найден и проверяем остаток
              pr_new=.F.
              nz=RECNO()
              SET EXACT OFF
              SCAN
                   SELECT tran_opl
                   SEEK STR(dv_kp.uni,7)
                   SCAN REST WHILE uni=dv_kp.uni FOR dat=fdat.AND.nrd=fnrd.AND.!DELETE()
                        fffsum=fffsum-summa
                   ENDSCAN
              ENDSCAN
              SET EXACT ON
              GO nz
         ENDIF
         klnrd=fnrd
         SELECT dv_kp
         IF fffsum=0
              RETURN
         ENDIF
*  конец работы с документом
         fffsum=IIF(fffsum>sopl-fsum,sopl-fsum,fffsum)
         fffsum=IIF(fffsum>ffsmd-ffsmdo,ffsmd-ffsmdo,fffsum)
         ffsmdo=ffsmdo+fffsum
         k_per=IIF(ffsmdo>ffsmd,1,ROUND(ffsmdo/ffsmd,5))
         SET EXACT OFF
         SEEK ffnrd
         SET EXACT ON
         SCAN REST WHILE nrd=ffnrd FOR smdo<smd.AND.bs_op=ff2.OR.EMPTY(bs_op)
              fsmdo=smdo
              REPLACE smdo WITH ROUND(smd*k_per,2),bs_op WITH ff2
              ffsmdo=ffsmdo-smdo
              IF pr_new
                   REPLACE dat_op WITH fdat,nrd_op WITH fnrd
              ENDIF
              SELECT tran_opl
              IF !SEEK(STR(dv_kp.uni,7)+DTOC(fdat,1)+fnrd)
                   APPEND BLANK
                   REPLACE uni WITH dv_kp.uni,dat WITH fdat,nrd WITH fnrd,;
                            ms WITH ntmec,god WITH nastf_b
              ELSE
                   RECALL
              ENDIF
              REPLACE summa WITH summa+dv_kp.smdo-fsmdo,bs WITH ff2
         ENDSCAN
         IF ffsmdo#0
              SKIP -1
              REPLACE smdo WITH smdo+ffsmdo
              SELECT tran_opl
              IF !SEEK(STR(dv_kp.uni,7)+DTOC(fdat,1)+fnrd)
                   APPEND BLANK
                   REPLACE uni WITH dv_kp.uni,dat WITH fdat,nrd WITH fnrd,;
                            ms WITH ntmec,god WITH nastf_b
              ELSE
                   RECALL
              ENDIF
              REPLACE summa WITH summa+ffsmdo,bs WITH ff2
              SELECT dv_kp
         ENDIF
         fsumv=fsumv+fffsum
         fsum=fsum+fffsum
         GO nz
    ENDIF
ELSE
	sss=IIF(sopl-fsum>smd-smdo,smd-smdo,sopl-fsum)
    fsmdo=smdo
    REPLACE smdo WITH smdo+sss
    IF fsmdo#smdo
         IF nastf_h=1
              DO Opl_tran
         ENDIF
         fsum=fsum-fsmdo+smdo
         fsumv=fsumv-fsmdo+smdo
    ENDIF
    REPLACE bs_op WITH IIF(smdo=0,'    ',ff2)
ENDIF
SET ORDER TO dat_nrd
RETURN
