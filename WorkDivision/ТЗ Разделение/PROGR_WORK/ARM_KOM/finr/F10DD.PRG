PRIVATE nlist,fname,chg12,nstr,nnstr,nlist,pt_otk,nz,fbs,fkp,sss,fsum,scr
SAVE SCREEN TO scr
@ 7,45 FILL TO 16,72 COLOR &color20
SET COLOR TO &color13
@ 6,44,15,71 BOX "�ͻ���Ⱥ�"
SET COLOR TO &color14
@  8,46 PROMPT ' ���� �� �p������樨    ' && 1
@  9,46 PROMPT ' �p�������� �� ������� ' && 2
@ 10,46 PROMPT ' �p�������� �� ����     ' && 3
@ 11,46 PROMPT ' �p�⥭���              ' && 4
@ 12,46 PROMPT ' ���� �� ��訬 ���㬥��.' && 5
@ 13,46 PROMPT ' ����� �� ���㬥�⠬   ' && 6
MENU TO menu_v
IF menu_v=0
     RETURN
ENDIF
DO CASE
CASE menu_v=2.OR.menu_v=3.OR.menu_v=5
    ffnrd=nrd
    fkol=3
    @ 16,41 FILL TO 19,73 COLOR &color20
    SET COLOR TO &color13
    @ 15,40,18,72 BOX "�ͻ���Ⱥ "
    SET COLOR TO &color14
    @ 16,41 SAY " H���p ���㬥��......." GET ffnrd
    @ 17,41 SAY " ������⢮ ��������p��" GET fkol PICTURE "9"
    READ
    IF LASTKEY()=27
         RETURN
    ENDIF
CASE menu_v=4
    ffplat=SPACE(15)
    ffnrd=nrd
    fkol=3
    @ 16,41 FILL TO 20,79 COLOR &color20
    SET COLOR TO &color13
    @ 15,40,19,78 BOX "�ͻ���Ⱥ "
    SET COLOR TO &color14
    @ 16,41 SAY " H���p ���㬥��......." GET ffnrd
    @ 17,41 SAY " ������⢮ ��������p��" GET fkol PICTURE "9"
    @ 18,41 SAY " ���⥦�� �p��������" GET ffplat
    READ
    IF LASTKEY()=27
         RETURN
    ENDIF
ENDCASE
RESTORE SCREEN FROM scr
nammec=RTRIM(name_mec(MONTH(DATE())))
IF MONTH(bk.dati)=3.OR.MONTH(DATE())=8
    nammec=nammec+"�"
ELSE
    nammec=LEFT(nammec,LEN(nammec)-1)+"�"
ENDIF
SELECT spr_bs
SET ORDER TO bs
SEEK bk.nzk
ffpr=0
RESTORE FROM nsch ADDITIVE
IF menu_v>1.AND.menu_v<6
    fffbs='    '
    @ 16,41 FILL TO 18+tek_b_16,68 COLOR &color20
    SET COLOR TO &color13
    @ 15,40,17+tek_b_16,67 BOX '�ͻ���Ⱥ '
    SET COLOR TO &color14
    @ 16,41 SAY ' �����ᮢ� ���' GET fffbs VALID Poisk_sc('fffbs',.T.,.F.,0,0,0,' ','.F.') ERROR "���祭�� ����p��..."
    IF tek_b_16=1
         @ 17,41 SAY ' �p�������� ��p�����?' GET ffpr PICTURE '9' VALID ffpr=0.OR.ffpr=1 ERROR "���祭�� ����p��..."
    ENDIF
    READ
    RESTORE SCREEN FROM scr
    IF EMPTY(fffbs).OR.LASTKEY()=27
         SELECT dv_kp
         RETURN
    ENDIF
    IF ffpr=0
         fnschn1=nschn1
         nn3=schn3
         nschs=schs
         nschl=schl
         nschk=schk
         nschg=schg
         nscho1=scho1
         nscho2=scho2
    ELSE
         fnschn1=nschn1v
         nn3=schn3v
         nschs=schsv
         nschl=schlv
         nschk=schkv
         nschg=schgv
         nscho1=scho1v
         nscho2=scho2v
    ENDIF
ENDIF
SELECT dv_kp
nlist=1
nnstr=0
nstr=kolstr+1
*
chg12=0
fname="out.txt        "
nlist=1
m.pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.F.,m.pr_otk
IF m.pr_otk
    RETURN
