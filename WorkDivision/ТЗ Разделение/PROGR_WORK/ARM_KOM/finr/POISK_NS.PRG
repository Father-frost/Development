PARAMETERS fname,pr_memo,n_str,n_poz,kol_zn
*
* fname   - ��� ��p������� ��� ⥪�饣� ����
* pr_memo - �p����� ��p������� (.T.) ��� ���� (.F.)
* n_str   - ����p ��p���
* n_poz   - ����p ����樨
* kol_zn  - ������⢮ ������ ������������ ��� �뢮��
*
PRIVATE f_poisk,nam_file,nz
nam_file=ALIAS()
SELECT sch
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         DO Vvodn WITH "Chapsc","Strsaysc","Strgetsc",.T.,.T.,.F.,.F.,".F.","",;
              "F2sc","F3sc","","","","","","","F10sc","",.F.
         IF pr_memo
              &fname=nsk
         ELSE
              REPLACE &fname WITH nsk
         ENDIF
    ENDDO
    f_poisk=.T.
ELSE
    SET ORDER TO sch
    IF EOF()
         GO TOP
    ENDIF
    nz=RECNO()
    f_poisk=SEEK(LEFT(&fname,5))
    IF !f_poisk
         IF RECCOUNT()#0
              GO nz
         ENDIF
    ENDIF
ENDIF
IF n_str#0
    @ n_str,n_poz SAY LEFT(sch.icsk,kol_zn)
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN f_poisk
