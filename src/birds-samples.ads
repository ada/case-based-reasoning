with Birds.Attributes;

package Birds.Samples is


   type Sample is record
      Bird : Kind;
      Attribute : Attributes.Vector;
   end record;

   type Vector is array (Integer range <>) of Sample;


   procedure Read_Sample_Array (Name : String; A : Attributes.Kind; X : out Vector; Min : out Float; Max : out Float);
   procedure Read_Sample_Array_Type (Name : String; X : out Vector);
   procedure Normalize (A : Attributes.Kind; Min, Max : Float; X : in out Vector);

   procedure Read_Sample_Array_Normalized (Name : String; A : Attributes.Kind; X : out Vector);

   procedure Put_Sample (X : Sample; Width : Natural);
   procedure Put_Sample_Array (X : Vector; Width : Natural);

end;