ENDIF
*
nz=RECNO()
fkp=osdkomr.kp
DO CASE
CASE menu_v=1
    SELECT bk
    SET ORDER TO kp_kor
    SET EXACT OFF
    SEEK fkp
    SET EXACT ON
    fsumpr=0
    fsumrx=0
    SCAN REST WHILE kp=fkp FOR MONTH(dat)=ntmec.AND.!DELETE().AND.pr_spr='1'
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
@ 0,0 SAY "���� "+STR(nnstr,2)+" ���p���� � �������� �������� �p���� "
@ 1,0 SAY "�� �p������樨 "+bk.kp+' '+skl.ikl
@ 2,0 SAY REPLICATE('-',59)
@ 3,0 SAY "|���.|H���p |  ���  |��pp|     �㬬�     |     �㬬�     |"
@ 4,0 SAY "|���|����.| ������ |���|    �p�室�    |    p��室�    |"
@ 5,0 SAY REPLICATE('-',59)
              ENDIF
              nstr=5
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr, 1 SAY nzk
              @ nstr, 6 SAY nrd
              @ nstr,13 SAY dat
              @ nstr,22 SAY kor
              IF vo='0'
                   @ nstr,27 SAY sm
                   fsumpr=fsumpr+sm
              ELSE
                   fsumrx=fsumrx+sm
                   @ nstr,43 SAY sm
              ENDIF
         ENDIF
    ENDSCAN
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',59)
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY "�⮣�"
         @ nstr,27 SAY fsumpr PICTURE '999999999999.99'
         @ nstr,43 SAY fsumrx PICTURE '999999999999.99'
    ENDIF
CASE menu_v=2.OR.menu_v=3
    IF menu_v=2
         GO TOP
         IF smd>smdo
              sss=RTRIM(nrd)
         ELSE
              sss=''
         ENDIF
         fsum=0
         fnrd=sss
         SCAN FOR !DELETE()
              IF fnrd#nrd.AND.LEN(sss)<43.AND.smd>smdo
                   sss=sss+IIF(LEN(sss)=0,'',',')+RTRIM(nrd)
                   fnrd=nrd
              ENDIF
              fsum=fsum+smd-smdo
         ENDSCAN
    ELSE
         fdat=CTOD('30/'+STR(ntmec,2)+'/'+RIGHT(STR(YEAR(DATE()),4),2))
         SELECT bk
         SET ORDER TO bk2
         SET EXACT OFF
         SEEK nastf_k+fkp
         SET EXACT ON
         SCAN REST WHILE nastf_k=kor.AND.fkp=kp FOR vo='0'.AND.dat<fdat.AND.!DELETE()
              fdat=dat
         ENDSCAN
         SET EXACT OFF
         SEEK nastf_e+fkp
         SET EXACT ON
         SCAN REST WHILE nastf_e=kor.AND.fkp=kp FOR vo='0'.AND.dat<fdat.AND.!DELETE()
              fdat=dat
         ENDSCAN
         SELECT dv_kp
         GO TOP
         fsum=0
         SCAN FOR smdo#0.AND.(fdat-dat)>=skl.kol_dn.AND.!EMPTY(dat).AND.!DELETE()
              fsum=fsum+ROUND(smdo*(fdat-dat-skl.kol_dn)*skl.pr_pen/100.0,2)
         ENDSCAN
    ENDIF
    IF fsum=0
         SET DEVICE TO SCREEN
         SELECT dv_kp
         IF RECCOUNT()#0
              GO nz
         ENDIF
         RETURN
    ENDIF
    sum_prop=Pr_prop(fsum)+' '
    n=55
    sum_1=''
    sum_2=''
    sum_3=''
    ntek=1
    jj=1
    FOR i=1 TO 3
         FOR j=jj TO n
              IF AT(' ',sum_prop,j)>=(ntek+n).OR.EMPTY(AT(' ',sum_prop,j))
                   j=j-1
                   EXIT
              ENDIF
         ENDFOR
         iii=STR(i,1)
         sum_&iii=SUBSTR(sum_prop,ntek,AT(' ',sum_prop,j)-ntek)
         ntek=AT(' ',sum_prop,j)+1
         jj=j
    ENDFOR
    IF ntek<LEN(sum_prop)
         DO Net_n WITH 12,'�p���襭� ���ᨬ��쭠� ����� �㬬� �p������. ����� �p��p�頥���.'
         RETURN
    ENDIF
    @ PROW(),0 SAY &sgat2
    FOR ii=1 TO fkol
         IF menu_v=2
              nstr=1
         ELSE
              @ 0,10 SAY '����� ���� �� �����'
              @ 1,0 SAY "----------------------------------------------------------"
              @ 2,0 SAY "|H���p |  ���  |     �㬬�     |  ���  |     �㬬�     |"
              @ 3,0 SAY "|����.|�p����.|  �p������� | ������ |      ����     |"
              @ 4,0 SAY "----------------------------------------------------------"
              nstr=4
              SELECT dv_kp
              GO TOP
              DO WHILE !EOF()
                   fnrd=nrd
                   ffsum=0
                   ffpen=0
                   ffdat=DATE()
                   SCAN REST WHILE fnrd=nrd FOR smdo#0.AND.(fdat-dat)>=skl.kol_dn.AND.!EMPTY(dat).AND.!DELETE()
                        ffsum=ffsum+smd
                        ffdat=dat
                        ffpen=ffpen+ROUND(smdo*(fdat-dat-skl.kol_dn)*skl.pr_pen/100.0,2)
                   ENDSCAN
                   IF ffsum#0.AND.ffpen#0
                        nstr=nstr+1
                        @ nstr, 1 SAY fnrd
                        @ nstr, 8 SAY ffdat
                        @ nstr,17 SAY ffsum PICTURE '999999999999.99'
                        @ nstr,33 SAY fdat
                        @ nstr,42 SAY ffpen PICTURE '999999999999.99'
                   ENDIF
              ENDDO
              nstr=nstr+1
              @ nstr, 1 SAY '�⮣�'
              @ nstr,42 SAY fsum PICTURE '999999999999.99'
              nstr=nstr+3
         ENDIF
