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

   procedure Put (Item : Class) is
   begin
      Put (Integer (Item), 6);
   end;

   procedure Put (Item : Time) is
   begin
      Put (Integer (Item), 6);
   end;

   procedure Put_Prominent (Item : Prominent) is
      use Ada.Containers;
   begin
      if Item.P.Length > 0 then
         Put (Item.P (Item.P.First_Index), 16);
         for I in Item.P.First_Index + 1 .. Item.P.Last_Index loop
            Put (",");
            Put (Item.P (I), 16);
         end loop;
      end if;
   end;

   procedure Put_Point (Item : Asset) is
   begin
      for E of Item.P loop
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

   procedure Put_CSV (Item : Prominent_Vector) is
   begin
      for I in Item.First_Index.. Item.Last_Index loop
         --Put (I, 3);
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
         Put (E.T);
         Put (E.C);
         Put_Point (E);
         New_Line;
      end loop;
   end;

   procedure Put_Class (Item : Asset_Vector) is
   begin
      Put_Time_Header;
      Put_Class_Header;
      New_Line;
      for E : Asset of Item loop
         Put (E.T);
         Put (E.C);
         New_Line;
      end loop;
   end;

   procedure Put (Item : Distance_Info) is
   begin
      Put (Item.C);
      Put (Item.Dis);
   end;

   procedure Put (Item : Distance_Info_Vector) is
   begin
      for E of Item loop
         Put (E);
         New_Line;
      end loop;
   end;

   procedure Put (Item : K_Class_Vector) is
   begin
      for E of Item loop
         Put (E);
         New_Line;
      end loop;
   end;

end;
