with Ada.Float_Text_IO;
with Ada.Strings;
with Ada.Text_IO;
with Ada.Strings.Fixed;

package body Birds is

   procedure Put_Attribute_Kind (Width : Natural) is
      use Ada.Float_Text_IO;
      use Ada.Strings.Fixed;
      use Ada.Text_IO;
   begin
      for I in Attribute_Kind loop
         Put (Tail (I'Img, Width));
      end loop;
   end;

end;
