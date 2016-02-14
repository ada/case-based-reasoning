with Ada.Strings;
with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Float_Text_IO;

package body Birds.Deviations is
   procedure Put_Kind (X : Deviations.Kind; Width : Natural) is
      use Ada.Strings.Fixed;
      use Ada.Text_IO;
      Trim_Right : constant Natural := 5;
   begin
      Put (Tail (X'Img (X'Img'First .. X'Img'Last - Trim_Right), Width));
   end;

   procedure Put_Kind (Width : Natural; Separator : String) is
      use Ada.Text_IO;
   begin
      for I in Deviations.Kind loop
         Put_Kind (I, Width);
         Put (Separator);
      end loop;
   end;

   procedure Put_Vector (X : Deviations.Vector; Width : Natural; Separator : String) is
      use Ada.Float_Text_IO;
      use Ada.Text_IO;
   begin
      for I in X'Range loop
         Put (X (I), 4, Width - 5, 0);
         Put (Separator);
      end loop;
   end;
end;
