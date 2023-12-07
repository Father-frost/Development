*
* Reviver_DBF_files for FoxBase - Foxpro 2.6
* DIM, 30/12/1996, Minsk
*

FUNCTION Reviver
PARAMETERS _nmfile
PRIVATE    _handle,_buf,_szfile,_nrec,_szrec,_szhead,_rc

SET TALK OFF

IF !FILE(_nmfile)
          WAIT WINDOW " Reviver ["+_nmfile+"]: not found "
          RETURN -1
ENDIF

_handle = FOPEN(_nmfile,12)
IF _handle < 0
          WAIT WINDOW " Reviver ["+_nmfile+"]: access denied "
          RETURN -2
ENDIF

_szfile = FSEEK(_handle,0,2)   && GOTO BOTTOM
        = FSEEK(_handle,0)     && GOTO TOP
_buf    = FREAD(_handle,32)    && READ HEADER
        = FSEEK(_handle,0)     && GOTO TOP

IF LEN(_buf) != 32
        = FCLOSE(_handle)
          WAIT WINDOW " Reviver ["+_nmfile+"]: impossible to read "
          RETURN -3
ENDIF

IF NOT SUBSTR(_buf,1,1) ;
        $ CHR(2)+CHR(3)+CHR(67)+CHR(99)+CHR(131)+;
          CHR(139)+CHR(203)+CHR(245)+CHR(251)

        = FCLOSE(_handle)
          WAIT WINDOW " Reviver ["+_nmfile+"]: no FoxBase-Foxpro2.6 format "
          RETURN -4
ENDIF

_nrec   = ASC(SUBSTR(_buf, 5,1))            +;
          ASC(SUBSTR(_buf, 6,1)) *      256 +;
          ASC(SUBSTR(_buf, 7,1)) *    65536 +;
          ASC(SUBSTR(_buf, 8,1)) * 16777216

_szhead = ASC(SUBSTR(_buf, 9,1))            +;
          ASC(SUBSTR(_buf,10,1)) *      256

_szrec  = ASC(SUBSTR(_buf,11,1))            +;
          ASC(SUBSTR(_buf,12,1)) *      256

_rc     = .t.

IF _nrec = 0 OR _szfile = _szhead && TRUNCATE FILE
 IF _nrec > 0
  = FWRITE(_handle,STUFF(_buf,5,4,;
     CHR(0)+CHR(0)+CHR(0)+CHR(0)),32)
  = FCHSIZE(_handle,_szhead)
 ELSE
  _rc = .f.
 ENDIF
ELSE                              && CHANGE HEADER
 IF _szfile != _szhead + _szrec * _nrec + 1
  _nrec = INT((_szfile - _szhead - 1)/_szrec)
  IF _nrec = 0
   = FWRITE(_handle,STUFF(_buf,5,4,;
      CHR(0)+CHR(0)+CHR(0)+CHR(0)),32)
   = FCHSIZE(_handle,_szhead)
  ELSE
   = FWRITE(_handle,STUFF(_buf,5,4,;
      CHR(_nrec%256)+CHR((_nrec/256)%256)+;
      CHR((_nrec/65536)%256)+CHR((_nrec/16777216)%256)),32)
  ENDIF
 ELSE
  _rc = .f.
 ENDIF
ENDIF

IF !FCLOSE(_handle)
          WAIT WINDOW " Reviver ["+_nmfile+"]: impossible to close "
          RETURN -5
ENDIF
IF _rc
          WAIT WINDOW NOWAIT " Reviver ["+_nmfile+"]: Ok "
          RETURN 1
ENDIF
RETURN 0
