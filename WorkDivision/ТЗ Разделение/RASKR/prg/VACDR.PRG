**************************************************
*File:VACDR.PRG
*Date:
*Version:Home
*Notes:просмотр, добавление, корректировка и удаление!
**************************************************
//
//Private RnameField,nameZdb,nameInd1,nameInd2,nameInd3,nameInd4  ()
//массив имен полей Database,имя Database,имена индексных файлов
//
*-------------------------------------------------
Procedure prVACD( nTop, nLeft, nBottom, nRight )

Local vScreen
Local nCursSave
Local vColorSave
private kll:=0,tt:=0,kras:=0
private fsprav:='';rNvrk1:=0;rNvrk2:=0;rNvrk3:=0;rNvrk4:=0;rNvrk5:=0;rNvrk6:=0  //для последовательности
private fdn:=0;fkodbr:=0;ffkmod:=0;ffnmod:='';ftn:=0;fno:=0                        // для выработки

#include "Inkey.ch"
#include "Setcurs.ch"

#define INS_CURSOR if(ReadInsert(),SC_INSERT,SC_NORMAL)

//режима "append mode" (т.е. режима добавления)
#define TURN_ON_APPEND_MODE(browse)   (browse:cargo := .T.)
#define TURN_OFF_APPEND_MODE(browse)  (browse:cargo := .F.)
#define IS_APPEND_MODE(browse)        (browse:cargo)

SET EXACT ON
if ( ! Used() )
  vScreen:=SaveScreen(7,10,9,70)
  setcolor('w+/n')
  @ 7,10 clear to 9,70
  dispbox(7,10,9,70,2)
  @ 8,22 say'НЕ СУЩЕСТВУЕТ ОТКРЫТОЙ БАЗЫ ДАННЫХ !'
  tone(1000,3)
  tone(0,36)
  RestScreen(7,10,9,70)
  return
end

vScreen:= SaveScreen(nTop,nLeft,nBottom,nRight)

nCursSave:= SetCursor(SC_NONE)


vColorSave:=SetColor('n/n')
@ nTop+1,nLeft+1 clear to nBottom--,nRight--
SetColor(vColorSave)

@ nTop,nLeft clear to nBottom,nRight
@ nTop++,nLeft++,nBottom--,nRight-- box"╒═╕│╛═╘│"
DoTBrowse(nTop,nLeft,nBottom,nRight)  //Pr работа с .obj

SetCursor(nCursSave)

RestScreen(nTop-1,nLeft-1,nBottom+2,nRight+2,vScreen)

SET EXACT OFF
return
*-------------------------------------------------
Procedure DoTBrowse(nTop,nLeft,nBottom,nRight)

Local browse
Local column
Local mainLoop
Local nKey
Local n
Local name_ntx

browse := TBrowseDB(nTop, nLeft, nBottom, nRight)

browse:headSep:="╪═"
browse:colSep:= "│"

browse:skipBlock:={|x| Skipper(x,browse)}

do case
 case clm=1
  if ALIAS()='RAZD'
    for n := 1 to FCount()
     if n>3.and.n<>6.and.n<>7
        column := TBColumnNew(nameField[n],FieldWBlock(Field(n), Select())) //Rus
        browse:addColumn(column)
     endif
    next
  elseif  ALIAS()='WYRAB'
    for n := 1 to FCount()
     if n<>3.and.n<>4.and.n<>7.and.n<>9.and.n<>10.and.n<>11
        column := TBColumnNew(nameField[n],FieldWBlock(Field(n), Select())) //Rus
        browse:addColumn(column)
     endif
    next
  endif
 case clm=2
  for n := 1 to FCount()
      column := TBColumnNew(nameField[n],FieldWBlock(Field(n), Select())) //Rus
      browse:addColumn(column)
   next
endcase
if ALIAS()='RAZD'
  @ 1,2 say 'Модель '
  @ 1,35 say 'Группа ткани '
  @ 1,50 say 'Стоимость 1 изд '
  @ 2,2 say 'Переход'
endif

if ALIAS()='WYRAB'
  @ 1,2 say 'ФИО'
  @ 1,35 say 'Модель'
  @ 2,2 say 'Операция '
endif

if clm=2 .and.ALIAS()='SPRPER'
  @ 2,2 say 'Участок '
  @ 2,20 say 'Переход '
endif

TURN_OFF_APPEND_MODE(browse)

//Main Loop
mainLoop:= .T.
do while mainLoop

  nKey:=0
  do while nKey==0 .and. ! browse:stable
    browse:stabilize()
    nKey:=InKey()
  enddo

  if browse:stable
    if browse:hitBottom .and. ! IS_APPEND_MODE(browse)
      TURN_ON_APPEND_MODE(browse)
      tt:=lastrec()
      if tt<>0.and.clm=1.and.ALIAS()='WYRAB'
         fdn:=dn
         fkodbr:=kodbr
         ffkmod:=kmod
         ffnmod:=nmod
         fTn:=Tn
         fno:=no
      endif
      nKey:=K_DOWN
    else
      if browse:hitTop .or. browse:hitBottom
        tone(125,0)
      endif
      nKey:=InKey(0)
    endif
  endif

  if nKey == K_ESC
    mainLoop:= .F.
  else
    DoInKey(browse,nKey,nBottom)
  endif

enddo
//end Main Loop

name_ntx:=Indexord()


Use
Use (nameZdb) Index (nameInd1),(nameInd2),(nameInd3),(nameInd4)
set order to name_ntx
return
//end работа с TBrowse-obj
//
//****************************
*-------------------------------------------------
Static Procedure DoInKey(browse,nKey,nBottom)
   local nrow,ncol
do case

  case nKey == K_F1
    ListHelp()

  case nKey == K_F2
    IF ALIAS()=="WYRAB"
       vybor("sprtn")
       browse:refreshAll()
    ELSEIF ALIAS()=="SPRMOD"
       go top
       SET ORDER TO 1
       browse:refreshAll()
     ELSE
       IF ALIAS()="SPRTN"
         ftn:=0
         @ 10,23 clear to 14,68
         dispbox(10,23,14,68,3)
         setcolor('w+/n')
         prcolor:=setcolor()
         setcursor(INS_CURSOR)
         @ 11,25 say "Табельный номер:" get fTn color'w+/n' picture "@B 9999"
         READ
         setcursor(SC_NONE)
         go top
         Locate for TN=ftn
         if !found()
           @ 13,25 say 'Нет такого табельного номера' color'w+/r+'
           wait ""
           @ 13,25 clear to 12,52
         else
           browse:refreshAll()
         endif
          setcolor(prcolor)
       ENDIF
    ENDIF

     IF ALIAS()=='RAZD'
       vv_perex()
       browse:refreshAll()
     ENDIF

  case nKey == K_F3
    IF ALIAS()=='RAZD'
      red_perex()
    ENDIF
    IF ALIAS()=='WYRAB'
      vScreen:= SaveScreen()
      vColorSave:=SetColor()
      vyb_per()
       select 1
       field->no:=val(kod_as)
      SetColor(vColorSave)
      RestScreen(0,0,maxRow(),maxCol(),vScreen)
      browse:refreshAll()
    ENDIF

  case nKey == K_F4
    IF ALIAS()=='RAZD'
      nz:=recno()
      STOIMOBR()
      go nz
    ENDIF
  case nKey == K_F5
    IF ALIAS()=='RAZD'
      PRAZD()
    ELSEIF ALIAS()='SPRTN'
      prPRN()
    ENDIF
  case nKey == K_DOWN
    browse:Down()

  case nKey == K_PGDN
    browse:pageDown()

  case nKey == K_CTRL_PGDN
    browse:goBottom()

  case nKey == K_UP
    browse:Up()
      if IS_APPEND_MODE(browse)
        TURN_OFF_APPEND_MODE(browse)
        browse:refreshAll()
      endif

  case nKey == K_PGUP
    browse:pageUp()
      if IS_APPEND_MODE(browse)
        TURN_OFF_APPEND_MODE(browse)
        browse:refreshAll()
      endif

  case nKey == K_CTRL_PGUP
    browse:goTop()
      if IS_APPEND_MODE(browse)
        TURN_OFF_APPEND_MODE(browse)
        browse:refreshAll()
      endif

  case nKey == K_LEFT
    browse:Left()

  case nKey == K_CTRL_HOME
    browse:Home()

  case nKey == K_HOME
    browse:panHome()

  case nKey == K_RIGHT
    browse:Right()

  case nKey == K_CTRL_END
    browse:End()

  case nKey == K_END
    browse:panEnd()

  case nKey == K_CTRL_LEFT
    browse:panLeft()

  case nKey == K_CTRL_RIGHT
    browse:panRight()

  case nKey == K_F8
    DoDel(browse,nBottom)

  case nKey == K_F9
    DoDelAll(browse,nBottom)

  case nKey == K_F10
    if clm=1.and.ALIAS()='WYRAB'
      kll:=1
    endif
    DoGetZ(browse)

  case nKey == K_ENTER
    if ALIAS()='WYRAB'
      DoGetZ(browse)
    else
      DoGet(browse)
    endif
  otherwise
    Keyboard Chr(nKey)
    if ALIAS()='WYRAB'
      DoGetZ(browse)
    else
      DoGet(browse)
    endif
