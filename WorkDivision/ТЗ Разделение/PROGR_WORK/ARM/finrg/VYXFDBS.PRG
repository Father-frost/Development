PARAMETERS ch1
SELECT skl
SET ORDER TO kkl
chg12=0
IF ch1#14
    SET COLOR TO &color13
    DO CASE
    CASE ch1=1.OR.ch1=3.OR.ch1=7
         IF ch1=3.OR.ch1=7
              ffbs=nastf_k
         ELSE
              ffbs=nastf_l
         ENDIF
         DEFINE WINDOW Zapros FROM 15,40 TO 17,63 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " H���p ���...." GET ffbs VALID Poisk_sc('ffbs',.T.,.F.,0,0,0,nastf_l,'.F.') ERROR 'H�� ⠪��� ���...'
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27.AND.READKEY()#271
              RETURN
         ENDIF
         IF ch1=3
              DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
              DEFINE BAR 1 OF Tekm PROMPT " �\<� ����.���           "
              DEFINE BAR 2 OF Tekm PROMPT " �\<஬� ������ ����.��⮢ "
              ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
              ACTIVATE POPUP Tekm
              menu_v=BAR()
              IF menu_v=0
                   RETURN
              ENDIF
         ENDIF
    CASE ch1=2
         ffbs=nastf_l
         fdato=DATE()
         fdatb=DATE()
         DEFINE WINDOW Zapros FROM 15,40 TO 19,69 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " H���p ���......" GET ffbs VALID Poisk_sc('ffbs',.T.,.F.,0,0,0,nastf_l,'.F.') ERROR 'H�� ⠪��� ���...'
         @ 1,0 SAY " ��p㧪� �� �᫮" GET fdato
         @ 2,0 SAY " ����� �� �᫮.." GET fdatb
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27
              RETURN
         ENDIF
         DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
         DEFINE BAR 1 OF Tekm PROMPT " �\<� ����.���           "
         DEFINE BAR 2 OF Tekm PROMPT " �\<஬� ������ ����.��⮢ "
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         menu_v=BAR()
         IF menu_v=0
              RETURN
         ENDIF
    CASE ch1=4
         fkkl=SPACE(LEN(skl.kkl))
         ffdat=CTOD('  /  /  ')
         DEFINE WINDOW Zapros FROM 15,40 TO 18,66 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " ��� �࣠����樨" GET fkkl
         @ 1,0 SAY " H� ����� �᫮." GET ffdat
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27
              RETURN
         ENDIF
    CASE ch1=5
         DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
         DEFINE BAR 1 OF Tekm PROMPT " �\<��⪨ �� ���p���������    "
         DEFINE BAR 2 OF Tekm PROMPT " �\<�p㧪� �� ���p���������   "
         DEFINE BAR 3 OF Tekm PROMPT " �\<�������� �� ���p��������� "
         DEFINE BAR 4 OF Tekm PROMPT " ��\<��� �� ���p���������      "
         DEFINE BAR 5 OF Tekm PROMPT " �\<��p���� �� �p������樨    "
         DEFINE BAR 6 OF Tekm PROMPT " �\<p��p�祭�� ���⪨         "
         DEFINE BAR 7 OF Tekm PROMPT " �\<������������ �� ���p�����-� "
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         menu_v=BAR()
         IF menu_v=0
              RETURN
         ENDIF
         IF menu_v#4.AND.menu_v#5
              DEFINE WINDOW Zapros FROM 15,45 TO 17,72 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              pskl=SPACE(LEN(sch.nsk))
              @ 0,0 SAY " ��� ���p���������" GET pskl
              READ
              RELEASE WINDOW Zapros
              IF LASTKEY()=27
                   RETURN
              ENDIF
         ENDIF
         DO CASE
         CASE menu_v=5
              DEFINE WINDOW Zapros FROM 15,45 TO 17,72 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              ffvid_pr=SPACE(LEN(sch.vid_pr))
              @ 0,0 SAY " ��� �p�������⢠" GET ffvid_pr
              READ
              RELEASE WINDOW Zapros
              IF LASTKEY()=27
                   RETURN
              ENDIF
         CASE menu_v=6
              DEFINE WINDOW Zapros FROM 15,45 TO 17,72 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              fdat=DATE()
              @ 0,0 SAY " �� ������ �᫠" GET fdat
              READ
              RELEASE WINDOW Zapros
              IF LASTKEY()=27
                   RETURN
              ENDIF
         ENDCASE
    CASE ch1=6
         ffbs=nastf_l
         ffreg=SPACE(LEN(spr_reg.kod))
         DEFINE WINDOW Zapros FROM 15,40 TO 17,63 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " ��� p������...." GET ffreg
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27
              RETURN
         ENDIF
    CASE ch1=8
         DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
         DEFINE BAR 1 OF Tekm PROMPT " �\<��p���� �� p�������     "
         DEFINE BAR 2 OF Tekm PROMPT " ��\<�p���� �� �p�������� "
         DEFINE BAR 3 OF Tekm PROMPT " �\<������ ��������� ����     "
         DEFINE BAR 4 OF Tekm PROMPT " ���\<�p���� �� �p������樨  "
         DEFINE BAR 5 OF Tekm PROMPT " �\<p�����騥 ����㯫����    "
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         menu_v=BAR()
         ffbs=nastf_l
         SET COLOR TO &color13
         DO CASE
         CASE menu_v=0
              RETURN
         CASE menu_v=1
              ffbs=nastf_l
              ffreg=SPACE(LEN(spr_reg.kod))
              DEFINE WINDOW Zapros FROM 15,40 TO 17,63 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,0 SAY " ��� p������...." GET ffreg
              READ
              RELEASE WINDOW Zapros
              IF LASTKEY()=27
                   RETURN
              ENDIF
         CASE menu_v=2
              DEFINE POPUP Tekm FROM 11,57 COLOR SCHEME 19 SHADOW
              DEFINE BAR 1 OF Tekm PROMPT ' ������          '
              DEFINE BAR 2 OF Tekm PROMPT ' ���쪮 �� ����� '
              ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
              ACTIVATE POPUP Tekm
              menu_w=BAR()
              IF menu_w=0
                   RETURN
              ENDIF
              SET COLOR TO &color13
              fkkl=SPACE(LEN(skl.kkl))
              DEFINE WINDOW Zapros FROM 15,40 TO 17,66 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,0 SAY " ��� �࣠����樨" GET fkkl
              READ
              RELEASE WINDOW Zapros
              IF LASTKEY()=27
                   RETURN
              ENDIF
         CASE menu_v=3
              DEFINE WINDOW Zapros FROM 15,40 TO 17,63 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,0 SAY " H���p ���...." GET ffbs VALID Poisk_sc('ffbs',.T.,.F.,0,0,0,nastf_l,'.F.') ERROR 'H�� ⠪��� ���...'
              READ
              RELEASE WINDOW Zapros
              IF LASTKEY()=27.AND.READKEY()#271
                   RETURN
              ENDIF
         CASE menu_v=4
              DEFINE WINDOW Zapros FROM 15,40 TO 17,67 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              ffvid_pr=SPACE(LEN(sch.vid_pr))
              @ 0,0 SAY " ��� �p�������⢠" GET ffvid_pr
              READ
              RELEASE WINDOW Zapros
              IF LASTKEY()=27
                   RETURN
              ENDIF
         CASE menu_v=5
              DEFINE WINDOW Zapros FROM 15,40 TO 19,66 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              ffdat=DATE()
              ffdatk=DATE()
              @ 0,0 SAY " H���p ���..." GET ffbs VALID Poisk_sc('ffbs',.T.,.F.,0,0,0,nastf_l,'.F.') ERROR 'H�� ⠪��� ���...'
              @ 1,0 SAY " � ������ �᫠" GET ffdat
              @ 2,0 SAY " �� ����� �᫮" GET ffdatk VALID ffdatk>=ffdat ERROR '����७ ��ਮ�...'
              READ
              RELEASE WINDOW Zapros
              IF LASTKEY()=27
                   RETURN
              ENDIF
         ENDCASE
    CASE ch1=10
         ffbs=nastf_l
         cfsum=0
         fdat1=DATE()-15
         fdat2=DATE()-30
         DEFINE WINDOW Zapros FROM 15,40 TO 19,68 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " �㬬�.........." GET cfsum PICTURE '999999999'
         @ 1,0 SAY " ������� �p��..." GET fdat1 PICTURE '999'
         @ 2,0 SAY " ������ �p��...." GET fdat2 PICTURE '999'
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27
              RETURN
         ENDIF
    CASE ch1=12
         cfsum=0
         fkkl=SPACE(LEN(skl.kkl))
         ffyear='    '
         ffdat=DATE()
         DEFINE WINDOW Zapros FROM 15,40 TO 20,68 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " ��� �p������樨" GET fkkl
         @ 1,0 SAY " �� ����� ���..." GET ffyear
         @ 2,0 SAY " �� ����� �᫮." GET ffdat
         @ 3,0 SAY " �㬬�.........." GET cfsum PICTURE '999999999'
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27
              RETURN
         ENDIF
         ffyear=VAL(ffyear)
    CASE ch1=13
         ffbs=nastf_e
         fkor=SPACE(4)
         ffgg='  '
         ffmm='  '
         fkp=SPACE(7)
         DEFINE WINDOW Zapros FROM 13,40 TO 19,65 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @ 0,0 SAY " �����ᮢ� ���" GET ffbs VALID Poisk_sc('ffbs',.T.,.F.,0,0,0,nastf_l,'.F.') ERROR 'H�� ⠪��� ���...'
         @ 1,0 SAY " ����ᯮ��.���" GET fkor
         @ 2,0 SAY " �� ����� ���..." GET ffgg
         @ 3,0 SAY " �� ����� ����� " GET ffmm
         *@ 2,0 SAY " � ������ �᫠" GET fdat1
         *@ 3,0 SAY " �� ����� �᫮" GET fdat2
         @ 4,0 SAY " ��� �࣠����樨" GET fkp
         READ
         RELEASE WINDOW Zapros
         IF LASTKEY()=27
           ACTIVATE SCREEN
           RETURN
         ENDIF
         ffmm=VAL(ffmm)
    ENDCASE
