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

   type KNN_Common_Distance is array (Class range <>) of Float;

   type KNN_Block is record
      Distance : KNN_Common_Distance (Class);
      Kind : Class;
   end record;

   type KNN_Block_Array is array (Integer range <>) of KNN_Block;

   type Asset is record
      Distance : KNN_Common_Distance (Class);
      Kind : Class;
   end record;

   type Asset_Array is array (Integer range <>) of Asset;


   type KNN_Vote is array (Class range <>) of Natural;
   type KNN_Vote_Array is array (Integer range <>) of KNN_Vote (Class);

   procedure Make_Summery (X : Distance_Info_Array; Y : out KNN_Block_Array);
   procedure Collective_Vote (Item : KNN_Block_Array; Result : in out KNN_Vote_Array);

   procedure Put (Item : KNN_Block_Array);
   procedure Put (Item : Distance_Info_Array);
   procedure Put (Item : KNN_Vote);
   procedure Put (Item : KNN_Vote_Array);

end;
