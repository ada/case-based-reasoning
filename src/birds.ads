with Ada.Numerics.Real_Arrays;

package Birds is

   use Ada.Numerics.Real_Arrays;

   type Bird_Kind is (Blahake_Kind, Bofink_Kind);

   type Attribute_Kind is (Freq1_Kind, Freq2_Kind);
   type Attribute_Array is array (Attribute_Kind) of Float;

end;