*
    fname="out.txt        "
    nlist=1
    pr_otk=.F.
    DO Pr_file WITH chg12,fname,nlist,.T.,pr_otk
    IF pr_otk
         RETURN
    ENDIF
*
    SET DEVICE TO SCREEN
    ACTIVATE WINDOW Pogal
    SET COLOR TO &color15
    @ 0,0 SAY '�'
    SET COLOR TO &color13
    @ 0,1 SAY "��������, ��������..."
    @ 1,2 SAY ' �ᥣ� ����ᥩ:       '
    @ 2,2 SAY ' ������ ������:      '
    SET COLOR TO &color14
ENDIF
SET ESCAPE ON
ON ESCAPE DO Stop_esc
SET DELETED ON
DO CASE
CASE ch1=1
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    APPEND FROM osdkom FOR bs=ffbs
    INDEX ON bs+kor TAG rab
    SELECT spr_bs
    SET ORDER TO bs
    SELECT 0
    USE avotrr EXCLUSIVE
    ZAP
    APPEND FROM avot FOR bs=ffbs
    INDEX ON kor TAG rab
    SCAN
         SELECT osdkomr
         IF !SEEK(ffbs+avotrr.kor)
              APPEND BLANK
              REPLACE bs WITH ffbs,kor WITH avotrr.kor
         ENDIF
    ENDSCAN
    SELECT osdkomr
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    DO Svod_16
    DELETE TAG rab
    ZAP
    USE
    SELECT avotrr
    DELETE TAG rab
    ZAP
    USE