@ nstr+ 0,2 SAY '�����.� ���� ����.|'+SPACE(51)+'|  0401040  |'
@ nstr+ 0,2 SAY '____________________'+SPACE(51)+'____________|'
@ nstr+ 1,0 SAY SPACE(14)+'��������� ����������-���������'+" N "+ffnrd+SPACE(32)+"|"
         IF chg12=2
@ nstr+ 1,0 SAY SPACE(14)+'��������� ����������-���������'+" N "+ffnrd
         ENDIF
@ nstr+ 2,0 SAY SPACE(29)+LEFT(DTOC(DATE()),2)+" "+nammec+" 19"+RIGHT(DTOC(DATE()),2)+" �."
@ nstr+ 2,0 SAY SPACE(30)+"__________________"
@ nstr+ 3,0 SAY SPACE(60)+"�����        �㬬�       |"
         IF chg12=2
@ nstr+ 4,0 SAY '����������'
         ENDIF
@ nstr+ 4,0 SAY '���������� '+skl.ikl+skl.ikl1+' -----------------------------|'
@ nstr+ 5,0 SAY '��� '+skl.unn+skl.ikld+'----------|    ��. N    |               |'
@ nstr+ 6,0 SAY skl.ikldd+'|         |             |               |'
@ nstr+ 7,0 SAY '���� ����.'+skl.otd+'|   ���   |'+skl.sch+'|'+STR(fsum,15,2)+'|'
@ nstr+ 8,0 SAY LEFT(skl.otdd,25)+' � �.'+skl.gorb+'|'+skl.mfo+'|'+skl.korr+'|               |'
@ nstr+ 8,0 SAY '_____________________________________________________________________________________'
@ nstr+ 9,0 SAY '���������� '+fnschn1+SPACE(5)+'������   |               |'
         IF chg12=2
@ nstr+ 9,0 SAY '����������'
         ENDIF
@ nstr+10,0 SAY '��� '+SPACE(21)+nn3+'--------------|---------------|'
@ nstr+11,0 SAY '���� ���. '+nscho1+' ----------|    ��.N     |               |'
@ nstr+12,0 SAY nscho2+'|   ���   |'+nschl+'|               |'
@ nstr+13,0 SAY SPACE(10)+' � �.'+nschg+SPACE(15)+'|'+nschs+'|'+nschk+'|               |'
@ nstr+13,0 SAY '_____________________________________________________________________________________'
@ nstr+14,0 SAY 'H�������.⮢��,�믮������� ࠡ��,����.���,NN �                    |               |'
@ nstr+15,0 SAY '�㬬� ⮢���� ���㬥�⮢ ��� ᯥ�䨪��� ⮢��                    |               |'
IF menu_v=2
@ nstr+16,0 SAY '�� ������祭�� ���⥦�� �p�������� NN'+SPACE(30)+'|               |'
@ nstr+17,0 SAY sss
ELSE
@ nstr+16,69 SAY '|               |'
@ nstr+17,0 SAY '���� �� ��᢮��p������� ������ ��p㦥���� �p���樨'
ENDIF
@ nstr+17,69 SAY '|               |'
@ nstr+17,0 SAY '______________________________________________________________________'
         nstr=nstr+18
