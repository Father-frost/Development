PRIVATE ii,fkp,fsum,nz,scr,sum_1,sum_2,sum_3,ntek,i,j
RESTORE FROM nsch ADDITIVE
SELECT spr_bs
SET ORDER TO bs
SEEK bk.nzk
ii=0
nn3=schn3
nschs=schs
nschl=schl
nschk=schk
nschg=schg
nscho1=scho1
nscho2=scho2
SELECT bk
SET ORDER TO nrd
SEEK gfbs+ffnrd1
SCAN REST WHILE nzk=gfbs FOR nrd>=ffnrd1.AND.nrd<=ffnrd2.AND.vo=fvo.AND.fwid_d=wid_d.AND.!DELETE()
    ii=ii+1
    ?? ii PICTURE '999999' AT 18
    IF EMPTY(bk.dati)
         SET DEVICE TO SCREEN
         DO Net_n WITH 12,'H���p�� ��� ���㬥��. ����p��...'
         RETURN
    ENDIF
    nammec=RTRIM(name_mec(MONTH(bk.dati)))
    IF MONTH(bk.dati)=3.OR.MONTH(bk.dati)=8
         nammec=nammec+'�'
    ELSE
         nammec=LEFT(nammec,LEN(nammec)-1)+'�'
    ENDIF
    nz=RECNO()
    fsum=0
    fkp=IIF(nastf_11=0,bk.kp,bk.kpp)
    ffkp=bk.kp
    fnrd=bk.nrd
    SET ORDER TO kp
    SET EXACT OFF
    SEEK gfbs+ffkp+fnrd
    SET EXACT ON
    SCAN REST WHILE nzk=gfbs.AND.nrd=fnrd.AND.kp=ffkp FOR !DELETE()
         fsum=fsum+bk.sm
    ENDSCAN
    IF fsum<=0
         DO Net_n WITH 12,'H���p�� �㬬� �� ���㬥��� '+fnrd+'. ����p��...'
         RETURN
    ENDIF
    GO nz
    DO CASE
    CASE wid_d=2
         n=69
    CASE wid_d=3
         n=42
    CASE wid_d=4
         n=60
    OTHERWISE
         n=54
    ENDCASE
    RESTORE FROM tek_b ADDITIVE
    ff17=tek_b_17
    RELEASE ALL LIKE tek_b_??
    IF INLIST(wid_d,2,3,4).OR.wid_d=5.AND.ff17=1
         sum_prop=Pr_prop(fsum)+' '
         sum_1=''
         sum_2=''
         sum_3=''
         ntek=1
         jj=1
         FOR i=1 TO IIF(wid_d=3,3,2)
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
              SET DEVICE TO SCREEN
              DO Net_n WITH 12,'�p���襭� ���ᨬ��쭠� ����� �㬬� �p������. ����� �p��p�頥���.'
              RETURN
         ENDIF
         IF wid_d=3
              fsum_1=''
              fsum_2=''
              fsum_3=''
              fsum_4=''
              ntek=1
              jj=1
              nn=32
              FOR i=1 TO 4
                   FOR j=jj TO nn
                        IF AT(' ',sum_prop,j)>=(ntek+nn).OR.EMPTY(AT(' ',sum_prop,j))
                             j=j-1
                             EXIT
                        ENDIF
                   ENDFOR
                   iii=STR(i,1)
                   fsum_&iii=SUBSTR(sum_prop,ntek,AT(' ',sum_prop,j)-ntek)
                   ntek=AT(' ',sum_prop,j)+1
                   jj=j
              ENDFOR
         ENDIF
    ENDIF
    IF chg12=2
         IF INLIST(wid_d,1,2,5)
              @ PROW(),0 SAY &sgat2+&sgat3
         ELSE