CASE ch1=2
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    APPEND FROM osdkom FOR bs=ffbs.AND.(menu_v=1.OR.!EMPTY(kor))
    SET ORDER TO kp_pr
    SELECT 0
    USE osdkom
    SET ORDER TO bs_kp
    SELECT 0
    USE avot
    SET ORDER TO bs_kp
    SCAN FOR bs=ffbs.AND.(menu_v=1.OR.!EMPTY(kor)).AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(avot.bs+avot.kp+avot.pr_spr)
              APPEND BLANK
              REPLACE bs WITH avot.bs,kp WITH avot.kp,pr_spr WITH avot.pr_spr
         ENDIF
    ENDSCAN
    SELECT osdkom
    SET EXACT OFF
    SEEK nastf_k
    SET EXACT ON
    SCAN REST WHILE bs=nastf_k FOR !DELETE()
         SELECT osdkomr
         IF !SEEK(ffbs+osdkom.kp+osdkom.pr_spr)
              APPEND BLANK
              REPLACE bs WITH ffbs,kp WITH osdkom.kp,pr_spr WITH osdkom.pr_spr
         ENDIF
    ENDSCAN
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
    INDEX ON kor+kp TAG rab
    APPEND FROM bk FOR (kor=nastf_e.OR.kor=nastf_k).AND.MONTH(dat)=ntmec
    SELECT bk
    SCAN FOR (nzk=nastf_e.OR.nzk=nastf_k).AND.MONTH(dat)=ntmec.AND.!DELETE()
         SELECT bkr
         APPEND BLANK
         REPLACE kor WITH bk.nzk,kp WITH bk.kp,pr_spr WITH bk.pr_spr,;
                  sm WITH bk.sm,vo WITH IIF(bk.vo='0','1','0')
    ENDSCAN
    SELECT bkr
    SCAN
         SELECT osdkomr
         IF !SEEK(ffbs+bkr.kp+bkr.pr_spr)
              APPEND BLANK
              REPLACE bs WITH ffbs,kp WITH bkr.kp,pr_spr WITH bkr.pr_spr
         ENDIF
    ENDSCAN
    SELECT osdkomr
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    GO TOP
    @ PROW(),0 SAY &sgat1
    DO Sprav_16
    ZAP
    USE
    SELECT avot
    USE
    SELECT osdkom
    USE
    SELECT bkr
    DELETE TAG rab
    ZAP
    USE
