PRIVATE ii,fkp,fsum,nz,scr,sum_1,sum_2,sum_3,ntek,i,j,nam_file
SAVE SCREEN TO scr
IF nastf_d=0
    RETURN
ENDIF
*
chg12=0
fname='out.txt        '
nlist=1
m.pr_otk=.F.
DO Pr_file WITH chg12,fname,nlist,.F.,m.pr_otk
IF m.pr_otk
     RETURN
ENDIF
*
nam_file=ALIAS()
SET DEVICE TO SCREEN
fkol=1
ffpr=0
fftar=0
ffl=0
IF INLIST(wid_d,1,2,5)
    @ 16,41 FILL TO 18,69 COLOR &color20
    SET COLOR TO &color13
    @ 15,40,17,68 BOX '╔═╗║╝═╚║ '
    SET COLOR TO &color14
    SET ORDER TO nrd
    @ 16,41 SAY ' Количество экземпляpов' GET fkol PICTURE '9'
    READ
    IF LASTKEY()=27
         RETURN
    ENDIF
    RESTORE FROM tek_b ADDITIVE
    ftek_b_29=tek_b_29
    ftek_b_52=tek_b_52
    ff17=tek_b_17
    IF tek_b_16=1
         RESTORE SCREEN FROM scr
         @ 16,41 FILL TO 18,69 COLOR &color20
         SET COLOR TO &color13
         @ 15,40,17,68 BOX '╔═╗║╝═╚║ '
         SET COLOR TO &color14
         @ 16,41 SAY ' Оpганизация стоpонняя?' GET ffpr PICTURE '9' VALID ffpr=0.OR.ffpr=1 ERROR "Значение невеpно..."
         READ
         IF LASTKEY()=27
              RETURN
         ENDIF
         IF ffpr=1.AND.ftek_b_29#0
              @ 19,45 FILL TO 21,63 COLOR &color20
              SET COLOR TO &color13
              @ 18,44,20,62 BOX '╔═╗║╝═╚║ '
              SET COLOR TO &color14
              @ 19,45 SAY ' Телеграфом ?' GET fftar PICTURE '9' VALID fftar=0.OR.fftar=1 ERROR "0 - нет, 1 - телеграфом..."
              READ
              IF LASTKEY()=27
                   RETURN
              ENDIF
         ENDIF
    ENDIF
    DO CASE
    CASE wid_d=1.AND.vo='0'
         RESTORE SCREEN FROM scr
         @ 15,19 FILL TO 22,77 COLOR &color20
         SET COLOR TO &color13
         @ 14,18,21,76 BOX '╔═╗║╝═╚║ '
         SET COLOR TO &color14
         fftext=SPACE(50)
         ffcen=SPACE(32)
         ffdot=DATE()
         ffdov=SPACE(23)
         @ 15,19 SAY ' Текст' GET fftext
         @ 16,19 SAY ' Вид отгрузки ' GET dat_tov
         @ 17,19 SAY ' Дата договора' GET dats
         @ 18,19 SAY ' Дата отгрузки' GET ffdot
         @ 19,19 SAY ' Доверенность ' GET ffdov
         @ 20,19 SAY ' Цена         ' GET ffcen
         READ
         IF LASTKEY()=27
              RETURN
         ENDIF
    CASE wid_d=2.AND.vo='1'
         RESTORE SCREEN FROM scr
         @ 17,31 FILL TO 22,65 COLOR &color20
         SET COLOR TO &color13
         @ 16,30,21,56 BOX '╔═╗║╝═╚║ '
         SET COLOR TO &color14
         fftext=SPACE(30)
         ffdat=CTOD('  /  /  ')
         ffpl=SPACE(5)
         @ 17,31 SAY ' Признак текста' GET ffl PICTURE '9' VALID ffl=0.OR.ffl=1.OR.ffl=2.OR.ffl=3 ERROR "Значение невеpно..."
         @ 18,31 SAY ' Срок платежа' GET ffdat
         @ 19,31 SAY ' Очер.платежа' GET ffpl
         @ 20,31 SAY ' Вид операции' GET vid_op
         READ
         IF LASTKEY()=27
              RETURN
         ENDIF
    ENDCASE
    RELEASE ALL LIKE tek_b_??
