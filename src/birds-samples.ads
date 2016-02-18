with Birds.Attributes;

package Birds.Samples is


   type Sample is record
      Bird : Kind;
      Attribute : Attributes.Vector;
   end record;

   type Vector is array (Integer range <>) of Sample;


   procedure Read_Vector (Name : String; A : Attributes.Kind; X : out Vector; Min : out Float; Max : out Float);
   procedure Read_Vector_Kind (Name : String; X : out Vector);
   procedure Read_Vector_Normalized (Name : String; A : Attributes.Kind; X : out Vector);

   procedure Normalize_Vector (A : Attributes.Kind; Min, Max : Float; X : in out Vector);


   procedure Put (X : Sample; Fore : Natural; Width : Natural);
   procedure Put_Vector (X : Vector; Fore : Natural; Width : Natural);

end;
