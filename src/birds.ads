package Birds is


   package Attributes is
      type Kind is (Freq1, Freq2);
      type Vector is array (Kind) of Float;
      procedure Put_Kind (Width : Natural);
   end;

   type Kind is (Blahake_Kind, Bofink_Kind);


end;