CASE ch1=3
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    SET ORDER TO kp_pr
    SELECT 0
    USE osdkom
    SET ORDER TO kp_nrd
    SCAN FOR (menu_v=1.OR.!EMPTY(kor).OR.bs=ffbs).AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(nastf_l+osdkom.kp+osdkom.pr_spr)
              APPEND BLANK
              REPLACE kp WITH osdkom.kp,bs WITH nastf_l,pr_spr WITH osdkom.pr_spr
         ENDIF
    ENDSCAN
    SELECT 0
    USE avotrr EXCLUSIVE
    ZAP
    APPEND FROM avot FOR bs_op=ffbs.AND.(menu_v=1.OR.!EMPTY(kor))
    INDEX ON kp TAG rab
    SCAN
         SELECT osdkomr
         IF !SEEK(avotrr.bs+avotrr.kp+avotrr.pr_spr)
              APPEND BLANK
              REPLACE kp WITH avotrr.kp,bs WITH avotrr.bs,pr_spr WITH avotrr.pr_spr
         ENDIF
    ENDSCAN
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
    INDEX ON kp TAG rab
    APPEND FROM bk FOR kor=ffbs.AND.MONTH(dat)=ntmec
    SELECT bk
    SET EXACT OFF
    SET ORDER TO nrd
    SEEK ffbs
    SET EXACT ON
    SCAN REST WHILE nzk=ffbs FOR MONTH(dat)=ntmec.AND.!DELETE()
         SELECT bkr
         APPEND BLANK
         REPLACE kp WITH bk.kp,pr_spr WITH bk.pr_spr,;
                  sm WITH bk.sm,vo WITH IIF(bk.vo='0','1','0')
    ENDSCAN
    SELECT bkr
    SCAN
         SELECT osdkomr
         IF !SEEK(nastf_l+bkr.kp+bkr.pr_spr)
              APPEND BLANK
              REPLACE kp WITH bkr.kp,bs WITH nastf_l,pr_spr WITH bkr.pr_spr
         ENDIF
    ENDSCAN
    SET EXACT ON
    SELECT osdkomr
    GO TOP
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Avans_16
    USE
    SELECT avotrr
    DELETE TAG rab
    ZAP
    USE
    SELECT osdkom
    USE
    SELECT bkr
    DELETE TAG rab
    ZAP
    USE
CASE ch1=4.OR.ch1=8.AND.menu_v=2
    IF ch1=8
         ffdat=CTOD('  /  /  ')
    ENDIF
    SELECT spr_bs
    SET ORDER TO bs
    SELECT 0
    USE bkr EXCLUSIVE
    ZAP
    INDEX ON kp+pr_spr TAG rab
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    APPEND FROM osdkom
    INDEX ON bs+kp+pr_spr+nrd+nvx+kor TAG rab
    SCAN FOR EMPTY(fkkl).OR.fkkl=osdkomr.kp
         SELECT bkr
         IF !SEEK(osdkomr.kp+osdkomr.pr_spr)
              APPEND BLANK
              REPLACE kp WITH osdkomr.kp,pr_spr WITH osdkomr.pr_spr
         ENDIF
    ENDSCAN
    SELECT 0
    USE avotrr EXCLUSIVE
    ZAP
    APPEND FROM avot FOR bs=nastf_l
    INDEX ON kp+pr_spr+nrd+nvx+kor TAG rab
    SCAN FOR EMPTY(fkkl).OR.fkkl=avotrr.kp
         SELECT bkr
         IF !SEEK(avotrr.kp+avotrr.pr_spr)
              APPEND BLANK
              REPLACE kp WITH avotrr.kp,pr_spr WITH avotrr.pr_spr
         ENDIF
    ENDSCAN
    SELECT bkr
    RESTORE FROM tek_b ADDITIVE
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Inf_16
    RELEASE ALL LIKE tek_b_??
    SELECT bkr
    DELETE TAG rab
    ZAP
    USE
    SELECT avotrr
    DELETE TAG rab
    ZAP
    USE
    SELECT osdkomr
    DELETE TAG rab
    USE
