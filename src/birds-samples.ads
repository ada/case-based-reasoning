with Birds.Attributes;

package Birds.Samples is


   type Sample is record
      Bird : Birds.Kinds.Kind;
      Attribute : Attributes.Vector;
   end record;

   type Vector is array (Integer range <>) of Sample;


   procedure Read_Vector (Name : String; A : Attributes.Kinds.Kind; X : out Vector; Min : out Float; Max : out Float);
   procedure Read_Vector_Kind (Name : String; X : out Vector);
   procedure Read_Vector_Normalized (Name : String; A : Attributes.Kinds.Kind; X : out Vector);
   procedure Normalize_Vector (A : Attributes.Kinds.Kind; Min, Max : Float; X : in out Vector);

end;
