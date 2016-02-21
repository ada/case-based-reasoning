with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Texts;

package body Birds.Samples is


   procedure Read_Vector (Name : String; A : Attributes.Kinds.Kind; X : out Vector; Min : out Float; Max : out Float) is
      procedure Set (Index : Positive; Value : Float; Destination : out Vector) is
      begin
         Destination (Index).Attribute (A) := Value;
      end;
      procedure Read is new Texts.Generic_Read_Float_List (Vector, Set);
   begin
      Read (Name, X'Length, X, Min, Max);
   end;

   procedure Read_Vector_Kind (Name : String; X : out Vector) is
      use Ada.Text_IO;
      use Ada.Integer_Text_IO;
      File : File_Type;
      V : Integer;
   begin
      Open (File, In_File, Name);
      for I in X'Range loop
         Get (File, V);
         X (I).Bird := Birds.Kinds.Kind'Enum_Val (V);
      end loop;
      Close (File);
   end;

   function Normalize (X : Float; Min : Float; Max : Float) return Float is
   begin
      return (X - Min) / (Max - Min);
   end;

   procedure Normalize_Vector (A : Attributes.Kinds.Kind; Min, Max : Float; X : in out Vector) is
   begin
      for I in X'Range loop
         X (I).Attribute (A) := Normalize (X (I).Attribute (A), Min, Max);
      end loop;
   end;

   procedure Read_Vector_Normalized (Name : String; A : Attributes.Kinds.Kind; X : out Vector) is
      Min, Max : Float := 0.0;
   begin
      Read_Vector (Name, A, X, Min, Max);
      Normalize_Vector (A, Min, Max, X);
   end;


end;
