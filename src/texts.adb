with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Maps.Constants;
with Ada.Float_Text_IO;

package body Texts is


   procedure Generic_Put_Enum_Value (X : Enum; Width : Natural) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Ada.Strings.Maps.Constants;
      S : String := X'Img;
   begin
      Translate (S, Lower_Case_Map);
      Translate (S (S'First .. S'First), Upper_Case_Map);
      Put (Tail (S, Width));
   end;

   procedure Generic_Put_Enum (Width : Natural; Separator : String) is
      use Ada.Text_IO;
   begin
      for I in Enum loop
         Put (I, Width);
         Put (Separator);
      end loop;
   end;


   procedure Put (Value : Float; Fore : Natural; Width : Natural) is
      use Ada.Float_Text_IO;
   begin
      Put (Value, Fore, Width - Fore - 1, 0);
   end;

end;