@ nstr+ 0,0 SAY '     �.�.            ������ �����⥫�                              |               |'
@ nstr+ 1,0 SAY '                                                            �����    | �㬬� � �����|'
@ nstr+ 1,0 SAY '_____________________________________________________________________________________'
@ nstr+ 2,0 SAY sum_1
@ nstr+ 2,55 SAY '|             |               |'
@ nstr+ 3,0 SAY sum_2
@ nstr+ 3,55 SAY '|             |               |'
@ nstr+ 4,0 SAY sum_3
@ nstr+ 4,55 SAY '|             |               |'
@ nstr+ 4,0 SAY '______________________________________________________________________'
@ nstr+ 5,0 SAY '                                                            ������   |               |'
@ nstr+ 5,0 SAY '                                                           __________________________'
@ nstr+ 6,0 SAY '                                                     ��. N |         |               |'
@ nstr+ 6,0 SAY '                                                           __________________________'
@ nstr+ 7,0 SAY '                                                     ��. N |         |               |'
@ nstr+ 7,0 SAY '                                                           __________________________'
@ nstr+ 8,0 SAY '                                                                     |���� ��   ���� |'
@ nstr+ 9,0 SAY '                                                                     |  ��   : % P   |'
@ nstr+ 9,0 SAY '                                                                     ________________'
@ nstr+10,0 SAY '                                                                     | �㬬� � ����� |'
@ nstr+10,0 SAY '                                                                     ________________'
@ nstr+11,0 SAY '                                                                     |��� ���p.|     |'
@ nstr+11,0 SAY '                                                                     ________________'
@ nstr+12,0 SAY '                                       �p������� ������              |H���.����|     |'
@ nstr+12,0 SAY '                                                                     ________________'
@ nstr+13,0 SAY '                                                           19___�.   |�p�� ����|     |'
@ nstr+13,0 SAY '                                                                     ________________'
@ nstr+14,0 SAY '                                       ������ �����                 |��p.����|     |'
@ nstr+14,0 SAY '                                                                     ________________'
@ nstr+15,0 SAY '   �.�.   ������ ���⥫�騪�                                        |N �p.����|     |'
@ nstr+15,0 SAY '                                                                     ________________'
    ENDFOR
CASE menu_v=4
    DIMENSION mbs(15)
    mbs=' '
    IF ffplat#' '
         ntek=1
         FOR i=1 TO 15
              IF AT(',',ffplat,i)=0
                   mbs(i+1)=SUBSTR(ffplat,ntek,15)
                   EXIT
              ENDIF
              mbs(i)=SUBSTR(ffplat,ntek,AT(',',ffplat,i)-ntek)
              ntek=AT(',',ffplat,i)+1
         ENDFOR
    ENDIF
    @ PROW(),0 SAY &sgat2
    RESTORE FROM tek_b ADDITIVE
    FOR ii=1 TO fkol
         nnstr=1
         sss=''
         IF nnstr>=nlist
              @ 0,1 SAY '� � � � � H � � �   ��  �������  ��  '+skl.ikl+' �� '+DTOC(DATE())
              @ 1,0 SAY REPLICATE('-',82)
              @ 2,0 SAY '|H���p |'+tek_b_7+'|  ���  |     �㬬�     |�-�� ����|     �㬬�     |     �㬬�     |'
              @ 3,0 SAY '|����.|'+tek_b_8+'|���㬥�.| �� ���㬥���  |�p��p�窨|      ����     | �� �p�⥭���  |'
              @ 4,0 SAY REPLICATE('-',82)
              nstr=4
         ENDIF
         SELECT dv_kp
         GO TOP
         fsum=0
         fpen=0
         fit=0
         DO WHILE !EOF()
              fnrd=nrd
              fnvx=nvx
              ffsum=0
              ffpen=0
              ffdat=DATE()
              ffdn=0
              SCAN REST WHILE fnrd=nrd FOR !DELETE()
                   IF ffplat=' '.OR.fnrd=mbs(1).OR.fnrd=mbs(2).OR.fnrd=mbs(3).OR.fnrd=mbs(4).OR.fnrd=mbs(5)
                        IF smdo<smd.AND.(DATE()-dat)>=skl.kol_dn.AND.!EMPTY(dat))
                             ffsum=ffsum+smd-smdo
                             ffdat=dat
                             ffdn=DATE()-dat-skl.kol_dn
                             ffpen=ffpen+ROUND((smd-smdo)*ffdn*skl.pr_pen/100.0,2)
                        ENDIF
                   ENDIF
              ENDSCAN
              IF ffsum#0.AND.ffpen#0
                   sss=sss+RTRIM(fnrd)+','
                   fsum=fsum+ffsum
                   fpen=fpen+ffpen
                   fit=fit+ffsum+ffpen
                   nstr=nstr+1
                   @ nstr, 1 SAY fnrd
                   @ nstr, 8 SAY fnvx
                   @ nstr,15 SAY ffdat
                   @ nstr,24 SAY ffsum PICTURE '999999999999.99'
                   @ nstr,40 SAY ffdn PICTURE '999999999'
                   @ nstr,50 SAY ffpen PICTURE '999999999999.99'
                   @ nstr,66 SAY ffsum+ffpen PICTURE '999999999999.99'
              ENDIF
         ENDDO
         IF LEN(sss)#0
              sss=LEFT(sss,LEN(sss)-1)
         ENDIF
         nstr=nstr+1
         @ nstr,0 SAY REPLICATE('=',82)
         nstr=nstr+1
         @ nstr, 1 SAY '�⮣�'
         @ nstr,24 SAY fsum PICTURE '999999999999.99'
         @ nstr,50 SAY fpen PICTURE '999999999999.99'
         @ nstr,66 SAY fit PICTURE '999999999999.99'
         nstr=nstr+3
