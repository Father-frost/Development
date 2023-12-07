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
         s_p=s_p+"one hundred "
    CASE i3="2"
         s_p=s_p+"two hundred "
    CASE i3="3"
         s_p=s_p+"three hundred "
    CASE i3="4"
         s_p=s_p+"four hundred "
    CASE i3="5"
         s_p=s_p+"five hundred "
    CASE i3="6"
         s_p=s_p+"six hundred "
    CASE i3="7"
         s_p=s_p+"seven hundred "
    CASE i3="8"
         s_p=s_p+"eight hundred "
    CASE i3="9"
         s_p=s_p+"nine hundred "
    ENDCASE
    IF i=1.AND.(i2#'0'.OR.i1#'0')
         s_p=s_p+"and "
    ENDIF
    DO CASE
    CASE i2="1"
         DO CASE
         CASE i1="1"
              s_p=s_p+"eleven "
         CASE i1="2"
              s_p=s_p+"twelve "
         CASE i1="3"
              s_p=s_p+"thirteen "
         CASE i1="4"
              s_p=s_p+"fourteen "
         CASE i1="5"
              s_p=s_p+"fifteen "
         CASE i1="6"
              s_p=s_p+"sixteen "
         CASE i1="7"
              s_p=s_p+"seventeen "
         CASE i1="8"
              s_p=s_p+"eighteen "
         CASE i1="9"
              s_p=s_p+"nineteen "
         CASE i1="0"
              s_p=s_p+"teen "
         ENDCASE
         DO CASE
         CASE i=4
              s_p=s_p+"milliard "
         CASE i=3
              s_p=s_p+"million "
         CASE i=2
              s_p=s_p+"thousand "
         CASE i=1
              s_p=s_p+"USD "
         ENDCASE
    CASE i2="2"
         s_p=s_p+"twenty "
    CASE i2="3"
         s_p=s_p+"thirty "
    CASE i2="4"
         s_p=s_p+"fourty "
    CASE i2="5"
         s_p=s_p+"fifty "
    CASE i2="6"
         s_p=s_p+"sixty "
    CASE i2="7"
         s_p=s_p+"seventy "
    CASE i2="8"
         s_p=s_p+"eighty "
    CASE i2="9"
         s_p=s_p+"ninety "
    ENDCASE
    IF i2#"1"
         IF i=1.AND.i2#'0'.AND.i2#'1'
              s_p=s_p+"- "
         ENDIF
         DO CASE
         CASE i1="0".AND.(i2#'0'.OR.i3#'0'.OR.i=1)
              DO CASE
              CASE i=1
                   s_p=s_p+"USD "
              CASE i=2
                   s_p=s_p+"thousand "
              CASE i=3
                   s_p=s_p+"million "
              CASE i=4
                   s_p=s_p+"milliard "
              ENDCASE
         CASE i1="1"
              DO CASE
              CASE i=1
                   s_p=s_p+"one USD "
              CASE i=2
                   s_p=s_p+"one thousand "
              CASE i=3
                   s_p=s_p+"one million "
              CASE i=4
                   s_p=s_p+"one milliard "
              ENDCASE
         CASE i1="2"
              DO CASE
              CASE i=1
                   s_p=s_p+"two USD "
              CASE i=2
                   s_p=s_p+"two thousand "
              CASE i=3
                   s_p=s_p+"two million "
              CASE i=4
                   s_p=s_p+"two milliard "
              ENDCASE
         CASE i1="3"
              DO CASE
              CASE i=1
                   s_p=s_p+"three USD "
              CASE i=2
                   s_p=s_p+"three thousand "
              CASE i=3
                   s_p=s_p+"three million "
              CASE i=4
                   s_p=s_p+"three milliard "
              ENDCASE
         CASE i1="4"
              DO CASE
              CASE i=1
                   s_p=s_p+"four USD "
              CASE i=2
                   s_p=s_p+"four thousand "
              CASE i=3
                   s_p=s_p+"four million "
              CASE i=4
                   s_p=s_p+"four milliard "
              ENDCASE
         CASE i1="5"
              DO CASE
              CASE i=1
                   s_p=s_p+"five USD "
              CASE i=2
                   s_p=s_p+"five thousand "
              CASE i=3
                   s_p=s_p+"five million "
              CASE i=4
                   s_p=s_p+"five milliard "
              ENDCASE
         CASE i1="6"
              DO CASE
              CASE i=1
                   s_p=s_p+"six USD "
              CASE i=2
                   s_p=s_p+"six thousand "
              CASE i=3
                   s_p=s_p+"six million "
              CASE i=4
                   s_p=s_p+"six milliard "
              ENDCASE
         CASE i1="7"
              DO CASE
              CASE i=1
                   s_p=s_p+"seven USD "
              CASE i=2
                   s_p=s_p+"seven thousand "
              CASE i=3
                   s_p=s_p+"seven million "
              CASE i=4
                   s_p=s_p+"seven milliard "
              ENDCASE
         CASE i1="8"
              DO CASE
              CASE i=1
                   s_p=s_p+"eight USD "
              CASE i=2
                   s_p=s_p+"eight thousand "
              CASE i=3
                   s_p=s_p+"eight million "
              CASE i=4
                   s_p=s_p+"eight milliard "
              ENDCASE
         CASE i1="9"
              DO CASE
              CASE i=1
                   s_p=s_p+"nine USD "
              CASE i=2
                   s_p=s_p+"nine thousand "
              CASE i=3
                   s_p=s_p+"nine million "
              CASE i=4
                   s_p=s_p+"nine milliard "
              ENDCASE
         ENDCASE
    ENDIF
    i=i-1
ENDDO
s_p=s_p+RIGHT('0'+LTRIM(STR((fsum-INT(fsum))*100.0,2,0)),2)+"/100"
i=LEFT(s_p,1)
s_p=STUFF(s_p,1,1,UPPER(i))
RETURN s_p
