package Birds is

   type Bird_Kind is (Blahake_Kind, Bofink_Kind);

   type Attribute_Kind is (Freq1_Kind, Freq2_Kind);

   type Attribute_Array is array (Attribute_Kind) of Float;

   procedure Put_Attribute_Kind (Width : Natural);

end;
