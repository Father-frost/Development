PRIVATE fsumpr,fsumrx,ii
n1=1
n2=9
n3=17
n4=49
n5=56
n6=72
n7=88
fsumpr=0
fsumrx=0
kol_list=0
nstr=kolstr+1
ii=0
fdat=CTOD('  /   /  ')
GO TOP
DO WHILE !EOF()
    ffdat=dat
    fvo=vo
    fnrd=nrd
    kolnrd=0
    SCAN REST WHILE ffdat=dat.AND.fvo=vo.AND.fnrd=nrd
         IF nstr>kolstr
              kol_list=kol_list+1
              nstr=4
              IF kol_list=1
                   nstr=nstr+1
              ENDIF
         ENDIF
         IF fdat1#fdat2.AND.dat#fdat
              fdat=dat
              nstr=nstr+2
         ENDIF
         nstr=nstr+1
         kolnrd=kolnrd+1
    ENDSCAN
    IF kolnrd>1
         nstr=nstr+2
    ENDIF
ENDDO
nnstr=0
nstr=kolstr+1
kol_pr=0
kol_rx=0
GO TOP
DO WHILE !EOF()
    ffdat=dat
    fvo=vo
    fnrd=nrd
    fsum=0
    kolnrd=0
    SCAN REST WHILE ffdat=dat.AND.fvo=vo.AND.fnrd=nrd
         ii=ii+1
         ?? ii PICTURE '999999' AT 18
         IF nstr>kolstr
              nnstr=nnstr+1
              IF nnstr>=nlist
                   @ 0,20  SAY IIF(LEFT(spr_bs.bs,2)='50',"���ᮢ��   � H � � �         ��-4",'')
                   IF nastf_v=0
                        @ 1,10  SAY spr_bs.nam+" �� "+DTOC(fdat1)
                   ELSE
                        @ 1,10  SAY spr_bs.nam+" c "+DTOC(fdat1)+" �� "+DTOC(fdat2)
                   ENDIF
                   @ 1,60 SAY "���� "+STR(nnstr,3)+".   ���⮢ "+STR(kol_list,3)
                   @ 2,0 SAY REPLICATE('-',IIF(tek_b_41=0,88,139))
                   @ 3,0 SAY "|N ����|��� ���|�� ���� �����. ��� ���� �뤠��|���.��.|     �p�室    |     ���室    |"+IIF(tek_b_41=0,'',SPACE(20)+'�����')
                   @ 4,0 SAY REPLICATE('-',IIF(tek_b_41=0,88,139))
              ENDIF
              nstr=4
              IF nnstr=1
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n3 SAY "���⮪"
                        @ nstr,n5 SAY fost PICTURE '999,999,999.99'
                   ENDIF
              ENDIF
         ENDIF
         IF fdat1#fdat2.AND.dat#fdat
              fdat=dat
              nstr=nstr+2
              IF nnstr>=nlist
                   @ nstr-1,n3+10 SAY fdat
                   @ nstr,n3+10 SAY REPLICATE('=',8)
              ENDIF
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              fikl=Spr_nam(pr_spr,kp,30)
              @ nstr,n1 SAY nrd
              @ nstr,n2 SAY kp
              @ nstr,n3 SAY fikl
              @ nstr,n4 SAY kor
              @ nstr,IIF(vo='0',n5,n6) SAY sm PICTURE '999,999,999.99'
              IF tek_b_41=1
                   @ nstr,n7 SAY text_1
              ENDIF
         ENDIF
         IF vo='0'
              fsumpr=fsumpr+sm
         ELSE
              fsumrx=fsumrx+sm
         ENDIF
         fsum=fsum+sm
         kolnrd=kolnrd+1
    ENDSCAN
    IF fvo='0'
         kol_pr=kol_pr+1
    ELSE
         kol_rx=kol_rx+1
    ENDIF
    IF kolnrd>1
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,IIF(fvo='0',n5,n6) SAY REPLICATE('-',15)
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n3+20 SAY '�⮣� �� '+fnrd
              @ nstr,IIF(fvo='0',n5,n6) SAY fsum PICTURE '999,999,999.99'
         ENDIF
    ENDIF
ENDDO
nstr=nstr+1
IF nnstr>=nlist
    IF fsumpr#0.OR.fsumrx#0
         IF nastf_v=0
              @ nstr,1  SAY "�⮣� �� ����"
         ELSE
              @ nstr,1  SAY "�⮣� �� ��p���"
         ENDIF
         @ nstr,n5 SAY fsumpr PICTURE '999,999,999.99'
         @ nstr,n6 SAY fsumrx PICTURE '999,999,999.99'
    ENDIF
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,1  SAY "���⮪"
    @ nstr,n5 SAY fost+fsumpr-fsumrx PICTURE '999,999,999.99'
ENDIF
nstr=nstr+1
IF nnstr>=nlist
    @ nstr,  10  SAY "����� � ���ᮢ�� ����� �p���p�� � ���㬥���"
    @ nstr+1,10  SAY "� ������⢥ "+STR(kol_pr,4)+" �p�室��� � "+STR(kol_rx,4)+" p��室���"
    @ nstr+2,10  SAY "����稫   ________________________"
    @ nstr+3,10  SAY "��壠��p ________________________"
ENDIF
EJECT
RETURN
