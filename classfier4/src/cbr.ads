with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Dev.Math;
with Dev.Math.Distances;

package CBR is

   type Time is new Natural;
   type Class is new Natural;

   package Class_Counter_Vectors is new Ada.Containers.Vectors (Class, Natural);
   package K_Class_Vectors is new Ada.Containers.Vectors (Positive, Class);
   package Name_Vectors is new Ada.Containers.Vectors (Natural, Ada.Strings.Unbounded.Unbounded_String, Ada.Strings.Unbounded."=");
   subtype Name_Vector is Name_Vectors.Vector;

   subtype Class_Counter_Vector is Class_Counter_Vectors.Vector;
   subtype K_Class_Vector is K_Class_Vectors.Vector;

   subtype Point is Dev.Math.Float_Vector;
   subtype Weight_Vector is Dev.Math.Float_Vector;

   type Asset is record
      T : Time := 0;
      C : Class := 0;
      P : Point;
   end record;

   type Prominent is record
      P : Class_Counter_Vector;
   end record;

   type Distance_Info is record
      T : Time := 0;
      C : Class := 0;
      Dis : Float;
   end record;

   package Asset_Vectors is new Ada.Containers.Vectors (Positive, Asset);
   package Prominent_Vectors is new Ada.Containers.Vectors (Positive, Prominent);
   package Distance_Info_Vectors is new Ada.Containers.Vectors (Positive, Distance_Info);

   subtype Asset_Vector is Asset_Vectors.Vector;
   subtype Prominent_Vector is Prominent_Vectors.Vector;
   subtype Distance_Info_Vector is Distance_Info_Vectors.Vector;


   procedure Initialize (Item : in out Prominent_Vector; Class_Count : Natural; K_Count : Natural);

   --procedure Evaluate (Item : in out Prominent_Vector; Sample : Asset_Vector; Correctness : out Natural_Vector);
   -- If sample have known classes then we can evaluate the prominent classes.
   -- This is used if we have multiple samples.

   function Dim_Count_Min (Item : Asset_Vector) return Natural;
   function Dim_Count_Max (Item : Asset_Vector) return Natural;
   function Max_Class (Item : Asset_Vector) return Class;
   function Unique_Class_Count (Item : Asset_Vector) return Natural;
   procedure Find_Min_Max (X : Asset_Vector; Min : in out Point; Max : in out Point);
   procedure Normalize (X : in out Asset_Vector; Min : in out Point; Max : in out Point);
   procedure Initialize_Min_Max (X : Asset_Vector; Min : in out Point; Max : in out Point);

   procedure Calc_Distance (DB : Asset_Vector; Sample : Asset; Kind : Dev.Math.Distances.Kinds.Kind; W : Weight_Vector; D : in out Distance_Info_Vector);
   procedure Calc_Prominent (D : Distance_Info_Vector; To : in out K_Class_Vector);
   procedure Sort (Container : in out Distance_Info_Vector);
   procedure Summarize1 (Estimations : K_Class_Vector; To : in out Prominent_Vector);



end;