ENDIF
RESTORE SCREEN FROM scr
RESTORE FROM nsch ADDITIVE
IF EMPTY(dati)
    DO Net_n WITH 12,'Hевеpна дата документа. Повтоpите...'
    RETURN
ENDIF
nammec=RTRIM(name_mec(MONTH(dati)))
IF MONTH(dati)=3.OR.MONTH(dati)=8
    nammec=nammec+'а'
ELSE
    nammec=LEFT(nammec,LEN(nammec)-1)+'я'
ENDIF
nz=RECNO()
fsum=0
fkp=IIF(nastf_11=0,kp,kpp)
ffkp=kp
fnrd=nrd
fdat=dati
fnzk=nzk
fwid_d=wid_d
fvo=vo
SET ORDER TO kp
IF ALIAS()='BK'
    SET EXACT OFF
    SEEK gfbs+ffkp+fnrd
    SET EXACT ON
ELSE
    SET EXACT OFF
    SEEK ffkp+fnrd
    SET EXACT ON
ENDIF
SCAN REST WHILE (ALIAS()='BK'.AND.nzk=gfbs.OR.ALIAS()='BKR').AND.nrd=fnrd.AND.kp=ffkp FOR !DELETE().AND.fdat=dati.AND.vo=fvo
    fsum=fsum+IIF(sm_val=0,sm,sm_val)
ENDSCAN
GO nz
IF fsum<=0
    DO Net_n WITH 12,'Hевеpна сумма по документу. Повтоpите...'
    RETURN
ENDIF
DO CASE
CASE wid_d=1.OR.wid_d=5
    n=54
CASE wid_d=2
    n=69
CASE wid_d=3
    n=42
CASE wid_d=4
    n=60
ENDCASE
IF INLIST(wid_d,2,3,4).OR.wid_d=5.AND.ff17=1
    sum_prop=Pr_prop(fsum,vid_val)+' '
    sum_1=''
    sum_2=''
    sum_3=''
    ntek=1
    jj=1
    FOR i=1 TO IIF(wid_d=3.OR.wid_d=5,3,2)
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
         DO Net_n WITH 12,'Пpевышена максимальная длина суммы пpописью. Печать пpекpащается.'
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
SET DEVICE TO PRINT
IF chg12=2
    IF INLIST(wid_d,1,2,5)
         @ PROW(),0 SAY &sgat2+&sgat3
    ELSE
         IF !EMPTY(sgat4)
              @ PROW(),0 SAY &sgat4
         ENDIF
         @ PROW(),0 SAY &sgat3
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
    fikl=sprrab.fio
    fikl1=SPACE(14)
    fikld=SPACE(30)
    fikldd=SPACE(45)
    funn=SPACE(11)
ENDIF
SELECT spr_bs
SET ORDER TO bs
SEEK fnzk
IF ffpr=0
    fnschn1=nschn1
    fnschn3=nschn3
    nn3=schn3
    nschs=schs
    nschl=schl
    nschk=schk
    nschg=schg
    nscho1=scho1
    nscho2=scho2
ELSE
    fnschn1=nschn1v
    fnschn3=nschn3v
    nn3=schn3v
    nschs=schsv
    nschl=schlv
    nschk=schkv
    nschg=schgv
    nscho1=scho1v
    nscho2=scho2v
