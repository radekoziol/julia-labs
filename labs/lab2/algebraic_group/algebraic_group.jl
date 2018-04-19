include("../utils.jl")
import Base.*
import Base.convert
import Base.promote_type
import Base.^

# Example
N = 11

struct Gn{T} 
    x::T
    Gn(x::T) = typeof(x) != T || check_condition(x::Int) == 0 ? error("Can not convert!") : new(x%N)
    *(x::Gn{Int64}, y::Gn{Int64}) = Gn{Int64}((x.x*y.x)%N)
    convert(::Type{Gn{Int64}}, z::Int64) = Gn{Int64}(z)
    convert(::Int64, z::Gn{Int64}) = z.x
    promote_type(x::Gn{Int64}) = promote_type(x.x)
end


function check_condition(x)
    x=x%N
    if !has_shared_divisors(x,N)
        return x
    else
        return 0
    end
end


function period(gn::Gn{Int64})
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

function ^(gn::Gn{Int64},b::Int64)

    sum = gn
    while(b > 1)
        sum = sum*gn
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

