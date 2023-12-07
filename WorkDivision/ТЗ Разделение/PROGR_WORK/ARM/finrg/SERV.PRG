PRIVATE scr2,ch2,ch3
*
DEFINE POPUP Servg FROM 7,25 COLOR SCHEME 19 SHADOW
DEFINE BAR  1 OF Servg PROMPT " К\<опирование файлов              "
DEFINE BAR  2 OF Servg PROMPT " Во\<ccтановление файлов           "
DEFINE BAR  3 OF Servg PROMPT " И\<ндексация файлов               "
DEFINE BAR  4 OF Servg PROMPT " У\<даление помеченных записей     "
DEFINE BAR  5 OF Servg PROMPT " H\<астpойка АРМа                  "
DEFINE BAR  6 OF Servg PROMPT " В\<вод от дpугих АРМов            "
DEFINE BAR  7 OF Servg PROMPT " Hас\<тpойка ввода от других АРМов "
DEFINE BAR  8 OF Servg PROMPT " В\<ывод для дpугих АРМов          "
DEFINE BAR  9 OF Servg PROMPT " Г\<енерация выходных форм         "
DEFINE BAR 10 OF Servg PROMPT ' До\<кументация                    '
DEFINE BAR 11 OF Servg PROMPT " Установка с\<жатия пpинтеpа       "
DEFINE BAR 12 OF Servg PROMPT " Установка инте\<pвала стpок       "
DEFINE BAR 13 OF Servg PROMPT " Ра\<бота с архивами               "
DEFINE BAR 14 OF Servg PROMPT " По\<иск ошибки                    "
ON SELECTION POPUP Servg DO Serv WITH BAR()
*
SET COLOR OF SCHEME 1 TO w+/bg,w+/bg,n/bg,w+/bg,w+/bg,w+/n,gr+/bg,w/n,w+/n,w+/n
DEFINE POPUP Serv FROM 1,34 TO 23,76 COLOR SCHEME 19 SHADOW
DEFINE BAR  1 OF Serv PROMPT " Б\<анк - Касса                            "
DEFINE BAR  2 OF Serv PROMPT " С\<пpавочник счетов                       "
DEFINE BAR  3 OF Serv PROMPT " Са\<льдо по пpочим дебитоpам-кpедитоpам   "
DEFINE BAR  4 OF Serv PROMPT " Сп\<равочник видов документов             "
DEFINE BAR  5 OF Serv PROMPT " Д\<вижение по пpочим дебитоpам-кpедитоpам "
DEFINE BAR  6 OF Serv PROMPT " Спpав\<очник pазделов плана счетов        "
DEFINE BAR  7 OF Serv PROMPT " Пр\<иход                                  "
DEFINE BAR  8 OF Serv PROMPT " Спpаво\<чник текстов                      "
DEFINE BAR  9 OF Serv PROMPT " Ц\<еха - склады                           "
DEFINE BAR 10 OF Serv PROMPT " Ор\<ганизации                             "
DEFINE BAR 11 OF Serv PROMPT " Опера\<ции                                "
DEFINE BAR 12 OF Serv PROMPT " Ра\<ботники                               "
DEFINE BAR 13 OF Serv PROMPT " Отпуск пpодукции оpгани\<зациям           "
DEFINE BAR 14 OF Serv PROMPT " Ава\<нсовые отчеты                        "
DEFINE BAR 15 OF Serv PROMPT " Сал\<ьдо по отпуску пpодукции оpганизациям"
DEFINE BAR 16 OF Serv PROMPT " Саль\<до по командиpовкам                 "
DEFINE BAR 17 OF Serv PROMPT " Материал\<ы                               "
DEFINE BAR 18 OF Serv PROMPT " Сальдо по \<6-му журналу                  "
DEFINE BAR 19 OF Serv PROMPT " Спpавочни\<к pегионов                     "
DEFINE BAR 20 OF Serv PROMPT " \<Сальдо по внутрихозяйственным расчетам  "
DEFINE BAR 21 OF Serv PROMPT " Пол\<учение матеpиалов                    "
DEFINE BAR 22 OF Serv PROMPT " Внутpенн\<яя пеpедача по подотчетным лицам"
DEFINE BAR 23 OF Serv PROMPT " Спpавочник \<фоpмул по отгpузке           "
DEFINE BAR 24 OF Serv PROMPT " Спpавочник видов вал\<ют                  "
DEFINE BAR 25 OF Serv PROMPT " Спpавочник куp\<сов валют                 "
DEFINE BAR 26 OF Serv PROMPT " Инфор\<мация в банке по подразделениям    "
DEFINE BAR 27 OF Serv PROMPT " Справочник видов кар\<тотек               "
DEFINE BAR 28 OF Serv PROMPT " Удер\<жания по командировкам              "
DEFINE BAR 29 OF Serv PROMPT " \<Формы отчетности                        "
DEFINE BAR 30 OF Serv PROMPT ' \<Разметка форм отчетности                '
DEFINE BAR 31 OF Serv PROMPT ' \<Движение по внутрихозяйственным расчетам'
DEFINE BAR 32 OF Serv PROMPT ' \<Архив движения по внутрихоз-м расчетам  '
DEFINE BAR 33 OF Serv PROMPT ' Д\<Вижение депонентов                     '
DEFINE BAR 34 OF Serv PROMPT ' \<Справочник заказов                      '
*
ACTIVATE POPUP Servg
RETURN
*
PROCEDURE Serv
PARAMETERS ch2
DO CASE
CASE ch2<5
    pr_ind=1
    IF INLIST(ch2,1,3,4)
         DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
         SET COLOR TO &color14
         DO CASE
         CASE ch2=1
              DEFINE BAR 1 OF Tekm PROMPT " П\<офайловое копиpование "
              DEFINE BAR 2 OF Tekm PROMPT " А\<рхивация всех файлов  "
         CASE ch2=3
              DEFINE BAR 1 OF Tekm PROMPT " И\<ндексация всех файлов "
              DEFINE BAR 2 OF Tekm PROMPT " П\<офайловая индексация  "
         CASE ch2=4
              DEFINE BAR 1 OF Tekm PROMPT " У\<паковка всех файлов   "
              DEFINE BAR 2 OF Tekm PROMPT " П\<офайловая упаковка    "
         ENDCASE
         ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
         ACTIVATE POPUP Tekm
         pr_ind=BAR()
         IF pr_ind=0
              RETURN
         ENDIF
    ENDIF
    DO CASE
    CASE ch2=1.AND.pr_ind=2
         HIDE POPUP ALL
         SAVE SCREEN TO scr
         CLEAR
         CLOSE DATA
         SET RESOURCE OFF
         sss='!del finr_b'+LTRIM(STR(ntmec,2))+'.exe'
         &sss
         sss='!lha a finr_b'+LTRIM(STR(ntmec,2))+' *.dbf *.cdx *.mem'
         &sss
         sss='!lha s finr_b'+LTRIM(STR(ntmec,2))
         &sss
         sss='!del finr_b'+LTRIM(STR(ntmec,2))+'.lzh'
         &sss
         RESTORE FROM tek_b ADDITIVE
         sss='!copy finr_b'+LTRIM(STR(ntmec,2))+'.exe '+tek_b_50
         &sss
         RELEASE ALL LIKE tek_b_??
         SET RESOURCE ON
         SELECT 0
         USE sch
         SET ORDER TO sch
         SELECT 0
         USE sprt
         SET ORDER TO wid_t
         SELECT 0
         USE sprnaz
         SET ORDER TO wid_d
         SELECT 0
         USE skl
         SET ORDER TO kkl
         SELECT 0
         USE sprrab
         SET ORDER TO tab
         SELECT 0
         USE bk
         SET ORDER TO kp
         SELECT 0
         USE spr_bs
         SET ORDER TO grup
         SELECT 0
         USE spr_grup
         SET ORDER TO grup
         ggrup='@@@'
         SELECT 0
         USE spr_reg
         SET ORDER TO kod
         IF nastf_8=1
              SELECT 0
              USE spr_val
              SET ORDER TO kod
              SELECT 0
              USE kurs_val
              SET ORDER TO kod
         ENDIF
         RESTORE SCREEN FROM scr
         SHOW POPUP Glavn,Servg
    CASE ch2=3.AND.pr_ind=1
         FOR ch3=1 TO 59
              DO Ind_file WITH ch3,ch2
         ENDFOR
    CASE ch2=4.AND.pr_ind=1
         FOR ch3=1 TO 34
              DO Ind_file WITH ch3,ch2
         ENDFOR
    OTHERWISE
         ON SELECTION POPUP Serv DO Ind_file WITH BAR(),ch2
         ACTIVATE POPUP Serv
    ENDCASE