*
@ nstr+ 0,2 SAY '�����.� ���� ����.|'+SPACE(51)+'|  0401040  |'
@ nstr+ 0,2 SAY '____________________'+SPACE(51)+'____________|'
@ nstr+ 1,0 SAY SPACE(14)+'��������� ����������-���������'+" N "+ffnrd+SPACE(32)+"|"
         IF chg12=2
@ nstr+ 1,0 SAY SPACE(14)+'��������� ����������-���������'+" N "+ffnrd
         ENDIF
@ nstr+ 2,0 SAY SPACE(30)+LEFT(DTOC(DATE()),2)+" "+nammec+" 19"+RIGHT(DTOC(DATE()),2)+" �."
@ nstr+ 2,0 SAY SPACE(30)+"__________________"
@ nstr+ 3,0 SAY SPACE(60)+"�����        �㬬�       |"
         IF chg12=2
@ nstr+ 4,0 SAY '����������'
         ENDIF
@ nstr+ 4,0 SAY '���������� '+skl.ikl+skl.ikl1+' -----------------------------|'
@ nstr+ 5,0 SAY '��� '+skl.unn+skl.ikld+'----------|    ��. N    |               |'
@ nstr+ 6,0 SAY skl.ikldd+'|         |             |               |'
@ nstr+ 7,0 SAY '���� ����.'+skl.otd+'|   ���   |'+skl.sch+'|'+STR(fit,15,2)+'|'
@ nstr+ 8,0 SAY skl.otdd+'|'+skl.mfo+'|'+skl.korr+'|               |'
@ nstr+ 9,0 SAY SPACE(15)+' � �.'+skl.gorb+SPACE(10)+'|         |             |               |'
@ nstr+ 9,0 SAY '_____________________________________________________________________________________'
@ nstr+10,0 SAY '���������� '+fnschn1+SPACE(5)+'������   |               |'
         IF chg12=2
@ nstr+10,0 SAY '����������'
         ENDIF
@ nstr+11,0 SAY '��� '+SPACE(51)+'--------------|---------------|'
@ nstr+12,0 SAY '���� ���. '+nscho1+' ----------|    ��.N     |               |'
@ nstr+13,0 SAY nscho2+'|   ���   |'+nschl+'|               |'
@ nstr+14,0 SAY SPACE(10)+' � �.'+nschg+SPACE(15)+'|'+nschs+'|'+nschk+'|               |'
@ nstr+14,0 SAY '_____________________________________________________________________________________'
@ nstr+15,0 SAY 'H�������.⮢��,�믮������� ࠡ��,����.���,NN �                    |               |'
@ nstr+16,0 SAY '�㬬� ⮢���� ���㬥�⮢ ��� ᯥ�䨪��� ⮢��                    |               |'
@ nstr+17,0 SAY '�p�⥭��� �� ������� ���⥦��� �p�������� NN'+SPACE(24)+'|               |'
@ nstr+18,0 SAY IIF(LEN(sss)>68,LEFT(sss,68),sss)
@ nstr+18,69 SAY '|               |'
@ nstr+18,0 SAY '______________________________________________________________________'
         nstr=nstr+19
@ nstr+ 0,0 SAY '     �.�.            ������ �����⥫�                              |               |'
@ nstr+ 1,0 SAY '                                                             �����   | �㬬� � �����|'
@ nstr+ 1,0 SAY '_____________________________________________________________________________________'
@ nstr+ 2,0 SAY SPACE(51)+'    |             |               |'
@ nstr+ 3,0 SAY SPACE(51)+'    |             |               |'
@ nstr+ 3,0 SAY '______________________________________________________________________'
@ nstr+ 4,0 SAY '                                                             ������  |               |'
@ nstr+ 4,0 SAY '                                                           __________________________'
@ nstr+ 5,0 SAY '                                                     ��. N |         |               |'
@ nstr+ 5,0 SAY '                                                           __________________________'
@ nstr+ 6,0 SAY '                                                     ��. N |         |               |'
@ nstr+ 6,0 SAY '                                                           __________________________'
@ nstr+ 7,0 SAY '                                                                     |���� ��   ���� |'
@ nstr+ 8,0 SAY '                                                                     |  ��   : % P   |'
@ nstr+ 8,0 SAY '                                                                     ________________'
@ nstr+ 9,0 SAY '                                                                     | �㬬� � ����� |'
@ nstr+ 9,0 SAY '                                                                     ________________'
@ nstr+10,0 SAY '                                                                     |��� ���p.|     |'
@ nstr+10,0 SAY '                                                                     ________________'
@ nstr+11,0 SAY '                                       �p������� ������              |H���.����|     |'
@ nstr+11,0 SAY '                                                                     ________________'
@ nstr+12,0 SAY '                                                           19___�.   |�p�� ����|     |'
@ nstr+12,0 SAY '                                                                     ________________'
@ nstr+13,0 SAY '                                       ������ �����                 |��p.����|     |'
@ nstr+13,0 SAY '                                                                     ________________'
@ nstr+14,0 SAY '   �.�.   ������ ���⥫�騪�                                        |N �p.����|     |'
@ nstr+14,0 SAY '                                                                     ________________'
    ENDFOR
    RELEASE ALL LIKE tek_b_??
