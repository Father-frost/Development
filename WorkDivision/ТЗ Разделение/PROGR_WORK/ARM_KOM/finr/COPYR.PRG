PARAMETERS namef,namep,prposl,namedisk
* namef - ��� 䠩��
* namep - ��� ���� �ਧ����
* prposl - �ਧ��� ��᫥���� �����
* namedisk - ��� ��᪮����
PRIVATE tek,com,name,i,n,pname,n_order
SET COLOR OF SCHEME 19 TO w+/bg,w+/bg,n/bg,w+/bg,w+/bg,w+/n,gr+/bg,w/n,w+/n,w+/n
GO TOP
n_order=ORDER()
SET ESCAPE OFF
IF RIGHT(namef,4)=".dbf"
     namef=LEFT(namef,LEN(namef)-4)
ENDIF
DEFINE WINDOW Zapros_ FROM 10,15 TO 13,64 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros_
SET COLOR TO w+/bg
IF LEN(namef)>8
     @ 0,2 SAY "       ������ ����୮� ��� 䠩��        "
     @ 1,2 SAY "     �த������� - �� ������...     "
     READ
     RELEASE WINDOW Zapros_
     RETURN
ENDIF
namep=UPPER(namep)
i=1
DO WHILE i<=FCOUNT()
    IF FIELD(i)=namep
         IF TYPE(FIELD(i))#TYPE("prposl")
              @ 0,0 SAY " H�ᮮ⢥��⢨� ⨯�� ����ᥩ ���� � �ਧ����"
              @ 1,2 SAY "     �த������� - �� ������...     "
              READ
              RELEASE WINDOW Zapros_
              RETURN
         ENDIF
         EXIT
    ENDIF
    i=i+1
ENDDO
IF i>FCOUNT()
     @ 0,2 SAY "       H�� ⠪��� ���� � 䠩��.         "
     @ 1,2 SAY "     �த������� - �� ������...     "
     READ
     RELEASE WINDOW Zapros_
     RETURN
ENDIF
tek=SYS(5)
@ 0,2 SAY "  ��⠢�� ��᪥��  ��� ����� � ��᪮��� "+namedisk
@ 1,0 SAY "  � ������ ���� �������. <Esc> - �����襭��.  "
READ
IF LASTKEY()=27
     RELEASE WINDOW Zapros_
     RETURN
ENDIF
name=namedisk+namef
DO WHILE .T.
    SET DEFAULT TO &namedisk
    IF FILE(name+".dbf")
         @ 0,2 SAY "  ���� "+namef+".dbf"+" �� ��᪥ "+namedisk+" 㦥 �������. "
         @ 1,0 SAY "  ��९���� ? "+SPACE(31)
         @ 1,23 PROMPT " ��  "
         @ 1,33 PROMPT " H�� "
         MENU TO key
         IF key=2
               EXIT
         ENDIF
         com=name+".dbf"
         DELETE FILE &com
    ENDIF
    IF INT((DISKSPACE()-1000-32*FCOUNT())/RECSIZE())>RECCOUNT()
         USE
         SET DEFAULT TO &tek
         namef=namef+".dbf"
         name=name+".dbf"
         RELEASE WINDOW Zapros_
         COPY FILE &namef TO &name
         EXIT
    ELSE
         SET COLOR TO w+/r
         IF LEN(namef)>7
              @ 0,2 SAY " ����� ����� 䠩�� �ॢ�蠥� 7 ᨬ����� "
              @ 1,2 SAY "     �த������� - �� ������...     "
              READ
              EXIT
         ENDIF
         n=1
         IF FILE(namef+STR(n,1)+".dbf")
              SET COLOR TO w+/bg
              @ 0,2 SAY "  ���� "+namef+STR(n,1)+".dbf"+" �� ��᪥ "+namedisk+" 㦥 �������."
              @ 1,0 SAY "  ��९���� ? "+SPACE(31)
              @ 1,23 PROMPT " ��  "
              @ 1,33 PROMPT " H�� "
              MENU TO key
              IF key=2
                   RELEASE WINDOW Zapros_
                   RETURN
              ENDIF
              com=namef+STR(n,1)+".dbf"
              DELETE FILE &com
         ENDIF
         IF DISKSPACE()<4000
              DEFINE WINDOW Rab FROM 9,9 TO 13,71 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Rab
              SET COLOR TO w+/bg
              @ 0,2 SAY "               H�� ���� �� ��᪥.                 "
              @ 1,2 SAY "            ��⠭���� ����� ��᪥��.             "
              @ 2,2 SAY " �����襭�� - <Esc>. �த������� - �� ������..."
              READ
              HIDE WINDOW Rab
              IF LASTKEY()=27
                   RELEASE WINDOW Zapros_
                   EXIT
              ENDIF
              LOOP
         ENDIF
         DO WHILE !EOF()
              SET DEFAULT TO &tek
              pname=name+LTRIM(STR(n,1))+".dbf"
              IF FILE(pname)
                   DELETE FILE &pname
              ENDIF
              SET DEFAULT TO &namedisk
              IF INT((DISKSPACE()-1000-32*FCOUNT())/RECSIZE())<=0
                   DEFINE WINDOW Rab FROM 9,15 TO 13,66 COLOR SCHEME 19 SHADOW
                   ACTIVATE WINDOW Rab
                   SET COLOR TO w+/bg
                   @ 0,2 SAY "               H�� ���� �� ��᪥.                 "
                   @ 1,2 SAY "            ��⠭���� ����� ��᪥��.             "
                   @ 2,2 SAY " �����襭�� - <Esc>. �த������� - �� ������..."
                   READ
                   HIDE WINDOW Rab
                   IF LASTKEY()=27
                        RELEASE WINDOW Zapros_
                        EXIT
                   ENDIF
                   LOOP
              ENDIF
              nzap=INT((DISKSPACE()-1000-32*FCOUNT())/RECSIZE())
              SET DEFAULT TO &tek
              com="COPY TO "+pname+" NEXT nzap"
              &com
              n=n+1
              IF !EOF()
                   SKIP
                   DEFINE WINDOW Rab FROM 9,15 TO 12,66 COLOR SCHEME 19 SHADOW
                   ACTIVATE WINDOW Rab
                   SET COLOR TO w+/bg
                   @ 0,2 SAY "    ��⠢�� ��᪥�� "+STR(n,1)+" ��� ����� � ��᪮��� "+namedisk
                   @ 1,0 SAY "  � ������ ���� �������. <Esc> - �����襭��.  "
                   READ
                   IF LASTKEY()=27
                        EXIT
                   ENDIF
              ENDIF
         ENDDO
         IF LASTKEY()#27
              com="USE "+name+LTRIM(STR(n-1,1))
              &com
              APPEND BLANK
              REPLACE &namep WITH prposl
         ELSE
              EXIT
         ENDIF
         EXIT
    ENDIF
ENDDO
RELEASE WINDOW Zapros_
SET DEFAULT TO &tek
USE &namef
RETURN
