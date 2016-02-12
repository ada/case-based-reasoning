with Ada.Numerics.Real_Arrays;

package Birds.Samples is
   use Ada.Numerics.Real_Arrays;

   type Sample is record
      Bird : Bird_Kind;
      Attribute : Real_Vector (Attribute_Type);
   end record;

   type Sample_Array is array (1 .. 5) of Sample;
   procedure Read_Sample_Array (Name : String; A : Attribute_Type; X : out Sample_Array; Min : out Float; Max : out Float);
   procedure Read_Sample_Array_Type (Name : String; X : out Sample_Array);
   procedure Normalize (A : Attribute_Type; Min, Max : Float; X : in out Sample_Array);
   procedure Put (X : Sample);

end;
