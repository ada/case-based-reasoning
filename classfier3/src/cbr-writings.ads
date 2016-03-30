with Ada.Text_IO;

package CBR.Writings is

   use Ada.Text_IO;

   procedure Put_Class (F : File_Type; Item : Integer);
   procedure Put_Point (F : File_Type; Item : Float_Vector);
   procedure Put_Correctness (F : File_Type; Item : Natural);
   procedure Put_Distance_Vector (F : File_Type; Item : Distance_Vector);
   procedure Put_Prominent (F : File_Type; Item : Prominent);
   procedure Put_Prominent_CSV (F : File_Type; Item : Prominent);
   procedure Write_Class (Item : Asset_Vector; Name : String);
   procedure Write_Distance (Item : Asset_Vector; Name : String);
   procedure Write_Correctness (Item : Natural_Vector; Name : String);
   procedure Write_Prominent (Item : Prominent_Vector; Name : String);
   procedure Write_Prominent_CSV (Item : Prominent_Vector; Name : String);

end;
