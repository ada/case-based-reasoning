generic
   type Class is range <>;
   Number_Of_Dimension : Natural;
package CBR.Generic_Samples is
   subtype Dimension is Integer range 1 .. Number_Of_Dimension;
   subtype Feature_Vector is Float_Array (Dimension);
   subtype Dimension_Count is Integer range 1 .. Feature_Vector'Length;
   type Sample is record
      Point : Feature_Vector;
      Kind : Class;
   end record;
   type Sample_Array is array (Integer range <>) of Sample;
   procedure Read_Point (Name : String; Dim : Dimension; Last : out Integer; Result : out Sample_Array);
   procedure Read_Class (Name : String; Last : out Integer; Result : out Sample_Array);
   procedure Put (Item : Sample_Array);
end;