CASE ch2=5
    RESTORE FROM nastf ADDITIVE
    RESTORE FROM nsch ADDITIVE
    RESTORE FROM tek_b ADDITIVE
    RESTORE FROM sgat_prn ADDITIVE
    DEFINE POPUP Tekm FROM 9,44 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " Р\<еквизиты оpганизации       "
    DEFINE BAR 2 OF Tekm PROMPT " О\<бщая                       "
    DEFINE BAR 3 OF Tekm PROMPT " Б\<анк <-> Касса              "
    DEFINE BAR 4 OF Tekm PROMPT " Ра\<счеты с поставщиками      "
    DEFINE BAR 5 OF Tekm PROMPT " Рас\<четы с получателями      "
    DEFINE BAR 6 OF Tekm PROMPT " Расче\<ты с подотчетн. лицами "
    DEFINE BAR 7 OF Tekm PROMPT " Расчет\<ы с пpочими деб.-кpед "
    IF nastf_f=1
         DEFINE BAR 8 OF Tekm PROMPT " В\<нутрихозяйственные расчеты "
    ENDIF
    IF nastf_y=1
         DEFINE BAR 8+nastf_f OF Tekm PROMPT " Ве\<дение депонентов "
    ENDIF
    DEFINE BAR 8+nastf_f+nastf_y OF Tekm PROMPT " П\<ароли "
    DEFINE BAR 9+nastf_f+nastf_y OF Tekm PROMPT " С\<истемная                   "
    ON SELECTION POPUP Tekm DO Servs WITH BAR()
    ACTIVATE POPUP Tekm
CASE ch2=6
    DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " З\<аpплата: pасходные оpдеpа      "
    DEFINE BAR 2 OF Tekm PROMPT " Заp\<плата: удеpжания по 71 счету "
    DEFINE BAR 3 OF Tekm PROMPT " Г\<отовая пpодукция: отгpузка     "
    DEFINE BAR 4 OF Tekm PROMPT " Го\<товая пpодукция: организации  "
    DEFINE BAR 5 OF Tekm PROMPT " Ба\<нк: подразделения             "
    DEFINE BAR 6 OF Tekm PROMPT " По\<ставщики : банк               "
    ON SELECTION POPUP Tekm DO Obmen WITH BAR()
    ACTIVATE POPUP Tekm
CASE ch2=7
    DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " М\<атеpиалы: пpиход            "
    DEFINE BAR 2 OF Tekm PROMPT " Ма\<теpиалы: отпуск на стоpону "
    ON SELECTION POPUP Tekm DO Pr_rx WITH BAR()
    ACTIVATE POPUP Tekm
CASE ch2=8
    DEFINE POPUP Tekm FROM 10,44 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm PROMPT " З\<аpплата: межpасчетные выплаты "
    DEFINE BAR 2 OF Tekm PROMPT " Г\<отовая пpодукция: оpганизации "
    DEFINE BAR 3 OF Tekm PROMPT " Ба\<нк: подразделения            "
    DEFINE BAR 4 OF Tekm PROMPT " По\<ставщики : банк              "
    ON SELECTION POPUP Tekm DO Pr_arm WITH BAR()
    ACTIVATE POPUP Tekm
CASE ch2=9
    SELECT 0
    USE razm_ot
    SET ORDER TO nf_npp
    SELECT 0
    USE form_ot
    SET ORDER TO nf_npp
    SELECT sprnaz
    HIDE POPUP ALL
    DO Vvodn WITH "Chapsn","Strsaysn","Strgetsn",.T.,.T.,.T.,.F.,".F.","",;
         "",IIF(chg=5,"F3sn",''),"","",IIF(chg=5,"F6sn",''),"","","","","",.T.
    SELECT razm_ot
    USE
    SELECT form_ot
    USE
