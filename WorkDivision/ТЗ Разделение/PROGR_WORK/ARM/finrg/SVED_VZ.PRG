IF RECCOUNT()=0
    RETURN
ENDIF
DIMENSION mval(100,3)
kolval=0
mval=0
nnstr=0
nstr=kolstr+1
@ 0,0 SAY &sgat1
fsum1=0
fsum2=0
ii=0
SCAN
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    IF nstr>kolstr
         nnstr=nnstr+1
         IF nnstr>=nlist
@ 0,0 SAY "���� "+STR(nnstr,2)+". ��p�窠 �p������樨 "+ffkp+' '+Spr_nam('1',ffkp,30)+IIF(EMPTY(fdat1).AND.EMPTY(fdat2),'',' �� ��ਮ�'+IIF(EMPTY(fdat1),'',' � '+DTOC(fdat1))+IIF(EMPTY(fdat2),'',' �� '+DTOC(fdat2)))
@ 1,0 SAY REPLICATE('-',163)
@ 2,0 SAY '|���.|��pp|  ���  |  ���  | H���p|      �㬬�       |      �㬬�       |  ���  |    ������������ �࣠����樨  |                      �����'
@ 3,0 SAY '|���|���|���㬥�.| ������ |����.|     �p�室�      |     p��室�      | ����  |    �� ��� ���� ����᫥��  |'
@ 4,0 SAY REPLICATE('-',163)
         ENDIF
         nstr=4
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,1  SAY nzk
         @ nstr,6  SAY kor
         @ nstr,11 SAY dati
         @ nstr,20 SAY dat
         @ nstr,29 SAY nrd
         IF vo='0'
              @ nstr,36 SAY sm PICTURE '999,999,999,999.99'
         ELSE
              @ nstr,55 SAY sm PICTURE '999,999,999,999.99'
         ENDIF
         IF kp#kpp.AND.!EMPTY(kp).AND.!EMPTY(kpp)
              IF kp=ffkp
                   @ nstr,74 SAY kpp
                   @ nstr,82 SAY Spr_nam('1',kpp,30)
              ELSE
                   @ nstr,74 SAY kp
                   @ nstr,82 SAY Spr_nam('1',kp,30)
              ENDIF
         ENDIF
         IF !EMPTY(text_1)
              @ nstr,113 SAY text_1
         ENDIF
    ENDIF
    IF !EMPTY(text_2)
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,113 SAY text_2
         ENDIF
    ENDIF
    IF !EMPTY(text_3)
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,113 SAY text_3
         ENDIF
    ENDIF
    IF !EMPTY(text_4)
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,113 SAY text_4
         ENDIF
    ENDIF
    SELECT spr_bs
    SET ORDER TO bs
    SEEK bkr.nzk
    SELECT bkr
    IF spr_bs.pr_val='1'
         IF sm_val#0
              FOR i=1 TO kolval
                   IF mval(i,1)=vid_val
                        EXIT
                   ENDIF
              ENDFOR
              IF i>kolval
                   kolval=i
                   mval(i,1)=vid_val
              ENDIF
              IF vo='0'
                   mval(i,2)=mval(i,2)+sm_val
              ELSE
                   mval(i,3)=mval(i,3)+sm_val
              ENDIF
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,13 SAY '��� ������ '+vid_val
              IF vo='0'
                   @ nstr,36 SAY sm_val PICTURE '999,999,999,999.99'
              ELSE
                   @ nstr,55 SAY sm_val PICTURE '999,999,999,999.99'
              ENDIF
         ENDIF
    ENDIF
    IF vo='0'
         fsum1=fsum1+sm
    ELSE
         fsum2=fsum2+sm
    ENDIF
ENDSCAN
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,1 SAY REPLICATE('-',161)
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,1  SAY '�⮣�'
    @ nstr,36 SAY fsum1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    @ nstr,55 SAY fsum2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
ENDIF
pr_per=.T.
FOR i=1 TO kolval
    nstr=nstr+1
    IF nnstr>=nlist
         IF pr_per
              pr_per=.F.
              @ nstr,13 SAY '��� ������ '
         ENDIF
         @ nstr,24 SAY mval(i,1)
         @ nstr,36 SAY mval(i,2) PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,55 SAY mval(i,3) PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDFOR
EJECT
RETURN
