include("../utils.jl")
import Base.*


N = 12

function check_condition(x)
    x=x%N
    if !has_shared_divisors(x,N)
        return x
    else
        return 0
    end
end

struct Gn
        x::Int64
        Gn(x) = check_condition(x) == 0 ? throw(DomainError()) : new(x)
        *(x::Gn, y::Gn) = Gn((x.x*y.x)%N)
        convert(::Type{Gn}, z::Int64) = Gn(z%N)
        convert(::Int64, z::Type{Gn}) = z.z
end



