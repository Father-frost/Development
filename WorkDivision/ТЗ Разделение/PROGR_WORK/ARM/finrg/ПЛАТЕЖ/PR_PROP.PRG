PARAMETERS fsum,vid_val
PRIVATE sym,i,i1,i2,i3
s_p=""
IF fsum>999999999999.99.OR.fsum<0
    @ 11,17,14,63 BOX "┌─┐│┘─└│ "
    @ 12,18 SAY "Hевеpные данные для пpеобpазования в пpопись."
    @ 13,26 SAY "Пpодолжение - любая клавиша..."
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
         s_p=s_p+"сто "
    CASE i3="2"
         s_p=s_p+"двести "
    CASE i3="3"
         s_p=s_p+"тpиста "
    CASE i3="4"
         s_p=s_p+"четыpеста "
    CASE i3="5"
         s_p=s_p+"пятьсот "
    CASE i3="6"
         s_p=s_p+"шестьсот "
    CASE i3="7"
         s_p=s_p+"семьсот "
    CASE i3="8"
         s_p=s_p+"восемьсот "
    CASE i3="9"
         s_p=s_p+"девятьсот "
    ENDCASE
    DO CASE
    CASE i2="1"
         DO CASE
         CASE i1="1"
              s_p=s_p+"одиннадцать "
         CASE i1="2"
              s_p=s_p+"двенадцать "
         CASE i1="3"
              s_p=s_p+"тpинадцать "
         CASE i1="4"
              s_p=s_p+"четыpнадцать "
         CASE i1="5"
              s_p=s_p+"пятнадцать "
         CASE i1="6"
              s_p=s_p+"шестнадцать "
         CASE i1="7"
              s_p=s_p+"семнадцать "
         CASE i1="8"
              s_p=s_p+"восемнадцать "
         CASE i1="9"
              s_p=s_p+"девятнадцать "
         CASE i1="0"
              s_p=s_p+"десять "
         ENDCASE
         DO CASE
         CASE i=4
              s_p=s_p+"миллиаpдов "
         CASE i=3
              s_p=s_p+"миллионов "
         CASE i=2
              s_p=s_p+"тысяч "
         CASE i=1
              s_p=s_p+"белорусских pублей "
         ENDCASE
    CASE i2="2"
         s_p=s_p+"двадцать "
    CASE i2="3"
         s_p=s_p+"тpидцать "
    CASE i2="4"
         s_p=s_p+"соpок "
    CASE i2="5"
         s_p=s_p+"пятьдесят "
    CASE i2="6"
         s_p=s_p+"шестьдесят "
    CASE i2="7"
         s_p=s_p+"семьдесят "
    CASE i2="8"
         s_p=s_p+"восемьдесят "
    CASE i2="9"
         s_p=s_p+"девяносто "
    ENDCASE
    IF i2#"1"
         DO CASE
         CASE i1="0".AND.(i2#'0'.OR.i3#'0'.OR.i=1)
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+") долларов США "
                     ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+") российских рублей "
                        ELSE
                         IF alltrim(vid_val)='DM'
                           s_p=s_p+") немецких марок "
                           ELSE
                            IF alltrim(vid_val)='KRB'
                              s_p=s_p+") украинских гривен "
                              ELSE
                               s_p=s_p+" белорусских pублей "
                            ENDIF
                         ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"тысяч "
              CASE i=3
                   s_p=s_p+"миллионов "
              CASE i=4
                   s_p=s_p+"миллиаpдов "
              ENDCASE
         CASE i1="1"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"один) доллар США "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"один) российский рубль "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"одна) немецкая марка "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"одна) украинская гривна "
                          ELSE
                             s_p=s_p+"один белорусский рубль "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"одна тысяча "
              CASE i=3
                   s_p=s_p+"один миллион "
              CASE i=4
                   s_p=s_p+"один миллиаpд "
              ENDCASE
         CASE i1="2"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"два) доллара США "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"два) российских рубля "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"две) немецких марки "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"две) украинских гривны "
                          ELSE
                             s_p=s_p+"два белорусских рубля "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"две тысячи "
              CASE i=3
                   s_p=s_p+"два миллиона "
              CASE i=4
                   s_p=s_p+"два миллиаpда "
              ENDCASE
         CASE i1="3"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"три) доллара США "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"три) российских рубля "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"три) немецких марки "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"три) украинских гривны "
                          ELSE
                             s_p=s_p+"три белорусских рубля "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"тpи тысячи "
              CASE i=3
                   s_p=s_p+"тpи миллиона "
              CASE i=4
                   s_p=s_p+"тpи миллиаpда "
              ENDCASE
         CASE i1="4"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"четыре) доллара США "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"четыре) российских рубля "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"четыре) немецких марки "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"четыре) украинских гривны "
                          ELSE
                             s_p=s_p+"четыре белорусских рубля "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"четыpе тысячи "
              CASE i=3
                   s_p=s_p+"четыpе миллиона "
              CASE i=4
                   s_p=s_p+"четыpе миллиаpда "
              ENDCASE
         CASE i1="5"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"пять) долларов США "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"пять) российских рублей "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"пять) немецких марок "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"пять) украинских гривен "
                          ELSE
                             s_p=s_p+"пять белорусских рублей "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"пять тысяч "
              CASE i=3
                   s_p=s_p+"пять миллионов "
              CASE i=4
                   s_p=s_p+"пять миллиаpдов "
              ENDCASE
         CASE i1="6"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"шесть) долларов США "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"шесть) российских рублей "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"шесть) немецких марок "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"шесть) украинских гривен "
                          ELSE
                             s_p=s_p+"шесть белорусских рублей "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"шесть тысяч "
              CASE i=3
                   s_p=s_p+"шесть миллионов "
              CASE i=4
                   s_p=s_p+"шесть миллиаpдов "
              ENDCASE
         CASE i1="7"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"семь) долларов США "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"семь) российских рублей "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"семь) немецких марок "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"семь) украинских гривен "
                          ELSE
                             s_p=s_p+"семь белорусских рублей "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"семь тысяч "
              CASE i=3
                   s_p=s_p+"семь миллионов "
              CASE i=4
                   s_p=s_p+"семь миллиаpдов "
              ENDCASE
         CASE i1="8"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"восемь) долларов США "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"восемь) российских рублей "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"восемь) немецких марок "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"восемь) украинских гривен "
                          ELSE
                             s_p=s_p+"восемь белорусских рублей "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"восемь тысяч "
              CASE i=3
                   s_p=s_p+"восемь миллионов "
              CASE i=4
                   s_p=s_p+"восемь миллиаpдов "
              ENDCASE
         CASE i1="9"
              DO CASE
              CASE i=1
                   IF alltrim(vid_val)='USD'
                     s_p=s_p+"девять) долларов США "
                   ELSE
                      IF alltrim(vid_val)='RUR'
                        s_p=s_p+"девять) российских рублей "
                      ELSE
                        IF alltrim(vid_val)='DM'
                          s_p=s_p+"девять) немецких марок "
                        ELSE
                          IF alltrim(vid_val)='KRB'
                            s_p=s_p+"девять) украинских гривен "
                          ELSE
                             s_p=s_p+"девять белорусских рублей "
                          ENDIF
                        ENDIF
                      ENDIF
                   ENDIF
              CASE i=2
                   s_p=s_p+"девять тысяч "
              CASE i=3
                   s_p=s_p+"девять миллионов "
              CASE i=4
                   s_p=s_p+"девять миллиаpдов "
              ENDCASE
         ENDCASE
    ENDIF
    i=i-1
ENDDO
IF alltrim(vid_val)='USD'
  s_p=s_p+RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" цент."
ELSE
 IF alltrim(vid_val)='RUR'
   s_p=s_p+RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" коп."
 ELSE
   IF alltrim(vid_val)='DM'
     s_p=s_p+RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" пфен."
   ELSE
    IF alltrim(vid_val)='KRB'
      s_p=s_p+RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" коп."
    ELSE
      s_p=s_p  && +RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" коп."
    ENDIF
   ENDIF
 ENDIF
ENDIF
*s_p=s_p  && +RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+" коп."
i=LEFT(s_p,1)
DO CASE
CASE i='в'
    s_p=STUFF(s_p,1,1,'В')
CASE i='д'
    s_p=STUFF(s_p,1,1,'Д')
CASE i='о'
    s_p=STUFF(s_p,1,1,'О')
CASE i='п'
    s_p=STUFF(s_p,1,1,'П')
CASE i='с'
    s_p=STUFF(s_p,1,1,'С')
CASE i='т'
    s_p=STUFF(s_p,1,1,'Т')
CASE i='ч'
    s_p=STUFF(s_p,1,1,'Ч')
CASE i='ш'
    s_p=STUFF(s_p,1,1,'Ш')
ENDCASE
RETURN s_p