with Ada.Float_Text_IO;
with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Integer_Text_IO;

package body CBR.Generic_KNN is



   procedure Summarize (X : Distance_Info_Array; Y : out KNN_Block_Array) is
      S : Election (Class) := (others => 0);
      M : Integer := -1;
      T : Class := Unknown_Class;
      D : Class_Distance (Class) := (others => 0.0);
   begin
      for I in X'Range loop
         D (X (I).Kind) := D (X (I).Kind) + X (I).Distance;
         S (X (I).Kind) := S (X (I).Kind) + 1;
         if M = S (X (I).Kind) then
            T := Unknown_Class;
         elsif M < S (X (I).Kind) then
            M := S (X (I).Kind);
            T := X (I).Kind;
         end if;
         Y (I).Kind := T;
         Y (I).Distance := D;
      end loop;
   end;


   procedure Elect (Item : KNN_Block_Array; Result : in out K_Election) is
   begin
      for I in Item'Range loop
         Result (I) (Item (I).Kind) := Result (I) (Item (I).Kind) + 1;
      end loop;
   end;


   procedure Put (Item : KNN_Block) is
      use Ada.Float_Text_IO;
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
   begin
      Put (Head (Item.Kind'Img, 4));
      for E of Item.Distance (Class'First .. Class'Last) loop
         Put (E, 3, 5, 0);
         Put (" ");
      end loop;
   end;

   procedure Put (Item : KNN_Block_Array) is
      use Ada.Text_IO;
      use Ada.Integer_Text_IO;
      use Ada.Strings.Fixed;
   begin
      Put ("KN |");
      Put ("Class");
      for I in Class loop
         Put (Tail ("Class" & I'Img & " ", 10));
      end loop;
      New_Line;
      for I in Item'Range loop
         Put (I - Item'First + 1, 3);
         Put ("|");
         Put (Item (I));
         New_Line;
      end loop;
   end;

   procedure Put (Item : Distance_Info_Array) is
      package Class_IO is new Ada.Text_IO.Integer_IO (Class);
      use Class_IO;
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for I in Item'Range loop
         Put (Item (I).Kind, 3);
         Put ("|");
         Put (Item (I).Distance, 3, 6, 0);
         New_Line;
      end loop;
   end;

   procedure Put (Item : Election) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
      use Ada.Integer_Text_IO;
   begin
      for I in Item'Range loop
         Put (Item (I), 3);
      end loop;
   end;

   procedure Put (Item : K_Election) is
      use Ada.Integer_Text_IO;
      use Ada.Text_IO;
   begin
      Put_Line ("KN | Class...");
      for I in Item'Range loop
         Put (I - Item'First + 1, 3);
         Put ("|");
         Put (Item (I));
         New_Line;
      end loop;
   end;

end;