CASE ch1=5.OR.ch1=8.AND.menu_v=4
    DO CASE
    CASE menu_v=1.OR.menu_v=6
         SELECT 0
         USE osdkomr EXCLUSIVE
         ZAP
         APPEND FROM osdkom FOR EMPTY(pskl).OR.bs=nastf_l.AND.nsk=pskl
         SET RELATION TO kp INTO skl
         INDEX ON nsk+skl.ikl+nrd+nvx+kor TAG rab
         @ 1,18 SAY RECCOUNT() PICTURE '999999'
         @ 2,18 SAY ' '
         SET DEVICE TO PRINT
         @ PROW(),0 SAY &sgat2
         DO Pr_ost
         DELETE TAG rab
         ZAP
         USE
    CASE menu_v=2
         SELECT 0
         USE avotrr EXCLUSIVE
         ZAP
         APPEND FROM avot FOR EMPTY(pskl).OR.bs=nastf_l.AND.nsk=pskl
         SET RELATION TO kp INTO skl
         INDEX ON nsk+skl.ikl+nvx+nrd+kor TAG rab
         @ 1,18 SAY RECCOUNT() PICTURE '999999'
         @ 2,18 SAY ' '
         SET DEVICE TO PRINT
         @ PROW(),0 SAY &sgat2
         DO Pr_otgr
         DELETE TAG rab
         ZAP
         USE
    CASE menu_v=3.OR.menu_v=4.OR.menu_v=5.OR.menu_v=7
         IF nastf_h=1.AND.menu_v=3
              SELECT 0
              USE tran_opl
              SET ORDER TO uni
         ENDIF
         SELECT 0
         USE osdkomr EXCLUSIVE
         ZAP
         IF menu_v=3.OR.menu_v=7
              IF EMPTY(pskl)
                   APPEND FROM osdkom FOR nsk#' '
                   APPEND FROM avot
              ELSE
                   APPEND FROM osdkom FOR nsk=pskl
                   APPEND FROM avot   FOR nsk=pskl
              ENDIF
              @ 1,18 SAY RECCOUNT() PICTURE '999999'
              @ 2,18 SAY ' '
              SET DEVICE TO PRINT
              @ PROW(),0 SAY &sgat2
              IF menu_v=3
                   INDEX ON nsk+kp+nvx+nrd+kor TAG rab
                   DO Pr_real
              ELSE
                   SET RELATION TO kp INTO skl
                   INDEX ON nsk+skl.pr_reg+skl.ikl+nrd+nvx TAG rab
                   DO Pr_zadol
              ENDIF
         ELSE
              APPEND FROM osdkom FOR nsk#' '
              APPEND FROM avot
              SET RELATION TO nsk INTO sch
              INDEX ON sch.vid_pr+nsk TAG rab
              @ 1,18 SAY RECCOUNT() PICTURE '999999'
              @ 2,18 SAY ' '
              SET DEVICE TO PRINT
              @ PROW(),0 SAY &sgat2
              IF ch1=5.AND.menu_v=4
                   RESTORE FROM tek_b ADDITIVE
                   DO Pr_itog
                   RELEASE ALL LIKE tek_b_??
              ELSE
                   DO Pr_svod
              ENDIF
         ENDIF
         DELETE TAG rab
         ZAP
         USE
         IF nastf_h=1.AND.menu_v=3
              SELECT tran_opl
              USE
         ENDIF
    ENDCASE
CASE ch1=6.OR.ch1=8.AND.menu_v=1
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    APPEND FROM osdkom FOR bs=ffbs
    SET ORDER TO kp_pr
    SELECT 0
    USE osdkom
    SET ORDER TO bs_kp
    SELECT 0
    USE avot
    SET ORDER TO bs_kp
    SET EXACT OFF
    SCAN FOR bs=ffbs.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(avot.bs+avot.kp+avot.pr_spr)
              APPEND BLANK
              REPLACE bs WITH avot.bs,kp WITH avot.kp,pr_spr WITH avot.pr_spr
         ENDIF
    ENDSCAN
    SELECT osdkomr
    SET EXACT ON
    SET RELATION TO kp INTO skl
    INDEX ON bs+skl.pr_reg+kp TAG rab
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat2
    DO Reg_16
    DELETE TAG rab
    ZAP
    USE
    SELECT avot
    USE
    SELECT osdkom
    USE