CASE menu_v=5
    SELECT bk
    SET ORDER TO kp_kor
    SELECT dv_kp
    GO TOP
    fsum=0
    SCAN FOR !DELETE()
         SELECT bk
         pr_poisk=SEEK(fkp+dv_kp.nrd+nastf_k)
         fkor=nastf_k
         IF !pr_poisk
              fkor=nastf_e
              pr_poisk=SEEK(fkp+dv_kp.nrd+nastf_e)
         ENDIF
         IF pr_poisk
              fdat=dat
              SELECT dv_kp
              IF smdo#0.AND.(fdat-dat)>=skl.kol_dn.AND.!EMPTY(dat)
                   fsum=fsum+ROUND(smdo*(fdat-dat-skl.kol_dn)*skl.pr_pen/100.0,2)
              ENDIF
         ENDIF
         SELECT dv_kp
    ENDSCAN
    IF fsum=0
         SET DEVICE TO SCREEN
         SELECT dv_kp
         IF RECCOUNT()#0
              GO nz
         ENDIF
         RETURN
    ENDIF
    sum_prop=Pr_prop(fsum)+' '
    n=54
    sum_1=''
    sum_2=''
    sum_3=''
    ntek=1
    jj=1
    FOR i=1 TO 3
         FOR j=jj TO n
              IF AT(' ',sum_prop,j)>=(ntek+n).OR.EMPTY(AT(' ',sum_prop,j))
                   j=j-1
                   EXIT
              ENDIF
         ENDFOR
         iii=STR(i,1)
         sum_&iii=SUBSTR(sum_prop,ntek,AT(' ',sum_prop,j)-ntek)
         ntek=AT(' ',sum_prop,j)+1
         jj=j
    ENDFOR
    IF ntek<LEN(sum_prop)
         DO Net_n WITH 12,'�p���襭� ���ᨬ��쭠� ����� �㬬� �p������. ����� �p��p�頥���.'
         RETURN
    ENDIF
    @ PROW(),0 SAY &sgat2
    FOR ii=1 TO fkol
         @ 0,10 SAY '����� ���� �� �����'
         @ 1,0 SAY "----------------------------------------------------------"
         @ 2,0 SAY "|H���p |  ���  |     �㬬�     |  ���  |     �㬬�     |"
         @ 3,0 SAY "|����.|�p����.|  �p������� | ������ |      ����     |"
         @ 4,0 SAY "----------------------------------------------------------"
         nstr=4
         SELECT dv_kp
         GO TOP
         DO WHILE !EOF()
              fnrd=nrd
              ffsum=0
              ffpen=0
              SELECT bk
              fdat=CTOD('01/01/99')
              pr_poisk=SEEK(fkp+dv_kp.nrd+nastf_k)
              fkor=nastf_k
              IF !pr_poisk
                   fkor=nastf_e
                   pr_poisk=SEEK(fkp+dv_kp.nrd+nastf_e)
              ENDIF
              IF pr_poisk
                   fdat=dat
              ENDIF
              SELECT dv_kp
              SCAN REST WHILE fnrd=nrd FOR fdat#CTOD('01/01/99').AND.smdo#0.AND.(fdat-dat)>=skl.kol_dn.AND.!EMPTY(dat).AND.!DELETE()
                   ffsum=ffsum+smd
                   ffdat=dat
                   ffpen=ffpen+ROUND(smdo*(fdat-dat-skl.kol_dn)*skl.pr_pen/100.0,2)
              ENDSCAN
              IF ffsum#0.AND.ffpen#0
                   nstr=nstr+1
                   @ nstr, 1 SAY fnrd
                   @ nstr, 8 SAY ffdat
                   @ nstr,17 SAY ffsum PICTURE '999999999999.99'
                   @ nstr,33 SAY fdat
                   @ nstr,42 SAY ffpen PICTURE '999999999999.99'
              ENDIF
         ENDDO
         nstr=nstr+1
         @ nstr, 1 SAY '�⮣�'
         @ nstr,42 SAY fsum PICTURE '999999999999.99'
         nstr=nstr+3
@ nstr+ 0,2 SAY '�����.� ���� ����.|'+SPACE(51)+'|  0401040  |'
@ nstr+ 0,2 SAY '____________________'+SPACE(51)+'____________|'
@ nstr+ 1,0 SAY SPACE(14)+'��������� ����������-���������'+" N "+ffnrd+SPACE(32)+"|"
         IF chg12=2
@ nstr+ 1,0 SAY SPACE(14)+'��������� ����������-���������'+" N "+ffnrd
         ENDIF
@ nstr+ 2,0 SAY SPACE(29)+LEFT(DTOC(DATE()),2)+" "+nammec+" 19"+RIGHT(DTOC(DATE()),2)+" �."
@ nstr+ 2,0 SAY SPACE(29)+"__________________"
@ nstr+ 3,0 SAY SPACE(60)+"�����        �㬬�       |"
         IF chg12=2