*              @ PROW(),0 SAY CHR(27)+CHR(38)+CHR(108)+'55'+CHR(80)
         ENDIF
    ENDIF
    IF IIF(nastf_11=0,pr_spr,pr_sprk)='1'
         SELECT skl
         SEEK fkp
         fikl=skl.ikl
         fikl1=skl.ikl1
         fikld=skl.ikld
         fikldd=skl.ikldd
         funn=skl.unn
    ELSE
         SELECT sprrab
         SEEK LEFT(fkp,6)
         fikl=LEFT(sprrab.fio,30)
         fikl1=SPACE(14)
         fikld=SPACE(30)
         fikldd=SPACE(49)
         funn=SPACE(11)
    ENDIF
    SELECT bk
    DO CASE
    CASE INLIST(wid_d,1,2,5)
         SELECT sprnaz
         SEEK bk.wid_d
         SELECT bk
         FOR jjj=1 TO fkol
              IF nastf_n=0
                   nstr=0
              ELSE
                   nstr=PROW()+nastf_6
              ENDIF
              DO CASE
              CASE wid_d=1.AND.vo='0'
                   @ nstr   ,0 SAY '�����.� ���� ����.| '+fftext+' |  0401001   |'
                   @ nstr+ 1,0 SAY '--------------------'+SPACE(52)+'-------------|'
                   @ nstr+ 2,0 SAY '                     '+sprnaz.nam+' N '+bk.nrd+'                         |'
                   @ nstr+ 3,0 SAY '                             '+LEFT(DTOC(bk.dati),2)+' '+nammec+' 19'+RIGHT(DTOC(bk.dati),2)+' �.'
                   @ nstr+ 4,0 SAY '                             ------------------              �����        �㬬�      |'
                   @ nstr+ 5,0 SAY '���⥫�騪 '+fikl+fikl1+'------------------------------|'
                   @ nstr+ 6,0 SAY '��� '+SPACE(11)+fikld+'----------|    ��. N    |               |'
                   @ nstr+ 7,0 SAY fikldd+'|   ���   |'+skl.sch+'|  '+STR(fsum,12,2)+' |'
                   @ nstr+ 8,0 SAY '���� ����.'+skl.otd+'|'+skl.mfo+'|'+skl.korr+'|               |'
                   @ nstr+ 9,0 SAY +skl.otdd+'------------------------|               |'
                   @ nstr+10,0 SAY '� �.'+skl.gorb+SPACE(39)+'������     |               |'
                   @ nstr+11,0 SAY '�����⥫� '+nschn1+'--------------|---------------|'
                   @ nstr+12,0 SAY '��� '+IIF(ffpr=1,nn3,SPACE(30))+SPACE(10)+' ----------|    ��.N     |               |'
                   @ nstr+13,0 SAY '���� ���. '+nscho1+' |   ���   |'+nschl+'|               |'
                   @ nstr+14,0 SAY nscho2+'|'+nschs+'|'+nschk+'|               |'
                   @ nstr+15,0 SAY ' � �.'+nschg+SPACE(25)+'------------------------|               |'
                   @ nstr+16,0 SAY REPLICATE('-',85)+'|'
                   @ nstr+17,0 SAY SPACE(32)+'��㧮��ࠢ�⥫� � ��.���.          |���� ��    ����|'
                   @ nstr+18,0 SAY '��� '+nschn1+SPACE(21)+'|��        % �. |'
                   @ nstr+19,0 SAY REPLICATE('-',85)+'|'
                   @ nstr+20,0 SAY SPACE(32)+'��㧮�����⥫� � ��.������.         |               |'
                   @ nstr+21,0 SAY '���     '+fikl+fikl1+SPACE(17)+'|�㬬� � �����  |'
                   @ nstr+22,0 SAY REPLICATE('-',85)+'|'
                   @ nstr+23,0 SAY '������� '+bk.dog+SPACE(10)+'|'+SPACE(14)+'��� ���㧪�'+SPACE(13)+' |��� ����樨   |'
                   @ nstr+24,0 SAY '����� '+SPACE(20)+'  |'+ffspos+' |H�����.���⥦� |'
                   @ nstr+25,0 SAY REPLICATE('-',28)+'|'+ffcen+'|               |'
                   @ nstr+26,0 SAY '��� ���㧪� '+DTOC(ffdot)+'      | ����७����� '+ffdov+' | �ப ���⥦�  |'
                   @ nstr+27,0 SAY REPLICATE('-',69)+'|               |'
                   @ nstr+28,0 SAY 'H�������.⮢��, �믮������� ࠡ��, ����. ��� ,NN � '+SPACE(15)+'|  ���.���⥦. |'
                   @ nstr+29,0 SAY '�㬬� ⮢���� ���㬥�⮢ ��� ᯥ�䨪��� ⮢��     '+SPACE(15)+'|               |'
                   @ nstr+30,0 SAY bk.text_1+SPACE(19)+'|  N ��.�����   |'
                   @ nstr+31,0 SAY bk.text_2+SPACE(19)+'|               |'
                   @ nstr+32,0 SAY bk.text_3+SPACE(19)+'|               |'
                   @ nstr+33,0 SAY bk.text_4+SPACE(19)+'|               |'
                   @ nstr+34,0 SAY REPLICATE('-',85)+'|'
                   @ nstr+35,0 SAY '�।�ᬮ�७�� ������஬ |'+SPACE(35)+'|   �஢����� ������   |'
                   @ nstr+36,0 SAY '���㬥��� ��᫠�� (����-|'+SPACE(35)+'|                      |'
                   @ nstr+37,0 SAY '��) ���⥫�騪�           |'+SPACE(35)+'|���                  |'
                   @ nstr+38,0 SAY '�.�.     '+DTOC(bk.dati)+'         |������ ������     '+SPACE(15)+'|  ������ �����       |'
                   @ nstr+39,0 SAY '                          |'+SPACE(35)+'|                      |'
                   @ nstr+40,0 SAY REPLICATE('-',85)+'|'
              CASE wid_d=2.AND.vo='1'
                   @ nstr   ,0 SAY '�����.� ���� ����.|'+SPACE(52)+'|  0401002   |'
                   @ nstr+ 1,0 SAY '--------------------'+SPACE(52)+'-------------|'
                   @ nstr+ 2,0 SAY '                     '+sprnaz.nam+' N '+bk.nrd+'                         |'
                   @ nstr+ 3,0 SAY '                             '+LEFT(DTOC(bk.dati),2)+' '+nammec+' 19'+RIGHT(DTOC(bk.dati),2)+' �.'
                   @ nstr+ 4,0 SAY '                             ------------------              �����        �㬬�      |'
                   @ nstr+ 5,0 SAY '���⥫�騪 '+nschn1+'------------------------------|'
                   @ nstr+ 6,0 SAY '��� '+nschn3+' '+nn3+'----------|    ��.N     |'+STR(fsum,15,2)+'|'
                   @ nstr+ 7,0 SAY '���� ����. '+nscho1+'|   ���   |'+nschl+'|               |'
                   @ nstr+ 8,0 SAY nscho2+'|'+nschs+'|'+nschk+'|               |'
                   @ nstr+ 9,0 SAY ' � �.'+nschg+SPACE(25)+'------------------------|               |'
                   @ nstr+10,0 SAY SPACE(58)+'������     |               |'
                   @ nstr+11,0 SAY '�����⥫� '+fikl+fikl1+'------------------------------|'
                   @ nstr+12,0 SAY '��� '+funn+fikld+'----------|    ��. N    |               |'
                   @ nstr+13,0 SAY fikldd+'|   ���   |'+skl.sch+'|'+SPACE(15)+'|'
                   @ nstr+14,0 SAY '���� ���. '+skl.otd+'|'+skl.mfo+'|'+skl.korr+'|               |'
                   @ nstr+15,0 SAY skl.otdd+'------------------------|               |'
                   @ nstr+16,0 SAY '� �. '+skl.gorb+SPACE(49)+'|               |'
                   @ nstr+17,0 SAY REPLICATE('-',29)+' �㬬� �p������ ----------------------------------------|'
                   @ nstr+18,0 SAY sum_1
                   @ nstr+18,69 SAY '|���� ��    ����|'
                   @ nstr+19,0 SAY sum_2
                   @ nstr+19,69 SAY '|��        % �. |'
                   @ nstr+20,0 SAY REPLICATE('-',69)+'|�㬬� � �����  |'
                   @ nstr+21,0 SAY '��� ���. ⮢�p� '+bk.dat_tov+'|'+SPACE(30)+' |               |'
                   @ nstr+22,0 SAY REPLICATE('-',69)+'|��� �����. '+bk.vid_op+' |'
                   @ nstr+23,0 SAY 'H�����. ���⥦�, ��������. ⮢��, �믮������� ࠡ��, '+SPACE(15)+'|H�����. ���⥦�|'
                   @ nstr+24,0 SAY '��������� ���,NN � �㬬� ⮢���� ���㬥�⮢        '+SPACE(15)+'|    '+bk.nazn_pl+'      |'
                   @ nstr+25,0 SAY SPACE(69)+'|�ப ����.     |'
                   IF EMPTY(AT('',bk.text_1,1)).AND.EMPTY(AT('',bk.text_2,1)).AND.EMPTY(AT('',bk.text_2,1)).AND.EMPTY(AT('',bk.text_4,1))
                        @ nstr+26,0 SAY bk.text_1+SPACE(19)+'|               |'
                        @ nstr+27,0 SAY bk.text_2+SPACE(19)+'|���.����.     |'
                        @ nstr+28,0 SAY bk.text_3+SPACE(19)+'|               |'
                        @ nstr+29,0 SAY bk.text_4+SPACE(19)+'|N ��.�����     |'
                   ELSE
                        st1=bk.text_1
                        st2=bk.text_2
                        st3=bk.text_3
                        st4=bk.text_4
                        FOR iii=1 TO 4
                             ii=STR(iii,1)
                             st=st&ii
                             st&ii=''
