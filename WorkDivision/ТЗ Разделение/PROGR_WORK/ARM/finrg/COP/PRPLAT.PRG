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
    @ 15,40,17,68 BOX '…Õª∫ºÕ»∫ '
    SET COLOR TO &color14
    SET ORDER TO nrd
    @ 16,41 SAY ' äÆ´®Á•·‚¢Æ Ì™ß•¨Ø´ÔpÆ¢' GET fkol PICTURE '9'
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
         @ 15,40,17,68 BOX '…Õª∫ºÕ»∫ '
         SET COLOR TO &color14
         @ 16,41 SAY ' ép£†≠®ß†Ê®Ô ·‚ÆpÆ≠≠ÔÔ?' GET ffpr PICTURE '9' VALID ffpr=0.OR.ffpr=1 ERROR "á≠†Á•≠®• ≠•¢•p≠Æ..."
         READ
         IF LASTKEY()=27
              RETURN
         ENDIF
         IF ffpr=1.AND.ftek_b_29#0
              @ 19,45 FILL TO 21,63 COLOR &color20
              SET COLOR TO &color13
              @ 18,44,20,62 BOX '…Õª∫ºÕ»∫ '
              SET COLOR TO &color14
              @ 19,45 SAY ' í•´•£‡†‰Æ¨ ?' GET fftar PICTURE '9' VALID fftar=0.OR.fftar=1 ERROR "0 - ≠•‚, 1 - ‚•´•£‡†‰Æ¨..."
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
         @ 14,18,21,76 BOX '…Õª∫ºÕ»∫ '
         SET COLOR TO &color14
         fftext=SPACE(50)
         ffcen=SPACE(32)
         ffdot=DATE()
         ffdov=SPACE(23)
         @ 15,19 SAY ' í•™·‚' GET fftext
         @ 16,19 SAY ' Ç®§ Æ‚£‡„ß™® ' GET dat_tov
         @ 17,19 SAY ' Ñ†‚† §Æ£Æ¢Æ‡†' GET dats
         @ 18,19 SAY ' Ñ†‚† Æ‚£‡„ß™®' GET ffdot
         @ 19,19 SAY ' ÑÆ¢•‡•≠≠Æ·‚Ï ' GET ffdov
         @ 20,19 SAY ' ñ•≠†         ' GET ffcen
         READ
         IF LASTKEY()=27
              RETURN
         ENDIF
    CASE wid_d=2.AND.vo='1'
         RESTORE SCREEN FROM scr
         @ 17,31 FILL TO 19,57 COLOR &color20
         SET COLOR TO &color13
         @ 16,30,18,56 BOX '…Õª∫ºÕ»∫ '
         SET COLOR TO &color14
         fftext=SPACE(30)
         ffpl=SPACE(5)
              * @ 17,31 SAY ' è‡®ß≠†™ ‚•™·‚†' GET ffl PICTURE '9' VALID ffl=0.OR.ffl=1.OR.ffl=2.OR.ffl=3 ERROR "á≠†Á•≠®• ≠•¢•p≠Æ..."
              * @ 18,31 SAY ' éÁ•‡.Ø´†‚•¶†' GET ffpl
         @ 17,31 SAY ' ë‡ÆÁ≠Î©/≠•·‡ÆÁ (1/0) ' GET ffl PICTURE '9' VALID ffl=0.OR.ffl=1     &&.OR.ffl=2.OR.ffl=3 ERROR "á≠†Á•≠®• ≠•¢•p≠Æ..."
              *@ 18,31 SAY ' éÁ•‡•§.Ø´†‚•¶†' GET ffpl
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
    DO Net_n WITH 12,'H•¢•p≠† §†‚† §Æ™„¨•≠‚†. èÆ¢‚Æp®‚•...'
    RETURN
ENDIF
nammec=RTRIM(name_mec(MONTH(dati)))
IF MONTH(dati)=3.OR.MONTH(dati)=8
    nammec=nammec+'†'
ELSE
    nammec=LEFT(nammec,LEN(nammec)-1)+'Ô'
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
    DO Net_n WITH 12,'H•¢•p≠† ·„¨¨† ØÆ §Æ™„¨•≠‚„. èÆ¢‚Æp®‚•...'
    RETURN
ENDIF
DO CASE
CASE wid_d=1.OR.wid_d=5
    n=54
CASE wid_d=2
    *n=69
    n=55
CASE wid_d=3
    n=42
CASE wid_d=4
    n=60