endcase
return
//

*-------------------------------------------------
 Static Procedure DoDel(browse,nBottom)

Local vScr:=SaveScreen(nBottom+2,24,nBottom+2,67),nz:=0
Local nrow,ncol

  @ nBottom+2,23 say ' Удалить текущую запись?   ( Y/N; Д/Н ) ' color'w+/n'
  InKey(0)
  if Lastkey()==121 .or. Lastkey()==89.or. Lastkey()==132 .or. Lastkey()==164
   @ nBottom+2,23 say '      Ждите!   Идет удаление!      ' color'w+*/n'
    nz:=recno()-1
    nrow:=row()
    ncol:=col()
     delete
     pack
     browse:refreshAll()
     if Lastrec()<>reccount()
       SETPOS(nrow,ncol)
     else
       SETPOS(nrow-1,ncol)
     endif
  else
     browse:refreshCurrent()
  endif
  RestScreen(nBottom+2,20,nBottom+2,61,vScr)
return
//

*-------------------------------------------------
Static Procedure DoDelAll(browse,nBottom)

Local vScr:=SaveScreen(nBottom+2,20,nBottom+2,60)

@ nBottom+2,24 say ' Удалить все записи ?   ( Y/N,Д/Н ) ' color'w+/n'
InKey(0)
if Lastkey()==121 .or. Lastkey()==89.or. Lastkey()==132 .or. Lastkey()==164
   @ nBottom+2,23 say '      Ждите!   Идет удаление!      ' color'w+*/n'
   delete all
   pack
   do while ! browse:stabilize() ; enddo
else
   browse:refreshCurrent()
endif
RestScreen(nBottom+2,20,nBottom+2,61,vScr)

return
//

*-------------------------------------------------
*-------------------------------------------------
Static Procedure DoGet(browse)

Local bIns,lTalk,lExit  //установки
Local xOldKey,xNewKey
Local lAppend,fmd,vscreen
Local name_col,get

Local vColors,fnaim:='',nz:=0

Local dkl:=0,dnkl:=0,d1:=0,dm:=0,ds:=0,dk:=0,nvrm:=0,nvrs:=0,nvrk:=0,rnvrk:=0
Private ahelp:=0

kod_as1:=nil
fper:=0

SET EXACT ON

lAppend:=IS_APPEND_MODE(browse)
if lAppend .and.(Recno()==LastRec()+1)
   Append Blank
   if clm=1
     if ALIAS()='RAZD'
        razd->ms:=mm
        razd->kmod:=fkod
        razd->nmod:=fnmod
        razd->koef:=1
        razd->kr:=1
     endif
   else
    IF clm=2.and.ALIAS()="SPRMOD"
       vscreen:=savescreen(3,4,21,75)
       vcolors:=Setcolor()
         PROSM_MOD()
       restscreen(3,4,21,75,vscreen)
       Setcolor(vcolors)
       field->Ei:='шт'
     endif
   endif

   TURN_OFF_APPEND_MODE(browse)
   browse:refreshCurrent()
endif
kll:=0

SetCursor(INS_CURSOR)

bIns:=SetKey( K_INS,;
            {|| ReadInsert(! ReadInsert() ),SetCursor(INS_CURSOR) } )

Set(_SET_SCOREBOARD, .F.)
Set(_SET_EXIT, .T.)
Set(_SET_ESCAPE,.T.)
   //Set(_SET_DELIMITERS,.F.)    //разделитель
Set(_SET_CONFIRM,.F.)

xOldKey:=if (Empty(IndexKey()), NIL, &(IndexKey()) )

name_col:=browse:getColumn(browse:colPos)
get:=GetNew(Row(),Col(),name_col:block,name_col:heading)

  do case
     case name_col[6]= 'Норма;врем.;(1м)'.and.substr(field->naim,1,13)='Проверить по '      //общая выраб., бригада
       vscreen:=SaveScreen(,,,)
       vyb_nvr("sprnormk")
       RestScreen(,,,,vscreen)
       select razd
       if kod_as<>nil.and.kod_as1<>nil.and.assort<>nil
         replace field->grtk with val(kod_as),;
                 field->Dlk with val(kod_as1),;
                 field ->nvr with val(assort)
       endif
       browse:refreshCurrent()
       @ 1,48 say razd->grtk color'w+/r'

     case name_col[6]= 'Норма;врем.;(1м)'.and.substr(naim,1,9)='Настелить'      //общая выраб., бригада
       vscreen:=SaveScreen(,,,)
       vyb_nvr("sprnormn")
       RestScreen(,,,,vscreen)
       select razd
       if kod_as1<>nil
         replace field->vidtk with kod_as,;
                 field->nvr with val(kod_as1)
       endif
       browse:refreshCurrent()

   case name_col[6]= 'Норма;врем.;(1м)'.and.substr(naim,1,21)='Сделать расчет кусков'      //общая выраб., бригада
       vscreen:=SaveScreen(,,,)
       vyb_nvr("sprras")
       RestScreen(,,,,vscreen)
       select razd
       if assort<>nil
         replace field->nvr with val(assort)
       endif
       browse:refreshCurrent()

   case name_col[6]= 'Код;проф;'.and.ALIAS()='SPRTN'
       vscreen:=SaveScreen(,,,)
       vybor("sprprof")
       RestScreen(,,,,vscreen)
       browse:refreshCurrent()

   case name_col[6]= 'Гр.;тка;ни'
     nKey:=Inkey(0)
     if nKey==K_F1
        ahelp:=1
        ListHelp()
     endif
   case name_col[6]= 'Кол;детал;полот.'
     nKey:=Inkey(0)
     if nKey==K_F1
        ahelp:=2
        ListHelp()
     endif
   case name_col[6]= 'Расх;ткани;1изд.'
     nKey:=Inkey(0)
     if nKey==K_F1
        ahelp:=2
        ListHelp()
     endif
   case name_col[6]= 'Кра;тно;сть'
     nKey:=Inkey(0)
     if nKey==K_F1
        ahelp:=3
        ListHelp()
     endif
   case name_col[6]= 'Вид;ткани'
     nKey:=Inkey(0)
     if nKey==K_F1
        ahelp:=4
        ListHelp()
     endif
endcase

