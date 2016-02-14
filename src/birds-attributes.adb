with Ada.Float_Text_IO;
with Ada.Strings;
with Ada.Text_IO;
with Ada.Strings.Fixed;

package body Birds.Attributes is


   procedure Put_Kind (Width : Natural) is
      use Ada.Float_Text_IO;
      use Ada.Strings.Fixed;
      use Ada.Text_IO;
   begin
      for I in Kind loop
         Put (Tail (I'Img, Width));
      end loop;
   end;

   procedure Put_Attribute (X : Float; Width : Natural) is
      use Ada.Float_Text_IO;
      Right : constant Natural := 4;
   begin
      Put (X, 4, Width - Right - 1, 0);
   end;


end;
