ffile=fpath
IF FILE(ffile)
    SELECT skl
    USE
    USE skl EXCLUSIVE
    SET ORDER TO kkl
    SELECT 0
    USE &ffile
    nam_file=ALIAS()
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    SCAN FOR !DELETE()
         @ 2,18 SAY RECNO() PICTURE '999999'
         fkp=LEFT(LTRIM(STR(cl,7)),7)
         fsch=sbank
         fikl=LEFT(namecl,30)
         fikld=SUBSTR(namecl,31,40)
         fikldd=SUBSTR(namecl,71,36)
         fadr=postcl
         fmfo=kodb
         fkor=kor_sch
         fgorb=bangor
         fpr_reg=LTRIM(kod_osn)+kod_dop
         fotd=bankcl
         SELECT skl
         IF !SEEK(fkp)
              APPEND BLANK
              REPLACE kkl WITH fkp,ikl WITH fikl,sch WITH fsch,otd WITH fotd,;
                     ikld WITH fikld,ikldd WITH fikldd,adr WITH fadr,;
                      mfo WITH fmfo,korr WITH fkor,gorb WITH fgorb,pr_reg WITH fpr_reg
         ENDIF
         SELECT &nam_file
    ENDSCAN
    USE
    SELECT skl
    USE
    USE skl
ELSE
    DO Net_n WITH 11,'Hе найден файл: '+ffile+'.'
ENDIF
RETURN
