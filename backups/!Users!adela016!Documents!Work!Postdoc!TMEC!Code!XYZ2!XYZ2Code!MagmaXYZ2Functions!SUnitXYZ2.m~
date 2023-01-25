//SUnitXYZ2.m

/*
INPUT:
    S:= [p_1,...,p_s], p_i primes in S

OUTPUT:
    FinalSolns:= [[x_1,y_1,z_1],...,[x_n,y_n,z_n]], all S-unit equations x_i + y_i = z_i^2, where
        x_i, y_i:= prod_{i:= 1 to s} p_i^{a_i} for rational integers x_i, y_i such that
            gcd(x_i, y_i) is squarefree
            x_i >= y_i and x_i >= 0
        z_i:= a rational integer, > 0 

COMMENTS:
    Computes all S-unit equations x + y = z^2
    This algorithm uses the Fincke-Pohst algorithm and LLL 

    Based on the algorithm found in Chapter 7 of the Reference

REFERENCE:
    B.M.M.De Weger. Algorithms For Diophantine Equations. PhD thesis, University of Leiden, 1988.

EXAMPLE:
    > S:= [2,5,13,17];
    > FinalSolns:= SUnitXYZ2(S);
    > #FinalSolns;
    165
    > FinalSolns;
    [
        [ 180625, -173056, 87 ],
        [ 1024, 65, 33 ],
        [ 4225, -256, 63 ],
        [ 625, -544, 9 ],
        [ 625, 104, 27 ],
        [ 169, -25, 12 ],
        [ 169, -160, 3 ],
        [ 64, 17, 9 ],
        [ 289, -64, 15 ],
        [ 289, -208, 9 ],
        [ 28561, 680, 171 ],
        [ 7225, -169, 84 ],
        [ 25, -16, 3 ],
        [ 1, -1, 0 ],
        [ 57122, -1, 239 ],
        [ 50, -1, 7 ],
        [ 512, 17, 23 ],
        [ 8, 1, 3 ],
        [ 800, 289, 33 ],
        [ 17, 8, 5 ],
        [ 338, -289, 7 ],
        [ 4913, 128, 71 ],
        [ 32, 17, 7 ],
        [ 1250, -289, 31 ],
        [ 22151168, 1419857, 4855 ],
        [ 1352, 17, 37 ],
        [ 2, -1, 1 ],
        [ 578, -2, 24 ],
        [ 50, -34, 4 ],
        [ 2, 2, 2 ],
        [ 34, 2, 6 ],
        [ 2, -2, 0 ],
        [ 5, -4, 1 ],
        [ 5, 4, 3 ],
        [ 5, -1, 2 ],
        [ 125, -4, 11 ],
        [ 80, 1, 9 ],
        [ 845, -4, 29 ],
        [ 1445, -1, 38 ],
        [ 20, 5, 5 ],
        [ 5, -5, 0 ],
        [ 250, -169, 9 ],
        [ 10, -1, 3 ],
        [ 2890, 26, 54 ],
        [ 26, 10, 6 ],
        [ 10985, 40, 105 ],
        [ 160, 65, 15 ],
        [ 10, -10, 0 ],
        [ 325, -1, 18 ],
        [ 208, 17, 15 ],
        [ 325, -289, 6 ],
        [ 13312, 4913, 135 ],
        [ 140608, 17, 375 ],
        [ 13, -4, 3 ],
        [ 68, 13, 9 ],
        [ 1300, 221, 39 ],
        [ 13, -13, 0 ],
        [ 17, -1, 4 ],
        [ 122825, -1024, 349 ],
        [ 425, 16, 21 ],
        [ 425, -256, 13 ],
        [ 265625, -262144, 59 ],
        [ 10625, -6656, 63 ],
        [ 265625, 1664, 517 ],
        [ 2873, -64, 53 ],
        [ 10625, -16, 103 ],
        [ 425984, 425, 653 ],
        [ 71825, 16384, 297 ],
        [ 1124864, 122825, 1117 ],
        [ 425, 416, 29 ],
        [ 425, -64, 19 ],
        [ 1088, 1, 33 ],
        [ 425, 104, 23 ],
        [ 4913, -13, 70 ],
        [ 2873, -1024, 43 ],
        [ 435200, 28561, 681 ],
        [ 425, -169, 16 ],
        [ 71825, -1, 268 ],
        [ 4913, -1664, 57 ],
        [ 4913, -2704, 47 ],
        [ 17, -13, 2 ],
        [ 272, 169, 21 ],
        [ 17, -16, 1 ],
        [ 17, -8, 3 ],
        [ 611926016, 6640625, 24871 ],
        [ 14144, 17, 119 ],
        [ 272, 17, 17 ],
        [ 485537, 272, 697 ],
        [ 4352, 2873, 85 ],
        [ 10625, -221, 102 ],
        [ 2176, 425, 51 ],
        [ 2873, -272, 51 ],
        [ 425, -136, 17 ],
        [ 221, 68, 17 ],
        [ 10625, -2704, 89 ],
        [ 26624, 10625, 193 ],
        [ 4913, 416, 73 ],
        [ 425, -416, 3 ],
        [ 1664, 17, 41 ],
        [ 104, 17, 11 ],
        [ 22984, 425, 153 ],
        [ 10625, 3536, 119 ],
        [ 17, -17, 0 ],
        [ 366991274, -625, 19157 ],
        [ 109850, -289, 331 ],
        [ 2600, 1, 51 ],
        [ 650, -289, 19 ],
        [ 416, 25, 21 ],
        [ 7514, -625, 83 ],
        [ 26, -1, 5 ],
        [ 26, -17, 3 ],
        [ 26, -25, 1 ],
        [ 4394, -4250, 12 ],
        [ 26, -10, 4 ],
        [ 170, 26, 14 ],
        [ 106250, 26, 326 ],
        [ 18785, 1664, 143 ],
        [ 6656, 1625, 91 ],
        [ 104, 65, 13 ],
        [ 650, 26, 26 ],
        [ 4394, -425, 63 ],
        [ 1105, 416, 39 ],
        [ 26, -26, 0 ],
        [ 9826, -25, 99 ],
        [ 34, -25, 3 ],
        [ 34, -34, 0 ],
        [ 18785, -16384, 49 ],
        [ 16640, 1, 129 ],
        [ 18785, -16, 137 ],
        [ 1625, -256, 37 ],
        [ 10985, -4096, 83 ],
        [ 65, -1, 8 ],
        [ 40625, -1024, 199 ],
        [ 65, 16, 9 ],
        [ 65, -64, 1 ],
        [ 65, -16, 7 ],
        [ 65, -40, 5 ],
        [ 1625, -104, 39 ],
        [ 4160, 65, 65 ],
        [ 65, -65, 0 ],
        [ 85, -4, 9 ],
        [ 85, -85, 0 ],
        [ 3250, -1, 57 ],
        [ 130, -130, 0 ],
        [ 114920, 1, 339 ],
        [ 170, -1, 13 ],
        [ 170, -169, 1 ],
        [ 170, -26, 12 ],
        [ 28730, 170, 170 ],
        [ 170, -170, 0 ],
        [ 221, -25, 14 ],
        [ 63869, -62500, 37 ],
        [ 37349, -100, 193 ],
        [ 221, 4, 15 ],
        [ 221, -100, 11 ],
        [ 221, -52, 13 ],
        [ 221, -221, 0 ],
        [ 442, -1, 21 ],
        [ 442, -442, 0 ],
        [ 690625, -64, 831 ],
        [ 1105, -1024, 9 ],
        [ 1105, -16, 33 ],
        [ 1105, -1105, 0 ],
        [ 2210, -1, 47 ],
        [ 2210, -2210, 0 ]
    ]
    

*/

Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/ConvertpAdic.m");
Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/pAdicLog.m");
Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/SFactors.m");
Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/NonEmptyMaxMinProductSum.m"); 
Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/Ordp.m"); 
Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/QsqrtDPrecision.m"); 
Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/BinaryRecurrenceSequence.m"); 
Attach("./XYZ2Code/MagmaXYZ2IntrinsicFunctions/BinaryRecurrenceSequencePeriod.m"); 

