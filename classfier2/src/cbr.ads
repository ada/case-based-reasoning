with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
with Ada.Numerics.Real_Arrays;
with Ada.Containers.Formal_Vectors;
with Ada.Containers.Vectors;
with Ada.Containers.Indefinite_Vectors;
with Ada.Assertions;
with Ada.Strings.Fixed;
with Ada.Numerics.Elementary_Functions;

with Dev.Math;
with Dev.Math.Distances;
with Dev.Texts;

package CBR is

   use Ada.Numerics.Elementary_Functions;
   use Ada.Numerics.Real_Arrays;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Containers;
   use Ada.Strings.Fixed;

   use Dev.Math;
   use Dev.Texts;

   package Class_Vectors is new Ada.Containers.Vectors (Natural, Natural);
   package Natural_Vectors is new Ada.Containers.Vectors (Positive, Natural);
   package Distance_Vectors is new Ada.Containers.Vectors (Natural, Distance);

   subtype Class_Vector is Class_Vectors.Vector;
   subtype Natural_Vector is Natural_Vectors.Vector;
   subtype Distance_Vector is Distance_Vectors.Vector;

   package Class_IO is new Ada.Text_IO.Integer_IO (Natural);
   package Natural_IO is new Ada.Text_IO.Integer_IO (Natural);
   package Distance_IO is new Ada.Text_IO.Float_IO (Distance);

   procedure Put_Vector is new Generic_Vectors_Put_Integer_File (Natural, Natural, Class_Vectors, Class_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float_File (Natural, Distance, Distance_Vectors, Distance_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float_File (Natural, Float, Float_Vectors, Ada.Float_Text_IO);

   type Asset is record
      Time : Natural := 0;
      Class : Natural := 0;
      Prominent : Integer := 0;
      Point : Float_Vector;
      Dis : Distance_Vector;
   end record;

   type Prominent is record
      P : Class_Vector;
   end record;

   package Prominent_Vectors is new Ada.Containers.Vectors (Positive, Prominent);
   package Asset_Vectors is new Ada.Containers.Vectors (Positive, Asset);

   subtype Asset_Vector is Asset_Vectors.Vector;
   subtype Prominent_Vector is Prominent_Vectors.Vector;

   procedure Write_Class (Item : Asset_Vector; Name : String);
   procedure Write_Distance (Item : Asset_Vector; Name : String);
   procedure Write_Correctness (Item : Natural_Vector; Name : String);
   procedure Write_Prominent (Item : Prominent_Vector; Name : String);

   procedure Calc_Distance (Item : in out Asset_Vector; Sample : Asset_Vector; Kind : Distances.Kinds.Kind);
   -- Calculate distance to all assets for each sample.
   -- This is the first step of CBR-KNN.

   procedure Sort_Distance (Item : in out Asset_Vector; Index : Natural);
   -- Sort by distance index.
   -- Index represents the sample to be sorted.
   -- This is the second step of CBR-KNN.

   procedure Calc_Prominent (Item : in out Asset_Vector);
   -- Calculate the most prominent classes.
   -- This is the last step of CBR-KNN.

   procedure Summarize (Summation : in out Prominent_Vector; Estimations : Asset_Vector) with Pre => Summation.First_Index = Estimations.First_Index;
   -- Summarize all prominent estimation for all K.
   -- This is used if we have multiple samples.

   procedure Initialize (Item : in out Prominent_Vector; Class_Count : Count_Type; K_Count : Count_Type);

   procedure Evaluate (Item : in out Prominent_Vector; Sample : Asset_Vector; Correctness : out Natural_Vector);
   -- If sample have known classes then we can evaluate the prominent classes.
   -- This is used if we have multiple samples.

   function Dim_Count_Min (Item : Asset_Vector) return Natural;
   function Dim_Count_Max (Item : Asset_Vector) return Natural;
   function Max_Class (Item : Asset_Vector) return Natural;
   function Unique_Class_Count (Item : Asset_Vector) return Natural;

end;
