IF EMPTY(fpath)
    RETURN
ENDIF
ffile=fpath+"bk.dbf"
ffile1=fpath+"lim_nsk.dbf"
IF FILE(ffile).AND.FILE(ffile1)
    SELECT bk
    APPEND FROM &ffile
    SELECT 0
    USE lim_nsk
    APPEND FROM &ffile1
    USE
ELSE
    DO Net_n WITH 11,'H� ������ 䠩�: '+ffile+' ��� 䠩�: '+ffile1+'.'
ENDIF
RETURN
