with Ada.Float_Text_IO;
with Ada.Strings;
with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings.Maps.Constants;

package body Birds.Attributes is

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

   procedure Put_Attribute (X : Float; Width : Natural) is
      use Ada.Float_Text_IO;
      Right : constant Natural := 4;
   begin
      Put (X, 4, Width - Right - 1, 0);
   end;


end;