ReadModal( {get} )

  if ALIAS()='RAZD'
   if !ISUPPER(naim)
     nz:=recno()
     fper:=per
     go top
     locate for per=fper
     fnaim:=naim
     if AT('Проверить настил',fnaim)<>0.or.AT('Ознакомиться с перечн',fnaim)<>0
      skip
      fnaim:=fnaim+' '+naim
     endif
     go nz
   else
     fnaim:=naim
     fper:=per
   endif
  endif
 DO CASE
   case name_col[6]= 'Раз;ряд'.and.clm=1
    do case
       case AT('Пронумеровать',fnaim)<>0
         vScreen:=SaveScreen()
         vcolors:=Setcolor()
         nrow:=ROW()
         ncol:=COL()
         setcolor('w+/b+')
         @ 7,20 clear to 15,58
         dispbox(7,20,15,58,6)
         @ 8,22 say  'Кол-во клеящихся деталей     :' get dkl picture '999'
         @ 10,22 say 'Кол-во неклеящихся деталей   :' get dnkl picture '999'
         @ 12,22 say 'Кол-во деталей с ном.1 и посл:' get d1 picture '999'
          read
         replace field->Nvr with (4.49*dkl*2.5+4.49*dnkl*1.05+d1*1.57)
         select s_tarif
         go top
          Locate for rz=razd->rz
          if found()
           select razd
           replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
           replace field->Nvri with Round(Nvr/kr,2),;
                   field->Rasci with Round(rasc/kr,5)
          else
           FTR()
           select razd
          endif
         RestScreen(,,,,vScreen)
         SETCOLOR(vcolors)
         SETPOS(nrow,ncol)
         browse:refreshCurrent()
         @ 1,66 say razd->rasci color'w+/r'

       case AT('Подобрать тем',fnaim)<>0
         vScreen:=SaveScreen()
         vcolors:=Setcolor()
         nrow:=ROW()
         ncol:=COL()
         setcolor('w+/b+')
         @ 7,15 clear to 15,69
         dispbox(7,15,15,69,6)
          nvrm:=14.56
          nvrs:=20.91
          nvrk:=27.25
         @ 8,17 say 'Кол-во мелких деталей  :' get dm picture '999'
                  //read
         @ 8,46 say 'Норма времени :' get nvrm picture '999.99'
                  //read
         @ 10,17 say 'Кол-во средних деталей :' get ds picture '999'
                  // read
         @ 10,46 say 'Норма времени :' get nvrs picture '999.99'
                  // read
         @ 12,17 say 'Кол-во крупных деталей :' get dk picture '999'
                  //read
         @ 12,46 say 'Норма времени :' get nvrk picture '999.99'
          read
         replace field->Nvr with nvrm*dm + nvrs*ds + nvrk*dk
         select s_tarif
         go top
          Locate for rz=razd->rz
          if found()
           select razd
           replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
           replace field->Nvri with Round(Nvr*kr,2),;
                   field->Rasci with Round(rasc*kr,5)
           @ 1,66 say razd->rasci color'w+/r'
          else
           FTR()
          endif
         RestScreen(,,,,vScreen)
         SETCOLOR(vcolors)
         SETPOS(nrow,ncol)
         browse:refreshCurrent()

       case AT('Проверить настил',fnaim)<>0.and.AT('кроя верха',fnaim)<>0
         nz:=recno()
         vScreen:=SaveScreen()
         vcolors:=Setcolor()
         nrow:=ROW()
         ncol:=COL()
         setcolor('w+/b+')
         @ 18,14 clear to 22,50
         dispbox(18,14,22,50,1)
         perim:=0
         nvrr:=0
         kras:=2.028         //  1,3*1,3*1,2
         rrz:=0
         @ 19,15 say 'Периметр   :' get perim picture '9999.99'
         @ 21,15 say 'Коэффициет :' get kras picture '9.999'
          read
         RestScreen(,,,,vScreen)
         SETCOLOR(vcolors)
         SETPOS(nrow,ncol)
         select s_tarif
          go top
         Locate for rz=razd->rz
         if found()
           select razd
           rrz:=rz
           GRADR()
           browse:refreshALL()
                //do while ! browse:stabilize() ; enddo
           go nz
           @ 1,66 say razd->rasci color'w+/r'
         else
           FTR()
         endif

       case AT('Вырезать детали кроя',fnaim)<>0.and.AT('верха',fnaim)=0
         vScreen:=SaveScreen()
         vcolors:=Setcolor()
         nrow:=ROW()
         ncol:=COL()
         setcolor('w+/b+')
         @ 18,14 clear to 22,50
         dispbox(18,14,22,50,1)
         perim:=0
         kras:=2.028
         @ 19,15 say 'Периметр  :' get perim picture '9999.99'
         @ 21,15 say 'Коэффициет сложности:' get kras picture '9.999'
          read
         RestScreen(,,,,vScreen)
         SETCOLOR(vcolors)
         SETPOS(nrow,ncol)
         replace field->Nvr with perim*0.5*kras/20
         rnvrk:=Nvr
         select s_tarif
           go top
           Locate for rz=razd->rz
         if found()
           select razd
            replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
            replace field->Nvri with Round(Nvr*IIF(rasxtk<>0,rasxtk,1),2),;
                    field->Rasci with Round(rasc*kr,5)
           @ 1,66 say razd->rasci color'w+/r'
         else
           FTR()
         endif
         nz:=recno()

         do case
           case AT('подкладки',naim)<>0
             Locate for AT('скомплектовать',naim)<>0.and.AT('подкладки',naim1)<>0
             if found()
               replace field->Nvr with rnvrk*0.3,;
                       field->Rz with 5
               select s_tarif
                go top
                Locate for rz=razd->rz
                if found()
                 select razd
                 replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
                 replace field->Nvri with Round(Nvr,2),;
                         field->Rasci with Round(rasc*kr,5)
                else
                 FTR()
                endif
             endif
           case AT('флезилин',naim)<>0.or.AT('прокламелин',naim)<>0
             Locate for AT('скомплектовать',naim)<>0.and.(AT('флезилин',naim1)<>0.or.AT('прокламелин',naim1)<>0)
             if found()
               replace field->Nvr with rnvrk*0.1,;
                       field->Rz with 5
               select s_tarif
                go top
                Locate for rz=razd->rz
                if found()
                 select razd
                 replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
                 replace field->Nvri with Round(Nvr,2),;
                         field->Rasci with Round(rasc*kr,5)
                else
                 FTR()
                endif
             endif
         endcase
         browse:refreshALL()
               //do while ! browse:stabilize() ; enddo
         go nz


       case AT('Сложить',fnaim)<>0.and.AT('для осноровки',fnaim)<>0
         vScreen:=SaveScreen()
         vcolors:=Setcolor()
         nrow:=ROW()
         ncol:=COL()
         setcolor('w+/b+')
         @ 18,14 clear to 22,50
         dispbox(18,14,20,50,1)
         perim:=0
         @ 19,15 say 'Количество деталей  :' get perim picture '9999'
          read
         RestScreen(,,,,vScreen)
         SETCOLOR(vcolors)
         SETPOS(nrow,ncol)
         replace field->Nvr with nvr*perim
         select s_tarif
          go top
         Locate for rz=razd->rz
         if found()
           select razd
            replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
            replace field->Nvri with Round(Nvr/kr,2),;
                    field->Rasci with Round(rasc/kr,5)
           browse:refreshcurrent()
           @ 1,66 say razd->rasci color'w+/r'
         else
           FTR()
         endif

       case AT('Осноровить',fnaim)<>0.and.AT('детали',fnaim)<>0
         vScreen:=SaveScreen()
         vcolors:=Setcolor()
         nrow:=ROW()
         ncol:=COL()
         setcolor('w+/b+')
         @ 18,14 clear to 22,50
         dispbox(18,14,22,50,1)
         perim:=0
         kras:=2.028
         @ 19,15 say 'Периметр  :' get perim picture '9999.99'
         @ 21,15 say 'Коэффициет сложности:' get kras picture '9.999'
          read
         RestScreen(,,,,vScreen)
         SETCOLOR(vcolors)
         SETPOS(nrow,ncol)
         replace field->Nvr with perim*0.5*kras/20
         select s_tarif
          go top
         Locate for rz=razd->rz
         if found()
           select razd
            replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
            replace field->Nvri with Round(Nvr/kr,2),;
                    field->Rasci with Round(rasc/kr,5)
           browse:refreshcurrent()
           @ 1,66 say razd->rasci color'w+/r'
         else
           FTR()
         endif
    endcase

   case  name_col[6]= 'Норма;врем.;(1м)'.and.clm=1
     select s_tarif
     go top
     Locate for rz=razd->rz
     if found()
       select razd
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       do case
          case AT('Настелить',fnaim)<>0
             replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1)*s_tarif->k_sd/kr,5)
             replace field->Nvri with Round(Nvr*IIF(rasxtk<>0,rasxtk,1),2),;
                     field->Rasci with Round(rasc*IIF(rasxtk<>0,rasxtk,1)*kr,5)
             @ 1,66 say razd->rasci color'w+/r'

          case AT('обмеловку',fnaim)<>0
            replace field->Nvri with Round(Nvr/IIF(kol_det<>0,kol_det,1),2),;
                    field->Rasci with Round(rasc/IIF(kol_det<>0,kol_det,1),5)
            @ 1,66 say razd->rasci color'w+/r'

          case AT('Пронумеровать',fnaim)<>0
            replace field->Nvri with Round(Nvr/kr,2),;
                    field->Rasci with Round(rasc/kr,5)
            @ 1,66 say razd->rasci color'w+/r'

       otherwise
          replace field->Nvri with Round(Nvr*IIF(rasxtk<>0,rasxtk,1)*kr,2),;
                  field->Rasci with Round(rasc*IIF(rasxtk<>0,rasxtk,1)*kr,5)
          @ 1,66 say razd->rasci color'w+/r'
       endcase
       browse:refreshCurrent()
     else
       FTR()
     endif

   case name_col[6]= 'Ра;зр;'
     IF UPDATED()
      SELECT S_TARIF
      LOCATE for field->rz=razd->rz
      IF FOUND()
       SELECT RAZD
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       replace field->Nvri with Round(Nvr*IIF(rasxtk<>0,rasxtk,1)*kr,2),;
               field->Rasci with Round(rasc*IIF(rasxtk<>0,rasxtk,1)*kr,5)
       browse:refreshCurrent()
      ELSE
       FTR()
      ENDIF
     ENDIF

   case name_col[6]= 'Кол;ра-;бот'
     IF UPDATED()
       replace field->Rasc with Round(rasc*IIF(kr<>0,kr,1),5),;
               field->Nvri with Round(Nvr*IIF(rasxtk<>0,rasxtk,1)*kr,2),;
               field->Rasci with Round(rasc*IIF(rasxtk<>0,rasxtk,1)*kr,5)
       browse:refreshCurrent()
     ENDIF

    case name_col[6]= 'Наименование;модели'.and.noms=1
      nz:=RECNO()
      fmd:=nmod
      GO TOP
      Locate  for nmod=fmd
      if found().and.recno()<>nz
       vScreen:=SaveScreen(12,10,12,31)
       @ 12,10 SAY 'ТАКАЯ МОДЕЛЬ УЖЕ ЕСТЬ ' color'W+/R'
       wait""
       RestScreen(12,10,12,31,vScreen)
       go nz
      endif
 ENDCASE

