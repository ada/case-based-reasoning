with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;

package body Birds.Samples is

   procedure Read_Vector (Name : String; A : Attributes.Kinds.Kind; X : out Vector; Min : out Float; Max : out Float) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
      File : File_Type;
   begin
      Min := Float'Last;
      Max := Float'First;
      Open (File, In_File, Name);
      for I in X'Range loop
         declare
            V : Float renames X (I).Attribute (A);
         begin
            Get (File, V);
            Max := Float'Max (Max, V);
            Min := Float'Min (Min, V);
         end;
      end loop;
      Close (File);
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
