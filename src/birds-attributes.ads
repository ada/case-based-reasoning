package Birds.Attributes is

   type Kind is (Freq1, Freq2);
   type Vector is array (Kind) of Float;
   procedure Put_Kind (Width : Natural);

end;
