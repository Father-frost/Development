PARAMETERS namef,namep,prposl,namedisk
* namef - ��� 䠩��
* namep - ��� ���� �ਧ����
* prposl - �ਧ��� ��᫥���� �����
* namedisk - ��� ��᪮����
PRIVATE tek,com,name,i,n,pname
SET COLOR OF SCHEME 19 TO w+/bg,w+/bg,n/bg,w+/bg,w+/bg,w+/n,gr+/bg,w/n,w+/n,w+/n
IF RIGHT(namef,4)=".dbf"
     namef=LEFT(namef,LEN(namef)-4)
ENDIF
prnamef=namef
DEFINE WINDOW Zapros_ FROM 10,15 TO 13,64 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros_
SET COLOR TO n/bg
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
SET COLOR TO w+/bg,w+/n
@ 0,2 SAY "  ��⠢�� ��᪥��  � ������ � ��᪮��� "+namedisk
@ 1,0 SAY "  � ������ ���� �������. <Esc> - �����襭��.  "
READ
IF LASTKEY()=27
     RELEASE WINDOW Zapros_
     RETURN
ENDIF
name=namedisk+namef
SET DEFAULT TO &namedisk
DO WHILE !FILE(namef+".dbf").AND.!FILE(namef+"1.dbf")
    @ 0,2 SAY "  ����� "+namef+".dbf"+" �� ��᪥ "+namedisk+" ���."+SPACE(10)
    @ 1,0 SAY "  ������� ? "+SPACE(31)
    @ 1,23 PROMPT " ��  "
    @ 1,33 PROMPT " H�� "
	MENU TO key
	IF key=2
         SET DEFAULT TO &tek
         RELEASE WINDOW Zapros_
         RETURN
	ENDIF
ENDDO
pname=namef+".dbf"
USE
SET DEFAULT TO &tek
* ���客�� ����� 䠩��
sss=RTRIM(LEFT(prnamef,7))+'_'+'.dbf'
sss1=RTRIM(prnamef)+'.dbf'
COPY FILE &sss1 TO &sss
*
IF FILE(namef+".dbf")
    DELETE FILE &pname
    USE
    namef=namef+".dbf"
    name=name+".dbf"
    RELEASE WINDOW Zapros_
    COPY FILE &name TO &namef
    USE &namef
ELSE
    SET COLOR TO n/bg
    IF LEN(namef)>7
         @ 0,2 SAY " ����� ����� 䠩�� �ॢ�蠥� 7 ᨬ����� "
         @ 1,2 SAY "     �த������� - �� ������...     "
         READ
         RELEASE WINDOW Zapros_
         RETURN
    ENDIF
    n=1
    DO WHILE .T.
         DO WHILE  !FILE(name+LTRIM(STR(n,1))+".dbf").AND.key<>27
              DEFINE WINDOW Rab FROM 9,20 TO 13,51 COLOR SCHEME 19 SHADOW DOUBLE
              ACTIVATE WINDOW Rab
              SET COLOR TO w+/bg
              @ 0,1 SAY " ��⠭������ �� � ��᪥�. "
              @ 1,1 SAY "    �����襭�� - <Esc>.     "
              @ 2,1 SAY "�த������� - �� ������."
              READ
              key=LASTKEY()
              RELEASE WINDOW Rab
         ENDDO
         IF key=27
              EXIT
         ENDIF
         IF n=1
              IF FILE(pname)
                   DELETE FILE &pname
              ENDIF
              com=name+"1.dbf"
              COPY FILE &com TO &pname
              USE &namef
         ELSE
              com=name+LTRIM(STR(n,1))
              APPEND FROM &com
         ENDIF
         GO BOTTOM
         IF RTRIM(&namep)=prposl
              DELETE
              PACK
              EXIT
         ENDIF
         n=n+1
         SET COLOR TO w+/bg
         @ 0,2 SAY "    ��⠢�� ��᪥�� "+STR(n,1)+" � ������ � ��᪮��� "+namedisk
         @ 1,2 SAY "  � ������ ���� �������. <Esc> - �����襭��.  "
         READ
         IF LASTKEY()=27
              EXIT
         ENDIF
    ENDDO
ENDIF
RELEASE WINDOW Zapros_
RETURN
