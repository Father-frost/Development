PARAMETERS fsum
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
              s_p=s_p+"долларов США "
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
                   s_p=s_p+"долларов США "
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
                   s_p=s_p+"один доллар США "
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
                   s_p=s_p+"два доллара США "
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
                   s_p=s_p+"тpи доллара США "
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
                   s_p=s_p+"четыpе доллара США "
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
                   s_p=s_p+"пять долларов США "
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
                   s_p=s_p+"шесть долларов США "
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
                   s_p=s_p+"семь долларов США "
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
                   s_p=s_p+"восемь долларов США "
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
                   s_p=s_p+"девять долларов США "
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
s_p=s_p+RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+"/100"
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