xNewKey := if( Empty(IndexKey()), NIL, &(IndexKey()) )

if ! (xNewKey == xOldKey) .or. (lAppend .and. xNewKey != NIL)
  browse:refreshAll()
  do while ! browse:stabilize() ; enddo

  do while &(IndexKey()) != xNewKey
    if &(IndexKey()) > xNewKey
      browse:Up()
    elseif &(IndexKey()) < xNewKey
      browse:Down()
    endif

    do while ! browse:stabilize() ; enddo
  enddo
else
  browse:refreshCurrent()
  do while ! browse:stabilize() ; enddo
endif

nKey:=LastKey()
if nKey==K_UP .or. nKey==K_DOWN .or. nKey==K_PGUP .or. nKey==K_PGDN
  Keyboard Chr(nKey)
elseif nKey==K_ENTER
 browse:right()
else
  nKey:=InKey(0)
  if nKey==K_ENTER
    browse:right()
  else
    Keyboard Chr(nKey)
endif
endif

SetCursor(SC_NONE)
SetKey(K_INS, bIns)

SET EXACT OFF
return
//

//*-------------------------------------------------
Static Procedure DoGetZ(browse)

Local bIns,lTalk,lExit
Local xOldKey,xNewKey
Local lAppend,fmd,vscreen,vcolors    
Local name_col,get,nrow,ncol,rezult:=.F.,kolp:=0

SET EXACT ON

lAppend:=IS_APPEND_MODE(browse)

if lAppend .and.(Recno()==LastRec()+1).and.kll=1.and.clm=1
  Append Blank
  if tt<>0
    field->ms:=mm
    field->dn:=fdn
    field->kodbr:=fkodbr
    field->kmod:=ffkmod
    field->nmod:=ffnmod
    field->Tn:=fTn
    browse:refreshCurrent()
    TURN_OFF_APPEND_MODE(browse)
    nKey:=0
      do while nKey==0 .and. ! browse:stable
        browse:stabilize()
        nKey:=InKey()
     enddo
  else
   Append Blank
   if ALIAS()='WYRAB'.and.clm=1
       wyrab->ms:=mm
    endif
    browse:refreshCurrent()
    TURN_OFF_APPEND_MODE(browse)
  endif
endif

if lAppend .and.(Recno()==LastRec()+1).and.kll=0
   Append Blank
   if clm=1.and. ALIAS()='WYRAB'
       wyrab->ms:=mm
   else
    IF clm=2.and.ALIAS()="SPRMOD"
       vscreen:=savescreen(3,4,21,75)
       vcolors:=Setcolor()
         PROSM_MOD()
       restscreen(3,4,21,75,vscreen)
       Setcolor(vcolors)
       field->Ei:='шт'
    ENDIF
   endif

   browse:refreshCurrent()
   TURN_OFF_APPEND_MODE(browse)
endif
kll:=0

SetCursor(INS_CURSOR)

bIns:=SetKey( K_INS,;
            {|| ReadInsert(! ReadInsert() ),SetCursor(INS_CURSOR) } )

Set(_SET_SCOREBOARD, .F.)
Set(_SET_EXIT, .T.)
Set(_SET_ESCAPE,.T.)
   //Set(_SET_DELIMITERS,.F.)    //разделитель
Set(_SET_CONFIRM,.F.)            //подтверждение ввода Get

xOldKey:=if (Empty(IndexKey()), NIL, &(IndexKey()) )

name_col:=browse:getColumn(browse:colPos)
get:=GetNew(Row(),Col(),name_col:block,name_col:heading)
do case

   case name_col[6]= 'Наим.модели'.and.ALIAS()='WYRAB'
       vscreen:=SaveScreen(,,,)
       vyb_ass("sprmod")
       RestScreen(,,,,vscreen)
       select wyrab
       if assort<>nil
         replace field->kmod with val(kod_as)
         replace field->nmod with assort
       endif
       @ 1,42 SAY nmod color'W+/R'
       browse:refreshCurrent()

endcase

ReadModal( {get} )

