PARAMETERS Str_1,n_nastr,Str_2,len_str,Str_r
*
* Str_1   - ��p��� ���� ��p���
* n_nastr - ����p��筮� ���
* Str_2   - ��p�� ���� ��p���
* len_str - ����� p�����p��饩 ��p���
* Str_r   - ������������ p�����p��饩 ��p���
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