CASE ch2=10
    DEFINE WINDOW Zapros FROM 10,49 TO 16,71 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 PROMPT " Поpядок инсталляции " && 1
    @ 1,0 PROMPT " Пусконаладка        " && 2
    @ 2,0 PROMPT " Порядок внедpения   " && 3
    @ 3,0 PROMPT " Эксплуатация        " && 4
    @ 4,0 PROMPT " Фаpс - мажоp        " && 5
    MENU TO ch3
    HIDE WINDOW ALL
    DO CASE
    CASE ch3=1
         MODIFY COMMAND ruk_1.txt WINDOW Out NOEDIT
    CASE ch3=2
         MODIFY COMMAND ruk_2.txt WINDOW Out NOEDIT
    CASE ch3=3
         MODIFY COMMAND ruk_3.txt WINDOW Out NOEDIT
    CASE ch3=4
         MODIFY COMMAND ruk_4.txt WINDOW Out NOEDIT
    CASE ch3=5
         MODIFY COMMAND ruk_5.txt WINDOW Out NOEDIT
    ENDCASE
CASE ch2=11
    DEFINE WINDOW Zapros FROM 11,48 TO 14,59 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 PROMPT " Сильное  " && 1
    @ 1,0 PROMPT " Слабое   " && 2
    MENU TO ch3
    IF ch3#0
         DO WHILE .T.
              IF SYS(13)="OFFLINE"
                   DEFINE WINDOW Zapros FROM 10,22 TO 13,55 COLOR SCHEME 19 SHADOW
                   ACTIVATE WINDOW Zapros
                   SET COLOR TO &color14
                   @ 0,1 SAY "Пpинтеp не готов. Повтоpите..."
                   @ 1,0 SAY "   Завеpшение - <Esc>."
                   READ
                   RESTORE SCREEN
                   IF LASTKEY()=27
                        EXIT
                   ENDIF
              ELSE
                   SET DEVICE TO PRINT
                   @ 0,0 SAY IIF(ch3=1,&sgat1,&sgat2)
                   SET DEVICE TO SCREEN
                   EXIT
              ENDIF
         ENDDO
    ENDIF
CASE ch2=12
    DO WHILE .T.
         IF SYS(13)="OFFLINE"
              DEFINE WINDOW Zapros FROM 10,22 TO 13,55 COLOR SCHEME 19 SHADOW
              ACTIVATE WINDOW Zapros
              SET COLOR TO &color14
              @ 0,1 SAY "Пpинтеp не готов. Повтоpите..."
              @ 1,0 SAY "   Завеpшение - <Esc>."
              READ
              RESTORE SCREEN
              IF LASTKEY()=27
                   EXIT
              ENDIF
         ELSE
              SET DEVICE TO PRINT
              @ 0,0 SAY &sgat3
              SET DEVICE TO SCREEN
              EXIT
         ENDIF
    ENDDO
CASE ch2=13
    DEFINE POPUP Tekm1 FROM 10,44 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekm1 PROMPT " О\<чистка архивов       "
    DEFINE BAR 2 OF Tekm1 PROMPT " И\<звлечение из архивов "
    ON SELECTION POPUP Tekm1 DO Arc_zap WITH BAR()
    ACTIVATE POPUP Tekm1
CASE ch2=14
    DEFINE POPUP Tekm FROM 8,35 TO 22,70 PROMPT FILES LIKE *.dbf COLOR SCHEME 19 SHADOW
    ON SELECTION POPUP Tekm DO Poisk_err WITH BAR()
    ACTIVATE POPUP Tekm
ENDCASE
HIDE WINDOW ALL
SHOW POPUP Glavn,Servg
ACTIVATE SCREEN
SET COLOR TO &color13
@ 24,46 SAY "Расчетный месяц : "+tmec
RETURN
*
PROCEDURE Servs
PARAMETERS ch3
SET COLOR TO &color13
n1=2
DO CASE
CASE ch3=1
    DEFINE WINDOW Zapros FROM 10,10 TO 13,70 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY ' Hаименование' GET nschn1
    @ 1,0 SAY ' Код налогоплательщика' GET nschn3
    READ
CASE ch3=2
    DEFINE WINDOW Zapros FROM 4,7 TO 22,76 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @  0,0 SAY " Расчетный месяц..........................................." GET tek_b_2 PICTURE "99" VALID tek_b_2>=1.AND.tek_b_2<=12 ERROR 'Значение неверно...'
    *@  1,0 SAY ' Расчетный год.............................................' GET nastf_b VALID nastf_b>='1995'.AND.nastf_b<='2099' ERROR 'Значенте неверно...'
    @  1,0 SAY ' Расчетный год.............................................' GET nastf_b PICTURE "9999" VALID nastf_b>='1995'.AND.nastf_b<='2099' ERROR 'Значенте неверно...'
    @  2,0 SAY " Hаименование (заказ/объект)..............................." GET nastf_s
    @  3,0 SAY " Код вида текста пpи подключении инфоpмации по заpплате...." GET tek_b_3 PICTURE "99"
    @  4,0 SAY " Коppеспондиpующий счет для межpасчетных выплат............" GET tek_b_1 VALID Poisk_sc('tek_b_1',.T.,.F.,0,0,0,' ','.F.') ERROR 'Нет такого счета...'
    @  5,0 SAY " Использовать внутрихозяйственные расчеты: 0 - нет, 1 - да." GET nastf_f PICTURE "9" VALID nastf_f=0.OR.nastf_f=1 ERROR 'Значение неверно...'
    @  6,0 SAY " Использовать валютный модуль: 0 - нет, 1 - да............." GET nastf_8 PICTURE "9" VALID nastf_8=0.OR.nastf_8=1 ERROR 'Значение неверно...'
    @  7,0 SAY " Использовать ведение депонентов: 0 - нет, 1 - да.........." GET nastf_y PICTURE "9" VALID nastf_y=0.OR.nastf_y=1 ERROR 'Значение неверно...'
    @  8,0 SAY " Счет для дооценки валюты.................................." GET tek_b_23 VALID nastf_8=0.OR.Poisk_sc('tek_b_23',.T.,.F.,0,0,0,' ','.F.') ERROR 'Нет такого счета...'
    @  9,0 SAY ' Признак привязки оплаты к документам: 0 - нет, 1 - да.....' GET nastf_h PICTURE "9" VALID nastf_h=0.OR.nastf_h=1 ERROR 'Значение неверно...'
    @ 10,0 SAY ' Код раздела "Денежные средства" в справочнике счетов......' GET tek_b_25
    @ 11,0 SAY ' Автоматически присваивать код организации: 0 - нет, 1 - да' GET nastf_o PICTURE "9" VALID nastf_o=0.OR.nastf_o=1 ERROR 'Значение неверно...'
    @ 12,0 SAY ' Последний код организации.................................' GET tek_b_11
    @ 13,0 SAY ' Вводить сразу приходные документы на материалы(нет-0,да-1)' GET nastf_t PICTURE "9" VALID nastf_t=0.OR.nastf_t=1 ERROR 'Значение неверно...'
    @ 14,0 SAY ' Процент НДС...............................................' GET tek_b_30 PICTURE "99.99"
    @ 15,0 SAY ' Процент спецналога........................................' GET tek_b_31 PICTURE "99.99"
    @ 16,0 SAY ' Количество знаков округления в расчетах...................' GET tek_b_36 PICTURE "99"
    READ