ENDIF
SELECT &nam_file
DO CASE
CASE INLIST(wid_d,1,2,5)
    SELECT sprnaz
    SEEK fwid_d
    SELECT &nam_file
    FOR jjj=1 TO fkol
         IF nastf_n=0
              nstr=0
         ELSE
              nstr=PROW()+nastf_6
         ENDIF
         DO CASE
         CASE wid_d=1.AND.vo='0'
              @ nstr   ,0 SAY 'Поступ.в банк плат.| '+fftext+' |  0401001   |'
              @ nstr+ 1,0 SAY '--------------------'+SPACE(52)+'-------------|'
              @ nstr+ 2,0 SAY '                     '+sprnaz.nam+' N '+fnrd+'                         |'
              @ nstr+ 3,0 SAY '                             '+LEFT(DTOC(fdat),2)+' '+nammec+' 20'+RIGHT(DTOC(fdat),2)+' г.'
              @ nstr+ 4,0 SAY '                             ------------------              ДЕБЕТ        Сумма      |'
              @ nstr+ 5,0 SAY 'Плательщик '+fikl+fikl1+'------------------------------|'
              @ nstr+ 6,0 SAY 'Код '+SPACE(11)+fikld+'----------|    сч. N    |               |'
              @ nstr+ 7,0 SAY fikldd+'|   Код   |'+skl.sch+'|  '+STR(fsum,12)+' |'
              @ nstr+ 8,0 SAY 'Банк плат.'+skl.otd+'|'+skl.mfo+'|'+skl.korr+'|               |'
              @ nstr+ 9,0 SAY +skl.otdd+'------------------------|               |'
              @ nstr+10,0 SAY 'в г.'+skl.gorb+SPACE(39)+'КРЕДИТ     |               |'
              @ nstr+11,0 SAY 'Получатель '+fnschn1+'--------------|---------------|'
              @ nstr+12,0 SAY 'Код '+IIF(ffpr=1,nn3,SPACE(30))+SPACE(10)+' ----------|    сч.N     |               |'
              @ nstr+13,0 SAY 'Банк пол. '+nscho1+' |   Код   |'+nschl+'|               |'
              @ nstr+14,0 SAY nscho2+'|'+nschs+'|'+nschk+'|               |'
              @ nstr+15,0 SAY ' в г.'+nschg+SPACE(25)+'------------------------|               |'
              @ nstr+16,0 SAY REPLICATE('-',85)+'|'
              @ nstr+17,0 SAY SPACE(32)+'Грузоотправитель и ст.отпр.          |Пеня за    дней|'
              @ nstr+18,0 SAY 'Код '+fnschn1+SPACE(21)+'|из        % Р. |'
              @ nstr+19,0 SAY REPLICATE('-',85)+'|'
              @ nstr+20,0 SAY SPACE(32)+'Грузополучатель и ст.назнач.         |               |'
              @ nstr+21,0 SAY 'Код     '+fikl+fikl1+SPACE(17)+'|сумма с пеней  |'
              @ nstr+22,0 SAY REPLICATE('-',85)+'|'
              @ nstr+23,0 SAY 'Договор '+dog+' от '+DTOC(dats)+'|'+SPACE(12)+'Вид отгрузки'+SPACE(13)+' |Вид операции   |'
              @ nstr+24,0 SAY 'Заказ '+SPACE(22)+'  | '+dat_tov+SPACE(17)+'|Hазнач.платежа |'
              @ nstr+25,0 SAY REPLICATE('-',30)+'| Цена '+ffcen+'|               |'
              @ nstr+26,0 SAY 'Дата отгрузки '+DTOC(ffdot)+SPACE(8)+'| Доверенность '+ffdov+' | Срок платежа  |'
              @ nstr+27,0 SAY REPLICATE('-',69)+'|               |'
              @ nstr+28,0 SAY 'Hаименов.товара, выполненных работ, оказ. услуг ,NN и '+SPACE(15)+'|  Очер.платеж. |'
              @ nstr+29,0 SAY 'суммы товарных документов или спецификация товара     '+SPACE(15)+'|               |'
              @ nstr+30,0 SAY text_1+SPACE(19)+'|  N гр.банка   |'
              @ nstr+31,0 SAY text_2+SPACE(19)+'|               |'
              @ nstr+32,0 SAY text_3+SPACE(19)+'|               |'
              @ nstr+33,0 SAY text_4+SPACE(19)+'|               |'
              @ nstr+34,0 SAY REPLICATE('-',85)+'|'
              @ nstr+35,0 SAY 'Предусмотренные договором |'+SPACE(35)+'|   Проведено банком   |'
              @ nstr+36,0 SAY 'документы отосланы (вруче-|'+SPACE(35)+'|                      |'
              @ nstr+37,0 SAY 'ны) плательщику           |'+SPACE(35)+'|Дата                  |'
              @ nstr+38,0 SAY 'М.П.     '+DTOC(fdat)+'         |Подписи клиента     '+SPACE(15)+'|  Подписи банка       |'
              @ nstr+39,0 SAY '                          |'+SPACE(35)+'|                      |'
              @ nstr+40,0 SAY '                          |'+SPACE(35)+'|                      |'
              @ nstr+41,0 SAY '                          |'+SPACE(35)+'|                      |'
              @ nstr+42,0 SAY REPLICATE('-',86)
         CASE wid_d=2.AND.vo='1'
          DO CASE
          CASE ffl=0
            fftext=space(30)
          CASE ffl=1
            fftext='  В счет неотложных нужд      '
          CASE ffl=2
            fftext=' В счет прожиточного минимума '
          CASE ffl=3
            fftext=' Вне очереди                  '
          ENDCASE
              @ nstr   ,ftek_b_52 SAY 'Поступ.в банк плат.|'+SPACE(2)+fftext+IIF(fftar=0,SPACE(19),'Т Е Л Е Г Р А Ф О М')+SPACE(1)+'| 0401600002 |'
              @ nstr+ 1,ftek_b_52 SAY '--------------------'+SPACE(52)+'-------------|'
              @ nstr+ 2,ftek_b_52 SAY '                     '+sprnaz.nam+' N '+fnrd+'                         |'
              @ nstr+ 3,ftek_b_52 SAY '                             '+LEFT(DTOC(fdat),2)+' '+nammec+' 20'+RIGHT(DTOC(fdat),2)+' г.'+SPACE(38)+'|'
              @ nstr+ 4,ftek_b_52 SAY SPACE(29)+'------------------'+SPACE(38)+'|'
              @ nstr+ 5,ftek_b_52 SAY 'Плательщик '+fnschn1+nn3+'     |'
              @ nstr+ 6,ftek_b_52 SAY 'Страна регистрации РБ                                        ДЕБЕТ        Сумма      |'
              @ nstr+ 7,ftek_b_52 SAY 'Код '+fnschn3+SPACE(40)+ '------------------------------|'
              @ nstr+ 8,ftek_b_52 SAY SPACE(45)+'----------|    сч.N     |'+IIF(EMPTY(vid_val)=.t.,STR(fsum,12,0),STR(fsum,12,2))+'=  |'
              @ nstr+ 9,ftek_b_52 SAY 'Банк плат. '+nscho1+'|   Код   |'+nschl+'|               |'
              @ nstr+10,ftek_b_52 SAY nscho2+'|'+nschs+'|'+nschk+'|      '+IIF(EMPTY(vid_val)=.t.,'   ',ALLTRIM(vid_val))+'      |'
              @ nstr+11,ftek_b_52 SAY 'в г.'+nschg+SPACE(26)+'------------------------|               |'
              @ nstr+12,ftek_b_52 SAY SPACE(58)+'КРЕДИТ     |               |'
              @ nstr+13,ftek_b_52 SAY 'Получатель '+fikl+fikl1+'------------------------------|'
              @ nstr+14,ftek_b_52 SAY 'Страна регистрации РБ                        ----------|    сч. N    |               |'
              @ nstr+15,ftek_b_52 SAY 'Код '+funn+fikld+'|   Код   |'+skl.sch+'|'+IIF(EMPTY(ftek_b_29).OR.fftar=0,'               ',STR(fsum-ftek_b_29,15,2))+'|'
              @ nstr+16,ftek_b_52 SAY 'Банк пол. '+skl.otd+'|'+skl.mfo+'|'+skl.korr+'|'+IIF(EMPTY(ftek_b_29).OR.fftar=0,SPACE(15),STR(ftek_b_29,15,2))+'|'
              @ nstr+17,ftek_b_52 SAY skl.otdd+'------------------------|               |'
              @ nstr+18,ftek_b_52 SAY 'в г. '+skl.gorb+SPACE(49)+'|               |'
              @ nstr+19,ftek_b_52 SAY REPLICATE('-',29)+' Сумма пpописью ----------------------------------------|'
              @ nstr+20,ftek_b_52 SAY sum_1
              @ nstr+20,ftek_b_52+69 SAY '|Пеня за    дней|'
              @ nstr+21,ftek_b_52 SAY sum_2
              @ nstr+21,ftek_b_52+69 SAY '|из        % Р. |'
              @ nstr+22,ftek_b_52 SAY REPLICATE('-',69)+'|Сумма с пеней  |'
              @ nstr+23,ftek_b_52 SAY 'Дата пол. товаpа '+dat_tov+'|'+SPACE(30)+' |               |'
              @ nstr+24,ftek_b_52 SAY REPLICATE('-',69)+'|Вид операц. '+vid_op+' |'
              @ nstr+25,ftek_b_52 SAY 'Hазнач. платежа, наименов. товара, выполненных работ, '+SPACE(15)+'|Hазнач. платежа|'
              @ nstr+26,ftek_b_52 SAY 'оказанных услуг,NN и суммы товарных документов        '+SPACE(15)+'|    '+nazn_pl+'      |'
              @ nstr+27,ftek_b_52 SAY SPACE(69)+'|Срок плат.     |'
              IF EMPTY(AT('',text_1,1)).AND.EMPTY(AT('',text_2,1)).AND.EMPTY(AT('',text_3,1)).AND.EMPTY(AT('',text_4,1))
                   @ nstr+28,ftek_b_52 SAY text_1+SPACE(19)+'|  '+DTOC(ffdat)+'   |'
                   @ nstr+29,ftek_b_52 SAY text_2+SPACE(19)+'|Очер.плат.'+ffpl+'|'
                   @ nstr+30,ftek_b_52 SAY text_3+SPACE(19)+'|               |'
                   @ nstr+31,ftek_b_52 SAY text_4+SPACE(19)+'|N гр.банка     |'
              ELSE
                   st1=text_1
                   st2=text_2
                   st3=text_3
                   st4=text_4
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
                                *  st&ii=st&ii+LTRIM(STR(sm,15,2))
                                  st&ii=st&ii+RTRIM(name_mec(IIF(MONTH(dati)=1,12,(MONTH(dati)-1))))
                             ENDIF
                             ntek=AT('',st,i-1)+1
                        ENDDO
