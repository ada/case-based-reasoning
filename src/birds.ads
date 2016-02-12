with Ada.Numerics.Real_Arrays;

package Birds is

   use Ada.Numerics.Real_Arrays;

   subtype Attribute_Type is Integer range 1 .. 2;

   type Bird_Kind is (Blahake_Kind, Bofink_Kind);

end;
