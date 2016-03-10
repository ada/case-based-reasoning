with Sortings;

generic
   type Class is range <>;
   Unknown_Class : Class;
package CBR.Generic_KNN is

   type Distance_Info is record
      Distance : Float;
      Kind : Class;
   end record;

   function ">" (A, B : Distance_Info) return Boolean is (A.Distance > B.Distance);
   function "<" (A, B : Distance_Info) return Boolean is (A.Distance < B.Distance);

   type Distance_Info_Array is array (Integer range <>) of Distance_Info;

   procedure Sort is new Sortings.Generic_Quicksort (Integer, Distance_Info, Distance_Info_Array);

   type Class_Distance is array (Class range <>) of Float;

   type KNN_Block is record
      Distance : Class_Distance (Class);
      Kind : Class;
   end record;

   type KNN_Block_Array is array (Integer range <>) of KNN_Block;

   type Election is array (Class range <>) of Natural;
   type K_Election is array (Integer range <>) of Election (Class);

   procedure Summarize (X : Distance_Info_Array; Y : out KNN_Block_Array);
   procedure Elect (Item : KNN_Block_Array; Result : in out K_Election);

   procedure Put (Item : KNN_Block_Array);
   procedure Put (Item : Distance_Info_Array);
   procedure Put (Item : Election);
   procedure Put (Item : K_Election);

end;
