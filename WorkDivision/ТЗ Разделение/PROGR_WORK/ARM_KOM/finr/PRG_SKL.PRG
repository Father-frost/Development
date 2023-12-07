ffile=fpath+"re_cl.dbf"
IF FILE(ffile)
    SELECT 0
    USE re_cl EXCLUSIVE
    ZAP
    SELECT skl
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    SCAN FOR !DELETE()
         @ 2,18 SAY RECNO() PICTURE '999999'
         SELECT re_cl
         APPEND BLANK
         REPLACE cl WITH VAL(skl.kkl)
         REPLACE namecl WITH skl.ikl+skl.ikld+skl.ikldd
         REPLACE sbank WITH skl.sch
         REPLACE postcl WITH skl.adr
         REPLACE kodb WITH skl.mfo
         REPLACE kor_sch WITH skl.korr
         REPLACE bangor WITH skl.gorb
         REPLACE bankcl WITH skl.otd
         SELECT skl
    ENDSCAN
    SELECT re_cl
    USE
ELSE
    DO Net_n WITH 11,'Hе найден файл: '+ffile+'.'
ENDIF
RETURN
