with Ada.Strings.Fixed;

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


end;