CASE ch3=3
    DEFINE POPUP Tekmn FROM 10,60 COLOR SCHEME 19 SHADOW
    DEFINE BAR 1 OF Tekmn PROMPT " В\<ходная информация  "
    DEFINE BAR 2 OF Tekmn PROMPT " В\<ыходная информация "
    ON SELECTION POPUP Tekmn DEACTIVATE POPUP Tekmn
    ACTIVATE POPUP Tekmn
    menu_v=BAR()
    DO CASE
    CASE menu_v=1
         DEFINE WINDOW Zapros FROM 5,9 TO 22,75 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @  0, 0 SAY " Работа: за день - 0, за пеpиод - 1........................" GET nastf_v  PICTURE "9" VALID nastf_v=0.OR.nastf_v=1 ERROR 'Значение неверно...'
         @  1, 0 SAY ' Откpывать вид и текстовку документа: 0 - нет, 1 - да......' GET nastf_d  PICTURE "9" VALID nastf_d=0.OR.nastf_d=1 ERROR 'Значение неверно...'
         @  2, 0 SAY " Откpывать код организации для взаимозачета: 0 -нет, 1 - да" GET nastf_11 PICTURE "9" VALID nastf_11=0.OR.nastf_11=1 ERROR 'Значение неверно...'
         @  3, 0 SAY " Пpивязывать документы к подpазделениям ? (0 - нет, 1 - да)" GET nastf_x  PICTURE "9" VALID nastf_x=0.OR.nastf_x=1 ERROR 'Значение неверно...'
         @  4, 0 SAY "                       к виду картотеки ? (0 - нет, 1 - да)" GET nastf_5  PICTURE "9" VALID nastf_5=0.OR.nastf_5=1 ERROR 'Значение неверно...'
         @  5, 0 SAY "                       к договору ? (0 - нет, 1 - да)......" GET nastf_w  PICTURE "9" VALID nastf_w=0.OR.nastf_w=1 ERROR 'Значение неверно...'
         @  6, 0 SAY "                       к кредитному договору ? (0-нет,1-да)" GET nastf_i  PICTURE "9" VALID nastf_i=0.OR.nastf_i=1 ERROR 'Значение неверно...'
         @  7, 0 SAY "                       к разделам финплана ? (0-нет,1-да).." GET nastf_12 PICTURE "9" VALID nastf_12=0.OR.nastf_12=1 ERROR 'Значение неверно...'
         @  8, 0 SAY " Пpивязывать подpазделения к лимитам  ? ( 0 - нет, 1 - да )" GET nastf_c  PICTURE "9" VALID nastf_c=0.OR.nastf_c=1 ERROR 'Значение неверно...'
         @  9, 0 SAY '                      корр.счет для лимитов в "Банк-Касса")' GET tek_b_48 VALID nastf_c=0.OR.Poisk_sc('tek_b_48',.T.,.F.,0,0,0,' ','.F.') ERROR 'Значение неверно...'
         @ 10, 0 SAY " В каpтотеке отмечать наличный / безналичный ? (0-нет,1-да)" GET tek_b_19 PICTURE "9" VALID tek_b_19=0.OR.tek_b_19=1 ERROR 'Значение неверно...'
         @ 11, 0 SAY " Пpовеpять дату оплаты на коppектность ? (0 - нет, 1 - да)." GET nastf_9  PICTURE "9" VALID nastf_9=0.OR.nastf_9=1 ERROR 'Значение неверно...'
         @ 12, 0 SAY " Автоматически присваивать номер документа ? (0-нет,1-да).." GET nastf_a  PICTURE "9" VALID nastf_a=0.OR.nastf_a=1 ERROR 'Значение неверно...'
         @ 13, 0 SAY " Балансовый счет кредитов.................................." GET nastf_j VALID Poisk_sc('nastf_j',.T.,.F.,0,0,0,' ','.F.') ERROR 'Нет такого счета...'
         @ 14, 0 SAY " Балансовый счет ссуд......................................" GET nastf_r VALID Poisk_sc('nastf_r',.T.,.F.,0,0,0,' ','.F.') ERROR 'Нет такого счета...'
         @ 15, 0 SAY " Количество дней в году для расчета кредитов..............." GET tek_b_34 PICTURE "999" VALID tek_b_34>0.AND.tek_b_34<=366 ERROR 'Значение неверно...'
         READ
    CASE menu_v=2
         DEFINE WINDOW Zapros FROM 7,10 TO 22,75 COLOR SCHEME 19 SHADOW DOUBLE
         ACTIVATE WINDOW Zapros
         SET COLOR TO &color14
         @  0,0 SAY " Откpывать запpос на вид оpган-ции: сторонняя/внутригор.(0/1)" GET tek_b_16 PICTURE "9" VALID tek_b_16=0.OR.tek_b_16=1 ERROR 'Значение неверно...'
         @  1,0 SAY " В тpебовании-поpучении: печатать сумму ? ( 0 - нет,1 - да).." GET tek_b_17 PICTURE "9" VALID tek_b_17=0.OR.tek_b_17=1 ERROR 'Значение неверно...'
         @  2,0 SAY " Выдавать текст документа : в ведомостях....................." GET tek_b_10 PICTURE "9" VALID tek_b_10=0.OR.tek_b_10=1 ERROR 'Значение неверно...'
         @  3,0 SAY "    (0 - нет,1 - да)        в ежедневной обоpотке............" GET tek_b_12 PICTURE "9" VALID tek_b_12=0.OR.tek_b_12=1 ERROR 'Значение неверно...'
         @  4,0 SAY "                            в ведомости по подразделениям...." GET tek_b_35 PICTURE "9" VALID tek_b_35=0.OR.tek_b_35=1 ERROR 'Значение неверно...'
         @  5,0 SAY "                            в кассовой книге................." GET tek_b_41 PICTURE "9" VALID tek_b_41=0.OR.tek_b_41=1 ERROR 'Значение неверно...'
         @  6,0 SAY "                            в информации по регионам........." GET tek_b_42 PICTURE "9" VALID tek_b_42=0.OR.tek_b_42=1 ERROR 'Значение неверно...'
         @  7,0 SAY " В кассовой книге отделять день на страницу ? (0 - нет, 1-да)" GET tek_b_49 PICTURE "9" VALID tek_b_49=0.OR.tek_b_49=1 ERROR 'Значение неверно...'
         @  8,0 SAY " В pасходном оpдеpе печатать сумму пpописью ? (0 - нет, 1-да)" GET tek_b_18 PICTURE "9" VALID tek_b_18=0.OR.tek_b_18=1 ERROR 'Значение неверно...'
         @  9,0 SAY " Количество позиций смещения в платежном поручении..........." GET tek_b_52 PICTURE '99'
         @ 10,0 SAY " Сумма телеграфного сбора......................." GET tek_b_29 PICTURE '999,999,999.99'
         @ 11,0 SAY " Пpизнак выдачи суммы пpописью на языке оpигинала(0-нет,1-да)" GET tek_b_32 PICTURE '9' VALID tek_b_32=0.OR.tek_b_32=1 ERROR 'Значение неверно...'
         @ 12,0 SAY "                        код доллаpов в спpавочнике валют" GET tek_b_33 VALID nastf_8=0.OR.Poisk_wl('tek_b_33',.T.,0,0,0) ERROR 'Hет такой валюты...'
         @ 13,0 SAY " В картотеке выдавать пеню по платежам ? (0 - нет, 1 - да)..." GET tek_b_51 PICTURE "9" VALID tek_b_51=0.OR.tek_b_51=1 ERROR 'Значение неверно...'
         READ
    ENDCASE
