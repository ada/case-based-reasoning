with Ada.Text_IO;
with Main_CBR_Load;
with Ada.Command_Line;
with CBR;
with CBR.Distances;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;

procedure Main_KNN is

   use Ada.Text_IO;
   use Ada.Integer_Text_IO;
   use Ada.Command_Line;

   function Get_Weighted_Distance_Function return CBR.Weighted_Distance_Function is
      Name : constant String := Argument (1);
   begin
      if Name = "Euclidean1" then
         return CBR.Distances.Euclidean1'Access;
      elsif Name = "Euclidean2" then
         return CBR.Distances.Euclidean2'Access;
      elsif Name = "Canberra" then
         return CBR.Distances.Canberra'Access;
      elsif Name = "Manhattan" then
         return CBR.Distances.Manhattan'Access;
      else
         return null;
      end if;
   end;

   Maximum_Number_Of_Assets : constant Natural := Natural'Value (Argument (2));
   Number_Of_Classes : constant Natural := Natural'Value (Argument (3));
   Class_File_Name : constant String := Argument (4);
   Number_Of_Dimensions : constant Natural := Natural'Value (Argument (5));
   Number_Of_Samples : constant Natural := Natural'Value (Argument (6 + Number_Of_Dimensions * 2));

   function Get_Dimension_File_Name (Index : Positive) return String is
   begin
      return Argument (Index + 5);
   end;

   function Get_Sample_Index (Index : Positive) return Positive is
   begin
      return Positive'Value (Argument (6 + Number_Of_Dimensions * 2 + Index));
   end;


   function Get_Weights return CBR.Float_Array is
      use Ada.Float_Text_IO;
      Weight : CBR.Float_Array (1 .. Number_Of_Samples) := (others => 1.0);
   begin
      for I in Weight'Range loop
         Weight (I) := Float'Value (Argument (5 + Number_Of_Dimensions + I));
         Put ("Weight ");
         Put (Weight (I), 3, 3, 0);
         New_Line;
      end loop;
      return Weight;
   end;

   procedure Test1 is new Main_CBR_Load
     (
      Number_Of_Dimensions => Number_Of_Dimensions,
      Get_Dimension_File_Name => Get_Dimension_File_Name,
      Number_Of_Samples => Number_Of_Samples,
      Get_Sample_Index => Get_Sample_Index,
      Class_File_Name => Class_File_Name,
      Number_Of_Classes => Number_Of_Classes,
      Maximum_Number_Of_Assets => Maximum_Number_Of_Assets,
      Weighted_Distance => Get_Weighted_Distance_Function,
      Weight => Get_Weights
     );


begin

   Put_Line ("");

   for I in 1 .. Ada.Command_Line.Argument_Count loop
      Put (I, 3);
      Put (" ");
      Put (Argument (I));
      New_Line;
   end loop;

   New_Line;

   Test1;

end;
