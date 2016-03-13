with CBR;

generic
   Number_Of_Dimensions : Natural;
   with function Get_Dimension_File_Name (I : Positive) return String;
   Number_Of_Samples : Natural;
   with function Get_Sample_Index (I : Positive) return Positive;
   Class_File_Name : String;
   Number_Of_Classes : Natural;
   Maximum_Number_Of_Assets : Natural;
   Weighted_Distance : CBR.Weighted_Distance_Function;
   Weight : CBR.Float_Array;
procedure Main_CBR_Load;