ENDCASE
IF INLIST(wid_d,2,3,4).OR.wid_d=5.AND.ff17=1
    sum_prop=Pr_prop(fsum,vid_val)
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
         DO Net_n WITH 12,'èp•¢ÎË•≠† ¨†™·®¨†´Ï≠†Ô §´®≠† ·„¨¨Î ØpÆØ®·ÏÓ. è•Á†‚Ï Øp•™p†È†•‚·Ô.'
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
              @ nstr   ,0 SAY 'èÆ·‚„Ø.¢ °†≠™ Ø´†‚.| '+fftext+' |  0401001   |'
              @ nstr+ 1,0 SAY '--------------------'+SPACE(52)+'-------------|'
              @ nstr+ 2,0 SAY '                     '+sprnaz.nam+' N '+fnrd+'                         |'
              @ nstr+ 3,0 SAY '                             '+LEFT(DTOC(fdat),2)+' '+nammec+' 20'+RIGHT(DTOC(fdat),2)+' £.'
              @ nstr+ 4,0 SAY '                             ------------------              ÑÖÅÖí        ë„¨¨†      |'
              @ nstr+ 5,0 SAY 'è´†‚•´ÏÈ®™ '+fikl+fikl1+'------------------------------|'
              @ nstr+ 6,0 SAY 'äÆ§ '+SPACE(11)+fikld+'----------|    ·Á. N    |               |'
              @ nstr+ 7,0 SAY fikldd+'|   äÆ§   |'+skl.sch+'|  '+STR(fsum,12)+' |'
              @ nstr+ 8,0 SAY 'Å†≠™ Ø´†‚.'+skl.otd+'|'+skl.mfo+'|'+skl.korr+'|               |'
              @ nstr+ 9,0 SAY +skl.otdd+'------------------------|               |'
              @ nstr+10,0 SAY '¢ £.'+skl.gorb+SPACE(39)+'äêÖÑàí     |               |'
              @ nstr+11,0 SAY 'èÆ´„Á†‚•´Ï '+fnschn1+'--------------|---------------|'
              @ nstr+12,0 SAY 'äÆ§ '+IIF(ffpr=1,nn3,SPACE(30))+SPACE(10)+' ----------|    ·Á.N     |               |'
              @ nstr+13,0 SAY 'Å†≠™ ØÆ´. '+nscho1+' |   äÆ§   |'+nschl+'|               |'
              @ nstr+14,0 SAY nscho2+'|'+nschs+'|'+nschk+'|               |'
              @ nstr+15,0 SAY ' ¢ £.'+nschg+SPACE(25)+'------------------------|               |'
              @ nstr+16,0 SAY REPLICATE('-',85)+'|'
              @ nstr+17,0 SAY SPACE(32)+'É‡„ßÆÆ‚Ø‡†¢®‚•´Ï ® ·‚.Æ‚Ø‡.          |è•≠Ô ß†    §≠•©|'
              @ nstr+18,0 SAY 'äÆ§ '+fnschn1+SPACE(21)+'|®ß        % ê. |'
              @ nstr+19,0 SAY REPLICATE('-',85)+'|'
              @ nstr+20,0 SAY SPACE(32)+'É‡„ßÆØÆ´„Á†‚•´Ï ® ·‚.≠†ß≠†Á.         |               |'
              @ nstr+21,0 SAY 'äÆ§     '+fikl+fikl1+SPACE(17)+'|·„¨¨† · Ø•≠•©  |'
              @ nstr+22,0 SAY REPLICATE('-',85)+'|'
              @ nstr+23,0 SAY 'ÑÆ£Æ¢Æ‡ '+dog+' Æ‚ '+DTOC(dats)+'|'+SPACE(12)+'Ç®§ Æ‚£‡„ß™®'+SPACE(13)+' |Ç®§ ÆØ•‡†Ê®®   |'
              @ nstr+24,0 SAY 'á†™†ß '+SPACE(22)+'  | '+dat_tov+SPACE(17)+'|H†ß≠†Á.Ø´†‚•¶† |'
              @ nstr+25,0 SAY REPLICATE('-',30)+'| ñ•≠† '+ffcen+'|               |'
              @ nstr+26,0 SAY 'Ñ†‚† Æ‚£‡„ß™® '+DTOC(ffdot)+SPACE(8)+'| ÑÆ¢•‡•≠≠Æ·‚Ï '+ffdov+' | ë‡Æ™ Ø´†‚•¶†  |'
              @ nstr+27,0 SAY REPLICATE('-',69)+'|               |'
              @ nstr+28,0 SAY 'H†®¨•≠Æ¢.‚Æ¢†‡†, ¢ÎØÆ´≠•≠≠ÎÂ ‡†°Æ‚, Æ™†ß. „·´„£ ,NN ® '+SPACE(15)+'|  éÁ•‡.Ø´†‚•¶. |'
              @ nstr+29,0 SAY '·„¨¨Î ‚Æ¢†‡≠ÎÂ §Æ™„¨•≠‚Æ¢ ®´® ·Ø•Ê®‰®™†Ê®Ô ‚Æ¢†‡†     '+SPACE(15)+'|               |'
              @ nstr+30,0 SAY text_1+SPACE(19)+'|  N £‡.°†≠™†   |'
              @ nstr+31,0 SAY text_2+SPACE(19)+'|               |'
              @ nstr+32,0 SAY text_3+SPACE(19)+'|               |'
              @ nstr+33,0 SAY text_4+SPACE(19)+'|               |'
              @ nstr+34,0 SAY REPLICATE('-',85)+'|'
              @ nstr+35,0 SAY 'è‡•§„·¨Æ‚‡•≠≠Î• §Æ£Æ¢Æ‡Æ¨ |'+SPACE(35)+'|   è‡Æ¢•§•≠Æ °†≠™Æ¨   |'
              @ nstr+36,0 SAY '§Æ™„¨•≠‚Î Æ‚Æ·´†≠Î (¢‡„Á•-|'+SPACE(35)+'|                      |'
              @ nstr+37,0 SAY '≠Î) Ø´†‚•´ÏÈ®™„           |'+SPACE(35)+'|Ñ†‚†                  |'
              @ nstr+38,0 SAY 'å.è.     '+DTOC(fdat)+'         |èÆ§Ø®·® ™´®•≠‚†     '+SPACE(15)+'|  èÆ§Ø®·® °†≠™†       |'
              @ nstr+39,0 SAY '                          |'+SPACE(35)+'|                      |'
              @ nstr+40,0 SAY '                          |'+SPACE(35)+'|                      |'
              @ nstr+41,0 SAY '                          |'+SPACE(35)+'|                      |'
              @ nstr+42,0 SAY REPLICATE('-',86)
         CASE wid_d=2.AND.vo='1'
              * DO CASE
              * CASE ffl=0
              *   fftext=space(30)
              * CASE ffl=1
              *   fftext='  Ç ·Á•‚ ≠•Æ‚´Æ¶≠ÎÂ ≠„¶§      '
              * CASE ffl=2
              *   fftext=' Ç ·Á•‚ °Ó§¶•‚† Ø‡Æ¶®‚ÆÁ≠Æ£Æ ¨®≠®¨„¨† '
              * CASE ffl=3
              *   fftext=' Ç≠• ÆÁ•‡•§®                  '
              * ENDCASE
                  *@ nstr   ,ftek_b_52 SAY '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒ¬ƒƒƒƒƒƒƒƒƒ¬ƒ¬ƒƒƒƒƒƒƒƒƒƒø'
                  *@ nstr+ 1,ftek_b_52 SAY '≥è´†‚•¶≠Æ•                          ≥Ñ†‚†          ≥ë‡ÆÁ≠Î©≥ ≥ç•·‡ÆÁ≠Î©≥ï≥0401600036≥'
                  *@ nstr+ 2,ftek_b_52 SAY '≥ØÆ‡„Á•≠®• N '+fnrd+'                 ≥'+ LEFT(DTOC(fdat),2)+'.'+substr(DTOC(fdat),4,2)+'.20'+RIGHT(DTOC(fdat),2)+'£.  ≥       ≥ ≥         ≥ ≥          ≥'
              @ nstr+1 ,ftek_b_52 SAY '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒ¬ƒƒƒƒƒƒƒƒƒ¬ƒ¬ƒƒƒƒƒƒƒƒƒƒø'
              @ nstr+ 2,ftek_b_52 SAY '≥èãÄíÖÜçéÖ èéêìóÖçàÖ N '+fnrd+'    ≥Ñ†‚† '+ LEFT(DTOC(fdat),2)+'.'+substr(DTOC(fdat),4,2)+'.20'+RIGHT(DTOC(fdat),2)        && +'£.≥ë‡ÆÁ≠Î©≥ ≥ç•·‡ÆÁ≠Î©≥ï≥0401600036≥'
              @ nstr+ 2,PCOL() SAY '£.≥ë‡ÆÁ≠Î©≥'+IIF(ffl=1,'ï',' ')+'≥ç•·‡ÆÁ≠Î©≥'+IIF(ffl=0,'ï',' ')+'≥0401600036≥'
              @ nstr+ 3,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒ¡ƒƒƒƒƒƒƒƒƒƒ¥'
                    *a1=substr(sum_1,2,len(sum_1)-1)
              a1=sum_1
              a11=len(a1)
              @ nstr+ 4,ftek_b_52 SAY '≥ë„¨¨† ® ¢†´Ó‚†:   '+a1+SPACE(65-a11)+'≥'
              a1=sum_2
              a11=len(a1)
              @ nstr+ 5,ftek_b_52 SAY '≥                  '+a1+SPACE(65-a11)+'≥'
              a1=ALLTRIM(STR(fsum,12,0))
              a11=len(a1)
              @ nstr+ 6,ftek_b_52 SAY '≥                                   ⁄ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
              @ nstr+ 7,ftek_b_52 SAY '≥                                   ≥äÆ§   ≥  974  ≥ë„¨¨†   ≥   '+a1+'='+SPACE(19-a11)+'≥'
              @ nstr+ 8,ftek_b_52 SAY '≥                                   ≥¢†´Ó‚Î≥       ≥Ê®‰‡†¨® ≥                       ≥'
              @ nstr+ 9,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
              a1=ALLTRIM(fnschn1)+' '+ALLTRIM(nn3)
              a11=len(a1)
              @ nstr+10,ftek_b_52 SAY '≥è´†‚•´ÏÈ®™:       '+a1+SPACE(65-a11)+'≥'
              @ nstr+11,ftek_b_52 SAY '≥                                                  ⁄ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
              @ nstr+12,ftek_b_52 SAY '≥                                                  ≥ëÁ•‚ N   ≥'+nschl+SPACE(9)+'≥'
              @ nstr+13,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
              a1=ALLTRIM(nscho1)+' '+ALLTRIM(nscho2)
              a11=len(a1)
              @ nstr+14,ftek_b_52 SAY '≥Å†≠™-Æ‚Ø‡†¢®‚•´Ï: '+a1+SPACE(65-a11)+'≥'
              @ nstr+15,ftek_b_52 SAY '≥                                                  ⁄ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¥'
              @ nstr+16,ftek_b_52 SAY '≥                                                  ≥äÆ§ °†≠™†≥'+nschs+'      ≥      ≥'
              @ nstr+17,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¥'
              if !EMPTY(skl.otdd)
                a1=ALLTRIM(skl.otd)+SUBSTR(ALLTRIM(skl.otdd),1,30)
              else
                a1=ALLTRIM(skl.otd)+' É. '+ALLTRIM(skl.gorb)
              endif
              a11=len(a1)
              @ nstr+18,ftek_b_52 SAY '≥Å†≠™-ØÆ´„Á†‚•´Ï : '+a1+SPACE(65-a11)+'≥'
              if !EMPTY(skl.otdd)
                if SUBSTR(ALLTRIM(skl.otdd),31,15)#'  '
                 a1=SUBSTR(ALLTRIM(skl.otdd),31,15)+' É. ' +ALLTRIM(skl.gorb)
                else
                 a1=' É. ' +ALLTRIM(skl.gorb)
                endif
                a11=len(a1)
                @ nstr+19,ftek_b_52 SAY '≥                  '+a1+SPACE(65-a11)+'≥'
              else
                 @ nstr+19,ftek_b_52 SAY '≥                                                                                   ≥'
              endif
              @ nstr+20,ftek_b_52 SAY '≥                                                  ⁄ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¥'
              @ nstr+21,ftek_b_52 SAY '≥                                                  ≥äÆ§ °†≠™†≥'+skl.mfo+'      ≥      ≥'
              @ nstr+22,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¥'
              if !EMPTY(fikl)
                a1=ALLTRIM(fikl)+' '+ALLTRIM(fikl1)
                a11=len(a1)
                @ nstr+23,ftek_b_52 SAY '≥Å•≠•‰®Ê®†‡:       ' +a1+SPACE(65-a11)+'≥'
                @ nstr+24,ftek_b_52 SAY '≥êÅ                                                ⁄ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
              else
                a1=ALLTRIM(fikl)+' êÅ'
                a11=len(a1)
                @ nstr+23,ftek_b_52 SAY '≥Å•≠•‰®Ê®†‡:       ' +a1+' êÅ'+SPACE(65-a11-3)+'≥'
                @ nstr+24,ftek_b_52 SAY '≥                                                  ⁄ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
              endif
              @ nstr+25,ftek_b_52 SAY '≥                                                  ≥ëÁ•‚ N   ≥'+skl.sch+SPACE(9)+'≥'
              @ nstr+26,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
              @ nstr+27,ftek_b_52 SAY '≥ç†ß≠†Á•≠®• Ø´†‚•¶†: '+ text_1+SPACE(13)+'≥'
              @ nstr+28,ftek_b_52 SAY '≥                    '+ text_2+SPACE(13)+'≥'
              @ nstr+29,ftek_b_52 SAY '≥                    '+ text_3+SPACE(13)+'≥'
              @ nstr+30,ftek_b_52 SAY '≥                    '+ text_4+SPACE(13)+'≥'
              @ nstr+31,ftek_b_52 SAY '≥                                                                                   ≥'
              @ nstr+32,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¥'
              @ nstr+33,ftek_b_52 SAY '≥ìçè Ø´†‚•´ÏÈ®™†   ≥ìçè °•≠•‰®Ê®†‡†   ≥ìçè ‚‡•‚Ï•£Æ ´®Ê† ≥äÆ§  Ø´†‚•¶†      ≥éÁ•‡•§Ï≥'
              @ nstr+34,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒ¥'
              a1=alltrim(funn)+alltrim(fikld)
              a11=len(a1)
              @ nstr+35,ftek_b_52 SAY '≥'+fnschn3+'       ≥'+a1+SPACE(13-a11)+'     ≥                  ≥ '+nazn_pl+'            ≥  ' +vid_op+'   ≥'
              @ nstr+36,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¥'
              @ nstr+37,ftek_b_52 SAY '≥á†ØÆ´≠Ô•‚·Ô °†≠™Æ¨                                                                 ≥'
              @ nstr+38,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
              @ nstr+39,ftek_b_52 SAY '≥Ñ•°•‚          ≥ ä‡•§®‚       ≥ äÆ§  ≥                                             ≥'
              @ nstr+40,ftek_b_52 SAY '≥·Á•‚†          ≥ ·Á•‚†        ≥¢†´Ó‚Î≥               ë„¨¨† Ø•‡•¢Æ§†                ≥'
              @ nstr+41,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
              @ nstr+42,ftek_b_52 SAY '≥               ≥              ≥      ≥                                             ≥'
              @ nstr+43,ftek_b_52 SAY '¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ'
              @ nstr+44,ftek_b_52 SAY ' '
              @ nstr+45,ftek_b_52 SAY '  èÆ§Ø®·® Ø´†‚•´ÏÈ®™†  _______________      èÆ§Ø®·Ï ®·ØÆ´≠®‚•´Ô    ___________       '
              @ nstr+46,ftek_b_52 SAY ' '
              @ nstr+47,ftek_b_52 SAY '                                            Ñ†‚† ®·ØÆ´≠•≠®Ô °†≠™Æ¨ ___________       '
              @ nstr+48,ftek_b_52 SAY ' '
              @ nstr+49,ftek_b_52 SAY '  å.è.                                      ò‚†¨Ø °†≠™†                              '
              @ nstr+64,ftek_b_52 SAY ' '
                 *@ nstr+86,ftek_b_52 SAY ' ------------------------------------------------------------------------------------'
                 *@ nstr+90,ftek_b_52 SAY ' '
                    *@ nstr   ,ftek_b_52 SA0 I0F(fftar=0,SPACE(19),'í Ö ã Ö É ê Ä î é å')+SPACE(55)+'0401600031'  0
                    *@ nstr+ 1,ftek_b_52 SAY SPACE(32)+fftext
                    *@ nstr+ 2,ftek_b_52 SAY '                     '+sprnaz.nam+' N '+fnrd
                    *@ nstr+ 3,ftek_b_52 SAY '  '+LEFT(DTOC(fdat),2)+' '+nammec+' 20'+RIGHT(DTOC(fdat),2)+' £.'
                    *@ nstr+ 4,ftek_b_52 SAY ' Å†≠™ Æ‚Ø‡†¢®‚•´Ï '+nscho1+' '+alltrim(nscho2)+'      äÆ§   '+nschs
                    *@ nstr+ 5,ftek_b_52 SAY SPACE(60)+'⁄ƒƒƒƒƒƒƒ¬ƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒø'
                    *@ nstr+ 6,ftek_b_52 SAY SPACE(60)+'≥é°ÎÁ≠Î©≥ ï ≥ë‡ÆÁ≠Î©≥   ≥'
                    *@ nstr+ 7, ftek_b_52 SAY '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒ¥'
                    *a1=IIF(EMPTY(vid_val)=.t.,ALLTRIM(STR(fsum,12,0)),ALLTRIM(STR(fsum,12,2)))+'= '+sum_1
                    *a11=len(a1)
                    *@ nstr+ 8, ftek_b_52 SAY '≥ë„¨¨† ®         ≥'+a1+SPACE(66-a11)+'≥'
                    *a1=sum_2
                    *a11=len(a1)
                    *@ nstr+ 9, ftek_b_52 SAY '≥¢†´Ó‚†          ≥'+a1+SPACE(66-a11)+'≥'
                    *@ nstr+ 10,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *a1=ALLTRIM(fnschn1)
                    *a11=len(a1)
                    *@ nstr+ 11,ftek_b_52 SAY '≥                ≥'+a1+SPACE(50-a11)+'≥      ìçç      ≥'
                    *a1=ALLTRIM(nn3)
                    *a11=len(a1)
                    *@ nstr+ 12,ftek_b_52 SAY '≥è´†‚•´ÏÈ®™      ≥'+a1+SPACE(50-a11)+'≥  '+fnschn3+'  ≥'
                    *@ nstr+ 13,ftek_b_52 SAY '≥                ≥ë‚‡†≠† ‡•£®·‚‡†Ê®® êÅ                             √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *@ nstr+ 14,ftek_b_52 SAY '≥                ≥'+SPACE(50)+'≥ ëÁ•‚ N        ≥'
                    *@ nstr+ 15,ftek_b_52 SAY '≥                ≥'+SPACE(50)+'≥ '+nschl+' ≥'
                    *@ nstr+ 16,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *@ nstr+ 17,ftek_b_52 SAY '≥äÆ‡‡•·ØÆ≠§•≠‚   ≥                                                                  ≥'
                    *@ nstr+ 18,ftek_b_52 SAY '≥°†≠™†-ØÆ´„Á†‚•´Ô≥                                                                  ≥'
                    *@ nstr+ 19,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *a1=ALLTRIM(skl.otd)+' '+ALLTRIM(skl.gorb)+' äÆ§ '+ALLTRIM(skl.mfo)
                    *a11=len(a1)
                    *@ nstr+ 20,ftek_b_52 SAY '≥                ≥'+a1+SPACE(66-a11)+'≥'
                    *@ nstr+ 21,ftek_b_52 SAY '≥Å†≠™-ØÆ´„Á†‚•´Ï ≥                                                                  ≥'
                    *@ nstr+ 22,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *a1=ALLTRIM(fikl)+ALLTRIM(fikl1)
                    *a11=len(a1)
                    *@ nstr+ 23,ftek_b_52 SAY '≥                ≥'+a1+SPACE(50-a11)+'≥      ìçç      ≥'
                    *a1=alltrim(funn)+alltrim(fikld)
                    *a11=len(a1)
                    *@ nstr+ 24,ftek_b_52 SAY '≥                ≥ë‚‡†≠† ‡•£®·‚‡†Ê®® êÅ                             ≥  '+a1+SPACE(13-a11)+'≥'
                    *@ nstr+ 25,ftek_b_52 SAY '≥Å•≠•‰®Ê®†‡      ≥'+SPACE(50)+'√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *@ nstr+ 26,ftek_b_52 SAY '≥                ≥                                                  ≥ ëÁ•‚ N        ≥'
                    *@ nstr+ 27,ftek_b_52 SAY '≥                ≥'+SPACE(50)+'≥ '+skl.sch+' ≥'
                    *@ nstr+ 28,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *@ nstr+ 29,ftek_b_52 SAY '≥                ≥'+text_1+'≥éÁ•‡•§≠Æ·‚Ï    ≥'
                    *@ nstr+ 30,ftek_b_52 SAY '≥ç†ß≠†Á•≠®•      ≥'+text_2+'≥Ø´†‚•¶† '+ffpl+'  ≥'
                    *@ nstr+ 31,ftek_b_52 SAY '≥Ø´†‚•¶†         ≥'+text_3+'√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *@ nstr+ 32,ftek_b_52 SAY '≥                ≥'+text_4+'≥äÆ§ Ø´†‚•¶† ¢  ≥'
                    *@ nstr+ 33,ftek_b_52 SAY '≥                ≥'+SPACE(50)+'≥°Ó§¶•‚ '+nazn_pl+'   ≥'
                    *@ nstr+ 34,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *@ nstr+ 35,ftek_b_52 SAY '≥ê†·ÂÆ§Î ØÆ      ≥(*) - ß† ·Á•‚ Ø´†‚•´ÏÈ®™†                                         ≥'
                    *@ nstr+ 36,ftek_b_52 SAY '≥Ø•‡•¢Æ§„        ≥( ) - ß† ·Á•‚ °•≠•‰®Ê®†‡†                                         ≥'
                    *@ nstr+ 37,ftek_b_52 SAY '≥ç„¶≠Æ•          ≥( ) - ‡†·ÂÆ§Î °†≠™†-Æ‚Ø‡†¢®‚•´Ô ß† ·Á•‚ Ø´†‚•´ÏÈ®™†,              ≥'
                    *@ nstr+ 38,ftek_b_52 SAY '≥ØÆ¨•‚®‚Ï(*)     ≥      ‡†·ÂÆ§Î §‡„£®Â °†≠™Æ¢ ß† ·Á•‚ °•≠•‰®Ê®†‡†                   ≥'
                    *@ nstr+ 39,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *@ nstr+ 40,ftek_b_52 SAY '≥                ≥èÆ§Ø®·® ™´®•≠‚†:                                                  ≥'
                    *@ nstr+ 41,ftek_b_52 SAY '≥                ≥                                                                  ≥'
                    *@ nstr+ 42,ftek_b_52 SAY '≥     å.è.       ≥ê„™Æ¢Æ§®‚•´Ï     ___________________                              ≥'
                    *@ nstr+ 43,ftek_b_52 SAY '≥                ≥                                                                  ≥'
                    *@ nstr+ 44,ftek_b_52 SAY '≥                ≥É´.°„Â£†´‚•‡     ___________________                              ≥'
                    *@ nstr+ 45,ftek_b_52 SAY '¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ'
                    *@ nstr+ 46,ftek_b_52 SAY '                                                                                     '
                    *@ nstr+ 47,ftek_b_52 SAY '                                            ò‚†¨Ø  °†≠™†                             '
                    *@ nstr+ 48,ftek_b_52 SAY '                                                                                     '
                    *@ nstr+ 49,ftek_b_52 SAY '  Ñ†‚† ®·ØÆ´≠•≠®Ô "   "_____________£.      èÆ§Ø®·Ï ®·ØÆ´≠®‚•´Ô  _____________       '
                    *@ nstr+ 50,ftek_b_52 SAY '                                                                                     '
                    *@ nstr+ 51,ftek_b_52 SAY '                                                                                     '
                    *@ nstr+ 46,ftek_b_52 SAY '   á†ØÆ´≠Ô•‚·Ô °†≠™Æ¨-Æ‚Ø‡†¢®‚•´•¨ ¢ ·´„Á†• ≠•Æ°ÂÆ§®¨Æ·‚® (§ÆØÆ´≠®‚•´Ï≠Î• ØÆ´Ô)      '
                    *@ nstr+ 47,ftek_b_52 SAY '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø'
                    *@ nstr+ 48,ftek_b_52 SAY '≥èÆ§Ø®·® Ø‡Æ¢•‡•≠Î                ≥                                                 ≥'
                    *@ nstr+ 49,ftek_b_52 SAY '≥ë†´Ï§Æ ØÆß¢Æ´Ô•‚______________   ≥ Ñ†‚† ¢†´Ó‚®‡Æ¢†≠®Ô _____________________        ≥'
                    *@ nstr+ 50,ftek_b_52 SAY '≥                  ØÆ§Ø®·Ï        ≥                                                 ≥'
                    *@ nstr+ 51,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥                                                 ≥'
                    *@ nstr+ 52,ftek_b_52 SAY '≥äÆ¨®··®Ô °†≠™†-Æ‚Ø‡†¢®‚•´Ô       ≥ ÇÎØÆ´≠®‚Ï Á•‡•ß _______________________________ ≥'
                    *@ nstr+ 53,ftek_b_52 SAY '≥_____________    ___________     ≥                (™Æ‡‡•·ØÆ≠§•≠‚ °†≠™†-Æ‚Ø‡†¢®‚•´Ô)≥'
                    *@ nstr+ 54,ftek_b_52 SAY '≥_____________    ___________     ≥ ______________                                  ≥'
                    *@ nstr+ 55,ftek_b_52 SAY '≥  (·„¨¨†)          (¢†´Ó‚†)      ≥   (ØÆ§Ø®·Ï)                                     ≥'
                    *@ nstr+ 56,ftek_b_52 SAY '¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ'
                    *@ nstr+ 57,ftek_b_52 SAY '   á†ØÆ´≠Ô•‚·Ô °†≠™Æ¨-Æ‚Ø‡†¢®‚•´•¨ ¢ ·´„Á†• ≠•Æ°ÂÆ§®¨Æ·‚® (§ÆØÆ´≠®‚•´Ï≠Î• ØÆ´Ô)      '
                    *@ nstr+ 58,ftek_b_52 SAY '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø'
                    *@ nstr+ 59,ftek_b_52 SAY '≥   ÑÖÅÖí ëóÖíÄ  ≥      äêÖÑàí ëóÖíÄ      ≥        äéÑ ÇÄãûíõ       ≥ ëìååÄ èÖêÖÇéÑÄ≥'
                    *@ nstr+ 60,ftek_b_52 SAY '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥'
                    *@ nstr+ 61,ftek_b_52 SAY '≥                ≥                        ≥                         ≥               ≥'
                    *@ nstr+ 62,ftek_b_52 SAY '¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ'
                    *@ nstr+ 63,ftek_b_52 SAY '                                                                                     '
                    *@ nstr+ 64,ftek_b_52 SAY '                                            ò‚†¨Ø  °†≠™†                             '
                    *@ nstr+ 65,ftek_b_52 SAY '                                                                                     '
                    *@ nstr+ 66,ftek_b_52 SAY '  Ñ†‚† ®·ØÆ´≠•≠®Ô "   "_____________£.      èÆ§Ø®·Ï ®·ØÆ´≠®‚•´Ô  _____________       '
                    *@ nstr+ 67,ftek_b_52 SAY '                                                                                     '
                    *@ nstr+ 68,ftek_b_52 SAY '                                                                                     '
                    *@ nstr+ 5,ftek_b_52 SAY 'è´†‚•´ÏÈ®™ '+fnschn1+nn3+'     |'
                    *@ nstr+ 6,ftek_b_52 SAY 'ë‚‡†≠† ‡•£®·‚‡†Ê®® êÅ                                        ÑÖÅÖí        ë„¨¨†      |'
                    *@ nstr+ 7,ftek_b_52 SAY 'äÆ§ '+fnschn3+SPACE(40)+ '------------------------------|'
                        *@ nstr+ 8,ftek_b_52 SAY SPACE(45)+'----------|    ·Á.N     |'+IIF(EMPTY(vid_val)=.t.,STR(fsum,12,0),STR(fsum,12,2))+'=  |'
                        *@ nstr+ 9,ftek_b_52 SAY 'Å†≠™ Ø´†‚. '+nscho1+'|   äÆ§   |'+nschl+'|               |'
                        *@ nstr+10,ftek_b_52 SAY nscho2+'|'+nschs+'|'+nschk+'|      '+IIF(EMPTY(vid_val)=.t.,'   ',ALLTRIM(vid_val))+'      |'
                        *@ nstr+11,ftek_b_52 SAY '¢ £.'+nschg+SPACE(26)+'------------------------|               |'
                        *@ nstr+12,ftek_b_52 SAY SPACE(58)+'äêÖÑàí     |               |'
                        *@ nstr+13,ftek_b_52 SAY 'èÆ´„Á†‚•´Ï '+fikl+fikl1+'------------------------------|'
                        *@ nstr+14,ftek_b_52 SAY 'ë‚‡†≠† ‡•£®·‚‡†Ê®® êÅ                        ----------|    ·Á. N    |               |'
                        *@ nstr+15,ftek_b_52 SAY 'äÆ§ '+funn+fikld+'|   äÆ§   |'+skl.sch+'|'+IIF(EMPTY(ftek_b_29).OR.fftar=0,'               ',STR(fsum-ftek_b_29,15,2))+'|'
                        *@ nstr+16,ftek_b_52 SAY 'Å†≠™ ØÆ´. '+skl.otd+'|'+skl.mfo+'|'+skl.korr+'|'+IIF(EMPTY(ftek_b_29).OR.fftar=0,SPACE(15),STR(ftek_b_29,15,2))+'|'
                        *@ nstr+17,ftek_b_52 SAY skl.otdd+'------------------------|               |'
                        *@ nstr+18,ftek_b_52 SAY '¢ £. '+skl.gorb+SPACE(49)+'|               |'
                        *@ nstr+19,ftek_b_52 SAY REPLICATE('-',29)+' ë„¨¨† ØpÆØ®·ÏÓ ----------------------------------------|'
                        *@ nstr+20,ftek_b_52 SAY sum_1
                        *@ nstr+20,ftek_b_52+69 SAY '|è•≠Ô ß†    §≠•©|'
                        *@ nstr+21,ftek_b_52 SAY sum_2
                        *@ nstr+21,ftek_b_52+69 SAY '|®ß        % ê. |'
                        *@ nstr+22,ftek_b_52 SAY REPLICATE('-',69)+'|ë„¨¨† · Ø•≠•©  |'
                        *@ nstr+23,ftek_b_52 SAY 'Ñ†‚† ØÆ´. ‚Æ¢†p† '+dat_tov+'|'+SPACE(30)+' |               |'
                        *@ nstr+24,ftek_b_52 SAY REPLICATE('-',69)+'|Ç®§ ÆØ•‡†Ê. '+vid_op+' |'
                        *@ nstr+25,ftek_b_52 SAY 'H†ß≠†Á. Ø´†‚•¶†, ≠†®¨•≠Æ¢. ‚Æ¢†‡†, ¢ÎØÆ´≠•≠≠ÎÂ ‡†°Æ‚, '+SPACE(15)+'|H†ß≠†Á. Ø´†‚•¶†|'
                        *@ nstr+26,ftek_b_52 SAY 'Æ™†ß†≠≠ÎÂ „·´„£,NN ® ·„¨¨Î ‚Æ¢†‡≠ÎÂ §Æ™„¨•≠‚Æ¢        '+SPACE(15)+'|    '+nazn_pl+'      |'
                        *@ nstr+27,ftek_b_52 SAY SPACE(69)+'|ë‡Æ™ Ø´†‚.     |'
                        *IF EMPTY(AT('',text_1,1)).AND.EMPTY(AT('',text_2,1)).AND.EMPTY(AT('',text_3,1)).AND.EMPTY(AT('',text_4,1))
                        *     @ nstr+28,ftek_b_52 SAY text_1+SPACE(19)+'|  '+DTOC(ffdat)+'   |'
                        *     @ nstr+29,ftek_b_52 SAY text_2+SPACE(19)+'|éÁ•‡.Ø´†‚.'+ffpl+'|'
                        *     @ nstr+30,ftek_b_52 SAY text_3+SPACE(19)+'|               |'
                        *     @ nstr+31,ftek_b_52 SAY text_4+SPACE(19)+'|N £‡.°†≠™†     |'
                        *ELSE
                        *     st1=text_1
                        *     st2=text_2
                        *     st3=text_3
                        *     st4=text_4
                        *     FOR iii=1 TO 4
                        *          ii=STR(iii,1)
                        *          st=st&ii
                        *          st&ii=''
                        *
                        *          i=1
                        *          j=0
                        *          ntek=1
                        *          DO WHILE !EMPTY(AT('',st,i))
                        *               st&ii=st&ii+SUBSTR(st,ntek,AT('',st,i)-ntek)
                        *               ntek=AT('',st,i)
                        *               i=i+2
                        *               j=j+1
                        *               SET EXACT OFF
                        *               SEEK gfbs+ffkp+fnrd
                        *               SET EXACT ON
                        *               sss=SUBSTR(st,ntek+1,AT('',st,i-1)-ntek-1)
                        *               SCAN REST WHILE nzk=gfbs.AND.nrd=fnrd.AND.kp=ffkp
                        *                    IF LEFT(kor,LEN(sss))=sss
                        *                         EXIT
                        *                    ENDIF
                        *               ENDSCAN
                        *               IF nzk=gfbs.AND.nrd=fnrd.AND.kp=ffkp
                        *                  *  st&ii=st&ii+LTRIM(STR(sm,15,2))
                        *                    st&ii=st&ii+RTRIM(name_mec(IIF(MONTH(dati)=1,12,(MONTH(dati)-1))))
                        *               ENDIF
                        *               ntek=AT('',st,i-1)+1
                        *          ENDDO
                        *
                        *     ENDFOR
                        *     @ nstr+28,ftek_b_52 SAY IIF(EMPTY(st1),text_1,st1)
                        *     @ nstr+28,ftek_b_52+69 SAY '|   '+DTOC(ffdat)+'    |'
                        *     @ nstr+29,ftek_b_52 SAY IIF(EMPTY(st2),text_2,st2)
                        *     @ nstr+29,ftek_b_52+69 SAY '|éÁ•‡.Ø´†‚.     |'
                        *     @ nstr+30,ftek_b_52 SAY IIF(EMPTY(st3),text_3,st3)
                        *     @ nstr+30,ftek_b_52+69 SAY '|               |'
                        *     @ nstr+31,ftek_b_52 SAY IIF(EMPTY(st4),text_4,st4)
                        *     @ nstr+31,ftek_b_52+69 SAY '|N £‡.°†≠™†     |'
                        *ENDIF
                        *@ nstr+32,ftek_b_52 SAY REPLICATE('-',85)+'|'
                        *@ nstr+33,ftek_b_52 SAY '                          |'+SPACE(35)+'|   è‡Æ¢•§•≠Æ °†≠™Æ¨   |'
                        *@ nstr+34,ftek_b_52 SAY '                          |'+SPACE(35)+'|  Ñ†‚†                |'
                        *@ nstr+35,ftek_b_52 SAY '  å.è.                    |èÆ§Ø®·® ™´®•≠‚†     '+SPACE(15)+'|  èÆ§Ø®·® °†≠™†       |'
                        *@ nstr+36,ftek_b_52 SAY '                          |'+SPACE(35)+'|                      |'
                        *@ nstr+37,ftek_b_52 SAY '                          |'+SPACE(35)+'|                      |'
                        *@ nstr+38,ftek_b_52 SAY '                          |'+SPACE(35)+'|                      |'
           *CASE wid_d=5.AND.vo='0'
         CASE wid_d=5.AND.vo='0'
              @ nstr+ 0,2 SAY 'èÆ·‚„Ø.¢ °†≠™ Ø´†‚.|'+SPACE(51)+'|  0401040  |'
              @ nstr+ 0,2 SAY '____________________'+SPACE(51)+'____________|'
              @ nstr+ 1,0 SAY SPACE(14)+sprnaz.nam+' N '+fnrd+SPACE(32)+'|'
              @ nstr+ 2,0 SAY SPACE(29)+LEFT(DTOC(dati),2)+' '+nammec+' 20'+RIGHT(DTOC(dati),2)+' £.'
              @ nstr+ 2,0 SAY SPACE(29)+'__________________'
              @ nstr+ 3,0 SAY SPACE(60)+'ÑÖÅÖí        ë„¨¨†       |'
              @ nstr+ 4,0 SAY 'èãÄíÖãúôàä '+fikl+fikl1+' -----------------------------|'
              @ nstr+ 5,0 SAY 'äÆ§ '+funn+fikld+'----------|    ·Á. N    |               |'
              @ nstr+ 6,0 SAY fikldd+'|         |             |               |'
              @ nstr+ 7,0 SAY 'Å†≠™ Ø´†‚.'+skl.otd+'|   äÆ§   |'+skl.sch+'|'+STR(fsum,15)+'|'
              @ nstr+ 8,0 SAY skl.otdd+'|'+skl.mfo+'|'+skl.korr+'|               |'
              @ nstr+ 9,0 SAY SPACE(12)+'¢ £.'+skl.gorb+SPACE(14)+'|         |             |               |'
              @ nstr+ 9,0 SAY '_____________________________________________________________________________________'
              @ nstr+10,0 SAY 'èéãìóÄíÖãú '+fnschn1+'    äêÖÑàí    |               |'
              @ nstr+11,0 SAY 'äÆ§ '+IIF(ffpr=1,nn3,SPACE(30))+SPACE(21)+'--------------|---------------|'
              @ nstr+12,0 SAY 'Å†≠™ ØÆ´. '+nscho1+'  ---------|    ·Á.N     |               |'
              @ nstr+13,0 SAY nscho2+'|   äÆ§   |'+nschl+'|               |'
              @ nstr+14,0 SAY SPACE(12)+'¢ £.'+nschg+SPACE(14)+'|'+nschs+'|'+nschk+'|               |'
              @ nstr+14,0 SAY '_____________________________________________________________________________________'
              @ nstr+15,0 SAY '               ØÆÁ‚Æ© - ‚•´•£p†‰Æ¨ (≠„¶≠Æ• ØÆ§Á•p™≠„‚Ï)              |               |'
              @ nstr+16,0 SAY ' É‡„ßÆØÆ´„Á†‚•´Ï       éH ÜÖ'+SPACE(41)+'|               |'
              @ nstr+17,0 SAY 'äÆ§ '+SPACE(65)+'|               |'
              @ nstr+17,0 SAY '______________________________________________________________________               '
              @ nstr+18,0 SAY 'ÑÆ£Æ¢Æ‡ '+SPACE(19)+'| ëØÆ·Æ° Æ‚Øp†¢´•≠®Ô'+SPACE(22)+'|               |'
              @ nstr+19,0 SAY 'Æ‚ '+SPACE(24)+'|'+SPACE(41)+'|               |'
              @ nstr+19,0 SAY '______________________________________________________________________               '
              @ nstr+20,0 SAY 'Ñ†‚† Æ‚£‡„ß™® '+DTOC(fdat)+'     |ÑÆ¢-‚Ï '+SPACE(34)+'|               |'
              @ nstr+20,0 SAY '______________________________________________________________________               '
              @ nstr+21,0 SAY 'H†®¨•≠Æ¢.‚Æ¢†‡†,¢ÎØÆ´≠•≠≠ÎÂ ‡†°Æ‚,Æ™†ß.„·´„£,NN ®                    |               |'
              @ nstr+22,0 SAY '·„¨¨Î ‚Æ¢†‡≠ÎÂ §Æ™„¨•≠‚Æ¢ ®´® ·Ø•Ê®‰®™†Ê®Ô ‚Æ¢†‡†                    |               |'
              @ nstr+22,0 SAY '______________________________________________________________________               '
              @ nstr+23,0 SAY text_1+SPACE(19)+'|               |'
              @ nstr+24,0 SAY text_2+SPACE(19)+'|               |'
              @ nstr+25,0 SAY text_3+SPACE(19)+'|               |'
              @ nstr+26,0 SAY text_4+SPACE(19)+'|               |'
              @ nstr+26,0 SAY '______________________________________________________________________               '
              nstr=nstr+27
              @ nstr+ 0,0 SAY '     å.è.            èÆ§Ø®·® ØÆ´„Á†‚•´Ô                              |               |'
              @ nstr+ 1,0 SAY '                                                            ÑÖÅÖí    | ë„¨¨† ™ ÆØ´†‚•|'
              @ nstr+ 1,0 SAY '_____________________________________________________________________________________'
              @ nstr+ 2,0 SAY IIF(ff17=1,sum_1,'')
              @ nstr+ 2,56 SAY '|            |               |'
              @ nstr+ 3,0 SAY IIF(ff17=1,sum_2,'')
              @ nstr+ 3,56 SAY '|            |               |'
              @ nstr+ 4,0 SAY IIF(ff17=1,sum_3,'')
              @ nstr+ 4,56 SAY '|            |               |'
              @ nstr+ 4,0 SAY '______________________________________________________________________'
              @ nstr+ 5,0 SAY '                                                             äêÖÑàí  |               |'
              @ nstr+ 5,0 SAY '                                                           __________________________'
              @ nstr+ 6,0 SAY '                                                     ·Á. N |         |               |'
              @ nstr+ 6,0 SAY '                                                           __________________________'
              @ nstr+ 7,0 SAY '                                                     ·Á. N |         |               |'
              @ nstr+ 7,0 SAY '                                                           __________________________'
              @ nstr+ 8,0 SAY '                                                                     |è•≠Ô ß†   §≠•© |'
              @ nstr+ 9,0 SAY '                                                                     |  ®ß   : % P   |'
              @ nstr+ 9,0 SAY '                                                                     ________________'
              @ nstr+10,0 SAY '                                                                     | ·„¨¨† · Ø•≠•© |'
              @ nstr+10,0 SAY '                                                                     ________________'
              @ nstr+11,0 SAY '                                                                     |Ç®§ ÆØ•p.|     |'
              @ nstr+11,0 SAY '                                                                     ________________'
              @ nstr+12,0 SAY '                                      èpÆ¢•§•≠Æ °†≠™Æ¨               |H†ß≠.Ø´†‚|     |'
              @ nstr+12,0 SAY '                                                                     ________________'
              @ nstr+13,0 SAY '                                                          19___£.    |ëpÆ™ Ø´†‚|     |'
              @ nstr+13,0 SAY '                                                                     ________________'
              @ nstr+14,0 SAY '                                      èÆ§Ø®·® °†≠™†                  |éÁ•p.Ø´†‚|     |'
              @ nstr+14,0 SAY '                                                                     ________________'
              @ nstr+15,0 SAY '   å.è.   èÆ§Ø®·® Ø´†‚•´ÏÈ®™†                                        |N £p.°†≠™|     |'
              @ nstr+15,0 SAY '                                                                     ________________'
         OTHERWISE
              SET DEVICE TO SCREEN
              SET PRINTER TO
              DO Net_n WITH 10,'é‚·„‚·¢„•‚ ‚†™Æ© ¢®§ §Æ™„¨•≠‚† Ø‡® ‚†™Æ© ÆØ•‡†Ê®®...'
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
@ nstr+ 3, 5 SAY '       èêàïéÑHõâ äÄëëéÇõâ éêÑÖê           |       äÇàíÄñàü'
@ nstr+ 4, 5 SAY '                                          | ™ Øp®ÂÆ§≠Æ¨„ ™†··Æ¢Æ¨„'
@ nstr+ 5, 5 SAY '  HÆ¨•p       Ñ†‚†       äÆpp.     ë„¨¨†  |    Æp§•p„  N '+fnrd
@ nstr+ 6, 5 SAY '§Æ™„¨•≠‚†  ·Æ·‚†¢´•≠®Ô   ·Á•‚             |èp®≠Ô‚Æ Æ‚ '+fkp
@ nstr+ 7, 5 SAY '                            --------------|'+fikl
@ nstr+ 8, 8 SAY fnrd+'   '+DTOC(fdat)+'    '+kor+'|'+STR(fsum,12,2)+' |'
@ nstr+ 9, 5 SAY '                            --------------|'
@ nstr+10, 5 SAY 'é·≠Æ¢†≠®•                                 |é·≠Æ¢†≠®• '
@ nstr+11, 5 SAY ft_1
@ nstr+11,47 SAY '|'+fc_1
@ nstr+12, 5 SAY ft_2
@ nstr+12,47 SAY '|'+fc_2
@ nstr+13, 5 SAY ft_3
@ nstr+13,47 SAY '|'+fc_3
@ nstr+14, 5 SAY 'èp®≠Ô‚Æ Æ‚ '+LEFT(fkp,6)+' '+LEFT(fikl,24)+'|'+fsum_1
@ nstr+15,23 SAY SUBSTR(fikl,25,6)
@ nstr+15,47 SAY '|'+fsum_2
@ nstr+16, 5 SAY sum_1
@ nstr+16,47 SAY '|'+fsum_3
@ nstr+17, 5 SAY sum_2
@ nstr+17,47 SAY '|'+fsum_4
@ nstr+18, 5 SAY sum_3
@ nstr+18,47 SAY '|'
@ nstr+19,47 SAY '|'+DTOC(dat)
@ nstr+20, 5 SAY 'É´†¢≠Î© °„Â£†´‚•p                         |  å.è.'
@ nstr+21, 5 SAY '                                          |É´†¢≠Î© °„Â£†´‚•p'
@ nstr+22,47 SAY '|'
@ nstr+23, 5 SAY 'èÆ´„Á®´ ™†··®p                            |ä†··®p'
    CASE wid_d=4.AND.vo='1'
         RESTORE FROM tek_b ADDITIVE
