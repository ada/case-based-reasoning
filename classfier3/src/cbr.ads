with Ada.Containers.Vectors;
with Dev.Math;
with Dev.Math.Distances;

package CBR is

   use Ada.Containers;
   use Dev.Math;

   package Class_Vectors is new Ada.Containers.Vectors (Natural, Natural);
   package Natural_Vectors is new Ada.Containers.Vectors (Positive, Natural);
   package Distance_Vectors is new Ada.Containers.Vectors (Natural, Distance);

   subtype Class_Vector is Class_Vectors.Vector;
   subtype Natural_Vector is Natural_Vectors.Vector;
   subtype Distance_Vector is Distance_Vectors.Vector;

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

   procedure Calc_Distance (Item : in out Asset_Vector; Sample : Asset_Vector; Kind : Distances.Kinds.Kind; W : Float_Vector);
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

   procedure Initialize (Item : in out Prominent_Vector; Class_Count : Natural; K_Count : Natural);

   procedure Evaluate (Item : in out Prominent_Vector; Sample : Asset_Vector; Correctness : out Natural_Vector);
   -- If sample have known classes then we can evaluate the prominent classes.
   -- This is used if we have multiple samples.

   function Dim_Count_Min (Item : Asset_Vector) return Natural;
   function Dim_Count_Max (Item : Asset_Vector) return Natural;
   function Max_Class (Item : Asset_Vector) return Natural;
   function Unique_Class_Count (Item : Asset_Vector) return Natural;

end;
