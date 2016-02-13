with Ada.Numerics.Real_Arrays;

package Birds.Samples is
   use Ada.Numerics.Real_Arrays;

   type Bird_Sample is record
      Bird : Bird_Kind;
      Attribute : Attribute_Array;
   end record;

   type Sample_Array is array (1 .. 5) of Bird_Sample;
   procedure Read_Sample_Array (Name : String; A : Attribute_Kind; X : out Sample_Array; Min : out Float; Max : out Float);
   procedure Read_Sample_Array_Type (Name : String; X : out Sample_Array);
   procedure Normalize (A : Attribute_Kind; Min, Max : Float; X : in out Sample_Array);
   procedure Put (X : Bird_Sample);

end;
