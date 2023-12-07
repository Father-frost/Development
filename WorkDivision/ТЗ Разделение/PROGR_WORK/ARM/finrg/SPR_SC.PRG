PARAMETERS fsc,flen
PRIVATE nam_file,fnam
nam_file=ALIAS()
SELECT spr_bs
SET ORDER TO bs
SEEK fsc
fnam=LEFT(nam,flen)
IF LEN(nam_file)#0
    SELECT &nam_file
ENDIF
RETURN fnam
