with Ada.Text_IO;
with Ada.Strings.Fixed;

package body Birds is

   procedure Put_Kind (X : Kind; Width : Natural) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
   begin
      Put (Tail (X'Img, Width));
   end;


   procedure Put_Kind (Width : Natural) is
   begin
      for I in Kind loop
         Put_Kind (I, Width);
      end loop;
   end;




end;
