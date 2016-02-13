package Birds.Samples is


   type Sample is record
      Bird : Bird_Kind;
      Attribute : Attribute_Array;
   end record;

   type Sample_Array is array (Integer range <>) of Sample;


   procedure Read_Sample_Array (Name : String; A : Attribute_Kind; X : out Sample_Array; Min : out Float; Max : out Float);
   procedure Read_Sample_Array_Type (Name : String; X : out Sample_Array);
   procedure Normalize (A : Attribute_Kind; Min, Max : Float; X : in out Sample_Array);

   procedure Read_Sample_Array_Normalized (Name : String; A : Attribute_Kind; X : out Sample_Array);

   procedure Put_Sample (X : Sample; Width : Natural);
   procedure Put_Sample_Array (X : Sample_Array; Width : Natural);

end;
