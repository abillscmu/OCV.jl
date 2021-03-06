using Test
using OCV

using Test
using OCV
using BenchmarkTools

A = [-123466.90208905171,
-65215.58255076725,
-77739.69488015345,
-132750.8136541972,
-109183.62667589705]

U_0 = 3.4271972387993173      # U_0_p   # U_0_n

c_s_max = 100000.0
c_s_min = 0.0

cathodeocv = OCV.RKPolynomial(A,U_0,c_s_max,c_s_min,length(A_p))

atol = 1e-10

x = 0.56
V = cathodeocv(x,285.0)

x̂ = OCV.mybisection(V,0.6,0.4,cathodeocv,285.0,atol=atol)
V̂ = cathodeocv(x̂,285.0)

@test x ≈ x̂
@test V ≈ V̂


# Test the inversion function
x̂ = get_x_from_voltage(cathodeocv,V,285.0)
@test x̂ ≈ x

#do an anode to make sure it works both ways
A_n = [-9.04729951400691e6,
-8.911003506471587e6,
-9.04657963355355e6,
-8.904669509837592e6,
-9.0363250622869e6,
-9.05878665345401e6,
-9.606335422964232e6,
-8.023042975317075e6,
-2.3190474522951595e6,
 1.4303914546788693e6]
 
 U_0_n = -46.09780594535385
 c_s_max⁻ = 100000.0
 c_s_min⁻ = 0.0
 anodeocv   = OCV.RKPolynomial(A_n,U_0_n,c_s_max⁻,c_s_min⁻,length(A_n))

V̂⁻ = anodeocv(x,285.0)
x̂⁻ = get_x_from_voltage(anodeocv,V̂⁻,285.0)

@test x̂⁻ ≈ x

