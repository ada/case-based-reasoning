package body Dev.Texts is

   procedure Generic_Vectors_Put_Float_File (File : File_Type; Item : Vectors.Vector; Prefix : String; Fore : Field := IO.Default_Fore; Aft : Field := IO.Default_Aft; Exp : Field := IO.Default_Exp) is
   begin
      for E : Num of Item loop
         Put (Prefix);
         IO.Put (File, E, Fore, Aft, Exp);
      end loop;
   end;

   procedure Generic_Vectors_Put_Float (Item : Vectors.Vector; Prefix : String; Fore : Field := IO.Default_Fore; Aft : Field := IO.Default_Aft; Exp : Field := IO.Default_Exp) is
   begin
      for E : Num of Item loop
         Put (Prefix);
         IO.Put (E, Fore, Aft, Exp);
      end loop;
   end;

   procedure Generic_Get_Integer_File_Append_Vector (File : File_Type; Item : in out Vectors.Vector) is
      V : Num;
   begin
      while not End_Of_Line (File) loop
         IO.Get (File, V);
         Vectors.Append (Item, V);
      end loop;
   end;

   procedure Generic_Get_Float_File_Append_Vector (File : File_Type; Item : in out Vectors.Vector) is
      V : Num;
   begin
      while not End_Of_Line (File) loop
         IO.Get (File, V);
         Vectors.Append (Item, V);
      end loop;
   end;

   procedure Generic_Vectors_Put_Integer_File (File : File_Type; Item : Vectors.Vector; Prefix : String; Width : Field := IO.Default_Width) is
   begin
      for E : Num of Item loop
         Put (Prefix);
         IO.Put (File, E, Width);
      end loop;
   end;

   procedure Generic_Vectors_Put_Integer (Item : Vectors.Vector; Prefix : String; Width : Field := IO.Default_Width) is
   begin
      for E : Num of Item loop
         Put (Prefix);
         IO.Put (E, Width);
      end loop;
   end;

end;
