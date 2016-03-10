with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Integer_Text_IO;

package body CBR.Generic_Samples is

   package Class_IO is new Ada.Text_IO.Integer_IO (Class);

   procedure Read_Point (Name : String; Dim : Dimension; Last : out Integer; Result : out Sample_Array) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
      F : File_Type;
   begin
      Open (F, In_File, Name);
      Last := Result'First;
      loop
         exit when End_Of_File (F);
         exit when Last > Result'Last;
         Get (F, Result (Last).Point (Dim));
         Last := Last + 1;
      end loop;
      Last := Last - 1;
   end;

   procedure Read_Class (Name : String; Last : out Integer; Result : out Sample_Array) is
      use Ada.Text_IO;
      F : File_Type;
   begin
      Open (F, In_File, Name);
      Last := Result'First;
      loop
         exit when End_Of_File (F);
         exit when Last > Result'Last;
         Class_IO.Get (F, Result (Last).Kind);
         Result (Last).Time := Last;
         Last := Last + 1;
      end loop;
      Last := Last - 1;
   end;

   procedure Summarize (Item : in out Sample_Array) is
      S : Class_Count (Class) := (others => 0);
      M : Integer := -1;
      T : Class := Unknown_Class;
      D : Class_Distance (Class) := (others => 0.0);
   begin
      for I in Item'Range loop
         D (Item (I).Kind) := D (Item (I).Kind) + Item (I).Distance;
         S (Item (I).Kind) := S (Item (I).Kind) + 1;
         if M = S (Item (I).Kind) then
            T := Unknown_Class;
         elsif M < S (Item (I).Kind) then
            M := S (Item (I).Kind);
            T := Item (I).Kind;
         end if;
         Item (I).Leading_Kind := T;
         Item (I).Leading_Distance := D;
         Item (I).K := I - Item'First + 1;
      end loop;
   end;

   procedure Elect (Item : Sample_Array; Result : in out Election_Array) is
   begin
      for I in Item'Range loop
         Result (I).Vote (Item (I).Kind) := Result (I).Vote (Item (I).Kind) + 1;
         Result (I).Leading_Vote (Item (I).Leading_Kind) := Result (I).Leading_Vote (Item (I).Leading_Kind) + 1;
      end loop;
   end;

   procedure Put (Item : Feature_Vector) is
      use Ada.Float_Text_IO;
      use Ada.Text_IO;
   begin
      for I in Item'Range loop
         Put (Item (I), 2, 2, 0);
         Put (" ");
      end loop;
   end;

   procedure Put (Item : Class_Distance) is
      use Ada.Float_Text_IO;
      use Ada.Text_IO;
   begin
      for E of Item loop
         Put (E, 2, 5, 0);
         Put (" ");
      end loop;
   end;

   procedure Put (Item : Class_Count) is
      use Ada.Text_IO;
      use Ada.Integer_Text_IO;
   begin
      for E of Item loop
         Put (E, 5);
         Put (" ");
      end loop;
   end;

   procedure Put (Item : Sample_Array; Item2 : Election_Array) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Ada.Float_Text_IO;
      use Ada.Integer_Text_IO;
   begin
      Put (Tail ("Time", 5));
      Put (" ");
      Put (Tail ("Class", 5));
      Put ("|");
      for I in Dimension loop
         Put (Tail ("Fea", 3));
         Put (I, 2);
         Put (" ");
      end loop;
      Put ("|");
      Put (Tail ("Distance", 8));
      Put (" ");
      Put (Tail ("KNear", 5));
      Put (" ");
      Put (Tail ("LeadC", 5));
      Put ("|");
      for I in Class loop
         Put (Tail ("ClassD", 6));
         Class_IO.Put (I, 2);
         Put (" ");
      end loop;
      Put ("|");
      for I in Class loop
         Put (Tail ("IV", 3));
         Class_IO.Put (I, 2);
         Put (" ");
      end loop;
      Put ("|");
      for I in Class loop
         Put (Tail ("LV", 3));
         Class_IO.Put (I, 2);
         Put (" ");
      end loop;
      New_Line;
      Put_Line (Ada.Strings.Fixed."*" (200, "-"));
      for I in Item'Range loop
         Put (Item (I).Time, 5);
         Put (" ");
         Class_IO.Put (Item (I).Kind, 5);
         Put ("|");
         Put (Item (I).Point);
         Put ("|");
         Put (Item (I).Distance, 2, 5, 0);
         Put (" ");
         Put (Item (I).K, 5);
         Put (" ");
         Class_IO.Put (Item (I).Leading_Kind, 5);
         Put ("|");
         Put (Item (I).Leading_Distance);
         Put ("|");
         Put (Item2 (I).Vote);
         Put ("|");
         Put (Item2 (I).Leading_Vote);
         New_Line;
      end loop;
   end;

end;