CASE ch1=7
    IF !EMPTY(ffbs)
         SELECT 0
         USE osdkomr EXCLUSIVE
         ZAP
         APPEND FROM osdkom FOR bs_op=ffbs.or.(bs_op=' '.and.nvx<>' ')
         APPEND FROM avot   FOR bs_op=ffbs.or.(bs_op=' '.and.nvx<>' ')
         @ 1,18 SAY RECCOUNT() PICTURE '999999'
         @ 2,18 SAY ' '
         SET DEVICE TO PRINT
         @ PROW(),0 SAY &sgat2
         DO Pr_kor
         USE
    ENDIF
CASE ch1=8.AND.menu_v=3
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    APPEND FROM osdkom FOR bs=ffbs
    SET ORDER TO bs_kp
    SELECT 0
    USE osdkom
    SET ORDER TO bs_kp
    SELECT 0
    USE avot
    SET ORDER TO bs_kp
    SET EXACT OFF
    SCAN FOR bs=ffbs.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(avot.bs+avot.kp)
              APPEND BLANK
              REPLACE bs WITH avot.bs,kp WITH avot.kp,pr_spr WITH avot.pr_spr
         ENDIF
    ENDSCAN
    SELECT osdkom
    SEEK nastf_k
    SCAN REST WHILE bs=nastf_k FOR !DELETE()
         SELECT osdkomr
         IF !SEEK(ffbs+osdkom.kp)
              APPEND BLANK
              REPLACE bs WITH ffbs,kp WITH osdkom.kp,pr_spr WITH osdkom.pr_spr
         ENDIF
    ENDSCAN
    SELECT bk
    SET ORDER TO bk2
    SCAN FOR (kor=nastf_e.OR.kor=nastf_k.OR.nzk=nastf_e.OR.nzk=nastf_k).AND.MONTH(dat)=ntmec.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(ffbs+bk.kp)
              APPEND BLANK
              REPLACE bs WITH ffbs,kp WITH bk.kp,pr_spr WITH bk.pr_spr
         ENDIF
    ENDSCAN
    SET EXACT ON
    SELECT osdkomr
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    GO TOP
    @ PROW(),0 SAY &sgat1
    DO Sprav16n
    ZAP
    USE
    SELECT avot
    USE
    SELECT osdkom
    USE
CASE ch1=8.AND.menu_v=5
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    APPEND FROM osdkom FOR bs=ffbs.AND.db>smdo
    APPEND FROM avot FOR bs=ffbs.AND.smd>smdo
    SET RELATION TO kp INTO skl
    REPLACE ALL datp WITH dat+skl.kol_dn
    SET RELATION TO
    INDEX ON DTOC(datp,1)+kp TAG rab
    DELETE FOR datp<ffdat.OR.datp>ffdatk
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Pred_16
    ZAP
    DELETE TAG rab
    USE
CASE ch1=9
    SELECT 0
    USE osdkom
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat2
    DO Pr_prib
    USE
CASE ch1=10
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    APPEND FROM osdkom FOR bs=ffbs
    SET ORDER TO bs_kp
    SELECT 0
    USE avot
    SET ORDER TO bs_kp
    SET EXACT OFF
    SCAN FOR bs=ffbs.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(avot.bs+avot.kp)
              APPEND BLANK
              REPLACE bs WITH avot.bs,kp WITH avot.kp,pr_spr WITH avot.pr_spr
         ENDIF
    ENDSCAN
    SELECT 0
    USE osdkom
    SET ORDER TO bs_kp
    SEEK nastf_k
    SCAN REST WHILE bs=nastf_k FOR !DELETE()
         SELECT osdkomr
         IF !SEEK(ffbs+osdkom.kp)
              APPEND BLANK
              REPLACE bs WITH ffbs,kp WITH osdkom.kp,pr_spr WITH osdkom.pr_spr
         ENDIF
    ENDSCAN
    SELECT bk
    SCAN FOR (kor=nastf_e.OR.kor=nastf_k.OR.nzk=nastf_e.OR.nzk=nastf_k).AND.MONTH(dat)=ntmec.AND.!DELETE()
         SELECT osdkomr
         IF !SEEK(ffbs+bk.kp)
              APPEND BLANK
              REPLACE bs WITH ffbs,kp WITH bk.kp,pr_spr WITH bk.pr_spr
         ENDIF
    ENDSCAN
    SET EXACT ON
    SELECT osdkomr
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Anal_16
    ZAP
    USE
    SELECT avot
    USE
    SELECT osdkom
    USE
