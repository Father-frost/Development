PARAMETERS fsum,vid_val
PRIVATE sym,i,i1,i2,i3
s_p=""
IF fsum>999999999999.99.OR.fsum<0
    @ 11,17,14,63 BOX "�Ŀ����� "
    @ 12,18 SAY "H���p�� ����� ��� �p���p�������� � �p�����."
    @ 13,26 SAY "�p��������� - �� ������..."
    READ
    RETURN ''
ENDIF
sym=STR(INT(fsum),12,0)
DO CASE
CASE fsum<1000.00
    i=1
CASE fsum<1000000.00
    i=2
CASE fsum<1000000000.00
    i=3
OTHERWISE
    i=4
ENDCASE
DO WHILE i>=1
    DO CASE
    CASE i=1
         i1=SUBSTR(sym,12,1)
         i2=SUBSTR(sym,11,1)
         i3=SUBSTR(sym,10,1)
    CASE i=2
         i1=SUBSTR(sym,9,1)
         i2=SUBSTR(sym,8,1)
         i3=SUBSTR(sym,7,1)
    CASE i=3
         i1=SUBSTR(sym,6,1)
         i2=SUBSTR(sym,5,1)
         i3=SUBSTR(sym,4,1)
    CASE i=4
         i1=SUBSTR(sym,3,1)
         i2=SUBSTR(sym,2,1)
         i3=SUBSTR(sym,1,1)
    ENDCASE
    DO CASE
    CASE i3="1"
         s_p=s_p+"�� "
    CASE i3="2"
         s_p=s_p+"����� "
    CASE i3="3"
         s_p=s_p+"�p��� "
    CASE i3="4"
         s_p=s_p+"���p��� "
    CASE i3="5"
         s_p=s_p+"������ "
    CASE i3="6"
         s_p=s_p+"������ "
    CASE i3="7"
         s_p=s_p+"ᥬ��� "
    CASE i3="8"
         s_p=s_p+"��ᥬ��� "
    CASE i3="9"
         s_p=s_p+"�������� "
    ENDCASE
    DO CASE
    CASE i2="1"
         DO CASE
         CASE i1="1"
              s_p=s_p+"���������� "
         CASE i1="2"
              s_p=s_p+"��������� "
         CASE i1="3"
              s_p=s_p+"�p������� "
         CASE i1="4"
              s_p=s_p+"���p������ "
         CASE i1="5"
              s_p=s_p+"��⭠���� "
         CASE i1="6"
              s_p=s_p+"��⭠���� "
         CASE i1="7"
              s_p=s_p+"ᥬ������ "
         CASE i1="8"
              s_p=s_p+"��ᥬ������ "
         CASE i1="9"
              s_p=s_p+"����⭠���� "
         CASE i1="0"
              s_p=s_p+"������ "
         ENDCASE
         DO CASE
         CASE i=4
              s_p=s_p+"������p��� "
         CASE i=3
              s_p=s_p+"��������� "
         CASE i=2
              s_p=s_p+"����� "
         CASE i=1
              s_p=s_p+"�������᪨� p㡫�� "
         ENDCASE
    CASE i2="2"
         s_p=s_p+"������� "
    CASE i2="3"
         s_p=s_p+"�p����� "
    CASE i2="4"
         s_p=s_p+"�p�� "
    CASE i2="5"
         s_p=s_p+"���줥��� "
    CASE i2="6"
         s_p=s_p+"���줥��� "
    CASE i2="7"
         s_p=s_p+"ᥬ줥��� "
    CASE i2="8"
         s_p=s_p+"��ᥬ줥��� "
    CASE i2="9"
         s_p=s_p+"���ﭮ�� "
    ENDCASE
    IF i2#"1"
         DO CASE
         CASE i1="0".AND.(i2#'0'.OR.i3#'0'.OR.i=1)
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+") �����஢ ��� "
                     ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+") ��ᨩ᪨� �㡫�� "
                        ELSE
                         IF alltrim(vid_val)='DM'
                           s_p=s_p+") ����檨� ��ப "
                           ELSE
                            IF alltrim(vid_val)='KRB'
                              s_p=s_p+") �ࠨ�᪨� �ਢ�� "
                              ELSE
                               s_p=s_p+" �������᪨� p㡫�� "
                            ENDIF
                         ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"����� "
              CASE i=3
                   s_p=s_p+"��������� "
              CASE i=4
                   s_p=s_p+"������p��� "
              ENDCASE
         CASE i1="1"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"����) ������ ��� "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"����) ��ᨩ᪨� �㡫� "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"����) ����檠� ��ઠ "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"����) �ࠨ�᪠� �ਢ�� "
                          ELSE
                             s_p=s_p+"���� �������᪨� �㡫� "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"���� ����� "
              CASE i=3
                   s_p=s_p+"���� ������� "
              CASE i=4
                   s_p=s_p+"���� ������p� "
              ENDCASE
         CASE i1="2"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"���) ������ ��� "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"���) ��ᨩ᪨� �㡫� "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"���) ����檨� ��ન "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"���) �ࠨ�᪨� �ਢ�� "
                          ELSE
                             s_p=s_p+"��� �������᪨� �㡫� "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"��� ����� "
              CASE i=3
                   s_p=s_p+"��� �������� "
              CASE i=4
                   s_p=s_p+"��� ������p�� "
              ENDCASE
         CASE i1="3"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"��) ������ ��� "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"��) ��ᨩ᪨� �㡫� "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"��) ����檨� ��ન "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"��) �ࠨ�᪨� �ਢ�� "
                          ELSE
                             s_p=s_p+"�� �������᪨� �㡫� "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"�p� ����� "
              CASE i=3
                   s_p=s_p+"�p� �������� "
              CASE i=4
                   s_p=s_p+"�p� ������p�� "
              ENDCASE
         CASE i1="4"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"����) ������ ��� "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"����) ��ᨩ᪨� �㡫� "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"����) ����檨� ��ન "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"����) �ࠨ�᪨� �ਢ�� "
                          ELSE
                             s_p=s_p+"���� �������᪨� �㡫� "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"���p� ����� "
              CASE i=3
                   s_p=s_p+"���p� �������� "
              CASE i=4
                   s_p=s_p+"���p� ������p�� "
              ENDCASE
         CASE i1="5"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"����) �����஢ ��� "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"����) ��ᨩ᪨� �㡫�� "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"����) ����檨� ��ப "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"����) �ࠨ�᪨� �ਢ�� "
                          ELSE
                             s_p=s_p+"���� �������᪨� �㡫�� "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"���� ����� "
              CASE i=3
                   s_p=s_p+"���� ��������� "
              CASE i=4
                   s_p=s_p+"���� ������p��� "
              ENDCASE
         CASE i1="6"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"����) �����஢ ��� "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"����) ��ᨩ᪨� �㡫�� "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"����) ����檨� ��ப "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"����) �ࠨ�᪨� �ਢ�� "
                          ELSE
                             s_p=s_p+"���� �������᪨� �㡫�� "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"���� ����� "
              CASE i=3
                   s_p=s_p+"���� ��������� "
              CASE i=4
                   s_p=s_p+"���� ������p��� "
              ENDCASE
         CASE i1="7"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"ᥬ�) �����஢ ��� "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"ᥬ�) ��ᨩ᪨� �㡫�� "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"ᥬ�) ����檨� ��ப "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"ᥬ�) �ࠨ�᪨� �ਢ�� "
                          ELSE
                             s_p=s_p+"ᥬ� �������᪨� �㡫�� "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"ᥬ� ����� "
              CASE i=3
                   s_p=s_p+"ᥬ� ��������� "
              CASE i=4
                   s_p=s_p+"ᥬ� ������p��� "
              ENDCASE
         CASE i1="8"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"��ᥬ�) �����஢ ��� "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"��ᥬ�) ��ᨩ᪨� �㡫�� "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"��ᥬ�) ����檨� ��ப "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"��ᥬ�) �ࠨ�᪨� �ਢ�� "
                          ELSE
                             s_p=s_p+"��ᥬ� �������᪨� �㡫�� "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"��ᥬ� ����� "
              CASE i=3
                   s_p=s_p+"��ᥬ� ��������� "
              CASE i=4
                   s_p=s_p+"��ᥬ� ������p��� "
              ENDCASE
         CASE i1="9"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"������) �����஢ ��� "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"������) ��ᨩ᪨� �㡫�� "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"������) ����檨� ��ப "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"������) �ࠨ�᪨� �ਢ�� "
                          ELSE
                             s_p=s_p+"������ �������᪨� �㡫�� "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"������ ����� "
              CASE i=3
                   s_p=s_p+"������ ��������� "
              CASE i=4
                   s_p=s_p+"������ ������p��� "
              ENDCASE
         ENDCASE
    ENDIF
    i=i-1
ENDDO
IF alltrim(vid_val)='USD'
  s_p=s_p+RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" 業�."
ELSE
 IF alltrim(vid_val)='RUR'
   s_p=s_p+RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" ���."
 ELSE
   IF alltrim(vid_val)='DM'
     s_p=s_p+RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" �䥭."
   ELSE
    IF alltrim(vid_val)='KRB'
      s_p=s_p+RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" ���."
    ELSE
      s_p=s_p  && +RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" ���."
    ENDIF
   ENDIF
 ENDIF
ENDIF
*s_p=s_p  && +RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" ���."
i=LEFT(s_p,1)
DO CASE
CASE i='�'
    s_p=STUFF(s_p,1,1,'�')
CASE i='�'
    s_p=STUFF(s_p,1,1,'�')
CASE i='�'
    s_p=STUFF(s_p,1,1,'�')
CASE i='�'
    s_p=STUFF(s_p,1,1,'�')
CASE i='�'
    s_p=STUFF(s_p,1,1,'�')
CASE i='�'
    s_p=STUFF(s_p,1,1,'�')
CASE i='�'
    s_p=STUFF(s_p,1,1,'�')
CASE i='�'
    s_p=STUFF(s_p,1,1,'�')
ENDCASE
RETURN s_p