*
                             i=1
                             j=0
                             ntek=1
                             DO WHILE !EMPTY(AT('',st,i))
                                  st&ii=st&ii+SUBSTR(st,ntek,AT('',st,i)-ntek)
                                  ntek=AT('',st,i)
                                  i=i+2
                                  j=j+1
                                  SET EXACT OFF
                                  SEEK gfbs+ffkp+fnrd
                                  SET EXACT ON
                                  sss=SUBSTR(st,ntek+1,AT('',st,i-1)-ntek-1)
                                  SCAN REST WHILE nzk=gfbs.AND.nrd=fnrd.AND.kp=ffkp
                                       IF LEFT(kor,LEN(sss))=sss
                                            EXIT
                                       ENDIF
                                  ENDSCAN
                                  IF nzk=gfbs.AND.nrd=fnrd.AND.kp=ffkp
                                       st&ii=st&ii+LTRIM(STR(sm,15,2))
                                  ENDIF
                                  ntek=AT('',st,i-1)+1
                             ENDDO
*
                        ENDFOR
                        @ nstr+26,0 SAY IIF(EMPTY(st1),bk.text_1,st1)
                        @ nstr+26,69 SAY '|               |'
                        @ nstr+27,0 SAY IIF(EMPTY(st2),bk.text_2,st2)
                        @ nstr+27,69 SAY '|���.����.     |'
                        @ nstr+28,0 SAY IIF(EMPTY(st3),bk.text_3,st3)
                        @ nstr+28,69 SAY '|               |'
                        @ nstr+29,0 SAY IIF(EMPTY(st4),bk.text_4,st4)
                        @ nstr+29,69 SAY '|N ��.�����     |'
                   ENDIF
                   @ nstr+30,0 SAY REPLICATE('-',85)+'|'
                   @ nstr+31,0 SAY '                          |'+SPACE(35)+'|   �஢����� ������   |'
                   @ nstr+32,0 SAY '                          |'+SPACE(35)+'|  ���                |'
                   @ nstr+33,0 SAY '  �.�.                    |������ ������     '+SPACE(15)+'|  ������ �����       |'
                   @ nstr+34,0 SAY '                          |'+SPACE(35)+'|                      |'
                   @ nstr+35,0 SAY REPLICATE('-',85)+'|'
              CASE wid_d=5.AND.vo='0'
                   @ nstr+ 0,2 SAY '�����.� ���� ����.|'+SPACE(51)+'|  0401040  |'
                   @ nstr+ 0,2 SAY '____________________'+SPACE(51)+'____________|'
                   @ nstr+ 1,0 SAY SPACE(14)+sprnaz.nam+' N '+bk.nrd+SPACE(32)+'|'
                   IF chg12=2
                        @ nstr+ 1,0 SAY SPACE(14)+sprnaz.nam+' N '+bk.nrd
                   ENDIF
                   @ nstr+ 2,0 SAY SPACE(29)+LEFT(DTOC(dati),2)+' '+nammec+' 19'+RIGHT(DTOC(dati),2)+' �.'
                   @ nstr+ 2,0 SAY SPACE(29)+'__________________'
                   @ nstr+ 3,0 SAY SPACE(60)+'�����        �㬬�       |'
                   IF chg12=2
                        @ nstr+4,0 SAY '����������'
                   ENDIF
                   @ nstr+ 4,0 SAY '���������� '+fikl+fikl1+' -----------------------------|'
                   @ nstr+ 5,0 SAY '��� '+funn+fikld+'----------|    ��. N    |               |'
                   @ nstr+ 6,0 SAY '���� ����.'+skl.otd+'|   ���   |'+skl.sch+'|'+STR(fsum,15,2)+'|'
                   @ nstr+ 7,0 SAY skl.otdd+'|'+skl.mfo+'|'+skl.korr+'|               |'
                   @ nstr+ 8,0 SAY SPACE(12)+'� �.'+skl.gorb+SPACE(14)+'|         |             |               |'
                   @ nstr+ 8,0 SAY '_____________________________________________________________________________________'
                   @ nstr+ 9,0 SAY '���������� '+nschn1+'     ������   |               |'
                   IF chg12=2
                        @ nstr+9,0 SAY '����������'
                   ENDIF
                   @ nstr+10,0 SAY '��� '+IIF(ffpr=1,nn3,SPACE(30))+SPACE(21)+'--------------|---------------|'
                   @ nstr+11,0 SAY '���� ���. '+nscho1+'  ---------|    ��.N     |               |'
                   @ nstr+12,0 SAY nscho2+'|   ���   |'+nschl+'|               |'
                   @ nstr+13,0 SAY SPACE(12)+'� �.'+nschg+SPACE(14)+'|'+nschs+'|'+nschk+'|               |'
                   @ nstr+13,0 SAY '_____________________________________________________________________________________'
                   @ nstr+14,0 SAY '              ���⮩ - ⥫��p�䮬 (�㦭�� ����p�����)               |               |'
                   @ nstr+15,0 SAY ' ��㧮�����⥫�       �H ��'+SPACE(41)+'|               |'
                   @ nstr+16,0 SAY '��� '+SPACE(65)+'|               |'
                   @ nstr+16,0 SAY '______________________________________________________________________               '
                   @ nstr+17,0 SAY '������� '+SPACE(19)+'| ���ᮡ ��p�������'+SPACE(22)+'|               |'
                   @ nstr+18,0 SAY '�� '+SPACE(24)+'|'+SPACE(41)+'|               |'
                   @ nstr+18,0 SAY '______________________________________________________________________               '
                   @ nstr+19,0 SAY '��� ���㧪� '+DTOC(bk.dati)+'     |���-�� '+SPACE(34)+'|               |'
                   @ nstr+19,0 SAY '______________________________________________________________________               '
                   @ nstr+20,0 SAY 'H�������.⮢��,�믮������� ࠡ��,����.���,NN �                    |               |'
                   @ nstr+21,0 SAY '�㬬� ⮢���� ���㬥�⮢ ��� ᯥ�䨪��� ⮢��                    |               |'
                   @ nstr+21,0 SAY '______________________________________________________________________               '
                   @ nstr+22,0 SAY bk.text_1+SPACE(19)+'|               |'
                   @ nstr+23,0 SAY bk.text_2+SPACE(19)+'|               |'
                   @ nstr+24,0 SAY bk.text_3+SPACE(19)+'|               |'
                   @ nstr+25,0 SAY bk.text_4+SPACE(19)+'|               |'
                   @ nstr+25,0 SAY '______________________________________________________________________               '
                   nstr=nstr+26
                   @ nstr+ 0,0 SAY '     �.�.            ������ �����⥫�                              |               |'
                   @ nstr+ 1,0 SAY '                                                             �����   | �㬬� � �����|'
                   @ nstr+ 1,0 SAY '_____________________________________________________________________________________'
                   @ nstr+ 2,0 SAY IIF(ff17=1,sum_1,'')
                   @ nstr+ 2,56 SAY '|             |               |'
                   @ nstr+ 3,0 SAY IIF(ff17=1,sum_2,'')
                   @ nstr+ 3,56 SAY '|             |               |'
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
                   @ nstr+11,0 SAY '                                      �p������� ������               |H���.����|     |'
                   @ nstr+11,0 SAY '                                                                     ________________'
                   @ nstr+12,0 SAY '                                                          19___�.    |�p�� ����|     |'
                   @ nstr+12,0 SAY '                                                                     ________________'
                   @ nstr+13,0 SAY '                                      ������ �����                  |��p.����|     |'
                   @ nstr+13,0 SAY '                                                                     ________________'
                   @ nstr+14,0 SAY '   �.�.   ������ ���⥫�騪�                                        |N �p.����|     |'
                   @ nstr+14,0 SAY '                                                                     ________________'
              OTHERWISE
                   SET DEVICE TO SCREEN
                   SET PRINTER TO
                   DO Net_n WITH 10,'�������� ⠪�� ��� ���㬥�� �� ⠪�� ����樨...'
                   RETURN
              ENDCASE
         ENDFOR
         SET RELATION TO
    CASE wid_d=3.OR.wid_d=4
         IF nastf_n=0
              nstr=0
         ELSE
              nstr=PROW()+nastf_6
         ENDIF
         DO CASE
         CASE wid_d=3.AND.vo='0'
              ftext=RTRIM(text_1)+' '+RTRIM(text_2)
              ft_1=''
              ft_2=''
              ft_3=''
              ntek=1
              jj=1
              nn=42
              FOR i=1 TO 3
                   FOR j=jj TO nn
                        IF AT(' ',ftext,j)>=(ntek+nn).OR.EMPTY(AT(' ',ftext,j))
                             j=j-1
                             EXIT
                        ENDIF
                   ENDFOR
                   iii=STR(i,1)
                   ft_&iii=SUBSTR(ftext,ntek,AT(' ',ftext,j)-ntek)
                   ntek=AT(' ',ftext,j)+1
                   jj=j
              ENDFOR
              fc_1=''
              fc_2=''
              fc_3=''
              ntek=1
              jj=1
              nn=32
              FOR i=1 TO 3
                   FOR j=jj TO nn
                        IF AT(' ',ftext,j)>=(ntek+nn).OR.EMPTY(AT(' ',ftext,j))
                             j=j-1
                             EXIT
                        ENDIF
                   ENDFOR
                   iii=STR(i,1)
                   fc_&iii=SUBSTR(ftext,ntek,AT(' ',ftext,j)-ntek)
                   ntek=AT(' ',ftext,j)+1
                   jj=j
              ENDFOR