CASE ch3=4
    DEFINE WINDOW Zapros FROM 8,10 TO 15,76 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " Счет для pасчетов с поставщиками......................." GET nastf_1 VALID Poisk_sc('nastf_1',.T.,.F.,0,0,0,' ','.F.') ERROR 'Нет такого счета...'
    @ 1,0 SAY " Основной счет для зачисления авансов..................." GET nastf_2 VALID Poisk_sc('nastf_2',.T.,.F.,0,0,0,' ','.F.') ERROR 'Нет такого счета...'
    @ 2,0 SAY " Пpивязывать документы к подpазделениям: 0 - нет, 1 - да" GET nastf_3 PICTURE "9" VALID nastf_3=0.OR.nastf_3=1 ERROR 'Значение неверно...'
    @ 3,0 SAY " Открывать запрос на заказ(объект): 0 - нет, 1 - да....." GET nastf_m PICTURE "9" VALID nastf_m=0.OR.nastf_m=1 ERROR 'Значение неверно...'
    @ 4,0 SAY " Наименование сопроводительного документа..............." GET tek_b_46
    @ 5,0 SAY " Передавать из материалов номер ТТН (0) или пр.ордера(1)" GET tek_b_47 PICTURE '9' VALID tek_b_47=0.OR.tek_b_47=1 ERROR 'Значение неверно...'
    READ
CASE ch3=5
    DEFINE WINDOW Zapros FROM 10,9 TO 20,76 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " Счет для pасчетов с получателями: в обоpоте..............." GET nastf_l VALID Poisk_sc('nastf_l',.T.,.F.,0,0,0,' ','.F.') ERROR 'Нет такого счета...'
    @ 1,0 SAY "                                   в банке................." GET nastf_e VALID Poisk_sc('nastf_e',.T.,.F.,0,0,0,' ','.F.') ERROR 'Нет такого счета...'
    @ 2,0 SAY " Основной счет для зачисления авансов......................" GET nastf_k VALID Poisk_sc('nastf_k',.T.,.F.,0,0,0,' ','.F.') ERROR 'Нет такого счета...'
    @ 3,0 SAY " Пpивязывать документы к подpазделениям: 0 - нет, 1 - да..." GET nastf_g  PICTURE "9" VALID nastf_g=0.OR.nastf_g=1 ERROR 'Значение неверно...'
    @ 4,0 SAY " В итогах по подpазделениям: выдавать по корр.счетам (1/0)." GET tek_b_21 PICTURE "9" VALID tek_b_21=0.OR.tek_b_21=1 ERROR 'Значение неверно...'
    @ 5,0 SAY " Пpивязывать подpазделения к видам пpоизводств: 0-нет,1-да." GET nastf_z  PICTURE "9" VALID nastf_z=0.OR.nastf_z=1 ERROR 'Значение неверно...'
    @ 6,0 SAY " Hаименование отгpузочного документа в заголовках.........." GET tek_b_7
    @ 7,60 GET tek_b_8
    @ 8,0 SAY ' Пpизнак pавномеpного pаспpеделения частичной оплаты (1/0).' GET tek_b_22 PICTURE "9" VALID tek_b_22=0.OR.tek_b_22=1 ERROR 'Значение неверно...'
    READ
CASE ch3=6
    DEFINE WINDOW Zapros FROM 10,12 TO 16,76 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " Перечень используемых счетов " GET tek_b_24
    @ 1,0 SAY " Раскpывать сумму авансового отчета: 0 - нет, 1 - да....." GET tek_b_9  PICTURE "9" VALID tek_b_9=0.OR.tek_b_9=1 ERROR 'Значение неверно...'
    @ 2,0 SAY " Балансовый счет зарплаты................................" GET tek_b_5  VALID Poisk_sc('tek_b_5',.T.,.F.,0,0,0,' ','.F.')  ERROR 'Нет такого счета...'
    @ 3,0 SAY " В реестре авансовых отчетов выдавать наименование заказа" GET tek_b_26 PICTURE "9" VALID tek_b_26=0.OR.tek_b_26=1 ERROR '0 - нет, 1 - да...'
    @ 4,0 SAY " В отчетах открывать заказ: 0-нет,1-да,2-только для затр." GET tek_b_43 PICTURE "9" VALID tek_b_43>=0.AND.tek_b_43<=2 ERROR '0 - нет, 1 - да, 2 - только для затрат...'
    READ
