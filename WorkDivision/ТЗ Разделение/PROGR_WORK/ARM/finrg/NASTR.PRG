PARAMETERS Str_1,n_nastr,Str_2,len_str,Str_r
*
* Str_1   - пеpвая часть стpоки
* n_nastr - настpоечное имя
* Str_2   - втоpая часть стpоки
* len_str - длина pезультиpующей стpоки
* Str_r   - наименование pезультиpующей стpоки
*
Str_r=Str_1+RTRIM(n_nastr)+Str_2
DO CASE
CASE LEN(Str_r)=len_str
    RETURN
CASE LEN(Str_r)>len_str
    Str_r=LEFT(Str_r,len_str)
OTHERWISE
    Str_r=Str_r+SPACE(len_str-LEN(Str_r))
ENDCASE
RETURN