@ nstr+ 4,0 SAY '����������'
         ENDIF
@ nstr+ 4,0 SAY '���������� '+skl.ikl+skl.ikl1+' -----------------------------|'
@ nstr+ 5,0 SAY '��� '+skl.unn+skl.ikld+'----------|    ��. N    |               |'
@ nstr+ 6,0 SAY skl.ikldd+'|         |             |               |'
@ nstr+ 7,0 SAY '���� ����.'+skl.otd+'|   ���   |'+skl.sch+'|'+STR(fsum,15,2)+'|'
@ nstr+ 8,0 SAY skl.otdd+'|'+skl.mfo+'|'+skl.korr+'|               |'
@ nstr+ 9,0 SAY SPACE(11)+' � �.'+skl.gorb+SPACE(14)+'|         |             |               |'
@ nstr+ 9,0 SAY '_____________________________________________________________________________________'
@ nstr+10,0 SAY '���������� '+fnschn1+'     ������   |               |'
         IF chg12=2
@ nstr+10,0 SAY '����������'
         ENDIF
@ nstr+11,0 SAY '��� '+nn3+SPACE(21)+'--------------|---------------|'
@ nstr+12,0 SAY '���� ���. '+nscho1+'  ---------|    ��.N     |               |'
@ nstr+13,0 SAY nscho2+'|   ���   |'+nschl+'|               |'
@ nstr+14,0 SAY SPACE(10)+' � �.'+nschg+SPACE(15)+'|'+nschs+'|'+nschk+'|               |'
@ nstr+14,0 SAY '_____________________________________________________________________________________'
@ nstr+15,0 SAY 'H�������.⮢��,�믮������� ࠡ��,����.���,NN �                    |               |'
@ nstr+16,0 SAY '�㬬� ⮢���� ���㬥�⮢ ��� ᯥ�䨪��� ⮢��                    |               |'
IF menu_v=2
@ nstr+17,0 SAY '�� ������祭�� ���⥦�� �p�������� NN'+SPACE(30)+'|               |'
@ nstr+18,0 SAY sss
ELSE
@ nstr+17,69 SAY '|               |'
@ nstr+18,0 SAY '���� �� ��᢮��p������� ������ ��p㦥���� �p���樨'
ENDIF
@ nstr+18,69 SAY '|               |'
@ nstr+18,0 SAY '______________________________________________________________________'
         nstr=nstr+19
@ nstr+ 0,0 SAY '     �.�.            ������ �����⥫�                              |               |'
@ nstr+ 1,0 SAY '                                                             �����   | �㬬� � �����|'
@ nstr+ 1,0 SAY '_____________________________________________________________________________________'
@ nstr+ 2,0 SAY sum_1
@ nstr+ 2,55 SAY '|             |               |'
@ nstr+ 3,0 SAY sum_2
@ nstr+ 3,55 SAY '|             |               |'
@ nstr+ 4,0 SAY sum_3
@ nstr+ 4,55 SAY '|             |               |'
@ nstr+ 4,0 SAY '______________________________________________________________________'
@ nstr+ 5,0 SAY '                                                             ������  |               |'
@ nstr+ 5,0 SAY '                                                           __________________________'
@ nstr+ 6,0 SAY '                                                     ��. N |         |               |'
@ nstr+ 6,0 SAY '                                                           __________________________'
@ nstr+ 7,0 SAY '                                                     ��. N |         |               |'
@ nstr+ 7,0 SAY '                                                           __________________________'
@ nstr+ 8,0 SAY '                                                                     |���� ��   ���� |'
@ nstr+ 9,0 SAY '                                                                     |  ��   : % P   |'
@ nstr+ 9,0 SAY '                                                                     ________________'
@ nstr+10,0 SAY '                                                                     | �㬬� � ����� |'
@ nstr+10,0 SAY '                                                                     ________________'
@ nstr+11,0 SAY '                                                                     |��� ���p.|     |'
@ nstr+11,0 SAY '                                                                     ________________'
@ nstr+12,0 SAY '                                       �p������� ������              |H���.����|     |'
@ nstr+12,0 SAY '                                                                     ________________'
@ nstr+13,0 SAY '                                                           19___�.   |�p�� ����|     |'
@ nstr+13,0 SAY '                                                                     ________________'
@ nstr+14,0 SAY '                                       ������ �����                 |��p.����|     |'
@ nstr+14,0 SAY '                                                                     ________________'
@ nstr+15,0 SAY '    �.�.   ������ ���⥫�騪�                                       |N �p.����|     |'
@ nstr+15,0 SAY '                                                                     ________________'
    ENDFOR
CASE menu_v=6
    SELECT dv_kp
	DO Pr_razb
ENDCASE
SELECT dv_kp
IF RECCOUNT()#0
    GO nz
