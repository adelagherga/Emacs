//SUnitXYZ.m

/*
INPUT:
    S:= [p_1,...,p_s], p_i primes in S

OUTPUT:
    eqns:= [[x_1,y_1,z_1],...,[x_n,y_n,z_n]], all S-unit equations x_i + y_i = z_i, where
        x_i, y_i, z_i:= prod_{i:= 1 to s} p_i^{a_i}, for pairwise relatively prime rational integers x_i, y_i, z_i
    
COMMENTS:
    Computes all S-unit equations x + y = z
    This algorithm uses the Fincke-Pohst algorithm and LLL 

    Based on the algorithm found in Chapter 6 of the Reference

REFERENCE:
    B.M.M.De Weger. Algorithms For Diophantine Equations. PhD thesis, University of Leiden, 1988.

EXAMPLE:
    > S:=[2,3,5];   
    > SUnitXYZ(S);
    [
        [ 125, 3, 128 ],
        [ 27, 5, 32 ],
        [ 80, 1, 81 ],
        [ 25, 2, 27 ],
        [ 16, 9, 25 ],
        [ 24, 1, 25 ],
        [ 15, 1, 16 ],
        [ 8, 1, 9 ],
        [ 5, 4, 9 ],
        [ 3, 1, 4 ],
        [ 5, 3, 8 ],
        [ 4, 1, 5 ],
        [ 9, 1, 10 ],
        [ 2, 1, 3 ],
        [ 3, 2, 5 ],
        [ 5, 1, 6 ],
        [ 1, 1, 2 ]
    ]

*/

Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/pAdicLog.m");
Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/ConvertpAdic.m");
Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/SFactors.m");

load "./FinckePohstCode/F3Approx.m"; 
load "./FinckePohstCode/MyCholesky.m";
load "./FinckePohstCode/ShortVectors.m";
load "./FinckePohstCode/FinckePohst.m";
load "./XYZ2Code/MagmaXYZFunctions/InitialSortXYZ.m";
load "./XYZ2Code/MagmaXYZFunctions/LatticeXYZ.m";
load "./XYZ2Code/MagmaXYZFunctions/LatticeBoundXYZ.m";
load "./XYZ2Code/MagmaXYZFunctions/SmallestLatticeBoundXYZ.m";
load "./XYZ2Code/MagmaXYZFunctions/FPRestrictionsXYZ.m";


function SUnitXYZ(S)
    X0,U:= SmallestLatticeBoundXYZ(S);  // computes lowest bound X0 such that m(xyz) <= X0; U:= [[f_1,p_1],...,[f_s,p_s]] such that ord_{p_i}(xyz) <= f_i for each p_i in S
    s:= #S;     // computes the size of S
    Sort(~S);   // orders primes by size p_1 < ... < p_s
    F:= U;      // creates copy of U, to avoid changing U
    eqns:= [];  // stores S-unit solutions x + y = z
    
    for i in [1..s] do
        F,V:= FPRestrictionsXYZ(S,F,S,0.5);         // initial S-unit solution search, with constant 0.5; runs through all primes of S
        for v in V do 
            if (v in eqns) eq false then
                Append(~eqns, v);       // stores each [x,y,z] in eqns vector
            end if; 
        end for;
    end for;
    
    while (&or[F[i][1] gt 0 : i in [2..s]]) and (F[1][1] gt 2) do
        F,V:= FPRestrictionsXYZ(S,F,S,0.125);      // S-unit solution search; runs through all primes of S
        for v in V do 
            if (v in eqns) eq false then
                Append(~eqns, v);       // stores each [x,y,z] in eqns vector
            end if; 
        end for;
    end while;
    
    while (&or[F[i][1] gt 0 : i in [2..s]]) do
        ordering:= [];          // stores determined ordering for each remaining iteration of Fincke-Pohst
        for k in [2..s] do
            if F[k][1] gt 0 then
                Append(~ordering,F[k][2]);      // appends to ordering only those primes p in S\{2} for which f_{p_i} > 0
            end if;
        end for;    
        
        if ordering ne [] then
            F,V:= FPRestrictionsXYZ(S,F,ordering,0.125);        // S-unit solution search; runs through all primes of Ordering
            for v in V do 
                if (v in eqns) eq false then
                    Append(~eqns, v);       // stores each [x,y,z] in eqns vector
                end if; 
            end for; 
        end if;
    end while;    
    
    while F[1][1] gt 2 do
        F,V:= FPRestrictionsXYZ(S,F,[2],0.125);         // S-unit solution search on p = 2, iterated until f_{2} <= 2
        for v in V do 
            if (v in eqns) eq false then
                Append(~eqns, v);       // stores each [x,y,z] in eqns vector
            end if; 
        end for; 
    end while;
    
    Append(~eqns,[1, 1, 2]);    // appends last solution, 1 + 1 = 2
 
    return eqns;
end function;
