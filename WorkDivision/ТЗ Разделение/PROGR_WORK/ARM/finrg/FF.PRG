select 0
use skl
index on sch to oo
set filter to sch<>0
go top
ll:=sch
skip
do while !(eof())
 if ll=sch
  ? sch
 else
  skip
  ll=sch
 endif
enddo