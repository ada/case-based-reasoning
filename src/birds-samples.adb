with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Texts;

package body Birds.Samples is


   procedure Read_Vector (Name : String; Kind : Attributes.Kinds.Kind; Destination : out Vector; Min, Max : out Float) is
      procedure Set (Index : Positive; Value : Float; Destination : out Vector) is
      begin
         Destination (Index).Attribute (Kind) := Value;
      end;
      procedure Read is new Texts.Generic_Read_Float_List (Vector, Set);
   begin
      Read (Name, Destination'Length, Destination, Min, Max);
   end;

   procedure Read_Vector_Kind (Name : String; Destination : out Vector) is
      use Ada.Text_IO;
      use Ada.Integer_Text_IO;
      File : File_Type;
      Value : Integer;
   begin
      Open (File, In_File, Name);
      for Index in Destination'Range loop
         Get (File, Value);
         Destination (Index).Bird := Birds.Kinds.Kind'Enum_Val (Value);
      end loop;
      Close (File);
   end;

   function Normalize (Value : Float; Min, Max : Float) return Float is
   begin
      return (Value - Min) / (Max - Min);
   end;

   procedure Normalize_Vector (Kind : Attributes.Kinds.Kind; Min, Max : Float; Destination : in out Vector) is
   begin
      for Index in Destination'Range loop
         Destination (Index).Attribute (Kind) := Normalize (Destination (Index).Attribute (Kind), Min, Max);
      end loop;
   end;

   procedure Read_Vector_Normalized (Name : String; Kind : Attributes.Kinds.Kind; Destination : out Vector) is
      Min, Max : Float := 0.0;
   begin
      Read_Vector (Name, Kind, Destination, Min, Max);
      Normalize_Vector (Kind, Min, Max, Destination);
   end;


end;
