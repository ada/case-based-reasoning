package CBR.Readings is

   procedure Read_Point (Item : in out Asset_Vector; Name : String);
   procedure Read_Class (Item : out Asset_Vector; Name : String);
   procedure Read_Distance (Item : out Asset_Vector; Name : String);
   procedure Read_Prominent (Item : out Prominent_Vector; Name : String);

end;
