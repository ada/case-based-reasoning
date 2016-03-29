with Ada.Containers.Vectors;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;


package Dev.Texts is

   use Ada.Text_IO;

   function Get_Put_Float_Width (Fore : Field; Aft : Field) return Natural is (Fore + Aft + 5);

   generic
      type Index is range <>;
      type Num is digits <>;
      with package Vectors is new Ada.Containers.Vectors (Index, Num);
      with package IO is new Ada.Text_IO.Float_IO (Num);
   procedure Generic_Vectors_Put_Float_File (File : File_Type; Item : Vectors.Vector; Prefix : String; Fore : Field := IO.Default_Fore; Aft : Field := IO.Default_Aft; Exp : Field := IO.Default_Exp);

   generic
      type Index is range <>;
      type Num is digits <>;
      with package Vectors is new Ada.Containers.Vectors (Index, Num);
      with package IO is new Ada.Text_IO.Float_IO (Num);
   procedure Generic_Vectors_Put_Float (Item : Vectors.Vector; Prefix : String; Fore : Field := IO.Default_Fore; Aft : Field := IO.Default_Aft; Exp : Field := IO.Default_Exp);

   generic
      type Index is range <>;
      type Num is digits <>;
      with package Vectors is new Ada.Containers.Vectors (Index, Num);
      with package IO is new Ada.Text_IO.Float_IO (Num);
   procedure Generic_Get_Float_File_Append_Vector (File : File_Type; Item : in out Vectors.Vector);

   generic
      type Index is range <>;
      type Num is range <>;
      with package Vectors is new Ada.Containers.Vectors (Index, Num);
      with package IO is new Ada.Text_IO.Integer_IO (Num);
   procedure Generic_Get_Integer_File_Append_Vector (File : File_Type; Item : in out Vectors.Vector);

   generic
      type Index is range <>;
      type Num is range <>;
      with package Vectors is new Ada.Containers.Vectors (Index, Num);
      with package IO is new Ada.Text_IO.Integer_IO (Num);
   procedure Generic_Vectors_Put_Integer_File (File : File_Type; Item : Vectors.Vector; Prefix : String; Width : Field := IO.Default_Width);

   generic
      type Index is range <>;
      type Num is range <>;
      with package Vectors is new Ada.Containers.Vectors (Index, Num);
      with package IO is new Ada.Text_IO.Integer_IO (Num);
   procedure Generic_Vectors_Put_Integer (Item : Vectors.Vector; Prefix : String; Width : Field := IO.Default_Width);

--     generic
--        type Index is range <>;
--        type Num is range <>;
--        with package Vectors is new Ada.Containers.Vectors (Index, Num);
--        with procedure Put (Item  : Num; Width : Field; Base : Number_Base);
--     procedure Generic2_Vector_Put_Integer (Item : Vectors.Vector; Prefix : String; Width : Field);

end;
