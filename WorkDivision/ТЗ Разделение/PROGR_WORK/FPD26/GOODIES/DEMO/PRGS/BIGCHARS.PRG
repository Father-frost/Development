procedure bigchars
parameter startx,starty,instring

set blink off

if startx > 20
	return
endif

curenty = starty
curlet = 1

if "MONO" $ upper(sys(2006))
	colorvar = "n/n"
else
	colorvar = "n/b"
endif

do while curlet <= len(instring) and curenty < 89
	do case
		case substr(instring,curlet,1) = " "
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 3,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 6
		case substr(instring,curlet,1) = "t" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 6
			@ 0,0 say " ��"
			@ 0,3 say "�" color (colorvar)
			
			@ 1,0 say "���"
			@ 1,3 say "�" color w+/n
			@ 1,4 say "�" color (colorvar)
			
			@ 2,1 say "�� " color w+/n

			@ 3,0 say " ��"
			@ 3,3 say "�" color w+/n
			
			@ 4,0 say "   ��" color (colorvar)
		case substr(instring,curlet,1) = "s" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "��"
			@ 1,2 say "�" color w+/n
			@ 1,3 say "��"
			
			@ 2,0 say " �"
			@ 2,2 say "���" color w+/n
			@ 2,5 say "�" color (colorvar)

			@ 3,0 say "����"
			@ 3,4 say "� " color w+/n
			
			@ 4,0 say "  ���" color (colorvar)
		case substr(instring,curlet,1) = "e" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "��"
			@ 1,2 say "��" color w+/n
			@ 1,4 say "�"

			@ 2,0 say "����� " color w+/n
			
			@ 3,0 say "��"
			@ 3,2 say "���" color w+/n
			@ 3,5 say "�" color (colorvar)
			
			@ 4,0 say "  ���" color (colorvar)
		case substr(instring,curlet,1) = "r" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 6
			@ 1,0 say "���"
			@ 1,3 say "�" color w+/n
			@ 1,4 say "�" color (colorvar)
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say "�" color (colorvar)
			
			@ 3,0 say "�� " color w+/n
			
			@ 4,0 say " ��" color (colorvar)
		case substr(instring,curlet,1) = "o" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "��"
			@ 1,2 say "��" color w+/n
			@ 1,4 say "�"

			@ 2,0 say "�� �� " color w+/n
			
			@ 3,0 say "��"
			@ 3,2 say "��� " color w+/n
			
			@ 4,0 say "  ���" color (colorvar)
		case substr(instring,curlet,1) = "a" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 1,0 say "��"
			@ 1,2 say "��" color w+/n
			@ 1,4 say "�"

			@ 2,0 say "��"
			@ 2,2 say "��� " color w+/n
			
			@ 3,0 say "��"
			@ 3,2 say "����" color w+/n
			
			@ 4,0 say "  �� ��" color (colorvar)
		case substr(instring,curlet,1) = "i" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 3 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 4
			@ 0,0 say "�"
			@ 0,1 say "�" color w+/n
			@ 0,2 say "�" color (colorvar)
			
			@ 1,0 say "��"
			@ 1,2 say "�" color (colorvar)
			
			@ 2,0 say "�� " color w+/n

			@ 3,0 say "�� " color w+/n
			
			@ 4,0 say " ��" color (colorvar)
		case substr(instring,curlet,1) = "n" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "��"
			@ 1,2 say "��" color w+/n
			@ 1,4 say "�"

			@ 2,0 say "�� �� " color w+/n
			
			@ 3,0 say "�� �� " color w+/n

			@ 4,0 say " �� ��" color (colorvar)
		case substr(instring,curlet,1) = "m" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 8 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 10
			@ 1,0 say "��"
			@ 1,2 say "��" color w+/n
			@ 1,4 say "�"
			@ 1,5 say "��" color w+/n
			@ 1,7 say "�"

			@ 2,0 say "�� �� �� " color w+/n
			
			@ 3,0 say "�� �� �� " color w+/n

			@ 4,0 say " �� �� ��" color (colorvar)
		case substr(instring,curlet,1) = "f" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 0,0 say " ��"
			@ 0,3 say "��" color w+/n
			@ 0,5 say "�" color (colorvar)
			
			@ 1,0 say "���"
			@ 1,3 say "�" color w+/n
			@ 1,4 say "�" color (colorvar)
			
			@ 2,1 say "�� " color w+/n

			@ 3,1 say "�� " color w+/n
			
			@ 4,0 say "  ��" color (colorvar)
		case substr(instring,curlet,1) = "l" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 3 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 4
			@ 0,0 say "��"
			@ 0,2 say "�" color (colorvar)
			
			@ 1,0 say "�� " color w+/n
			
			@ 2,0 say "�� " color w+/n

			@ 3,0 say "�� " color w+/n
			
			@ 4,0 say " ��" color (colorvar)
		case substr(instring,curlet,1) = "k" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 7 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 0,0 say "��"
			@ 0,2 say "�" color (colorvar)
			
			@ 1,0 say "�����" color w+/n
			@ 1,5 say "�" color (colorvar)
			
			@ 2,0 say "����" color w+/n
			@ 2,4 say "�" color (colorvar)

			@ 3,0 say "�� " color w+/n
			@ 3,3 say "���"
			
			@ 4,0 say " ��  ��" color (colorvar)
		case substr(instring,curlet,1) = "u" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "��"
			@ 1,2 say "�" color (colorvar)
			@ 1,3 say "��"
			@ 1,5 say "�" color (colorvar)

			@ 2,0 say "�� �� " color w+/n
			
			@ 3,0 say "��"
			@ 3,2 say "�" color w+/n
			@ 3,3 say "�"
			@ 3,4 say "� " color w+/n
			
			@ 4,0 say "  �� �" color (colorvar)
		case substr(instring,curlet,1) = "b" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 0,0 say "��"
			@ 0,2 say "�" color (colorvar)

			@ 1,0 say "����" color w+/n
			@ 1,4 say "�"
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say " �"
			@ 2,5 say "�" color (colorvar)
				
			@ 3,0 say "����� " color w+/n

			@ 4,0 say " ����" color (colorvar)
		case substr(instring,curlet,1) = "c" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 6
			@ 1,0 say "��"
			@ 1,2 say "��" color w+/n
			@ 1,4 say "�" color (colorvar)
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say " �" color (colorvar)
			
			@ 3,0 say "��"
			@ 3,2 say "��" color w+/n
			@ 3,4 say "�" color (colorvar)

			@ 4,0 say "  ���" color (colorvar)
		case substr(instring,curlet,1) = "d" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 0,0 say "   ��"
			@ 0,5 say "�" color (colorvar)
			
			@ 1,0 say "��"
			@ 1,2 say "��� " color w+/n
			
			@ 2,0 say "� " color w+/n
			@ 2,2 say "�" color (colorvar)
			@ 2,3 say "�� " color w+/n
			
			@ 3,0 say "�����"
			@ 3,5 say "�" color (colorvar)

			@ 4,0 say "  ����" color (colorvar)
		case substr(instring,curlet,1) = "q" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "��"
			@ 1,2 say "�" color w+/n
			@ 1,3 say "��"
			@ 1,5 say "�" color (colorvar)
			
			@ 2,0 say "� " color w+/n
			@ 2,2 say "�" color (colorvar)
			@ 2,3 say "�� " color w+/n
			
			@ 3,0 say "�����"
			@ 3,5 say "�" color (colorvar)

			@ 4,0 say "  �" color (colorvar)
			@ 4,3 say "�� " color w+/n

			@ 5,0 say "    ��" color (colorvar)
			
		case substr(instring,curlet,1) = "g"  
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "��"
			@ 1,2 say "�" color w+/n
			@ 1,3 say "��"
			@ 1,5 say "�" color (colorvar)

			@ 2,0 say "� " color w+/n
			@ 2,2 say "�" color (colorvar)
			@ 2,3 say "�� " color w+/n
			
			@ 3,0 say "�����"
			@ 3,5 say "�" color (colorvar)
			
			@ 4,0 say " �"
			@ 4,2 say "�" color w+/n
			@ 4,3 say "�"
			@ 4,4 say "� " color w+/n
			
			@ 5,0 say "  ���" color (colorvar)
		case substr(instring,curlet,1) = "h" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 5 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 0,0 say "��" color w+/n
			@ 0,2 say "�" color (colorvar)

			@ 1,0 say "����" color w+/n
			@ 1,4 say "�"
			
			@ 2,0 say "�� �� " color w+/n
			
			@ 3,0 say "�� �� " color w+/n

			@ 4,0 say " �� ��" color (colorvar)
		case substr(instring,curlet,1) = "j" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 3 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 5
			@ 0,0 say " �"
			@ 0,2 say "�" color w+/n
			@ 0,3 say "�" color (colorvar)
			
			@ 1,0 say " ��"
			@ 1,3 say "�" color (colorvar)
			
			@ 2,1 say "�� " color w+/n

			@ 3,1 say "�� " color w+/n
			
			@ 4,0 say "�"
			@ 4,1 say "� " color w+/n
			@ 4,3 say "�" color (colorvar)
		case substr(instring,curlet,1) = "p" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "�����"

			@ 2,0 say "�� " color w+/n
			@ 2,3 say " �"
			@ 2,5 say "�" color (colorvar)
			
			@ 3,0 say "����� " color w+/n
			
			@ 4,0 say "�� " color w+/n
			@ 4,3 say "��" color (colorvar)
			
			@ 5,0 say " ��" color (colorvar)
		case substr(instring,curlet,1) = "w" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 8 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 9
			@ 1,0 say "��"
			@ 1,2 say "�" color (colorvar)
			@ 1,3 say "�"
			@ 1,4 say "�" color (colorvar)
			@ 1,5 say "��"
			@ 1,7 say "�" color (colorvar)

			@ 2,0 say "��"
			@ 2,2 say "����� " color w+/n
			
			@ 3,1 say "�� �� " color w+/n
			
			@ 4,0 say "  �� ��" color (colorvar)
		case substr(instring,curlet,1) = "x" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 7 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 1,0 say "�����"
			@ 1,5 say "�" color w+/n
			@ 1,6 say "�" color (colorvar)
			
			@ 2,0 say " ���"
			@ 2,4 say "�" color w+/n
			@ 2,5 say "�" color (colorvar)
			
			@ 3,0 say "�� " color w+/n
			@ 3,3 say "�" color (colorvar)
			@ 3,4 say "��" color w+/n
			@ 3,6 say "�" color (colorvar)
			
			@ 4,0 say " ��  ��" color (colorvar)
		case substr(instring,curlet,1) = "y" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "��"
			@ 1,2 say "�" color (colorvar)
			@ 1,3 say "��"
			@ 1,5 say "�" color (colorvar)

			@ 2,0 say "�� �� " color w+/n
			
			@ 3,0 say " ���"
			@ 3,4 say "� " color w+/n
			
			@ 4,0 say " ��"
			@ 4,3 say "� " color w+/n

			@ 5,0 say "  ��" color (colorvar)
		case substr(instring,curlet,1) = "v" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "��"
			@ 1,2 say "�" color (colorvar)
			@ 1,3 say "��"
			@ 1,5 say "�" color (colorvar)

			@ 2,0 say "�"
			@ 2,1 say "� �� " color w+/n
			
			@ 3,0 say " ��"
			@ 3,3 say "� " color w+/n

			@ 4,0 say "   �" color (colorvar)
		case substr(instring,curlet,1) = "/" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 4 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 6
			@ 0,0 say "   �"
			@ 0,4 say "�" color (colorvar)

			@ 1,0 say "  �"
			@ 1,3 say "��" color (colorvar)
			
			@ 2,0 say " �"
			@ 2,2 say "��" color (colorvar)
			
			@ 3,0 say "�"
			@ 3,1 say "��" color (colorvar)

			@ 4,0 say " �" color (colorvar)
		case substr(instring,curlet,1) = "z" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 1,0 say "�"
			@ 1,1 say "����" color w+/n
			@ 1,5 say "�" color (colorvar)
		
			@ 2,0 say " ��"
			@ 2,3 say "� " color w+/n
			@ 2,5 say "�" color (colorvar)
			
			@ 3,0 say "����" color w+/n
			@ 3,4 say "�"
			
			@ 4,0 say " �����" color (colorvar)
		case substr(instring,curlet,1) = "|"
			startx = startx + 6
			curenty = starty
		case substr(instring,curlet,1) = "A" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 7 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 9
			@ 0,2 say "���" color w+/n
			@ 0,5 say "�" color (colorvar)

			@ 1,1 say "�� ��" color w+/n
			@ 1,6 say "�" color (colorvar)

			@ 2,0 say "�"
			@ 2,1 say "������" color w+/n

			@ 3,0 say "�� " color w+/n
			@ 3,3 say "��" color (colorvar)
			@ 3,5 say "�� " color w+/n
			
			@ 4,0 say " ��   ��" color (colorvar)
		case substr(instring,curlet,1) = "B" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 0,0 say "����" color w+/n
			@ 0,4 say "��"

			@ 1,0 say "���" color w+/n
			@ 1,3 say "��"
			@ 1,5 say "� " color w+/n
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say "�"  color (colorvar)
			@ 2,4 say "��" color w+/n
			@ 2,6 say "�"  color (colorvar)

			@ 3,0 say "���" color w+/n
			@ 3,3 say "��"
			@ 3,5 say "� " color w+/n
			
			@ 4,0 say " �����" color (colorvar)
		case substr(instring,curlet,1) = "C" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 8 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 9
			@ 0,0 say " ��"
			@ 0,3 say "���" color w+/n
			@ 0,6 say "�"
			
			@ 1,0 say "�� " color w+/n
			@ 1,3 say "�" color (colorvar)
			@ 1,4 say "  �"
			@ 1,7 say "�" color (colorvar)

			@ 2,0 say "�� " color w+/n
			@ 2,3 say "   � "
			
			@ 3,0 say " �����"
			@ 3,6 say "� " color w+/n
			
			@ 4,0 say "   ����" color (colorvar)
		case substr(instring,curlet,1) = "D" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 0,0 say "����" color w+/n
			@ 0,4 say "�"
			
			@ 1,0 say "�� " color w+/n
			@ 1,3 say " ��"
			@ 1,6 say "�" color (colorvar)

			@ 2,0 say "�� " color w+/n
			@ 2,3 say " ��"
			@ 2,6 say "�" color (colorvar)
			
			@ 3,0 say "����� " color w+/n
			@ 3,6 say "�" color (colorvar)
			
			@ 4,0 say " ����" color (colorvar)
		case substr(instring,curlet,1) = "E" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 0,0 say "�����" color w+/n
			@ 0,5 say "�" color (colorvar)

			@ 1,0 say "���" color w+/n
			@ 1,3 say "��"
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say "���" color (colorvar)
			
			@ 3,0 say "���" color w+/n
			@ 3,3 say "��"
			
			@ 4,0 say " �����" color (colorvar)
		case substr(instring,curlet,1) = "F" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 0,0 say "�����" color w+/n
			@ 0,5 say "�" color (colorvar)

			@ 1,0 say "���" color w+/n
			@ 1,3 say "�"
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say "��" color (colorvar)
			
			@ 3,0 say "�� " color w+/n
			
			@ 4,0 say " ��" color (colorvar)
		case substr(instring,curlet,1) = "G" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 8 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 9
			@ 0,0 say " ��"
			@ 0,3 say "���" color w+/n
			@ 0,6 say "�"
			
			@ 1,0 say "�� " color w+/n
			@ 1,3 say "�" color (colorvar)
			@ 1,4 say "  �"
			@ 1,7 say "�" color (colorvar)

			@ 2,0 say "�� " color w+/n
			@ 2,3 say " ���"
			@ 2,7 say "�" color (colorvar)
			
			@ 3,0 say " �����"
			@ 3,6 say "� " color w+/n
			
			@ 4,0 say "   ����" color (colorvar)
		case substr(instring,curlet,1) = "H" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 7 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 0,0 say "��"
			@ 0,2 say "� " color (colorvar)
			@ 0,4 say "��"
			@ 0,6 say "� " color (colorvar)

			@ 1,0 say "���" color w+/n
			@ 1,3 say "���"
			@ 1,6 say "�" color (colorvar)
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say "�" color (colorvar)
			@ 2,4 say "�� " color w+/n
			
			@ 3,0 say "�� " color w+/n
			@ 3,3 say " "
			@ 3,4 say "�� " color w+/n
			
			@ 4,0 say " ��  ��" color (colorvar)
		case substr(instring,curlet,1) = "I" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 3 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 4
			@ 0,0 say "��"
			@ 0,2 say "�" color (colorvar)
			
			@ 1,0 say "�� " color w+/n
			
			@ 2,0 say "�� " color w+/n

			@ 3,0 say "�� " color w+/n
			
			@ 4,0 say " ��" color (colorvar)
		case substr(instring,curlet,1) = "J" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 0,0 say "   ��"
			@ 0,5 say "�" color (colorvar)
			
			@ 1,3 say "�� " color w+/n
			
			@ 2,3 say "�� " color w+/n
			
			@ 3,0 say "����"
			@ 3,4 say "� " color w+/n
			
			@ 4,0 say "  ���" color (colorvar)
		case substr(instring,curlet,1) = "K" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 7 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 9
			@ 0,0 say "��"
			@ 0,2 say "�" color (colorvar)
			@ 0,3 say "��"
			@ 0,5 say "�" color w+/n
			@ 0,6 say "�" color (colorvar)

			@ 1,0 say "���� " color w+/n
			@ 1,5 say "�" color (colorvar)
			
			@ 2,0 say "����" color w+/n
			@ 2,4 say "�"
			
			@ 3,0 say "�� " color w+/n
			@ 3,3 say " ���"
			
			@ 4,0 say " ��   ��" color (colorvar)
		case substr(instring,curlet,1) = "L" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 7
			@ 0,0 say "��"
			@ 0,2 say "�" color (colorvar)
			
			@ 1,0 say "�� " color w+/n
			
			@ 2,0 say "�� " color w+/n
			
			@ 3,0 say "���" color w+/n
			@ 3,3 say "��"
			
			@ 4,0 say " �����" color (colorvar)
		case substr(instring,curlet,1) = "M" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 10 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 11
			@ 0,0 say "���   ���"
			@ 0,9 say "�" color (colorvar)

			@ 1,0 say "����" color w+/n
			@ 1,4 say " ����"
			@ 1,9 say "�" color (colorvar)

			
			@ 2,0 say "�� ��� �� " color w+/n

			@ 3,0 say "�� " color w+/n
			@ 3,3 say " �"
			@ 3,5 say "��" color (colorvar)
			@ 3,7 say "�� " color w+/n

			@ 4,0 say " ��  �  ��" color (colorvar)
		case substr(instring,curlet,1) = "N" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 8 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 9
			@ 0,0 say "���  ��"
			@ 0,7  say "�" color (colorvar)

			@ 1,0 say "����" color w+/n
			@ 1,4 say " ��"
			@ 1,7 say "�" color (colorvar)
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say "�"
			@ 2,4 say "��� " color w+/n
			
			@ 3,0 say "�� " color w+/n
			@ 3,3 say " ���"
			@ 3,7 say " " color w+/n
			
			@ 4,0 say " ��   ��" color (colorvar)
			
		case substr(instring,curlet,1) = "O" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 7,curenty + 7 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 9
			@ 0,0 say " ��"
			@ 0,3 say "�" color w+/n
			@ 0,4 say "��"
			
			@ 1,0 say "�� " color w+/n
			@ 1,3 say "� " color (colorvar)
			@ 1,5 say "��"
			@ 1,7 say "�" color (colorvar)
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say "  ��"
			@ 2,7 say "�" color (colorvar)

			@ 3,0 say " ����"
			@ 3,5 say "� " color w+/n
			@ 3,7 say "�" color (colorvar)
						
			@ 4,0 say "   ���" color (colorvar)
		case substr(instring,curlet,1) = "P" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 0,0 say "���" color w+/n
			@ 0,3 say "���"

			@ 1,0 say "�� " color w+/n
			@ 1,3 say " ��"
			@ 1,6 say "�" color (colorvar)
			
			@ 2,0 say "����� " color w+/n
			@ 2,6 say "�" color (colorvar)
			
			@ 3,0 say "�� " color w+/n
			
			@ 4,0 say " ��" color (colorvar)
		case substr(instring,curlet,1) = "Q" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 8 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 9
			@ 0,0 say " ��"
			@ 0,3 say "�" color w+/n
			@ 0,4 say "��"
			
			@ 1,0 say "�� " color w+/n
			@ 1,3 say "� " color (colorvar)
			@ 1,5 say "��"
			@ 1,7 say "�" color (colorvar)
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say "� ��"
			@ 2,7 say "�" color (colorvar)

			@ 3,0 say " �����"
			@ 3,6 say "��" color (colorvar)
			
			@ 4,0 say "   ���" color (colorvar)
			@ 4,6 say "�"
			@ 4,7 say "�" color (colorvar)
		case substr(instring,curlet,1) = "R" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 7 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 0,0 say "���" color w+/n
			@ 0,3 say "���"

			@ 1,0 say "�� " color w+/n
			@ 1,3 say " ��"
			@ 1,6 say "�" color (colorvar)
			
			@ 2,0 say "������" color w+/n
			@ 2,6 say "�" color (colorvar)
			
			@ 3,0 say "�� " color w+/n
			@ 3,3 say " ��"
			@ 3,6 say "�" color (colorvar)
			
			@ 4,0 say " ��  ��" color (colorvar)
		case substr(instring,curlet,1) = "S" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 7 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 0,0 say "��"
			@ 0,2 say "���" color w+/n
			@ 0,5 say "�"

			@ 1,0 say "�����"
			@ 1,5 say "��" color (colorvar)
			
			@ 2,0 say "�  ���"
			@ 2,6 say "�" color (colorvar)
			
			@ 3,0 say "�����"
			@ 3,5 say "� " color w+/n
			
			@ 4,0 say "  ����" color (colorvar)
		case substr(instring,curlet,1) = "T" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 7 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 0,0 say "�"
			@ 0,1 say "�����" color w+/n
			@ 0,6 say "�" color (colorvar)

			@ 1,2 say "�� " color w+/n
			
			@ 2,2 say "�� " color w+/n
			
			@ 3,2 say "�� " color w+/n
			
			@ 4,0 say "   ��" color (colorvar)
		case substr(instring,curlet,1) = "U" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 0,0 say "��"
			@ 0,2 say "� " color (colorvar)
			@ 0,4 say "��"
			@ 0,6 say "� " color (colorvar)

			@ 1,0 say "�� " color w+/n
			@ 1,3 say " ��"
			@ 1,6 say "�" color (colorvar)
			
			@ 2,0 say "�� " color w+/n
			@ 2,3 say " "
			@ 2,4 say "�� " color w+/n
			
			@ 3,0 say "��"
			@ 3,2 say "�" color w+/n
			@ 3,3 say "�"
			@ 3,4 say "�� " color w+/n
			
			@ 4,0 say "  ����" color (colorvar)
		case substr(instring,curlet,1) = "V" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 7 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 9
			@ 0,0 say "��"
			@ 0,2 say "�" color (colorvar)
			@ 0,3 say "  ��"
			@ 0,7 say "�" color (colorvar)

			@ 1,0 say " ��"
			@ 1,3 say "�" color (colorvar)
			@ 1,4 say "�� " color w+/n
			@ 1,7 say "�" color (colorvar)
			
			@ 2,0 say " ��"
			@ 2,3 say "��� " color w+/n
			
			@ 3,0 say "  ��"
			@ 3,4 say "� " color w+/n

			@ 4,0 say "    �" color (colorvar)
		case substr(instring,curlet,1) = "W" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 10 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 12
			@ 0,0 say "��"
			@ 0,2 say "� " color (colorvar)
			@ 0,4 say "��"
			@ 0,6 say "� " color (colorvar)
			@ 0,8 say "��"
			@ 0,10 say "�" color (colorvar)

			@ 1,0 say "��"
			@ 1,2 say "�" color w+/n
			@ 1,3 say " ��"
			@ 1,6 say "�" color (colorvar)
			@ 1,7 say "��"
			@ 1,9 say "� " color w+/n
			
			@ 2,1 say "�������� " color w+/n
			
			@ 3,2 say "�� " color w+/n
			@ 3,6 say "�� " color w+/n
			@ 3,9 say "�" color (colorvar)

			@ 4,0 say "   ��  ��" color (colorvar)
		case substr(instring,curlet,1) = "X" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 8 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 9
			@ 0,0 say "��"
			@ 0,2 say "�" color (colorvar)
			@ 0,3 say "  ��"
			@ 0,7 say "�" color (colorvar)

			@ 1,0 say " ����"
			@ 1,5 say "�" color w+/n
			@ 1,6 say "��" color (colorvar)

			@ 2,0 say " ��"
			@ 2,3 say "���" color w+/n
			
			@ 3,0 say "�� " color w+/n
			@ 3,3 say "�" color (colorvar)
			@ 3,4 say " ��"
			@ 3,7 say "�" color (colorvar)
			
			@ 4,0 say " ��   ��" color (colorvar)
		case substr(instring,curlet,1) = "Y" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 9 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 10
			@ 0,0 say "��"
			@ 0,2 say "�" color (colorvar)
			@ 0,3 say "   ��"
			@ 0,8 say "�" color (colorvar)

			@ 1,0 say " ��"
			@ 1,3 say "�" color (colorvar)
			@ 1,4 say " ��"
			@ 1,7 say "��" color (colorvar)
			
			@ 2,0 say "  ���"
			@ 2,5 say "� " color w+/n
			@ 2,7 say "�" color (colorvar)
			
			@ 3,3 say "�� " color w+/n
			
			@ 4,0 say "    ��" color (colorvar)
		case substr(instring,curlet,1) = "Z" 
			define window ("letter" + alltrim(str(curlet))) ;
				 from startx,curenty to startx + 5,curenty + 6 ;
				 none noshadow 
			activate window ("letter" + alltrim(str(curlet)))
			curenty = curenty + 8
			@ 0,0 say "�"
			@ 0,1 say "�����" color w+/n
			@ 0,6 say "�" color (colorvar)
		
			@ 1,0 say "  ��"
			@ 1,4 say "� " color w+/n
			@ 1,6 say "�" color (colorvar)
			
			@ 2,0 say " ��"
			@ 2,3 say "� " color w+/n
			
			@ 3,0 say "����" color w+/n
			@ 3,4 say "��"
			
			@ 4,0 say " ������ " color (colorvar)
	endcase
	curlet = curlet + 1
enddo