@ nstr+ 0, 5 SAY LEFT(nschn1,42)+'| '+LEFT(nschn1,28)
@ nstr+ 1,47 SAY '|'
@ nstr+ 2,47 SAY '|'
@ nstr+ 3, 5 SAY '       ������H�� �������� �����           |       ��������'
@ nstr+ 4, 5 SAY '                                          | � �p�室���� ���ᮢ���'
@ nstr+ 5, 5 SAY '  H���p       ���       ��pp.     �㬬�  |    �p��p�  N '+bk.nrd
@ nstr+ 6, 5 SAY '���㬥��  ��⠢�����   ���             |�p���� �� '+fkp
@ nstr+ 7, 5 SAY '                            --------------|'+fikl
@ nstr+ 8, 8 SAY bk.nrd+'   '+DTOC(bk.dati)+'    '+bk.kor+'|'+STR(fsum,12,2)+' |'
@ nstr+ 9, 5 SAY '                            --------------|'
@ nstr+10, 5 SAY '�᭮�����                                 |�᭮����� '
@ nstr+11, 5 SAY ft_1
@ nstr+11,47 SAY '|'+fc_1
@ nstr+12, 5 SAY ft_2
@ nstr+12,47 SAY '|'+fc_2
@ nstr+13, 5 SAY ft_3
@ nstr+13,47 SAY '|'+fc_3
@ nstr+14, 5 SAY '�p���� �� '+LEFT(fkp,6)+' '+LEFT(fikl,24)+'|'+fsum_1
@ nstr+15,23 SAY SUBSTR(fikl,25,6)
@ nstr+15,47 SAY '|'+fsum_2
@ nstr+16, 5 SAY sum_1
@ nstr+16,47 SAY '|'+fsum_3
@ nstr+17, 5 SAY sum_2
@ nstr+17,47 SAY '|'+fsum_4
@ nstr+18, 5 SAY sum_3
@ nstr+18,47 SAY '|'
@ nstr+19,47 SAY '|'+DTOC(bk.dat)
@ nstr+20, 5 SAY '������ ��壠��p                         |  �.�.'
@ nstr+21, 5 SAY '                                          |������ ��壠��p'
@ nstr+22,47 SAY '|'
@ nstr+23, 5 SAY '����稫 ����p                            |����p'
         CASE wid_d=4.AND.vo='1'
              RESTORE FROM tek_b ADDITIVE