@ nstr+ 0,5 SAY fnschn1+'         îÆp¨† äé-02'
@ nstr+ 2, 5 SAY '       êÄëïéÑHõâ äÄëëéÇõâ éêÑÖê  N '+fnrd
@ nstr+ 4,30 SAY '   Ñ†‚†       äÆpp.            ë„¨¨†  '
@ nstr+ 5,30 SAY '·Æ·‚†¢´•≠®Ô   ·Á•‚         ---------------------'
@ nstr+ 6,30 SAY DTOC(fdat)+'      '+kor+'         |     '+STR(fsum,12,2)+'  |'
@ nstr+ 7,30 SAY SPACE(27)+'---------------------'
@ nstr+ 9, 5 SAY 'ÇÎ§†‚Ï '+fkp+fikl
@ nstr+11, 5 SAY 'é·≠Æ¢†≠®• '+text_1
@ nstr+12, 5 SAY SPACE(10)+text_2
@ nstr+14, 5 SAY sum_1
@ nstr+15, 5 SAY sum_2
@ nstr+17, 5 SAY 'ê„™Æ¢Æ§®‚•´Ï                     É´†¢≠Î© °„Â£†´‚•p'
@ nstr+19, 5 SAY 'èÆ´„Á®´ '+IIF(tek_b_18=0,REPLICATE('_',60),sum_1)
@ nstr+21, 5 SAY DTOC(dat)+'       èÆ§Ø®·Ï'
@ nstr+23, 5 SAY 'èÆ__________________________________________________________________'
@ nstr+24, 5 SAY '       ≠†®¨•≠Æ¢†≠®•, ≠Æ¨•p, §†‚† ® ¨•·‚Æ ¢Î§†Á® §Æ™„¨•≠‚†'
@ nstr+27, 5 SAY 'ÇÎ§†´ ™†··®p'
@ nstr+35, 5 SAY ' '
         RELEASE ALL LIKE tek_b_??
    OTHERWISE
         SET DEVICE TO SCREEN
         SET PRINTER TO
         DO Net_n WITH 10,'é‚·„‚·¢„•‚ ‚†™Æ© ¢®§ §Æ™„¨•≠‚† Ø‡® ‚†™Æ© ÆØ•‡†Ê®®...'
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