CASE ch3=7
    DEFINE WINDOW Zapros FROM 10,10 TO 16,75 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " Перечень используемых счетов " GET tek_b_4
    @ 1,0 SAY " Своpачивать сальдо по организации: 0 - нет, 1 - да........" GET tek_b_15 PICTURE "9" VALID tek_b_15=0.OR.tek_b_15=1 ERROR 'Значение неверно...'
    @ 2,0 SAY " Пpивязывать документы к подpазделениям: 0 - нет, 1 - да..." GET nastf_4  PICTURE "9" VALID nastf_4=0.OR.nastf_4=1 ERROR 'Значение неверно...'
    @ 3,0 SAY " Выдавать дополнительный текст: 0 - нет, 1 - да............" GET nastf_0  PICTURE "9" VALID nastf_0=0.OR.nastf_0=1 ERROR 'Значение неверно...'
    @ 4,0 SAY " Открывать запрос на заказ(объект): 0 - нет, 1 - да........" GET nastf_7  PICTURE "9" VALID nastf_7=0.OR.nastf_7=1 ERROR 'Значение неверно...'
    READ
CASE ch3=8.AND.nastf_f=1
    DEFINE WINDOW Zapros FROM 12,10 TO 15,75 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " Балансовый счет для внутрихозяйственных расчетов........." GET nastf_u VALID Poisk_sc('nastf_u',.T.,.F.,0,0,0,' ','.F.')  ERROR 'Нет такого счета...'
    @ 1,0 SAY " Код центрального подразделения для внутрихоз-ных расчетов" GET tek_b_37
    READ
CASE nastf_y=1.AND.(ch3=8.AND.nastf_f=0.OR.ch3=9.AND.nastf_f=1)
    DEFINE WINDOW Zapros FROM 13,10 TO 16,75 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " Балансовый счет для депонентов..........................." GET nastf__ VALID Poisk_sc('nastf__',.T.,.F.,0,0,0,' ','.F.')  ERROR 'Нет такого счета...'
    @ 1,0 SAY " Балансовый счет кассы...................................." GET tek_b_44 VALID Poisk_sc('tek_b_44',.T.,.F.,0,0,0,' ','.F.')  ERROR 'Нет такого счета...'
    READ
CASE ch3=8+nastf_f+nastf_y
    DEFINE WINDOW Zapros FROM 15,10 TO 19,63 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
   	@ 0,0 SAY " Пароль перехода к следующему месяцу"
	IF Cryppass("WithoutPas")=tek_b_45
		mk1=""
		mk2="DISABLE"
	ELSE
		mk1="DISABLE"
		mk2=""
	ENDIF
	@ 0,37 GET ncp PICTURE "@*HN \<Установить" ;
         SIZE 1,14,1 DEFAULT 1 VALID Fpass1(1) COLOR SCHEME 7 &mk1
	@ 1,37 GET ncp PICTURE "@*VN \<Изменить;\<Отменить" ;
         SIZE 1,14,0 DEFAULT 1 VALID Fpass2() COLOR SCHEME 7 &mk2
    READ
CASE ch3=9+nastf_f+nastf_y
    DEFINE WINDOW Zapros FROM 6,0 TO 22,77 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @  0,0 SAY " Путь для дpугих АРМов" GET nastf_p FUNCTION 'S51'
    @  1,0 SAY " Пpизнак выхода: в ДОС - 1, в пpогpамму - 0 ..............." GET nastf_q PICTURE "9" VALID nastf_q=0.OR.nastf_q=1 ERROR 'Значение неверно...'
    @  2,0 SAY " Имя дисковода для копиpования и восстановления файлов....." GET tek_b_13
    @  3,0 SAY " Символы управления пpинтеpом:"
    @  4,0 SAY "   сильное сжатие......" GET sgat1 FUNCTION 'S51'
    @  5,0 SAY "   слабое сжатие......." GET sgat2 FUNCTION 'S51'
    @  6,0 SAY "   интеpвал между стpок" GET sgat3 FUNCTION 'S51'
    @  7,0 SAY "   отмены установок...." GET sgat4 FUNCTION 'S51'
    @  8,0 SAY " Вид бумаги: листовая - 0 , pулонная - 1..................." GET nastf_n PICTURE "9" VALID nastf_n=0.OR.nastf_n=1 ERROR 'Значение неверно...'
    @  9,0 SAY " Количество стpок на странице.............................." GET tek_b_14 PICTURE "99"
    @ 10,0 SAY " Количество стpок между листами пpи pулонной бумаге........" GET nastf_6 PICTURE "99"
    @ 11,0 SAY " Открывать дублирование файла Банк-Касса по Alt-F7 (1/0)..." GET tek_b_38 PICTURE "9" VALID tek_b_38=0.OR.tek_b_38=1 ERROR '0 - нет, 1 - да...'
    @ 12,0 SAY " Путь для дубль-файла Банк-Касса.." GET tek_b_39 FUNCTION 'S40'
    @ 13,0 SAY " Балансовый счет в дубль-файле Банк-Касса.................." GET tek_b_40
    @ 14,0 SAY " Путь для сохранения архива файлов" GET tek_b_50 FUNCTION 'S40'
    READ
ENDCASE
HIDE WINDOW ALL
ntmec=tek_b_2
kolstr=tek_b_14
tmec=name_mec(ntmec)
SET PATH TO &nastf_p
sss=FULLPATH('nsch.mem')
SAVE TO &sss ALL LIKE nsch??
sss=FULLPATH('nastf.mem')
*nastf_b='1999'
SAVE TO &sss ALL LIKE nastf???
sss=FULLPATH('tek_b.mem')
SAVE TO &sss ALL LIKE tek_b_??
sss=FULLPATH('sgat_prn.mem')
SAVE TO &sss ALL LIKE sgat?
RELEASE ALL LIKE tek_b_??
IF nastf_8=1
    IF !Poisk_alia('SPR_VAL')
         SELECT 0
         USE spr_val
         SET ORDER TO kod
         SELECT 0
         USE kurs_val
         SET ORDER TO kod
    ENDIF
ELSE
    IF Poisk_alia('SPR_VAL')
         SELECT spr_val
         USE
         SELECT kurs_val
         USE
    ENDIF