load "./XYZ2Code/MagmaXYZFunctions/SUnitXYZ.m";
load "./XYZ2Code/MagmaXYZ2Functions/SUnitXYZtoSUnitXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/ExponentsXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/DecompositionOfPrimesXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/IdealExponentsXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/IdealConjugatesXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/AlphasXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/FundamentalUnitXYZ2.m";          
load "./XYZ2Code/MagmaXYZ2Functions/IUFactorsXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/SymmetricCaseZerosXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/SymmetricCaseXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/SplitPrimePropertiesXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/IIPrimeXYZ2.m"; 
load "./XYZ2Code/MagmaXYZ2Functions/nExponentsXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/C1pnXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/LambdaBoundXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/KappaBoundXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/Kappa_BoundXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/C12BoundXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/MaximalC12BoundXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/LambdaLogpXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/LambdaInitialSortXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/LambdaLatticeXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/HenselLiftXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/KappaInitialSortXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/Kappa_InitialSortXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/KappaLatticeXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/Kappa_LatticeXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/SmallestLatticeBoundXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/FPRestrictionsKappaXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/FPRestrictionsKappa_XYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/FPRestrictionsLambdaXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/FPRestrictionsXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/FPParametersXYZ2.m";
load "./XYZ2Code/MagmaXYZ2Functions/FinalSearchXYZ2.m";


