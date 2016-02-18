with Ada.Text_IO;
with Ada.Float_Text_IO;

package body Birds.Deviations is

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