CASE ch1=11
    DO Jurnal
CASE ch1=12
    SELECT 0
    USE osdkomr EXCLUSIVE
    ZAP
    IF EMPTY(fkkl)
         IF ffyear=0
              SELECT 0
              USE osdkom
              SCAN FOR db#smdo.AND.bs=nastf_l.AND.!DELETE()
                   SELECT osdkomr
                   APPEND BLANK
                   REPLACE nrd WITH osdkom.nrd,kp WITH osdkom.kp,dat WITH osdkom.dat,;
                        pr_spr WITH osdkom.pr_spr,db WITH osdkom.db-osdkom.smdo
              ENDSCAN
              USE avot
              SCAN FOR smd#smdo.AND.!DELETE()
                   SELECT osdkomr
                   APPEND BLANK
                   REPLACE nrd WITH avot.nrd,kp WITH avot.kp,;
                           dat WITH avot.dat,pr_spr WITH avot.pr_spr,db WITH avot.smd-avot.smdo
              ENDSCAN
              USE
         ELSE
              SELECT 0
              USE osdkom
              SCAN FOR db#smdo.AND.bs=nastf_l.AND.YEAR(dat)=ffyear.AND.!DELETE()
                   SELECT osdkomr
                   APPEND BLANK
                   REPLACE nrd WITH osdkom.nrd,kp WITH osdkom.kp,dat WITH osdkom.dat,;
                        pr_spr WITH osdkom.pr_spr,db WITH osdkom.db-osdkom.smdo
              ENDSCAN
              USE avot
              SCAN FOR smd#smdo.AND.YEAR(dat)=ffyear.AND.!DELETE()
                   SELECT osdkomr
                   APPEND BLANK
                   REPLACE nrd WITH avot.nrd,kp WITH avot.kp,dat WITH avot.dat,;
                        pr_spr WITH avot.pr_spr,db WITH avot.smd-avot.smdo
              ENDSCAN
              USE
         ENDIF
    ELSE
         IF ffyear=0
              SELECT 0
              USE osdkom
              SCAN FOR db#smdo.AND.bs=nastf_l.AND.kp=fkkl.AND.!DELETE()
                   SELECT osdkomr
                   APPEND BLANK
                   REPLACE nrd WITH osdkom.nrd,kp WITH osdkom.kp,dat WITH osdkom.dat,;
                        pr_spr WITH osdkom.pr_spr,db WITH osdkom.db-osdkom.smdo
              ENDSCAN
              USE avot
              SCAN FOR smd#smdo.AND.kp=fkkl.AND.!DELETE()
                   SELECT osdkomr
                   APPEND BLANK
                   REPLACE nrd WITH avot.nrd,kp WITH avot.kp,dat WITH avot.dat,;
                        pr_spr WITH avot.pr_spr,db WITH avot.smd-avot.smdo
              ENDSCAN
              USE
         ELSE
              SELECT 0
              USE osdkom
              SCAN FOR db#smdo.AND.bs=nastf_l.AND.kp=fkkl.AND.YEAR(dat)=ffyear.AND.!DELETE()
                   SELECT osdkomr
                   APPEND BLANK
                   REPLACE nrd WITH osdkom.nrd,kp WITH osdkom.kp,dat WITH osdkom.dat,;
                        pr_spr WITH osdkom.pr_spr,db WITH osdkom.db-osdkom.smdo
              ENDSCAN
              USE avot
              SCAN FOR smd#smdo.AND.kp=fkkl.AND.YEAR(dat)=ffyear.AND.!DELETE()
                   SELECT osdkomr
                   APPEND BLANK
                   REPLACE nrd WITH avot.nrd,kp WITH avot.kp,dat WITH avot.dat,;
                        pr_spr WITH avot.pr_spr,db WITH avot.smd-avot.smdo
              ENDSCAN
              USE
         ENDIF
    ENDIF
    SELECT osdkomr
    INDEX ON kp+DTOC(dat,1) TAG rab
    IF cfsum#0.AND.RECCOUNT()#0
         fkp='*******'
         fsum=0
         pr_udd=.F.
         SCAN
              IF fkp#kp
                   IF fsum<=cfsum
                        nz=RECNO()
                        DELETE FOR kp=fkp
                        GO nz
                        pr_udd=.T.
                   ENDIF
                   fkp=kp
                   fsum=0
              ENDIF
              fsum=fsum+db
         ENDSCAN
         IF pr_udd
              PACK
         ENDIF
    ENDIF
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    @ 2,18 SAY ' '
    SET DEVICE TO PRINT
    @ PROW(),0 SAY &sgat1
    DO Zadol_16
    DELETE TAG rab
    ZAP
    USE
