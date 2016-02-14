with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings.Maps.Constants;

package body Birds is

   procedure Put_Kind (X : Kind; Width : Natural) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Ada.Strings.Maps.Constants;
      S : String := X'Img;
   begin
      Translate (S, Lower_Case_Map);
      Translate (S (S'First .. S'First), Upper_Case_Map);
      Put (Tail (S, Width));
   end;


   procedure Put_Kind (Width : Natural) is
   begin
      for I in Kind loop
         Put_Kind (I, Width);
      end loop;
   end;




end;
