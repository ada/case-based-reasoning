with Ada.Text_IO;

package CBR.Writings is

   use Ada.Text_IO;

   procedure Put_Class (F : File_Type; Item : Class);
   procedure Put_Point (F : File_Type; Item : Point);
   procedure Put_Prominent (F : File_Type; Item : Prominent);
   procedure Put_Prominent_CSV (F : File_Type; Item : Prominent);

   procedure Write_Class (Item : Asset_Vector; Name : String);
   procedure Write_Prominent (Item : Prominent_Vector; Name : String);
   procedure Write_Prominent_CSV (Item : Prominent_Vector; Name : String);

end;
