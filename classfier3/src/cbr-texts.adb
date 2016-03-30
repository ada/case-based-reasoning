with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with Ada.Strings.Fixed;

package body CBR.Texts is

   use Ada.Text_IO;
   use Ada.Integer_Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Strings.Fixed;

   procedure Put_K_Header is
   begin
      Put (Tail ("K", 3));
   end;

   procedure Put_Prominent_Header is
   begin
      Put (Tail ("Prominent", 10));
   end;

   procedure Put_Prominent_Class_Wise_Header is
   begin
      Put ("  ");
      Put ("Prominent Class-wise");
   end;

   procedure Put_Time_Header is
   begin
      Put (Tail ("Time", 6));
   end;

   procedure Put_Class_Header is
   begin
      Put (Tail ("Class", 6));
   end;

   procedure Put_Point_Header is
   begin
      Put (Tail ("Point", 8));
   end;

   procedure Put_Distance_Header is
   begin
      Put (Tail ("Distance", 8));
   end;

   procedure Put_Class (Item : Asset) is
   begin
      Put (Item.Class, 4);
   end;

   procedure Put_Time (Item : Asset) is
   begin
      Put (Item.Time, 4);
   end;

   procedure Put_Prominent (Item : Prominent) is
   begin
      for E of Item.P loop
         Put (",");
         Put (E, 4);
      end loop;
   end;

   procedure Put_Point (Item : Asset) is
   begin
      for E of Item.Point loop
         Put (",");
         Put (E);
      end loop;
   end;

   procedure Put_Distance_Vector (Item : Asset) is
   begin
      for E of Item.Dis loop
         Put (",");
         Put (E);
      end loop;
   end;

   procedure Put (Item : Prominent_Vector) is
   begin
      Put_K_Header;
      Put ("|");
      Put_Prominent_Class_Wise_Header;
      New_Line;
      for I in Item.First_Index .. Item.Last_Index loop
         Put (I, 3);
         Put ("|");
         Put_Prominent (Item (I));
         New_Line;
      end loop;
   end;

   procedure Put_Point (Item : Asset_Vector) is
   begin
      Put_Time_Header;
      Put_Class_Header;
      Put_Point_Header;
      New_Line;
      for E : Asset of Item loop
         Put (E.Time, 6);
         Put (E.Class, 6);
         Put_Point (E);
         Put_Distance_Vector (E);
         New_Line;
      end loop;
   end;

   procedure Put_Distance (Item : Asset_Vector) is
   begin
      Put_Time_Header;
      Put_Class_Header;
      Put_Distance_Header;
      New_Line;
      for E : Asset of Item loop
         Put_Time (E);
         Put_Class (E);
         Put_Distance_Vector (E);
         New_Line;
      end loop;
   end;

   procedure Put_Prominent (Item : Asset_Vector) is
   begin
      Put_Time_Header;
      Put_Class_Header;
      Put_Prominent_Header;
      New_Line;
      for E : Asset of Item loop
         Put (E.Time, 6);
         Put (E.Class, 6);
         Put (E.Prominent, 10);
         New_Line;
      end loop;
   end;

   procedure Put_Class (Item : Asset_Vector) is
   begin
      Put_Time_Header;
      Put_Class_Header;
      New_Line;
      for E : Asset of Item loop
         Put (E.Time, 6);
         Put (E.Class, 6);
         New_Line;
      end loop;
   end;

end;
