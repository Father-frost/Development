ffile=fpath+"ud_71.txt"
IF FILE(ffile)
    SELECT 0
    USE rab_71
    ZAP
    SET DELETED ON
    APPEND FROM &ffile TYPE SDF
    SET DELETED OFF
    SET RELATION TO tab INTO sprrab
    SELECT 0
    USE avotr
    SELECT rab_71
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    SCAN FOR !DELETE()
         @ 2,18 SAY RECNO() PICTURE '999999'
         SELECT avotr
         APPEND BLANK
         REPLACE bs WITH '71  ',tab WITH rab_71.tab,;
                nvx WITH rab_71.nvx,kor WITH '7001',;
                smk WITH rab_71.summa,nrd WITH rab_71.nvx,;
                nsk WITH sprrab.cex
         SELECT rab_71
    ENDSCAN
    USE
    SELECT avotr
    USE
ELSE
    DO Net_n WITH 11,'Hе найден файл: '+ffile+'.'
ENDIF
RETURN