@ nstr+ 0,5 SAY nschn1+'         ��p�� ��-02'
@ nstr+ 2, 5 SAY '       ������H�� �������� �����  N '+bk.nrd
@ nstr+ 4,30 SAY '   ���       ��pp.            �㬬�  '
@ nstr+ 5,30 SAY '��⠢�����   ���         ---------------------'
@ nstr+ 6,30 SAY DTOC(bk.dati)+'      '+bk.kor+'         |     '+STR(fsum,12,2)+'  |'
@ nstr+ 7,30 SAY SPACE(27)+'---------------------'
@ nstr+ 9, 5 SAY '�뤠�� '+fkp+fikl
@ nstr+11, 5 SAY '�᭮����� '+bk.text_1
@ nstr+12, 5 SAY SPACE(10)+bk.text_2
@ nstr+14, 5 SAY sum_1
@ nstr+15, 5 SAY sum_2
@ nstr+17, 5 SAY '�㪮����⥫�                     ������ ��壠��p'
@ nstr+19, 5 SAY '����稫 '+IIF(tek_b_18=0,REPLICATE('_',60),sum_1)
@ nstr+21, 5 SAY DTOC(bk.dat)+'       �������'
@ nstr+23, 5 SAY '��__________________________________________________________________'
@ nstr+24, 5 SAY '       ������������, ����p, ��� � ���� �뤠� ���㬥��'
@ nstr+27, 5 SAY '�뤠� ����p'
@ nstr+35, 5 SAY ' '
              RELEASE ALL LIKE tek_b_??
         OTHERWISE
              SET DEVICE TO SCREEN
              DO Net_n WITH 10,'�������� ⠪�� ��� ���㬥�� �� ⠪�� ����樨...'
              RETURN
         ENDCASE
    ENDCASE
    IF nastf_n=0
         EJECT
    ELSE
         @ PROW()+1,0 SAY ' '
    ENDIF
    SELECT bk
    SET ORDER TO nrd
ENDSCAN
RETURN