*
                   ENDFOR
                   @ nstr+28,ftek_b_52 SAY IIF(EMPTY(st1),text_1,st1)
                   @ nstr+28,ftek_b_52+69 SAY '|   '+DTOC(ffdat)+'    |'
                   @ nstr+29,ftek_b_52 SAY IIF(EMPTY(st2),text_2,st2)
                   @ nstr+29,ftek_b_52+69 SAY '|Очер.плат.     |'
                   @ nstr+30,ftek_b_52 SAY IIF(EMPTY(st3),text_3,st3)
                   @ nstr+30,ftek_b_52+69 SAY '|               |'
                   @ nstr+31,ftek_b_52 SAY IIF(EMPTY(st4),text_4,st4)
                   @ nstr+31,ftek_b_52+69 SAY '|N гр.банка     |'
              ENDIF
              @ nstr+32,ftek_b_52 SAY REPLICATE('-',85)+'|'
              @ nstr+33,ftek_b_52 SAY '                          |'+SPACE(35)+'|   Проведено банком   |'
              @ nstr+34,ftek_b_52 SAY '                          |'+SPACE(35)+'|  Дата                |'
              @ nstr+35,ftek_b_52 SAY '  М.П.                    |Подписи клиента     '+SPACE(15)+'|  Подписи банка       |'
              @ nstr+36,ftek_b_52 SAY '                          |'+SPACE(35)+'|                      |'
              @ nstr+37,ftek_b_52 SAY '                          |'+SPACE(35)+'|                      |'
              @ nstr+38,ftek_b_52 SAY '                          |'+SPACE(35)+'|                      |'
         CASE wid_d=5.AND.vo='0'
         CASE wid_d=5.AND.vo='0'
              @ nstr+ 0,2 SAY 'Поступ.в банк плат.|'+SPACE(51)+'|  0401040  |'
              @ nstr+ 0,2 SAY '____________________'+SPACE(51)+'____________|'
              @ nstr+ 1,0 SAY SPACE(14)+sprnaz.nam+' N '+fnrd+SPACE(32)+'|'
              @ nstr+ 2,0 SAY SPACE(29)+LEFT(DTOC(dati),2)+' '+nammec+' 20'+RIGHT(DTOC(dati),2)+' г.'
              @ nstr+ 2,0 SAY SPACE(29)+'__________________'
              @ nstr+ 3,0 SAY SPACE(60)+'ДЕБЕТ        Сумма       |'
              @ nstr+ 4,0 SAY 'ПЛАТЕЛЬЩИК '+fikl+fikl1+' -----------------------------|'
              @ nstr+ 5,0 SAY 'Код '+funn+fikld+'----------|    сч. N    |               |'
              @ nstr+ 6,0 SAY fikldd+'|         |             |               |'
              @ nstr+ 7,0 SAY 'Банк плат.'+skl.otd+'|   Код   |'+skl.sch+'|'+STR(fsum,15)+'|'
              @ nstr+ 8,0 SAY skl.otdd+'|'+skl.mfo+'|'+skl.korr+'|               |'
              @ nstr+ 9,0 SAY SPACE(12)+'в г.'+skl.gorb+SPACE(14)+'|         |             |               |'
              @ nstr+ 9,0 SAY '_____________________________________________________________________________________'
              @ nstr+10,0 SAY 'ПОЛУЧАТЕЛЬ '+fnschn1+'    КРЕДИТ    |               |'
              @ nstr+11,0 SAY 'Код '+IIF(ffpr=1,nn3,SPACE(30))+SPACE(21)+'--------------|---------------|'
              @ nstr+12,0 SAY 'Банк пол. '+nscho1+'  ---------|    сч.N     |               |'
              @ nstr+13,0 SAY nscho2+'|   Код   |'+nschl+'|               |'
              @ nstr+14,0 SAY SPACE(12)+'в г.'+nschg+SPACE(14)+'|'+nschs+'|'+nschk+'|               |'
              @ nstr+14,0 SAY '_____________________________________________________________________________________'
              @ nstr+15,0 SAY '               почтой - телегpафом (нужное подчеpкнуть)              |               |'
              @ nstr+16,0 SAY ' Грузополучатель       ОH ЖЕ'+SPACE(41)+'|               |'
              @ nstr+17,0 SAY 'Код '+SPACE(65)+'|               |'
              @ nstr+17,0 SAY '______________________________________________________________________               '
              @ nstr+18,0 SAY 'Договор '+SPACE(19)+'| Способ отпpавления'+SPACE(22)+'|               |'
              @ nstr+19,0 SAY 'от '+SPACE(24)+'|'+SPACE(41)+'|               |'
              @ nstr+19,0 SAY '______________________________________________________________________               '
              @ nstr+20,0 SAY 'Дата отгрузки '+DTOC(fdat)+'     |Дов-ть '+SPACE(34)+'|               |'
              @ nstr+20,0 SAY '______________________________________________________________________               '
              @ nstr+21,0 SAY 'Hаименов.товара,выполненных работ,оказ.услуг,NN и                    |               |'
              @ nstr+22,0 SAY 'суммы товарных документов или спецификация товара                    |               |'
              @ nstr+22,0 SAY '______________________________________________________________________               '
              @ nstr+23,0 SAY text_1+SPACE(19)+'|               |'
              @ nstr+24,0 SAY text_2+SPACE(19)+'|               |'
              @ nstr+25,0 SAY text_3+SPACE(19)+'|               |'
              @ nstr+26,0 SAY text_4+SPACE(19)+'|               |'
              @ nstr+26,0 SAY '______________________________________________________________________               '
              nstr=nstr+27
              @ nstr+ 0,0 SAY '     М.П.            Подписи получателя                              |               |'
              @ nstr+ 1,0 SAY '                                                            ДЕБЕТ    | Сумма к оплате|'
              @ nstr+ 1,0 SAY '_____________________________________________________________________________________'
              @ nstr+ 2,0 SAY IIF(ff17=1,sum_1,'')
              @ nstr+ 2,56 SAY '|            |               |'
              @ nstr+ 3,0 SAY IIF(ff17=1,sum_2,'')
              @ nstr+ 3,56 SAY '|            |               |'
              @ nstr+ 4,0 SAY IIF(ff17=1,sum_3,'')
              @ nstr+ 4,56 SAY '|            |               |'
              @ nstr+ 4,0 SAY '______________________________________________________________________'
              @ nstr+ 5,0 SAY '                                                             КРЕДИТ  |               |'
              @ nstr+ 5,0 SAY '                                                           __________________________'
              @ nstr+ 6,0 SAY '                                                     сч. N |         |               |'
              @ nstr+ 6,0 SAY '                                                           __________________________'
              @ nstr+ 7,0 SAY '                                                     сч. N |         |               |'
              @ nstr+ 7,0 SAY '                                                           __________________________'
              @ nstr+ 8,0 SAY '                                                                     |Пеня за   дней |'
              @ nstr+ 9,0 SAY '                                                                     |  из   : % P   |'
              @ nstr+ 9,0 SAY '                                                                     ________________'
              @ nstr+10,0 SAY '                                                                     | сумма с пеней |'
              @ nstr+10,0 SAY '                                                                     ________________'
              @ nstr+11,0 SAY '                                                                     |Вид опеp.|     |'
              @ nstr+11,0 SAY '                                                                     ________________'
              @ nstr+12,0 SAY '                                      Пpоведено банком               |Hазн.плат|     |'
              @ nstr+12,0 SAY '                                                                     ________________'
              @ nstr+13,0 SAY '                                                          19___г.    |Сpок плат|     |'
              @ nstr+13,0 SAY '                                                                     ________________'
              @ nstr+14,0 SAY '                                      Подписи банка                  |Очеp.плат|     |'
              @ nstr+14,0 SAY '                                                                     ________________'
              @ nstr+15,0 SAY '   М.П.   Подписи плательщика                                        |N гp.банк|     |'
              @ nstr+15,0 SAY '                                                                     ________________'
         OTHERWISE
              SET DEVICE TO SCREEN
              SET PRINTER TO
              DO Net_n WITH 10,'Отсутсвует такой вид документа при такой операции...'
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
@ nstr+ 0, 5 SAY LEFT(fnschn1,42)+'| '+LEFT(fnschn1,28)
@ nstr+ 1,47 SAY '|'
@ nstr+ 2,47 SAY '|'
@ nstr+ 3, 5 SAY '       ПРИХОДHЫЙ КАССОВЫЙ ОРДЕР           |       КВИТАЦИЯ'
@ nstr+ 4, 5 SAY '                                          | к пpиходному кассовому'
@ nstr+ 5, 5 SAY '  Hомеp       Дата       Коpp.     Сумма  |    оpдеpу  N '+fnrd
@ nstr+ 6, 5 SAY 'документа  составления   счет             |Пpинято от '+fkp
@ nstr+ 7, 5 SAY '                            --------------|'+fikl
@ nstr+ 8, 8 SAY fnrd+'   '+DTOC(fdat)+'    '+kor+'|'+STR(fsum,12,2)+' |'
@ nstr+ 9, 5 SAY '                            --------------|'
@ nstr+10, 5 SAY 'Основание                                 |Основание '
@ nstr+11, 5 SAY ft_1
@ nstr+11,47 SAY '|'+fc_1
@ nstr+12, 5 SAY ft_2
@ nstr+12,47 SAY '|'+fc_2
@ nstr+13, 5 SAY ft_3
@ nstr+13,47 SAY '|'+fc_3
@ nstr+14, 5 SAY 'Пpинято от '+LEFT(fkp,6)+' '+LEFT(fikl,24)+'|'+fsum_1
@ nstr+15,23 SAY SUBSTR(fikl,25,6)
@ nstr+15,47 SAY '|'+fsum_2
@ nstr+16, 5 SAY sum_1
@ nstr+16,47 SAY '|'+fsum_3
@ nstr+17, 5 SAY sum_2
@ nstr+17,47 SAY '|'+fsum_4
@ nstr+18, 5 SAY sum_3
@ nstr+18,47 SAY '|'
@ nstr+19,47 SAY '|'+DTOC(dat)
@ nstr+20, 5 SAY 'Главный бухгалтеp                         |  М.П.'
@ nstr+21, 5 SAY '                                          |Главный бухгалтеp'
@ nstr+22,47 SAY '|'
@ nstr+23, 5 SAY 'Получил кассиp                            |Кассиp'
    CASE wid_d=4.AND.vo='1'
         RESTORE FROM tek_b ADDITIVE
