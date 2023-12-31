PARAMETERS fname,pr_memo,v_poisk,n_str,n_poz,kol_zn,fvo_p,v_uslg
*
* fname   - ��� ��p������� ��� ⥪�饣� ����
* pr_memo - �p����� ��p������� (.T.) ��� ���� (.F.)
* v_poisk - ��� ���᪠
* n_str   - ����p ��p���
* n_poz   - ����p ����樨
* kol_zn  - ������⢮ ������ ������������ ��� �뢮��
* fvo_p   - ��� �᫮��� ��� ��室� � �p���筨�
* vusl_g  - �᫮��� ��� ����p��p�
*
PRIVATE fpoisk_,nam_file,nz
nam_file=ALIAS()
SELECT spr_bs
IF v_poisk
    SET ORDER TO grup
ELSE
    SET ORDER TO bs
ENDIF
IF EMPTY(&fname)
    DO WHILE EMPTY(&fname)
         IF !EMPTY(fvo_p)
              SET EXACT OFF
              SEEK fvo_p
              SET EXACT ON
         ENDIF
         DO Vvodn WITH "Chapss","Strsayss","Strgetss",.T.,.T.,.F.,.F.,v_uslg,"",;
                       "","","","","","","F8ss","F9ss","F10ss","",.F.
         IF pr_memo
              &fname=bs
         ELSE
              REPLACE &fname WITH bs
         ENDIF
    ENDDO
    fpoisk_=.T.
ELSE
    IF EOF()
         GO TOP
    ENDIF
    nz=RECNO()
    IF v_poisk
         fpoisk_=SEEK(fvo_p+&fname)
    ELSE
         fpoisk_=SEEK(&fname)
    ENDIF
    IF !fpoisk_
         IF RECCOUNT()#0
              GO nz
         ENDIF
    ENDIF
ENDIF
IF n_str#0
    @ n_str,n_poz SAY LEFT(spr_bs.nam,kol_zn)
ENDIF
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN fpoisk_