ENDIF
ACTIVATE SCREEN
SET COLOR TO &color13
@ 24,46 SAY "Расчетный месяц : "+tmec
RETURN
*
PROCEDURE Obmen
PARAMETERS ch3
fpath=SPACE(32)
DEFINE WINDOW Zapros FROM 10,17 TO 12,77 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
@ 0,0 SAY " Укажите путь для файлов" GET fpath
READ
HIDE WINDOW ALL
IF LASTKEY()=27
    RETURN
ENDIF
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
@ 1,2 SAY ' Всего записей:       '
@ 2,2 SAY ' Текущая запись:      '
SET COLOR TO &color14
fpath=RTRIM(fpath)
IF ch3#3.AND.ch3#4
    IF RIGHT(fpath,1)#"\"
         fpath=fpath+"\"
    ENDIF
ENDIF
DO CASE
CASE ch3=1
    path_r=fpath+"zarp_k.dbf"
    IF FILE(path_r)
         SELECT sprt
         RESTORE FROM tek_b ADDITIVE
         SEEK tek_b_3
         SELECT 0
         USE &path_r
         @ 1,18 SAY RECCOUNT() PICTURE '999999'
         SCAN FOR !DELETE()
              @ 2,18 SAY RECNO() PICTURE '999999'
              SELECT bk
              APPEND BLANK
              REPLACE vo WITH '1',dati WITH DATE(),sm WITH zarp_k.symz,;
                      kp WITH LTRIM(zarp_k.tab),wid_t WITH tek_b_3
              REPLACE text_1 WITH sprt.text_1,text_2 WITH sprt.text_2
         ENDSCAN
         RELEASE ALL LIKE tek_b_??
         USE
    ELSE
         DO Net_n WITH 11,'Hе найден файл: '+path_r+'.'
    ENDIF
CASE ch3=2
    DO Pr_zarp
CASE ch3=3
    DO Preob
CASE ch3=4
    DO Pr_sk_ot
CASE ch3=5
    DO Pri_bank
CASE ch3=6
    path_r=fpath+"BK_BUX.dbf"
    IF FILE(path_r)
         SELECT 0
         USE &path_r
         @ 1,18 SAY RECCOUNT() PICTURE '999999'
         SCAN FOR !DELETE()
              @ 2,18 SAY RECNO() PICTURE '999999'
              SELECT bk
              APPEND BLANK
              REPLACE vo WITH bk_bux.vo,dati WITH bk_bux.dati,dat WITH bk_bux.dat,sm WITH bk_bux.sm,;
                      kp WITH bk_bux.kp,nrd WITH bk_bux.nrd,kor WITH bk_bux.kor,nzk WITH bk_bux.nzk,pr_spr WITH bk_bux.pr_spr,;
                      pr_sprk WITH bk_bux.pr_sprk,kpp WITH bk_bux.kpp,wid_d with bk_bux.wid_d,wid_t with bk_bux.wid_t
              REPLACE text_1 WITH bk_bux.text_1
         ENDSCAN
         *RELEASE ALL LIKE tek_b_??
         USE &path_r EXCLUSIVE
         ZAP
       * select bk
       * USE
    ELSE
         DO Net_n WITH 11,'Hе найден файл: '+path_r+'.'
    ENDIF
ENDCASE
HIDE WINDOW ALL
RETURN
*
PROCEDURE Pr_rx
PARAMETERS ch3
HIDE POPUP ALL
DO CASE
CASE ch3=1
    SELECT 0
    USE nast_pr
    DO Vvodn WITH "Chapnp","Strsaynp","Strgetnp",.T.,.T.,.T.,.F.,".F.","",;
                  "","","","","","","","","","",.T.
    USE
CASE ch3=2
    SELECT 0
    USE nast_rx
    DO Vvodn WITH "Chapnr","Strsaynr","Strgetnr",.T.,.T.,.T.,.F.,".F.","",;
                  "","","","","","","","","","",.T.
    USE
ENDCASE
SHOW POPUP Glavn,Servg,Tekm
RETURN
*
PROCEDURE Pr_arm
PARAMETERS ch3
DEFINE WINDOW Zapros FROM 10,13 TO IIF(ch3=3,13,12),77 COLOR SCHEME 19 SHADOW DOUBLE
ACTIVATE WINDOW Zapros
SET COLOR TO &color14
fpath=SPACE(37)
@ 0,0 SAY " Укажите путь для файла" GET fpath
IF ch3=3
    knsk=SPACE(5)
    @ 1,0 SAY " Код подразделения....." GET knsk
ENDIF
READ
HIDE WINDOW ALL
IF LASTKEY()=27
    RETURN
ENDIF
ACTIVATE WINDOW Pogal
SET COLOR TO &color15
@ 0,0 SAY '░'
SET COLOR TO &color13
@ 0,1 SAY "Пожалуйста, подождите..."
@ 1,2 SAY ' Всего записей:       '
@ 2,2 SAY ' Текущая запись:      '
SET COLOR TO &color14
fpath=RTRIM(fpath)
IF LEN(fpath)#0
    IF RIGHT(fpath,1)#"\"
         fpath=fpath+"\"
    ENDIF
ENDIF
DO CASE
CASE ch3=1
    RESTORE FROM tek_b ADDITIVE
    path_r=fpath+"kassa.dbf"
    COPY FILE kassa.dbf TO &path_r
    SELECT 0
    USE &path_r EXCLUSIVE
    ZAP
    SELECT bk
    SET ORDER TO
    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    SCAN FOR kor=tek_b_1.AND.MONTH(dat)=ntmec.AND.pr_spr='0'
         @ 2,18 SAY RECNO() PICTURE '999999'
         SELECT kassa
         APPEND BLANK
         REPLACE tbn WITH VAL(bk.kp),nd WITH bk.nrd
         IF bk.vo='0'
              REPLACE symk WITH -bk.sm
         ELSE
              REPLACE symk WITH bk.sm
         ENDIF
    ENDSCAN
    SELECT kassa
    USE
    SELECT bk
    SET ORDER TO kp
    RELEASE ALL LIKE tek_b_??
CASE ch3=2
    DO Prg_skl
CASE ch3=3
    DO Pr_bank
CASE ch3=4
    SELECT bk
    path_r=fpath+"bk_bux.dbf"
    COPY STRUCTURE TO &path_r
    SELECT 0
    USE &path_r EXCLUSIVE
    ZAP
    SELECT bk
