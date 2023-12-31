PARAMETERS nam_mem,lik_mem,pr_izm,nam_field,znac_mem
SET EXACT ON
*
*  nam_mem    - ��� mem-䠩��
*  lik_mem    - ��p�� ��p�������
*  pr_izm     - �p����� ��������� ( 1 - ��⠢��� ��� ᪮pp���p�����,
*                                  -1 - 㤠���� )
*  nam_field  - ��� ��p�������
*  znac_mem   - ���祭�� ����
*
PRIVATE scr
SAVE SCREEN TO scr
nam_mem=UPPER(nam_mem)
IF RIGHT(UPPER(RTRIM(nam_mem)),4)#".MEM"
    nam_mem=nam_mem+".MEM"
ENDIF
IF pr_izm#-1.AND.pr_izm#1
    SET COLOR TO n/bg
    @ 7,15,10,64 BOX "�ͻ���Ⱥ "
    SET COLOR TO w+/bg
    @ 8,16 SAY '   H���p�� �p����� ��������� ��� ���� '+nam_field+'.'
    @ 9,18 SAY "     �த������� - �� ������...     "
    READ
    RESTORE SCREEN FROM scr
    RETURN
ENDIF
SET COLOR TO n/bg
@ 10,22,14,49 BOX "�ͻ���Ⱥ "
SET COLOR TO n*/bg
@ 10,24 SAY '�'
SET COLOR TO w+/bg
@ 11,24 SAY "��������, ��������..."
@ 12,24 SAY ' ���� '+nam_mem+'.'
@ 13,24 SAY ' ��p������� '+nam_field+'.'
IF FILE(nam_mem)
	RESTORE FROM &nam_mem ADDITIVE
    nam_mem=FULLPATH(nam_mem)
ENDIF
IF TYPE(nam_field)='U'
	IF pr_izm=1
    	&nam_field=znac_mem
		SAVE TO &nam_mem ALL LIKE &lik_mem
	ENDIF
ELSE
	IF pr_izm=-1
    	RELEASE &nam_field
		SAVE TO &nam_mem ALL LIKE &lik_mem
	ELSE
		IF TYPE(nam_field)#TYPE('znac_mem')
    		&nam_field=znac_mem
			SAVE TO &nam_mem ALL LIKE &lik_mem
         ELSE
              IF TYPE(nam_field)='C'
                   DO CASE
                   CASE LEN(&nam_field)>LEN(znac_mem)
                        &nam_field=LEFT(&nam_field,LEN(znac_mem))
                   CASE LEN(&nam_field)<LEN(znac_mem)
                        &nam_field=&nam_field+SPACE(LEN(znac_mem)-LEN(&nam_field))
                   ENDCASE
                   SAVE TO &nam_mem ALL LIKE &lik_mem
              ENDIF
		ENDIF
	ENDIF
ENDIF
RETURN
