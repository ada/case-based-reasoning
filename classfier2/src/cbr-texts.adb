package body CBR.Texts is

   procedure Put_Vector is new Generic_Vectors_Put_Integer (Natural, Natural, Class_Vectors, Class_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float (Natural, Distance, Distance_Vectors, Distance_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float (Natural, Float, Float_Vectors, Ada.Float_Text_IO);

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
      Put (Tail ("Point", Get_Put_Float_Width (2, 3)));
   end;

   procedure Put_Distance_Header is
   begin
      Put (Tail ("Distance", Get_Put_Float_Width (2, 3)));
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
         Put_Vector (Item (I).P, "", 3);
         New_Line;
      end loop;
   end;

   procedure Put_Point (Item : Asset_Vector) is
      Fore : Field := 2;
      Aft : Field := 3;
   begin
      Put_Time_Header;
      Put_Class_Header;
      Put_Point_Header;
      New_Line;
      for E : Asset of Item loop
         Put (E.Time, 6);
         Put (E.Class, 6);
         Put_Vector (E.Point, "", Fore, Aft);
         Put_Vector (E.Dis, "", Fore, Aft);
         New_Line;
      end loop;
   end;

   procedure Put_Distance (Item : Asset_Vector) is
      Fore : Field := 2;
      Aft : Field := 3;
   begin
      Put_Time_Header;
      Put_Class_Header;
      Put_Distance_Header;
      New_Line;
      for E : Asset of Item loop
         Put (E.Time, 6);
         Put (E.Class, 6);
         Put_Vector (E.Dis, "", Fore, Aft);
         New_Line;
      end loop;
   end;

   procedure Put_Prominent (Item : Asset_Vector) is
      Fore : Field := 2;
      Aft : Field := 3;
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
      Fore : Field := 2;
      Aft : Field := 3;
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
