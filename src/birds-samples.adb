with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;

package body Birds.Samples is

   procedure Read_Sample_Array (Name : String; A : Attribute_Type; X : out Sample_Array; Min : out Float; Max : out Float) is
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
            if V > Max then
               Max := V;
            end if;
            if V < Min then
               Min := V;
            end if;
         end;
      end loop;
      Close (File);
   end;

   procedure Read_Sample_Array_Type (Name : String; X : out Sample_Array) is
      use Ada.Text_IO;
      use Ada.Integer_Text_IO;
      File : File_Type;
      V : Integer;
   begin
      Open (File, In_File, Name);
      for I in X'Range loop
         Get (File, V);
         X (I).Bird := Bird_Kind'Enum_Val (V);
      end loop;
      Close (File);
   end;

   function Normalize (X : Float; Min : Float; Max : Float) return Float is
   begin
      return (X - Min) / (Max - Min);
   end;

   procedure Normalize (A : Attribute_Type; Min, Max : Float; X : in out Sample_Array) is
   begin
      for I in X'Range loop
         X (I).Attribute (A) := Normalize (X (I).Attribute (A), Min, Max);
      end loop;
   end;

   procedure Put (X : Sample) is
      use Ada.Float_Text_IO;
   begin
      for E of X.Attribute loop
         Put (E, 4, 1, 0);
      end loop;
   end;

end;