CASE ch1=13
*nz=RECNO()
SELECT 0
USE dv_pr EXCLUSIVE
ZAP
INDEX ON DTOC(dat,1) TAG rab
SELECT 0
use tran_opl
SET DELETED ON
SCAN FOR  BS=FFBS.AND.NZK=FKOR.AND.GOD=FFGG.AND.MS=FFMM.and.(EMPTY(fkp).OR.fkp=kp).AND.SUMMA<>0
 SELECT dv_pr
 APPEND BLANK
 REPLACE bs WITH tran_opl.bs,smd WITH tran_opl.summa,dat WITH tran_opl.dat,kor WITH tran_opl.nzk
 REPLACE kp WITH tran_opl.kp,text WITH tran_opl.text_1,nzk WITH tran_opl.nrd
*APPEND FROM BK_ARC FOR (EMPTY(fbs).OR.nzk=fbs).AND.(EMPTY(fkor).OR.kor=fkor).AND.;
*                       (EMPTY(fdat1).OR.dat>=fdat1).AND.(EMPTY(fdat2).OR.dat<=fdat2).AND.;
*                       (EMPTY(fkp).OR.fkp=kp)
*APPEND FROM bk FOR (EMPTY(fbs).OR.nzk=fbs).AND.(EMPTY(fkor).OR.kor=fkor).AND.;
*                   (EMPTY(fdat1).OR.dat>=fdat1).AND.(EMPTY(fdat2).OR.dat<=fdat2).AND.;
*                   (EMPTY(fkp).OR.fkp=kp).AND.!EMPTY(dat)
ENDSCAN
SET DEVICE TO SCREEN
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '�'
SET COLOR TO &color13
@ 0,1 SAY "��������, ��������..."
@ 1,2 SAY ' �ᥣ� ����ᥩ:       '
@ 2,2 SAY ' ������ ������:      '
SET COLOR TO &color14
@ 1,18 SAY RECCOUNT() PICTURE '999999'
@ 2,18 SAY ' '
SET DEVICE TO PRINT
@ PROW(),0 SAY &sgat1
ii=0
*SET DELETED OFF
SELECT DV_PR
goto top
n1=1
n2=10
n3=17
n4=22
n5=27
n6=46
n7=54
n8=86
nnstr=0
nstr=kolstr+1
fsum1=0
fsum2=0
fkp='*******'
SCAN
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
              @ 0,0 SAY '���� '+STR(nnstr,3)+'.'+"    �����஢�� �� ���� "+fkor+ " �� " +tmec+'         '+dtoc(date())
              @ 1,0 SAY REPLICATE('-',136)
              @ 2,0 SAY '|  ���  | �����|���.|����|      �㬬�       | ���   |    H������� �p������樨      |                      �����                       |'
              @ 3,0 SAY "|���㬥��|����.|���|���|                  |�࣠���|                              |                                                  |"
              @ 4,0 SAY REPLICATE('-',136)
         ENDIF
         nstr=5
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY dat
         @ nstr,n2 SAY nzk
         @ nstr,n3 SAY bs
         @ nstr,n4 SAY kor
         @ nstr,n5 SAY smd PICTURE "999,999,999,999.99" FUNCTION 'Z'
         @ nstr,n6 SAY kp
         @ nstr,n7 SAY Spr_nam('1',kp,30)
*         IF fkp#kp
*              fkp=kp
*              pr_spr='1'
*              @ nstr,n7 SAY Spr_nam(pr_spr,fkp,30)
*         ENDIF
         @ nstr,n8 SAY text
    ENDIF
         fsum1=fsum1+smd
ENDSCAN
nstr=nstr+2
IF nnstr>=nlist
    @ nstr-1,0 SAY REPLICATE('-',136)
    @ nstr,n1 SAY '�⮣�'
    @ nstr,n5 SAY fsum1 PICTURE "999,999,999,999.99" FUNCTION 'Z'
ENDIF
EJECT
HIDE WINDOW Pogal
SET DEVICE TO SCREEN
ACTIVATE SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
ZAP
DELETE TAG rab
USE
SELECT TRAN_OPL
USE
RETURN
CASE ch1=14
    DO Prvyx
ENDCASE
SET DELETED OFF
SET ESCAPE OFF
SET PROCEDURE TO Procgol
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN