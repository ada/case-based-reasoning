with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;

package body CBR.Writings is

   use Ada.Integer_Text_IO;
   use Ada.Float_Text_IO;

   procedure Put_Class (F : File_Type; Item : Class) is
   begin
      Put (F, Integer (Item), 4);
   end;

   procedure Put_Point (F : File_Type; Item : Point) is
   begin
      for E of Item loop
         Put (F, " ");
         Put (F, E);
      end loop;
   end;

   procedure Put_Prominent (F : File_Type; Item : Prominent) is
   begin
      for E of Item.P loop
         Put (F, " ");
         Put (F, E, 4);
      end loop;
   end;

   procedure Put_Prominent_CSV (F : File_Type; Item : Prominent) is
   begin
      for E of Item.P loop
         Put (F, E, 4);
         Put (F, ",");
      end loop;
   end;

   procedure Write_Class (Item : Asset_Vector; Name : String) is
      F : File_Type;
   begin
      Create (F, Out_File, Name);
      for E : Asset of Item loop
         Put_Class (F, E.C);
         Put_Point (F, E.P);
         New_Line (F);
      end loop;
      Close (F);
   end;


   procedure Write_Prominent (Item : Prominent_Vector; Name : String) is
      F : File_Type;
   begin
      Create (F, Out_File, Name);
      for E : Prominent of Item loop
         Put_Prominent (F, E);
         New_Line (F);
      end loop;
      Close (F);
   end;

   procedure Write_Prominent_CSV (Item : Prominent_Vector; Name : String) is
      F : File_Type;
   begin
      Create (F, Out_File, Name);
      for E : Prominent of Item loop
         Put_Prominent_CSV (F, E);
         New_Line (F);
      end loop;
      Close (F);
   end;
end;
