## Dear Comrades,
## You shall now implement Golden search rule!

### Run the following part to see if there is any package that you need to install
### if something goes wrong, watch the error message and install the needed package by 
### Pkg.add("missing_package")
using Pkg
import Base: isapprox

### Scroll down for your HW
### Before getting started you should write your student_number in integer format
const student_number::Int64 = 1234567 ## <---replace 0 by your student_number 


### Run the following function as it is needed for comparison purposses
### You should not change this function -- otherwise you will get an error!!!
function isapprox((a,b)::Tuple{T, T}, (c,d)::Tuple{L, L}; rtol = 1e-2) where {T <: Real, L <: Real}
    return abs(a-c) < rtol && abs(b-d) < rtol
end


#= You will now implement Golden search method before you get started please see the slides for a detailed information!!!!
=#
function GoldenSection(f::Function, 
    a::Real, 
    b::Real; max_iter::Int = 100, ϵ::Float64 = 1e-4)::Tuple{Float64, Float64}
    ## Beginning of the function ##

    r = (3 - sqrt(5)) / 2 ## Golden Ratio

    x_1 = a + r * (b - a)
    x_2 = b - r * (b - a) 

    f1 = f(x_1) # Function at x1
    f2 = f(x_2) # Function at x2

    for k in 1:max_iter
        ## Your code goes here your function should return a tuple of the form α, f(α),
        ### Use the following returning rule instead of the one in the book, 
        ### this will help you to avoid the error in the unit test

        if f1 > f2 # If f1 is greater than f2
            a = x_1 # Set a to x1
            x_1 = x_2 # Set x1 to x2
            f1 = f2 # Set f1 to f2

            x_2 = r * a + (1 - r) * b # Update x2 
            f2 = f(x_2) # Evaluate the function at x2
        else
            b = x_2 # Set b to x2
            x_2 = x_1 # Set x2 to x1
            f2 = f1 # Set f2 to f1
             
            x_1 = r * b + (1 -r) * a # Update x1
            f1 = f(x_1) # Evaluate the function at x1
        end

      if abs(x_1 - x_2) < ϵ
            return x_1, f(x_1)
        end
        
    end

    @info "Algorithm did not converge correctly!!!"
    α = (x_1 + x_2) / 2
    return α, f(α)
end

## Before going to unit_test run the next cell see what ya doin?
GoldenSection(x->x^2-1, -1.0,  1, max_iter = 10000, ϵ = 1e-20)
### 

## Unit test for bisection ###
function unit_test_for_bisection()
    @assert isa(GoldenSection(x->x^2 , -1, 1), Tuple{Float64, Float64}) "Return type should be a tuple of Float64s"
    try
        @assert isapprox(GoldenSection(x->x^2 -1 , -1, 1), (0.0, -1.0); rtol = 1e-3)
        @assert isapprox(GoldenSection(x->-sin(x), 0.0, pi), (pi/2, -1.0); rtol = 1e-3)
        @assert isapprox(GoldenSection(x->x^4+x^2+x, -1, 1), (-0.3859, -0.2148); rtol = 1e-3)              
    catch AssertionError
        @info "Something went wrong buddy checkout your implementation"
        throw(AssertionError)
    end
    @info "In Tonny Montana style: things are fine now!!!! OKKAYYY"
end


## Run the unit_test_for_bisection to see if your doing goood!!!
unit_test_for_bisection()
###

if abspath(PROGRAM_FILE) == @__FILE__
    nothing
end

