IF RIGHT(fpath,1)#"\"
    fpath=fpath+"\"
ENDIF
IF RIGHT(RTRIM(fpath1),1)#"\"
    fpath1=fpath1+"\"
ENDIF
ffile=fpath+"rx.dbf"
ffile1=fpath1+"matr.dbf"
IF FILE(ffile).AND.FILE(ffile1)
    SELECT 0
    USE avot EXCLUSIVE
    INDEX ON bs+kp+nrd+kor+nvx TAG rab
    REPLACE ALL pr_zam WITH 0
    IF Poisk_alia('MATR')
         pr_f=.F.
    ELSE
         SELECT 0
         USE &ffile1
         pr_f=.T.
    ENDIF
    SET ORDER TO mat
    SELECT 0
    USE &ffile
    SET RELATION TO mat INTO matr
    REPLACE ALL bs WITH matr.bs
    SET RELATION TO
    IF pr_f
         SELECT matr
         USE
    ENDIF
    SELECT 0
    USE nast_rx
    SELECT rx
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    SCAN FOR (menu_v=1.AND.vo='15'.OR.menu_v=2.AND.vo='16').AND.!DELETE()
         @ 2,18 SAY RECNO() PICTURE '999999'
         SELECT avot
         IF !SEEK(rx.kor+rx.kp+rx.nzk+rx.bs+rx.nrd)
              APPEND BLANK
              REPLACE bs WITH rx.kor,kp WITH rx.kp,;
                     nrd WITH rx.nzk,kor WITH rx.bs,pr_spr WITH IIF(rx.vo='15','1','0'),;
                     nvx WITH rx.nrd,dat WITH rx.dat,nsk WITH rx.nsk
         ENDIF
         IF nastf_h=1.AND.EMPTY(uni)
              sss=FULLPATH('unin.mem')
              RESTORE FROM unin ADDITIVE
              unin=unin+1
              SAVE TO &sss ALL LIKE unin
              REPLACE uni WITH unin
              RELEASE unin
         ENDIF
         IF pr_zam=0
              REPLACE smd WITH 0,pr_zam WITH 1
         ENDIF
         REPLACE smd WITH smd+rx.summa
         SELECT nast_rx
         SCAN FOR RTRIM(nam_fil)='rx'.AND.!DELETE()
              fff=nast_rx.kor
              IF EMPTY(fff)
                   n_kor=' '
              ELSE
                   n_kor=&fff
              ENDIF
              fff=nast_rx.form
              IF EMPTY(fff)
                   n_summa=0
              ELSE
                   n_summa=&fff
              ENDIF
              fff=nast_rx.usl
              IF EMPTY(fff)
                   n_usl=.T.
              ELSE
                   n_usl=&fff
              ENDIF
              IF n_usl.AND.n_summa#0
                   SELECT avot
                   IF !SEEK(rx.kor+rx.kp+rx.nzk+n_kor+rx.nrd)
                        APPEND BLANK
                        REPLACE bs WITH rx.kor,kp WITH rx.kp,;
                               nrd WITH rx.nzk,kor WITH n_kor,pr_spr WITH IIF(rx.vo='15','1','0'),;
                               nvx WITH rx.nrd,dat WITH rx.dat,nsk WITH rx.nsk
                   ENDIF
                   IF nastf_h=1.AND.EMPTY(uni)
                        sss=FULLPATH('unin.mem')
                        RESTORE FROM unin ADDITIVE
                        unin=unin+1
                        SAVE TO &sss ALL LIKE unin
                        REPLACE uni WITH unin
                        RELEASE unin
                   ENDIF
                   IF pr_zam=0
                        REPLACE smd WITH 0,pr_zam WITH 1
                   ENDIF
                   REPLACE smd WITH smd+n_summa
              ENDIF
         ENDSCAN
    ENDSCAN
    USE
    SELECT avot
    DELETE TAG rab
    USE
    SELECT nast_rx
    USE
ELSE
    DO Net_n WITH 11,'Hе найден файл: '+ffile+' или '+ffile1+'.'
ENDIF
RETURN
