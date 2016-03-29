with Ada.Characters.Handling;

package body CBR.Readings is

   procedure Skip_Space (F : File_Type) is
      EOL : Boolean;
      C : Character;
   begin
      loop
         exit when End_Of_File (F);
         Look_Ahead (F, C, EOL);
         exit when EOL;
         exit when C /= ' ';
         Get_Immediate (F, C);
      end loop;
   end;

   procedure Get_Time (F : File_Type; Item : out Asset) is
   begin
      Item.Time := Natural (Line (F));
   exception
      when others => raise Program_Error with "Get_Time. at line " & Line (F)'Img & ".";
   end;

   procedure Get_Class (F : File_Type; Item : out Natural) is
   begin
      Get (F, Item);
      Skip_Space (F);
   exception
      when others => raise Program_Error with "Get_Class. Can not get a value at line " & Line (F)'Img & ".";
   end;

   procedure Get_Class (F : File_Type; Item : out Asset) is
   begin
      Get (F, Item.Class);
      Skip_Space (F);
   exception
      when others => raise Program_Error with "Get_Class. Can not get a value at line " & Line (F)'Img & ".";
   end;

   procedure Get_Point_Element (F : File_Type; Item : out Float) is
   begin
      Get (F, Item);
      Skip_Space (F);
   exception
      when others => raise Program_Error with "Get_Point_Element. Can not get a value at line " & Line (F)'Img & ".";
   end;

   procedure Get_Distance (F : File_Type; Item : out Float) is
   begin
      Get (F, Item);
      Skip_Space (F);
   exception
      when others => raise Program_Error with "Get_Distance. Can not get a value at line " & Line (F)'Img & ".";
   end;




   procedure Get_Class_Vector_Append (F : File_Type; Item : out Prominent) is
      use Class_Vectors;
      X : Natural;
   begin
      while not End_Of_Line (F) loop
         Get_Class (F, X);
         Append (Item.P, X);
      end loop;
      if not End_Of_File (F) then
         Skip_Line (F);
      end if;
   end;

   procedure Get_Point_Vector_Append (F : File_Type; Item : in out Asset) is
      use Float_Vectors;
      V : Float;
   begin
      while not End_Of_Line (F) loop
         Get_Point_Element (F, V);
         Append (Item.Point, V);
      end loop;
      if not End_Of_File (F) then
         Skip_Line (F);
      end if;
   end;

   procedure Get_Distance_Vector_Append (F : File_Type; Item : out Asset) is
      use Distance_Vectors;
      V : Float;
   begin
      while not End_Of_Line (F) loop
         Get_Distance (F, V);
         Append (Item.Dis, V);
      end loop;
      if not End_Of_File (F) then
         Skip_Line (F);
      end if;
   end;









   procedure Read_Prominent (Item : out Prominent_Vector; Name : String) is
      function Get (F : File_Type) return Prominent with Inline_Always;
      function Get (F : File_Type) return Prominent is
         P : Prominent;
      begin
         Get_Class_Vector_Append (F, P);
         return P;
      end;
      use Prominent_Vectors;
      F : File_Type;
   begin
      Open (F, In_File, Name);
      while not End_Of_File (F) loop
         Append (Item, Get (F));
      end loop;
      Close (F);
   end;




   procedure Read_Class (Item : out Asset_Vector; Name : String) is
      function Get (F : File_Type) return Asset with Inline_Always;
      function Get (F : File_Type) return Asset is
         A : Asset;
      begin
         Get_Time (F, A);
         Get_Class (F, A);
         Get_Point_Vector_Append (F, A);
         return A;
      end;
      use Asset_Vectors;
      F : File_Type;
   begin
      Open (F, In_File, Name);
      while not End_Of_File (F) loop
         Append (Item, Get (F));
      end loop;
      Close (F);
   end;




   procedure Read_Point (Item : in out Asset_Vector; Name : String) is
      use Asset_Vectors;
      F : File_Type;
   begin
      Open (F, In_File, Name);
      for E : Asset of Item loop
         if End_Of_File (F) then
            raise Program_Error with "The file " & Name & " has less rows than the class file.";
         end if;
         Get_Point_Vector_Append (F, E);
      end loop;
      Close (F);
   end;




   procedure Read_Distance (Item : out Asset_Vector; Name : String) is
      function Get (F : File_Type) return Asset with Inline_Always;
      function Get (F : File_Type) return Asset is
         A : Asset;
      begin
         Get_Time (F, A);
         Get_Class (F, A);
         Get_Distance_Vector_Append (F, A);
         return A;
      end;
      use Asset_Vectors;
      F : File_Type;
   begin
      Open (F, In_File, Name);
      while not End_Of_File (F) loop
         Append (Item, Get (F));
      end loop;
      Close (F);
   end;

end;
