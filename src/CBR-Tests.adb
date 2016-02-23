package body CBR.Tests is

   procedure KNN (S : Sample; X : Sample_Array; Y : out Neighbor_Array) is
      K : Index := 0;
      Nearest : array (-1 .. Y'Length) of Float;
      D : Float;
   begin
      Nearest := (others => Float'Last);
      Nearest (-1) := Float'First;
      Y := (others => Index'First);
      loop
         exit when K = Y'Length;
         for I in X'Range loop
            D := Distance (X (I), S);
            if Nearest (Integer (K) - 1) < D and D < Nearest (Integer (K)) then
               Y (Y'First + K) := I;
               Nearest (Integer (K)) := D;
            end if;
         end loop;
         K := K + 1;
      end loop;
   end;


   procedure KNN_Summery (X : Index_Array; Y : out Index_Array) is
      S : array (Index) of Natural := (others => 0);
      M : Integer := -1;
      T : Index := Unknown;
   begin
      for I in X'Range loop
         S (X (I)) := S (X (I)) + 1;
         if M = S (X (I)) then
            T := Unknown;
         elsif M < S (X (I)) then
            M := S (X (I));
            T := X (I);
         end if;
         Y (I) := T;
      end loop;
   end;


end;