ENDIF
EJECT
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
SET DEVICE TO SCREEN
RETURN
*
PROCEDURE Pr_razb
PRIVATE scr,nz
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
PRIVATE ii
DIMENSION mbs(100,3)
n1=1
n2=10
n3=17
n4=24
n5=32
n6=64
n7=83
n8=92
n9=99
mbs=0
nnstr=0
nstr=kolstr+1
ii=0
GO TOP
fmbs=0
pr_nam=.T.
ffsum=0
ffsumop=0
DO WHILE !EOF()
    fnrd=nrd
    fsum=0
    fsumop=0
    fsmdo=0
    mbs=0
    kolbs=0
    fnvx=nvx
    fdat=dat
    SCAN REST WHILE fnrd=nrd
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         fsum=fsum+smd
         fsmdo=fsmdo+smdo
         IF nastf_h=1
              SELECT tran_opl
              SET EXACT OFF
              SEEK STR(dv_kp.uni,7)
              SET EXACT ON
              SCAN REST WHILE uni=dv_kp.uni FOR ms=ntmec.AND.god=nastf_b.AND.pr_doc=0.AND.!DELETE()
                   FOR i=1 TO kolbs
                        IF mbs(i,1)=dat.AND.mbs(i,2)=nrd
                             EXIT
                        ENDIF
                   ENDFOR
                   IF i>kolbs
                        kolbs=i
                        mbs(i,1)=dat
                        mbs(i,2)=nrd
                   ENDIF
                   mbs(i,3)=mbs(i,3)+summa
                   fsumop=fsumop+summa
              ENDSCAN
         ENDIF
    ENDSCAN
    IF nstr>kolstr
         nnstr=nnstr+1
         DO Chap1dd WITH nnstr,nstr,nlist
         pr_nam=.T.
    ENDIF
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY fdat
         @ nstr,n2 SAY fnrd
         @ nstr,n3 SAY fnvx
         @ nstr,n4 SAY osdkomr.kp
         IF pr_nam
              @ nstr,n5 SAY Spr_nam(osdkomr.pr_spr,osdkomr.kp,30)
              pr_nam=.F.
         ENDIF
         @ nstr,n6 SAY fsum PICTURE '999,999,999,999.99'
    ENDIF
    IF nastf_h=1
         FOR i=1 TO kolbs
              IF i>1
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        DO chap1dd WITH nnstr,nstr,nlist
                        pr_nam=.T.
                   ENDIF
                   nstr=nstr+1
              ENDIF
              IF nnstr>=nlist
                   @ nstr,n7 SAY mbs(i,1)
                   @ nstr,n8 SAY mbs(i,2)
                   @ nstr,n9 SAY mbs(i,3) PICTURE '999,999,999,999.99'
              ENDIF
         ENDFOR
         IF kolbs>1
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n7 SAY '�⮣� ����祭�'
                   @ nstr,n9 SAY fsumop PICTURE '999,999,999,999.99'
              ENDIF
         ENDIF
         IF fsmdo#fsumop
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n7 SAY '�訡�� �� �����'
                   @ nstr,n9 SAY fsmdo-fsumop PICTURE '999,999,999,999.99'
              ENDIF
         ENDIF
    ENDIF
    fmbs=fmbs+fsum
    ffsumop=ffsumop+fsumop
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,0 SAY REPLICATE('-',IIF(nastf_h=1,117,82))
    ENDIF
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,n1 SAY "�⮣� �� �p������樨 "+osdkomr.kp
    @ nstr,n5 SAY Spr_nam(osdkomr.pr_spr,osdkomr.kp,30)
    @ nstr,n6 SAY fmbs PICTURE '999,999,999,999.99'
    IF nastf_h=1
         @ nstr,n9 SAY ffsumop PICTURE '999,999,999,999.99'
    ENDIF
ENDIF
nstr=nstr+1
IF nnstr>=nlist
     @ nstr,0 SAY REPLICATE('=',IIF(nastf_h=1,117,82))
ENDIF
HIDE WINDOW ALL
ACTIVATE SCREEN
RETURN
*
PROCEDURE Chap1dd
PARAMETERS nst,nstr,nlist
IF nst>=nlist
    @ 0,0  SAY "���� "+STR(nst,2)+'. ����� ��p㧮� �� ����� '+tmec+' 19'+nastf_b+' �.'+SPACE(10)+DTOC(DATE())
    @ 1,0  SAY REPLICATE('-',IIF(nastf_h=1,118,83))
    @ 2,0  SAY '|  ���  |H���� |H���� |  ���  |        �����⥫�             |       �㬬�      |'+IIF(nastf_h=1,'  ���  | �����|       �㬬�      |','')
    @ 3,0  SAY '|        |����.| ���  |������|                               |                  |'+IIF(nastf_h=1,' ������ |����.|      ������      |','')
    @ 4,0  SAY REPLICATE('-',IIF(nastf_h=1,118,83))
ENDIF
nstr=4
RETURN
