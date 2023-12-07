PRIVATE fsum,ii
RESTORE FROM nsch ADDITIVE
GO TOP
n1=1
n2=12
n3=19
n4=24
n5=43
n6=62
n7=71
n8=102
nnstr=0
nstr=0
ii=0
ffffsum1=0
ffffsum2=0
nstr=kolstr+1
DO WHILE !EOF()
    fffsum1=0
    fffsum2=0
    fnzk=nzk
    DO WHILE fnzk=nzk.AND.!EOF()
         ffsum1=0
         ffsum2=0
         fdog=dog
         pr_dog=.T.
         DO WHILE fdog=dog.AND.fnzk=nzk.AND.!EOF()
              fsum1=0
              fsum2=0
              fkp=kp
              kolk=0
              SCAN REST WHILE fkp=kp.AND.fdog=dog.AND.fnzk=nzk FOR sm#0
                   kolk=kolk+1
                   ii=ii+1
                   ?? ii PICTURE '999999' AT 18
                   IF nstr>kolstr
                        nnstr=nnstr+1
                        IF nnstr>=nlist
                             @ 0,0 SAY nschn1
                             @ 1,1  SAY "Лист "+STR(nnstr,2)+"."
@ 1,10 SAY "Информация по договорам "+tmec+' '+nastf_b+' г.'
@ 2,0 SAY REPLICATE('-',150)
@ 3,0 SAY '|   Дата   | Номер|Корр|      Сумма       |      Сумма       |        |                              |'
@ 4,0 SAY '| документа|докум.|счет|     прихода      |     расхода      |  Код   |   Hаименование  организации  |'+SPACE(20)+'Текст'
@ 5,0 SAY REPLICATE('-',150)
                        ENDIF
                        nstr=5
                   ENDIF
                   IF pr_dog
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n4 SAY 'Балансовый счет '+fnzk+'    Договор '+fdog
                        ENDIF
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n4 SAY REPLICATE('-',42)
                        ENDIF
                        pr_dog=.F.
                   ENDIF
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY dat
                        @ nstr,n2 SAY nrd
                        @ nstr,n3 SAY kor
                        @ nstr,IIF(vo='0',n4,n5) SAY sm PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n6 SAY kp
                        @ nstr,n7 SAY Spr_nam(pr_spr,kp,30)
                        @ nstr,n8 SAY text_1
                   ENDIF
                   IF !EMPTY(text_2)
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n8 SAY text_2
                        ENDIF
                   ENDIF
                   IF !EMPTY(text_3)
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n8 SAY text_3
                        ENDIF
                   ENDIF
                   IF !EMPTY(text_4)
                        nstr=nstr+1
                        IF nnstr>=nlist
                             @ nstr,n8 SAY text_4
                        ENDIF
                   ENDIF
                   IF vo='0'
                        fsum1=fsum1+sm
                   ELSE
                        fsum2=fsum2+sm
                   ENDIF
              ENDSCAN
              IF (fsum1#0.OR.fsum2#0).AND.kolk>1
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,n1 SAY "Итого по "+fkp
                        @ nstr,n4 SAY fsum1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                        @ nstr,n5 SAY fsum2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   ENDIF
              ENDIF
              IF (fsum1#0.OR.fsum2#0).AND.kolk>0
                   nstr=nstr+1
                   IF nnstr>=nlist
                        @ nstr,0 SAY REPLICATE('-',100)
                   ENDIF
              ENDIF
              ffsum1=ffsum1+fsum1
              ffsum2=ffsum2+fsum2
         ENDDO
         IF ffsum1#0.OR.ffsum2#0
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,n1 SAY "Итог "+fdog
                   @ nstr,n4 SAY ffsum1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
                   @ nstr,n5 SAY ffsum2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              ENDIF
              nstr=nstr+1
              IF nnstr>=nlist
                   @ nstr,0 SAY REPLICATE('=',100)
              ENDIF
         ENDIF
         fffsum1=fffsum1+ffsum1
         fffsum2=fffsum2+ffsum2
    ENDDO
    IF fffsum1#0.OR.fffsum2#0
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,n1 SAY "Итого по "+fnzk
              @ nstr,n4 SAY fffsum1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
              @ nstr,n5 SAY fffsum2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         ENDIF
         nstr=nstr+1
         IF nnstr>=nlist
              @ nstr,0 SAY REPLICATE('═',100)
         ENDIF
    ENDIF
    ffffsum1=ffffsum1+fffsum1
    ffffsum2=ffffsum2+fffsum2
ENDDO
IF ffffsum1#0.OR.ffffsum2#0
    nstr=nstr+1
    IF nnstr>=nlist
         @ nstr,n1 SAY "Всего"
         @ nstr,n4 SAY ffffsum1 PICTURE '999,999,999,999.99' FUNCTION 'Z'
         @ nstr,n5 SAY ffffsum2 PICTURE '999,999,999,999.99' FUNCTION 'Z'
    ENDIF
ENDIF
RETURN