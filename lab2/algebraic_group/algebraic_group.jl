include("../utils.jl")
import Base.*
import Base.convert
import Base.promote_type
import Base.^

# Example

struct Gn{N}
    x::Integer
    function Gn{N}(x) where N 
         return !has_shared_divisors(x%N,N) ? error("Can not convert!") : new(x%N)
    end
    convert(::Type{Gn{Int64}}, z::Int64) = Gn{Int64}(z)
    convert(::Int64, z::Gn{Int64}) = z.x
    promote_type(x::Gn{Int64}) = promote_type(x.x)
end

function *(g1::Gn, g2::Gn) 
    return typeof(g1)(g1.x*g2.x)
end

function has_shared_divisors(a,b)

    while b != 0
        a,b = b, a%b
    end

    return a == 1

end



function check_condition(x)
    x=x%N
    if !has_shared_divisors(x,N)
        return x
    else
        return 0
    end
end


function period(gn::Gn{N}) where N
    it = 2
    while(it != N)
        if((gn^it).x == 1)
            return it
        end
        it = it + 1
    end
end

function reversed(gn::Gn{Int64})

    it = 1
    while(it != y )
        if((gn*it) == 1)
            return it
        end
        it = it + 1
    end 
end

function ^(gn::Gn{N},b::Int64)

    sum = gn.x
    while(b > 1)
        sum = sum*gn.x
        sum %= N
        b = b - 1
    end

    return sum
end

# group_size(Gn{Int})
function group_size(gn::Type{Gn{T}}) where T <:Int
    
    it = 0
    while gn(it).x == it
        it = it + 1
    end

    return it
end


N=55
c=17
b=4
#Calculate period r of message b in a multiplicative algebraic group Gn{N}
r = period(Gn{N}(b))
println("repetition period = ",r)
#Calculate d - modular multiplicative inverse of c in Gn{r}. It's a private key
d = Int16(reversed(c,N)[2])
println("Inveresed element = ", d)
#Decoded message
a = b^d %N
#Check if the coding (N,k) is correct
println("Decoded msg: ", a)
println("a^c % N = ",a^c % N)
println("b = ", b)
println(a^c % N == b ? "Coding is correct" : "Coding is wrong")