function SUnitXYZ2(S)
    Z:= IntegerRing();
    D0:= ExponentsXYZ2(S,0);    // generates all possible values for D:= ( (p_1)^(b_1) )* /cdots *( (p_n)^(b_n) ), where S:= [p_1, ..., p_n], b_i in {0,1} 
    
    AllSolns:= [];      // stores all [x,y,z] where x + y = z^2
    for D in D0 do
        print "D:", D;
        if D eq 1 then
            xyzsol:= SUnitXYZ(S);       // computes all [x,y,z] where x + y = z
            sol:= [];   // stores [x,y,z] where x + y = z^2 coming from SUnitXYZ.m
            for s in xyzsol do
                sol:= sol cat SUnitXYZtoSUnitXYZ2(s);   // converts xyz solutions to [x,y,z] where x + y = z^2
            end for;
            AllSolns:= AllSolns cat sol;        // appends solutions from SUnitXYZ.m
        else
            K<sqrtD>:= QuadraticField(D);       // generates real quadratic field K = Q(Sqrt(D))
            R:= RingOfIntegers(K);      // generates ring of integers of K
            b0, SplitPrimes, NonSplitPrimes:= DecompositionOfPrimesXYZ2(S,D);
            if IsEmpty(SplitPrimes) then
                A0:= AlphasXYZ2([],b0,SplitPrimes,NonSplitPrimes,S,D);  // generates all alphas in the case I, I_ == []  
                for A in A0 do
                    AllSolns:= AllSolns cat SymmetricCaseXYZ2(A,S,D);   // generates [x,y,z] where x + y = z in the symmetric case
                end for;
            else 
                J:= IIPrimeXYZ2(SplitPrimes,D);         // generates all possible I, I_
                for II_ in J do                    
                    A0:= AlphasXYZ2(II_,b0,SplitPrimes,NonSplitPrimes,S,D);     // generates all alphas in the case I, I_ != [] 
                    FA:= MaximalC12BoundXYZ2(II_,b0,SplitPrimes,NonSplitPrimes,S,D);    // computes maximal upper bound on U0, M0, M0_, absn
                    U0, M0, M0_, absn:= SmallestLatticeBoundXYZ2(II_,FA,S);     // generates reduced bounds U0, M0, M0_, absn
                    for A in A0 do
                        a:= A[3];
                        U01:= U0;
                        M01:= M0;
                        M0_1:= M0_;
                        absn1:= absn;
                        if (#M0 + #M0_) gt 2 then
                            U01, M01, M0_1, absn1, eqns:= FPParametersXYZ2(FA,U01,M01,M0_1,absn1,b0,A,S);   // reduces U0, M0, M0_, absn via Fincke-Pohst, when more than 1 prime splits in K
                            AllSolns:= AllSolns cat eqns;   // appends solutions that may have come from the Fincke-Pohst reduction
                        end if;
                        xyz2:= FinalSearchXYZ2(U01,M01,M0_1,absn1,A,S,D);       // computes all [x,y,z] where x + y = z^2 below the reduced bounds U0, M0, M0_, absn
                        for s in xyz2 do
                            if (s in AllSolns) eq false then
                                Append(~AllSolns, s);
                            end if;
                        end for;
                    end for;
                end for;
            end if;
        end if;
        Append(~AllSolns, [D,-D,0]);    // appends the trivial solution [x,y,z]:= [D,-D,0]
    end for;
    
    FinalSolns:= [];
    for s in AllSolns do
        sqfree,sq:= Squarefree(GCD(Z!s[1],Z!s[2]));   // computes the squarefree integer sqfree as well as an integer sq, such that GCD(x,y) = (sqfree)*(sq^2)
        if sq ne 1 then         // if GCD(x,y) is not squarefree
            Reduceds:= [s[1]/(sq^2), s[2]/(sq^2), s[3]/sq];
            if (Reduceds in FinalSolns) eq false then
                Append(~FinalSolns, Reduceds);  // appends only the reduced solution, [x,y,z] with GCD(x,y) squarefree, to FinalSolns
            end if;
        elif (s in FinalSolns) eq false then    // appends the solution, [x,y,z] to FinalSolns; this solution is reduced, ie. GCD(x,y) is squarefree
            Append(~FinalSolns, s);
        end if;
    end for;
            
    return FinalSolns;
end function;