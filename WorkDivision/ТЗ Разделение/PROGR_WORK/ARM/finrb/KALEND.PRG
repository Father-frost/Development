function fkalend(vgg,vmm)
do case
case vmm=2
   if mod(vgg,4)==0
      return(29)
   else
      return(28)
   endif
case (str(vmm,2)+",") $ " 1, 3, 5, 7, 8,10,12,"
     return(31)
otherwise
     return(30)
endcase