DO CASE
   case  name_col[6]= 'Таб;ном'.and.ALIAS()='WYRAB'
     vyb_fam()
     field->FI:= sprtn->FI
     field->kodbr:=sprtn->kodbr
   case name_col[6]= 'Номер;опер.'.and.clm=1
     select razd
     go top
     locate for alltrim(wyrab->nmod)=alltrim(nmod).and.wyrab->No=per
     if found()
       if AT('Проверить настил по длине',naim)<>0.or.AT('Ознакомиться с перечнем деталей',naim)<>0
         vScreen:=SaveScreen()
         vcolors:=Setcolor()
         nrow:=ROW()
         ncol:=COL()
         setcolor('w+/b+')
         @ 18,14 clear to 22,50
         dispbox(18,14,22,50,1)
         kolp:=0
         @ 19,15 say 'Количество полотен: ' get kolp picture '999'
          read
         RestScreen(,,,,vScreen)
         SETCOLOR(vcolors)
         SETPOS(nrow,ncol)
         skip 2
         rezult:=.T.
         Do while wyrab->No=per.and.rezult
           npos:=AT('-',naim)
           if kolp<=20
             if kolp>=val(substr(naim,1,1)).and.kolp<=val(substr(naim,npos+1,2))
                rezult:=.F.
             endif
           else
             if kolp>20.and.kolp<100
              if kolp>=val(substr(naim,1,2)).and.kolp<=val(substr(naim,npos+1,2))
                  rezult:=.F.
               endif
             else
               if kolp>=val(substr(naim,1,3))
                 rezult:=.F.
               endif
             endif
           endif
          skip
         enddo
         if rezult
           @ 2,20 SAY "Неправильная градация" color'W+/R'
           wait ""
           @ 2,20 clear to 2,40
         endif
       endif
       select wyrab
       field->naim:=razd->naim
       field->naim1:=razd->naim1
       field->nst:=razd->nst
       ?no
       ?nst
       wait""
       @ 2,12 SAY naim+naim1
       if razd->rasc=0.and.rezult=.F.
        select razd
         Locate for alltrim(wyrab->nmod)=alltrim(nmod).and.wyrab->No=per.and.rasc<>0
         select wyrab
       endif
       if razd->rasxtk<>0
         field->rasc:=razd->rasci
         field->vr:=razd->nvri
       else
         field->rasc:=razd->rasc
         field->vr:=razd->nvr
       endif
     else
       select wyrab
       @ 2,20 SAY "Нет такой операции" color'W+/R'
       wait ""
       @ 2,20 clear to 2,37
     endif
     browse:refreshCurrent()
    case name_col[6]= 'Наименование;модели'.and.noms=1
      nz:=RECNO()
      fmd:=nmod
      GO TOP
      Locate  for nmod=fmd
      if found().and.recno()<>nz
       vScreen:=SaveScreen(12,10,12,31)
       @ 12,10 SAY 'ТАКАЯ МОДЕЛЬ УЖЕ ЕСТЬ ' color'W+/R'
       wait""
       RestScreen(12,10,12,31,vScreen)
       go nz
      endif
 ENDCASE

xNewKey := if( Empty(IndexKey()), NIL, &(IndexKey()) )

if ! (xNewKey == xOldKey) .or. (lAppend .and. xNewKey != NIL)
  browse:refreshAll()
  do while ! browse:stabilize() ; enddo

  do while &(IndexKey()) != xNewKey
    if &(IndexKey()) > xNewKey
      browse:Up()
    elseif &(IndexKey()) < xNewKey
      browse:Down()
    endif

    do while ! browse:stabilize() ; enddo
  enddo
else
  browse:refreshCurrent()
  do while ! browse:stabilize() ; enddo
endif

nKey:=LastKey()
if nKey==K_UP .or. nKey==K_DOWN .or. nKey==K_PGUP .or. nKey==K_PGDN
  Keyboard Chr(nKey)
elseif nKey==K_ENTER
 browse:right()
 DO CASE
    case name_col[6]= 'Таб;ном'.and.clm=1.and.ALIAS()="WYRAB"                       // выраб., таб.номер
       nKey:=Inkey(0)
    case name_col[6]= 'Номер;опер.'.and.ALIAS()="WYRAB"                             // выраб., таб.номер
       nKey:=Inkey(0)
 ENDCASE
else
  nKey:=InKey(0)
  if nKey==K_ENTER
    browse:right()
    DO CASE
      case name_col[6]= 'Таб;ном'.and.clm=1.and.ALIAS()="WYRAB"                       // выраб., таб.номер
        nKey:=Inkey(0)
      case name_col[6]= 'Номер;опер.'.and.ALIAS()="WYRAB"                             // выраб., таб.номер
        nKey:=Inkey(0)
    ENDCASE
 else
  Keyboard Chr(nKey)
  endif
endif

SetCursor(SC_NONE)
SetKey(K_INS, bIns)

SET EXACT OFF
return
//

*-------------------------------------------------
*-------------------------------------------------
PROCEDURE FTR()
 Local vScr
  vScr:=SaveScreen(12,10,12,55)
  @ 12,10 SAY 'ПРОВЕРЬТЕ ВВОДИМЫЙ РАЗРЯД ИЛИ ТАРИФНУЮ СТАВКУ ' color'W+/R'
    wait ""
  RestScreen(12,10,12,55,vScr)
  select razd
return
*--------------------------------------------------

PROCEDURE GRADR()
  Local rNvr:=0

  rNvr:=perim*0.67*kras/20
  do case
     case alltrim(substr(naim,1,2))='5-'
       replace field->Nvr with rNVr
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
       replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
       rnVrk1:=rNvr/2
       skip
       do while fper=per
        do case
           case alltrim(substr(naim,1,2))='21'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3
             rnVrk2:=Nvr/2
           case alltrim(substr(naim,1,2))='41'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^2
             rnVrk3:=Nvr/2
           case alltrim(substr(naim,1,2))='61'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^3
             rnVrk4:=Nvr/2
           case alltrim(substr(naim,1,2))='81'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^4
             rnVrk5:=Nvr/2
           case alltrim(substr(naim,4,3))='101'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^5
             rnVrk6:=Nvr/2
        endcase
        replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
        replace field->Nvri with Round(Nvr,2),;
                field->Rasci with Round(rasc*kr,5)
        skip
       enddo
     case alltrim(substr(naim,1,2))='21'
       replace field->Nvr with rNVr/1.3
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
       replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
       rnVrk2:=Nvr/2
       skip
       do while fper=per
        do case
           case alltrim(substr(naim,1,2))='41'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^2
             rnVrk3:=Nvr/2
           case alltrim(substr(naim,1,2))='61'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^3
             rnVrk4:=Nvr/2
           case alltrim(substr(naim,1,2))='81'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^4
             rnVrk5:=Nvr/2
           case alltrim(substr(naim,4,3))='101'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^5
             rnVrk6:=Nvr/2
        endcase
        replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
        replace field->Nvri with Round(Nvr,2),;
                field->Rasci with Round(rasc*kr,5)
        skip
       enddo
     case alltrim(substr(naim,1,2))='41'
       replace field->Nvr with rNVr/1.3^2
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
       replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
       rnVrk3:=Nvr/2
       skip
       do while fper=per
        do case
           case alltrim(substr(naim,1,2))='61'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^3
             rnVrk4:=Nvr/2
           case alltrim(substr(naim,1,2))='81'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^4
             rnVrk5:=Nvr/2
           case alltrim(substr(naim,4,3))='101'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^5
             rnVrk6:=Nvr/2
        endcase
        replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
        replace field->Nvri with Round(Nvr,2),;
                field->Rasci with Round(rasc*kr,5)
        skip
       enddo
     case alltrim(substr(naim,1,2))='61'
       replace field->Nvr with rNVr/1.3^3
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
       replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
       rnVrk4:=Nvr/2
       skip
       do while fper=per
        do case
           case alltrim(substr(naim,1,2))='81'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^4
             rnVrk5:=Nvr/2
           case alltrim(substr(naim,4,3))='101'
             replace rz with rrz
             replace field->Nvr with rNvr/1.3^5
             rnVrk6:=Nvr/2
        endcase
        replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
        replace field->Nvri with Round(Nvr,2),;
                field->Rasci with Round(rasc*kr,5)
        skip
       enddo
     case alltrim(substr(naim,1,2))='81'
       replace field->Nvr with rNVr/1.3^4
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
       replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
       rnVrk5:=Nvr/2
       skip
       if fper=per.and. alltrim(substr(naim,4,3))='101'
             replace rz with rrz
          replace field->Nvr with rNvr/1.3^5
          rnVrk6:=Nvr/2
          replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
          replace field->Nvri with Round(Nvr,2),;
                  field->Rasci with Round(rasc*kr,5)
       endif
     case alltrim(substr(naim,4,3))='101'
       replace rz with rrz
       replace field->Nvr with rNvr/1.3^5
       rnVrk6:=Nvr/2
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*koef,5)
       replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
   endcase
   Locate for AT('скомплектовать детали кроя верха',naim)<>0
   if found()
    skip
    fper:=per
    GRADK()
   endif