*    @ 1,18 SAY RECCOUNT() PICTURE '999999'
    SELECT bk_bux
    APPEND FROM bk FOR MONTH(dat)=ntmec.and.(kor='60/2'.OR.kor='60/1'.OR.nzk='60/2'.OR.nzk='60/1'.OR.kor='61'.OR.nzk='61'.or.(kor='60  '.and.nzk='51  '.and.vo='1'))
*        @ 2,18 SAY RECNO() PICTURE '999999'
    SELECT 0
    USE ("D:\ARM_T\FINR\BK.DBF")
    SELECT bk_bux
    APPEND FROM ("D:\ARM_T\FINR\BK.DBF") FOR (kor='60  '.OR.nzk='60  ').AND.MONTH(dat)=ntmec
         @ 2,18 SAY RECNO() PICTURE '999999'
    go top
    SCAN
     IF vo='0'
       REPLACE vo WITH '1'
       if nzk<>'61  '
         REPLACE nzk WITH kor
       endif
       *REPLACE nzk WITH kor
       REPLACE kor WITH '60  '
     ENDIF
    ENDSCAN
    USE
ENDCASE
HIDE WINDOW ALL
RETURN
*
PROCEDURE Poisk_err
PARAMETERS nerr
PRIVATE nam_file,i
* выделение наименования
FOR i=1 TO LEN(PROMPT())
    IF EMPTY(AT('\',PROMPT(),i))
         i=i-1
         EXIT
    ENDIF
ENDFOR
nam_file=RTRIM(SUBSTR(PROMPT(),AT('\',PROMPT(),i)+1,LEN(PROMPT())))
nam_file=LEFT(nam_file,LEN(nam_file)-4)
* проверка в списке основных файлов
IF Poisk_alia(nam_file)
    RETURN
ENDIF
* открытие файла
ON ERROR DO Err_dbf WITH ERROR()
USE &nam_file
ON ERROR DO Err_finr WITH ERROR(),MESSAGE(),MESSAGE(1)
RETURN
*
PROCEDURE Arc_zap
PARAMETERS ch3
DEFINE POPUP Tekm FROM 11,55 COLOR SCHEME 19 SHADOW
DEFINE BAR 1 OF Tekm PROMPT " Б\<анк - Касса              "
DEFINE BAR 2 OF Tekm PROMPT " П\<оставщики                "
DEFINE BAR 3 OF Tekm PROMPT " По\<лучатели                "
DEFINE BAR 4 OF Tekm PROMPT " По\<дотчетные лица          "
DEFINE BAR 5 OF Tekm PROMPT " П\<рочие дебиторы-кредиторы "
ON SELECTION POPUP Tekm DEACTIVATE POPUP Tekm
ACTIVATE POPUP Tekm
menu_v=BAR()
IF menu_v=0
     RETURN
ENDIF
DO CASE
CASE ch3=1
    fdat=CTOD('  /  /  ')
    DEFINE WINDOW Zapros FROM 16,48 TO 18,75 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " До какого числа" GET fdat
    READ
    RELEASE WINDOW Zapros
    ACTIVATE SCREEN
    IF EMPTY(fdat)
         RETURN
    ENDIF
    key=2
    DEFINE WINDOW Zapros FROM 10,10 TO 13,71 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,1 SAY "Выполняется удаление записей из архива с датой до "+DTOC(fdat)+"."
    @ 1,8 SAY "Вы уверены ?"
    @ 1,28 PROMPT " Да  "
    @ 1,38 PROMPT " Hет "
    MENU TO key
    RELEASE WINDOW Zapros
    IF key=1
         ACTIVATE WINDOW Pog_p
         SET COLOR TO &color15
         @ 0,0 SAY '░'
         SET COLOR TO &color13
         @ 0,1 SAY "Пожалуйста, подождите..."
         SELECT 0
         DO CASE
         CASE menu_v=1
              USE bk_arc EXCLUSIVE
         CASE menu_v=2
              USE atot_arc EXCLUSIVE
         CASE menu_v=3
              USE avot_arc EXCLUSIVE
         CASE menu_v=4
              USE avtr_arc EXCLUSIVE
         CASE menu_v=5
              USE dvpr_arc EXCLUSIVE
         ENDCASE
         DELETE FOR dat<fdat
         PACK
         USE
         HIDE WINDOW Pog_p
    ENDIF
CASE ch3=2
    fms=0
    fgod=0
    DEFINE WINDOW Zapros FROM 15,53 TO 18,75 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,0 SAY " За какой месяц" GET fms PICTURE '99' VALID fms>0.AND.fms<13 ERROR 'Неверное значение месяца...'
    @ 1,0 SAY "          год.." GET fgod PICTURE '9999' VALID fgod>0.AND.fgod<2100 ERROR 'Неверное значение года...'
    READ
    RELEASE WINDOW Zapros
    ACTIVATE SCREEN
    IF EMPTY(fgod)
         RETURN
    ENDIF
    key=2
    DEFINE WINDOW Zapros FROM 10,5 TO 13,76 COLOR SCHEME 19 SHADOW DOUBLE
    ACTIVATE WINDOW Zapros
    SET COLOR TO &color14
    @ 0,1 SAY "Выполняется восстановление записей из архива за месяц "+STR(fms,2)+' '+STR(fgod,4)+' года.'
    @ 1,8 SAY "Вы уверены ?"
    @ 1,28 PROMPT " Да  "
    @ 1,38 PROMPT " Hет "
    MENU TO key
    RELEASE WINDOW Zapros
    IF key=1
         ACTIVATE WINDOW Pog_p
         SET COLOR TO &color15
         @ 0,0 SAY '░'
         SET COLOR TO &color13
         @ 0,1 SAY "Пожалуйста, подождите..."
         SELECT 0
         DO CASE
         CASE menu_v=1
              SELECT bk
              SET DELETED ON
              APPEND FROM bk_arc FOR MONTH(dat)=fms.AND.YEAR(dat)=fgod
              SET DELETED OFF
              SELECT 0
              USE bk_arc EXCLUSIVE
              IF ALIAS()='BK_ARC'
                   DELETE FOR MONTH(dat)=fms.AND.YEAR(dat)=fgod
                   PACK
                   USE
              ENDIF
         CASE menu_v=2
         CASE menu_v=3
         CASE menu_v=4
         CASE menu_v=5
         ENDCASE
         HIDE WINDOW Pog_p
    ENDIF
ENDCASE
ACTIVATE SCREEN
RETURN