@ nstr+ 0,5 SAY fnschn1+'         Фоpма КО-02'
@ nstr+ 2, 5 SAY '       РАСХОДHЫЙ КАССОВЫЙ ОРДЕР  N '+fnrd
@ nstr+ 4,30 SAY '   Дата       Коpp.            Сумма  '
@ nstr+ 5,30 SAY 'составления   счет         ---------------------'
@ nstr+ 6,30 SAY DTOC(fdat)+'      '+kor+'         |     '+STR(fsum,12,2)+'  |'
@ nstr+ 7,30 SAY SPACE(27)+'---------------------'
@ nstr+ 9, 5 SAY 'Выдать '+fkp+fikl
@ nstr+11, 5 SAY 'Основание '+text_1
@ nstr+12, 5 SAY SPACE(10)+text_2
@ nstr+14, 5 SAY sum_1
@ nstr+15, 5 SAY sum_2
@ nstr+17, 5 SAY 'Руководитель                     Главный бухгалтеp'
@ nstr+19, 5 SAY 'Получил '+IIF(tek_b_18=0,REPLICATE('_',60),sum_1)
@ nstr+21, 5 SAY DTOC(dat)+'       Подпись'
@ nstr+23, 5 SAY 'По__________________________________________________________________'
@ nstr+24, 5 SAY '       наименование, номеp, дата и место выдачи документа'
@ nstr+27, 5 SAY 'Выдал кассиp'
@ nstr+35, 5 SAY ' '
         RELEASE ALL LIKE tek_b_??
    OTHERWISE
         SET DEVICE TO SCREEN
         SET PRINTER TO
         DO Net_n WITH 10,'Отсутсвует такой вид документа при такой операции...'
         RETURN
    ENDCASE
CASE wid_d>5
    ffnf=STR(wid_d,3)
    SELECT 0
    USE form_ot
    SET ORDER TO nf_npp
    SELECT 0
    USE razm_ot
    SET ORDER TO nf_npp
    DO Pr_form
    SELECT razm_ot
    USE
    SELECT form_ot
    USE
    SELECT &nam_file
ENDCASE
IF wid_d<6
    IF nastf_n=0
         EJECT
    ELSE
         @ PROW()+1,0 SAY ' '
    ENDIF
ENDIF
SET DEVICE TO SCREEN
SET PRINTER TO
IF chg12=1
    MODIFY COMMAND &fname WINDOW Out NOEDIT
ENDIF
RETURN