return

//***********************************
PROCEDURE GRADK()
  do case
     case alltrim(substr(naim,1,2))='5-'
       replace field->Nvr with rNvrk1
       replace field->Rasc with Round(Nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       replace field->Nvri with Round(Nvr,2),;
          field->Rasci with Round(rasc*kr,5)
       skip
       do while fper=per
       do case
         case alltrim(substr(naim,1,2))='21'
           replace rz with rrz
           replace field->Nvr with rNvrk2
         case alltrim(substr(naim,1,2))='41'
           replace rz with rrz
           replace field->Nvr with rNvrk3
         case alltrim(substr(naim,1,2))='61'
           replace rz with rrz
           replace field->Nvr with rNvrk4
         case alltrim(substr(naim,1,2))='81'
           replace rz with rrz
           replace field->Nvr with rNvrk5
         case alltrim(substr(naim,4,3))='101'
           replace rz with rrz
           replace field->Nvr with rNvrk6
       endcase
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
        skip
       enddo
     case alltrim(substr(naim,1,2))='21'
       replace field->Nvr with rNvrk2
       replace field->Rasc with Round(Nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       replace field->Nvri with Round(Nvr,2),;
          field->Rasci with Round(rasc*kr,5)
       skip
       do while fper=per
       do case
         case alltrim(substr(naim,1,2))='41'
           replace rz with rrz
           replace field->Nvr with rNvrk3
         case alltrim(substr(naim,1,2))='61'
           replace rz with rrz
           replace field->Nvr with rNvrk4
         case alltrim(substr(naim,1,2))='81'
           replace rz with rrz
           replace field->Nvr with rNvrk5
         case alltrim(substr(naim,4,3))='101'
           replace rz with rrz
           replace field->Nvr with rNvrk6
       endcase
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
        skip
       enddo
     case alltrim(substr(naim,1,2))='41'
       replace field->Nvr with rNvrk3
       replace field->Rasc with Round(Nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       replace field->Nvri with Round(Nvr,2),;
          field->Rasci with Round(rasc*kr,5)
       skip
       do while fper=per
       do case
         case alltrim(substr(naim,1,2))='61'
           replace rz with rrz
           replace field->Nvr with rNvrk4
         case alltrim(substr(naim,1,2))='81'
           replace rz with rrz
           replace field->Nvr with rNvrk5
         case alltrim(substr(naim,4,3))='101'
           replace rz with rrz
           replace field->Nvr with rNvrk6
       endcase
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
        skip
       enddo
     case alltrim(substr(naim,1,2))='61'
       replace field->Nvr with rNvrk4
       replace field->Rasc with Round(Nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       replace field->Nvri with Round(Nvr,2),;
          field->Rasci with Round(rasc*kr,5)
       skip
       do while fper=per
       do case
         case alltrim(substr(naim,1,2))='81'
           replace rz with rrz
           replace field->Nvr with rNvrk5
         case alltrim(substr(naim,4,3))='101'
           replace rz with rrz
           replace field->Nvr with rNvrk6
       endcase
       replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
        skip
       enddo
     case alltrim(substr(naim,1,2))='81'
       replace field->Nvr with rNvrk5
       replace field->Rasc with Round(Nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
       replace field->Nvri with Round(Nvr,2),;
          field->Rasci with Round(rasc*kr,5)
       skip
       if alltrim(substr(naim,4,3))='101'
         replace rz with rrz
         replace field->Nvr with rNvrk6
         replace field->Rasc with Round(Nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
         replace field->Nvri with Round(Nvr,2),;
            field->Rasci with Round(rasc*kr,5)
         replace field->Rasc with Round(nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
         replace field->Nvri with Round(Nvr,2),;
               field->Rasci with Round(rasc*kr,5)
       endif
     case alltrim(substr(naim,4,3))='101'
         replace field->Nvr with rNvrk6
         replace field->Rasc with Round(Nvr*s_tarif->Tar_vr*IIF(koef<>0,koef,1),5)
         replace field->Nvri with Round(Nvr,5)
   endcase
return

//***********************************
 Function Skipper(n,browse)
//перемещение указателя записи на текущий .obj
//кол-во перемещений == "числу" перемещений указателя.obj по Database,
//ему-> на сколько н.S; он-> на сколько произошло S;
Local lAppend
Local i

Local fper
lAppend:=IS_APPEND_MODE(browse)
i:=0

if n == 0 .or. LastRec() == 0
  skip 0  //ук-тель записи не перемещать

elseif n > 0 .and. Recno() != LastRec() + 1
  do while i < n
    skip 1
    if ALIAS()='RAZD'
       @ 1,10 say razd->nmod color'w+/r'
       if grtk<>0
         @ 1,48 say razd->grtk color'w+/r'
       else
         @ 1,48 clear to 1,48
       endif
       @ 1,66 say razd->rasci color'w+/r'
       @ 2,10 say razd->per color'w+/b+'

      if fper<>per.and.naim<>' '
       @ 3,01 say razd->naim color'w+/B+'
       @ 3,COL() say razd->naim1 color'w+/B+'
       fper:=per
      endif
    endif
    if clm=2 .and.ALIAS()='SPRPER'
       @ 2,11 say sprper->uch color'w+/r'
       @ 2,29 say sprper->per color'w+/r'
    endif
    if ALIAS()='WYRAB'
      @ 1,6  say nmod color'w+/r'
      @ 1,42 say nmod color'w+/r'
      @ 2,12 say naim+naim1 color'w+/r'
    endif
    if ( eof() )
       if ALIAS()='RAZD'
          @ 1,10 clear to 1,30
          @ 1,48 clear to 1,48
          @ 1,66 clear to 1,78
          @ 2,10 clear to 2,11
          @ 3,01 clear to 3,80
       endif
       if clm=2 .and.ALIAS()='SPRPER'
         @ 2,11 clear to 2,11
         @ 2,29 clear to 2,30
       endif
       if ALIAS()='WYRAB'
          @ 1,6 clear to 1,25
          @ 1,42 clear to 1,61
          @ 2,12 clear to 2,78
       endif

       if (lAppend)
         i++
       else
         skip -1
        if ALIAS()='RAZD'
          @ 1,10 say razd->nmod color'w+/r'
          if grtk<>0
            @ 1,48 say razd->grtk color'w+/r'
          else
            @ 1,48 clear to 1,48
          endif
          @ 1,66 say razd->rasci color'w+/r'
          @ 2,10 say razd->per color'w+/b+'
          if fper<>per.and.naim<>' '
            @ 3,01 say razd->naim color'w+/b+'
            @ 3,COL() say razd->naim1 color'w+/b+'
            fper:=per
          endif
        endif
        if clm=2 .and.ALIAS()='SPRPER'
          @ 2,11 say sprper->uch color'w+/r'
          @ 2,29 say sprper->per color'w+/r'
        endif
        if ALIAS()="WYRAB"
          @ 1,6  say fi color'w+/r'
          @ 1,42 say nmod color'w+/r'
          @ 2,12 say naim+naim1 color'w+/r'
        endif
       endif
     exit
    endif
    i++
  enddo

elseif n < 0
  do while i > n
    skip -1
    if ALIAS()='RAZD'
      @ 1,10 say razd->nmod color'w+/r'
      if grtk<>0
        @ 1,48 say razd->grtk color'w+/r'
      else
        @ 1,48 clear to 1,48
      endif
      @ 1,66 say razd->rasci color'w+/r'
      @ 2,10 say razd->per color'w+/b+'
     if fper<>per.and.naim<>' '
       @ 3,01 say razd->naim color'w+/b+'
       @ 3,COL() say razd->naim1 color'w+/b+'
       fper:=per
      endif
    endif
    if clm=2 .and.ALIAS()='SPRPER'
     @ 2,11 say sprper->uch color'w+/r'
     @ 2,29 say sprper->per color'w+/r'
    endif
    if clm=1.and.ALIAS()='WYRAB'
      @ 1,6  say fi color'w+/r'
      @ 1,42 say nmod color'w+/r'
      @ 2,12 say naim+naim1 color'w+/r'
    endif
    if ( bof() )
      exit
    endif
    i--
  enddo
endif

return i
//end перемещение указателя записи на текущий .obj
//
*-------------------------------------------------
Static Procedure ListHelp()

Local vScreen
Local vColorSave
Local i,j
Local xRow,yCol
vScreen:= SaveScreen()
vColorSave:=SetColor()
xRow:=Row()
yCol:=Col()

dispbox(0,0,24,79,'         ','n/w')
dispbox(3,4,22,76,'         ','w+/n')
dispbox(2,3,21,75,'╒═╕│╛═╘│ ','n/bg')
setcolor('n/bg')
@ 2,37 say ' HELP '
if ahelp=1
  @ 7,6 say  'Выбирается из справочника: ткань-ворсовая,неворсовая'
else
@ 2,37 say ' HELP '
@ 3,6 say  '<  >          -перемещение курсора на строку вверх'
@ 4,6 say  '<  >          -перемещение курсора на строку вниз/ввод новой строки'
@ 5,6 say  '< ─ >         -перемещение курсора влево  на один столбец'
@ 6,6 say  '< ─ >         -перемещение курсора вправо на один столбец'
@ 7,6 say  '<PgUp>         -перемещение курсора на страницу вверх'
@ 8,6 say  '<PgDn>         -перемещение курсора на страницу вниз'
@ 9,6 say '<Home>          -перемещение курсора в крайний левый  столбец данных'
@ 10,6 say '<End>          -перемещение курсора в крайний правый столбец данных'
@ 11,6 say '<Ctrl>-<PgUp>  -перемещение курсора на начало файла'
@ 12,6 say '<Ctrl>-<PgDn>  -перемещение курсора на конец  файла'
@ 13,6 say '<Ctrl>-<Home>  -перемещение курсора в крайний левый  столбец экрана'
@ 14,6 say '<Ctrl>-<End>   -перемещение курсора в крайний правый столбец экрана'
@ 15,6 say '<Ctrl>-< ─ >  -перемещение влево  без изменения положения курсора'
@ 16,6 say '<Ctrl>-< ─ >  -перемещение вправо без изменения положения курсора'
@ 17,6 say '<Enter>        -включение режима редактирования'
@ 18,6 say '<F8>           -удаление текущей строки'
@ 19,6 say '<F9>           -удаление всех записей'
if clm=1
  @ 20,6 say '<F10>          -перенос зн-ий полей в новую строку из пред. строки'
endif
@ 21,6 say '<Esc>          -выход'
endif
wait''

RestScreen(0,0,maxRow(),maxCol(),vScreen)
@ xRow,yCol say ''

return
//
*-------------------------------------------------
STATIC PROCEDURE FancyColors(browse)

    LOCAL n, column
    LOCAL xValue


    // Установка списка цветов для использования TBrowse
    //browse:colorSpec := "N/W, N/BG, B/W, B/BG, B/W, B/BG, R/W, B/R"

    // Цикл по всем колонкам со сменой некоторых цветов
    //    FOR n := 1 TO browse:colCount
 for n := 1 to FCount()

          // Доступ к колонке
          // column := browse:getColumn(n)

          // Получение варианта данных путем вычисления блока кода
          //xValue := EVAL(column:block)

          //IF VALTYPE(xValue) != "N"
       // Для нецифровых данных использовать цвета 3 и 4 ("B/W" и "B/BG")
     column:defColor := {3, 4}

          //ELSE
            // Для цифровых - цветовой блок кода для выделения отрицательных величин
          //  column:colorBlock := {|x| if( x < 0, {7, 8}, {5, 6} )}

       // Установка цвета по умолчанию (цвета для заголовков)
     column:defColor := {7, 8}

           // ENDIF
  NEXT
 RETURN
//
*-------------------------------------------------
Procedure vv_perex()
Local vScreen,vScreen1
Local vColorSave,vColorS,nrow,ncol,ffper,fuch

 nrow:=0
 ncol:=0

 nz:=recno()
 nrow:=ROW()
 ncol:=COL()
 fuch:=0
 fkmod:=0

 vColorSave:=SetColor()
 vScreen:=savescreen()
 dispbox(11,15,13,45,'╒═╕│╛═╘│ ','W+/B+')
 setcolor('w+/b+')
 setcursor(INS_CURSOR)
 @ 12,17 say "Номер участка :" get fuch color'w+/n' picture "@B 9"
 @ 16,04 say "0-все разделение;1-подготов; 2-раскройн; 3-контроль; 4-нумеровка;5-    "  color'w+/b+'
    READ
 setcursor(SC_NONE)

   select sprper
 if fuch<>0
  set filter to uch=fuch
  go top
 else
  go top
 endif

 if .not.EOF()
   tbdemo()
   setColor('w+/w')
   vColorS:=SetColor()
   clear screen
   vScreen1:=savescreen()
   setColor('r+/b')
   tt3:=alert('  ДОБАВИТЬ В БАЗУ РАЗДЕЛЕНИЯ ',{' ДА ',' НЕТ '})
   if tt3=1
     SetColor(vColorS)
     restscreen(,,,,Vscreen1)
     dispbox(11,15,13,58,'╒═╕│╛═╘│ ','W+/B+')
     setcolor('w+/b+')
     setcursor(INS_CURSOR)
     ffper:=0
     @ 12,17 say "Под каким номером добавить переход :" get ffper color'w+/n' picture "@B 99"
        READ
     setcursor(SC_NONE)
     if ffper<>0
      select razd
      go top
      if fkmod=0
        fkmod=kmod
      endif
      Locate for per=ffper
      If found()
       fper:=0
       DO WHILE .NOT.EOF()
        if fper<>per
          fper:=per
        endif
        DO WHILE per=fper
          replace field->per with fper+1
          skip
        ENDDO
       ENDDO
      Endif
      select sprper
     endif

     go top
     fper:=0
     DO WHILE .NOT.EOF()
      if per<>fper.and.prr='*'
       fper=per
       DO WHILE per=fper
        if prr='*'
        select razd
        APPEND BLANK
        REPLACE ms with mm,;
                kmod with fkmod,;
                nmod with fnmod,;
                per with ffper,;
                nst with sprper->nst,;
                naim with sprper->naim,;
                naim1 with sprper->naim1,;
                kr with 1
                if sprper->koef<>0
                  replace koef with sprper->koef
                else
                  replace koef with 1
                endif
                if sprper->nvr<>0
                  replace nvr with sprper->nvr
                endif
        select sprper
         endif
        skip
       ENDDO
      else
       skip
      endif
     ENDDO
     go top
     replace prr with ' ' all
   else
     go top
     replace prr with ' ' all
   endif
 else
   @ 16,07 say "Нет информации по переходам "  color'w*/rb+'
   wait""
 endif
 SetColor(vColorSave)
 restscreen(,,,,Vscreen)
 select razd
 go nz
 SETPOS(nrow,ncol)
return 0

*-------------------------------------------------
Procedure red_perex()
Local vScreen     //сохранить экран
Local vColorSave,nrow,ncol,fper,masper[6,3]

 nrow:=0
 ncol:=0
 for i=1 to 6
   masper[i,1]:=0
   masper[i,2]:=SPACE(40)
   masper[i,3]:=SPACE(33)
 next

 nz:=recno()
 nrow:=ROW()
 ncol:=COL()
 fper:=per

 vColorSave:=SetColor()
 vScreen:=savescreen()
 dispbox(11,15,13,45,'╒═╕│╛═╘│ ','W+/B+')
 setcolor('w+/b+')
 setcursor(INS_CURSOR)
 @ 12,17 say "Номер перехода:" get fper color'w+/n' picture "@B 99"
    READ
 setcursor(SC_NONE)
 restscreen(,,,,Vscreen)
 if fper<>per
   go top
   locate for per=fper
 endif
 j:=1
 if !EOF()
   DO WHILE per=fper
      if field->naim<>' '
        masper[j,1]:=recno()
        masper[j,2]:=field->naim
        masper[j,3]:=field->naim1
      endif
      j++
      skip
   ENDDO
   vScreen:=SaveScreen(6,10,23,52)
   @ 6,10 clear to 23,52
   setcolor('w+/b+')
   dispbox(6,10,23,52,2)
   setcursor(INS_CURSOR)
   nn:=8
   for i:=1 to len(masper)
     if LASTKEY()=27
      exit
     endif
     if masper[i,2]<>' '
       @ nn,11  get masper[i,2] color'w+/n'
       nn:=nn+2
       @ nn,11  get masper[i,3] color'w+/n'
       nn:=nn+2
     endif
    READ
    if UPDATED()
     go masper[i,1]
     replace field->naim with masper[i,2]
     replace field->naim1 with masper[i,3]
    endif
   next
   setcursor(SC_NONE)
   RestScreen(6,10,23,52,vScreen)
   SetColor(vColorSave)
 else
   vScreen:=SaveScreen(14,10,16,37)
   dispbox(14,10,16,37,2)
   @ 15,17 say "Неправильный номер перехода"  color'w+/r+'
   wait""
   RestScreen(14,10,16,37,vScreen)
   SetColor(vColorSave)
 endif
 go nz
 SETPOS(nrow,ncol)
 @ 3,01 say field->naim color'w+/b+'
 @ 3,COL() say field->naim1 color'w+/b+'
return 0

****************************************************************
Procedure STOIMOBR()
Local SNVR:=0, SRASC:=0

   go top
   sum NVRI,RASCI to SNVR,SRASC
   vScreen:=SaveScreen(10,19,14,63)
   prcolor:=Setcolor()
   setcolor('w+/b+')
   @ 10,19 clear to 14,63
   dispbox(10,19,14,63,2)
   nROW:=ROW()
   nCOL:=COL()
   @ 11,20 say 'ПРОДОЛЖИТЕЛЬНОСТЬ ОБРАБОТКИ '+alltrim(str(SNVR))+ '  ='+str(SNVR/3600,5,2)
   @ 13,20 say 'СТОИМОСТЬ ОБРАБОТКИ         '+str(SRASC,8,2)
   @ 14,30 say '     ENTER-ВЫХОД  '
   wait ""
   SETPOS(nROW,nCOL)
   RestScreen(10,19,14,63,vscreen)
   SETCOLOR(prcolor)
 return

****************************************************************
Static Procedure vybor(fsprav)
Local vColorSave,vScreen

    vScreen:= SaveScreen()
    vColorSave:=SetColor()
    DO CASE
      case fsprav="sprmod"
        Vyb_ass(fsprav)
        select 1
      case fsprav="sbrig"
        Vyb_nvr(fsprav)
        select 1
      case fsprav="sprtn"
        Vyb_ass(fsprav)
        if kod_as<>nil
          locate for val(kod_as)=tn
        endif
        select 1
      case fsprav="sprprof"
        Vyb_nvr(fsprav)
        select 1
      case fsprav="razd"
        Vyb_ass(fsprav)
        select 1
    ENDCASE
    SetColor(vColorSave)
    RestScreen(0,0,maxRow(),maxCol(),vScreen)
    if assort<>nil
    DO CASE
      case fsprav="sprmod"
        field->kmod:=val(kod_as)
        field->nmod:=assort
      case fsprav="sbrig"
        field->kodbr:=val(kod_as)
      case fsprav="sprtn"
        field->Tn:=val(kod_as)
        field->FI:=assort
      case fsprav="sprprof"
        field->Kprof:=val(kod_as)
    ENDCASE
    endif
 return nil


Static Procedure prPrn()
Local vScreen,vColorSave

vColorSave:=SetColor()
vScreen:=savescreen()
if IsPrinter()=.f.
  setcolor('w+/n')
  @24,0 clear to 24,79
  @24,27 say'Подготовьте принтер для печати!' color 'w+/r'
  InKey(0)
  if IsPrinter()=.f.
    return
  endif
endif

//setcolor('w+/n')
//@ 24,0 clear to 24,79
//@ 24,30 say 'Ждите!    Идет печать!' color 'w+*/n'

Spr_Prn()
SetColor(vColorSave)
restscreen(,,,,Vscreen)

return

/*----------------------------------------*/
Procedure SPR_Prn()
Local vScreen

 fkodbr:=0
 nlist:=1
 kolstr:=1
 use sbrig new
 select stab

 vScreen:=SaveScreen(,,,)
 @ 0,0,24,79 box '         '
 setcolor('w+/bg')
 prcolor:=setcolor()
 setColor('r+/b')
 tt1:=alert(' СПРАВОЧНИК ',{' ОДНОЙ БРИГАДЫ ','  ВСЕХ БРИГАД '})
 setcolor(prcolor)
 if tt1=0
    restscreen(,,,,scrr2)
    close all
   return
 else
   if tt1=1
     VYB_NVR('sbrig')
     if .not.found()
      @ 11,25 say 'Неправильно сделан выбор бригады' color'w+/n'
      wait ""
      close all
      restscreen(,,,,scrr2)
      return
     else
      if fkodbr=0
        fkodbr:=sbrig->kodbr
        @ 7,34 say fkodbr color'w+/n'
      endif
      @ 7,40 say sbrig->naimb color'w+/n'
        wait ""
      select sprtn
      SET FILTER TO kodbr=fkodbr
      go top
     endif
   endif
 endif

set console off
SET DEVICE TO PRINTER
set printer on

SetPrc(0,0)
go top
nom:=1

if tt1=1
  chapt()
endif

do while .not.eof()

 if tt1=2.and.kodbr<>fkodbr
   if fkodbr<>0
     eject
     nlist:=1
     kolstr:=1
   endif
   fkodbr:=kodbr
   select sbrig
   go top
   locate for  fkodbr=kodbr
   select 1
   chapt()
   nom:=1
 endif
 if kolstr>60
    eject
    nlist:=nlist+1
    kolstr:=1
    chapt()
 endif

 @ PROW(),2 SAY '|'+ PADC(str(nom,4),4)+'|'+PADL(str(tn),4)+'   |'+PADR(fi,20)+'   |'+PADC(str(rz),3)+'|'
 ?
 kolstr:=kolstr+1
 nom++
 skip
enddo
eject

set console on
set printer off
SET PRINTER TO
set device to screen

select sbrig
  use
select sprtn
if tt1=1
 SET FILTER TO
endif
restscreen(,,,,vScreen)
RETURN

//*********************************
//*********************************
procedure chapt()
  AAAON()
  ?
  @ PROW(),2 SAY PADC('  СПРАВОЧНИК ТАБЕЛЬНЫХ НОМЕРОВ  ',80)
  ?
  @ PROW(),2 SAY PADC('Подразделение '+str(fkodbr,4) +'  '+rtrim(sbrig->naimb), 80)
  AAAOF()
  ?
  ?
  @ PROW(),2 SAY PADL('═',41,'═')
  ?
  @ PROW(),2 SAY "| №  |  Таб. |     Фамилия И.О.      |Раз|"
  ?
  @ PROW(),2 SAY "| п/п| номер |                       |ряд|"
  ?
  @ PROW(),2 SAY PADL('═',41,'═')
  ?
  kolstr:=10
RETURN

//
***** End of VACD.PRG ****************************
*-------------------------------------------------