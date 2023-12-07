ffile=fpath+"pl_kor.dbf"
IF FILE(ffile)
    SELECT 0
    USE avot
    SET ORDER TO bs_kp
    SELECT 0
    USE &ffile
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    SCAN FOR kor#' '.AND.summa#0.AND.!DELETE()
         @ 2,18 SAY RECNO() PICTURE '999999'
         SELECT avot
         IF !SEEK(nastf_l+pl_kor.kp+pl_kor.kor+pl_kor.nrd)
              APPEND BLANK
              REPLACE bs WITH nastf_l,kp WITH pl_kor.kp,;
                     kor WITH pl_kor.kor,pr_spr WITH '1',;
                     nvx WITH pl_kor.nrd,dat WITH pl_kor.dt
              IF nastf_h=1
                   sss=FULLPATH('unin.mem')
                   RESTORE FROM unin ADDITIVE
                   unin=unin+1
                   SAVE TO &sss ALL LIKE unin
                   REPLACE uni WITH unin
                   RELEASE unin
              ENDIF
         ENDIF
         REPLACE smd WITH pl_kor.summa
         SELECT pl_kor
    ENDSCAN
    ZAP
    USE
    SELECT AVOT
    USE
ELSE
    DO Net_n WITH 11,'Hе найден файл: '+ffile+'.'
ENDIF
RETURN