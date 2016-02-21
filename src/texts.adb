with Ada.Strings.Fixed;
with Ada.Float_Text_IO;

package body Texts is


   procedure Generic_Put_Enum_Head (Item : Enum; Width : Natural; Pad : Character) is
       use Ada.Strings.Fixed;
   begin
      Put (Head (Item'Img, Width, Pad));
   end;

   procedure Generic_Put_Enum_Tail (Item : Enum; Width : Natural; Pad : Character) is
       use Ada.Strings.Fixed;
   begin
      Put (Tail (Item'Img, Width, Pad));
   end;


   procedure Generic_Put_All_Enum_Head (Width : Field; Pad : Character; Separator : String) is
      use Ada.Strings.Fixed;
   begin
      for I in Enum loop
         Put (Head (I'Img, Width, Pad));
         Put (Separator);
      end loop;
   end;

   procedure Generic_Put_All_Enum_Tail (Width : Field; Pad : Character; Separator : String) is
      use Ada.Strings.Fixed;
   begin
      for I in Enum loop
         Put (Tail (I'Img, Width, Pad));
         Put (Separator);
      end loop;
   end;

   procedure Generic_Put_Digit_Vector (Item : Vector; Fore : Field; Aft : Field; Exp : Field; Separator : String) is
      package T is new Ada.Text_IO.Float_IO (Element);
   begin
      for E of Item loop
         T.Put (E, Fore, Aft, Exp);
         Put (Separator);
      end loop;
   end;


   procedure Generic_Read_Float_List (Name : String; Count : Natural; Destination : out Vector; Min : out Float; Max : out Float) is
      use Ada.Float_Text_IO;
      File : File_Type;
      Value : Float;
   begin
      Min := Float'Last;
      Max := Float'First;
      Open (File, In_File, Name);
      loop
         exit when Count = 0;
         exit when Positive (Line (File)) >= Count;
         exit when End_Of_Page (File);
         Get (File, Value);
         Max := Float'Max (Max, Value);
         Min := Float'Min (Min, Value);
         Set (Positive (Line (File)), Value, Destination);
      end loop;
      Close (File);
   end;


end;
