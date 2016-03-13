with Sortings;

generic
   type Class is range <>;
   type Dimension is range <>;
   Unknown_Class : Class;
package CBR.Generic_Samples is
   type Feature_Vector is array (Dimension) of Float;
   subtype Dimension_Count is Integer range 1 .. Feature_Vector'Length;
   subtype Distance_Quantity is Float range 0.0 .. Float'Last;
   type Class_Distance is array (Class range <>) of Distance_Quantity;
   type Class_Count is array (Class range <>) of Natural;
   type Sample is record
      Time : Natural := 0;
      Point : Feature_Vector;
      Kind : Class;
      Distance : Distance_Quantity := Distance_Quantity'First;
      Leading_Kind : Class := Unknown_Class;
      Leading_Distance : Class_Distance (Class) := (others => Distance_Quantity'First);
      K : Natural := 0;
   end record;
   type Sample_Array is array (Integer range <>) of Sample;

   type Election is record
      Leading_Vote : Class_Count (Class) := (others => 0);
   end record;
   type Election_Array is array (Integer range <>) of Election;

   function ">" (A, B : Sample) return Boolean is (A.Distance > B.Distance);
   function "<" (A, B : Sample) return Boolean is (A.Distance < B.Distance);
   procedure Sort is new Sortings.Generic_Quicksort (Integer, Sample, Sample_Array);

   procedure Read_Point (Name : String; Dim : Dimension; Last : out Integer; Result : out Sample_Array);
   procedure Read_Class (Name : String; Last : out Integer; Result : out Sample_Array);

   procedure Summarize (Item : in out Sample_Array);
   procedure Elect (Item : Sample_Array; Result : in out Election_Array);

   procedure Put (Item : Sample_Array; Item2 : Election_Array);

end;
