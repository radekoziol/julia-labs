include("../utils.jl")
import Base.*
import Base.convert
import Base.promote_type
import Base.^

N = 12

function check_condition(x)
    x=x%N
    if !has_shared_divisors(x,N)
        return x
    else
        return 0
    end
end

# korzystając z poprzedniej funkcji napisać funkcję obliczającą okres danej
#  liczby typu G{N} czyli najmniejszą liczbę naturalną r, taką, że a^r mod N =1.
#  Wskazówka: można to zrobić sprawdzająć po kolei wszystkie możliwości, można też 
#  skorzystać z twierdzenia, że r musi dzielić ilość elementów w grupie.
function period(gn::Gn)
    it = 1
    while(it != N+1)
        if(gn^it == 1)
            return it
        end
        it = it + 1
    end
end

function reversed(gn:gn)
    it = 1
    while(it != gn.x + 1)
        if((gn.x*it)%N == 1)
            return Gn(it)
        end
        it = it + 1
    end 
end

function ^(gn::Gn{Int64}, x::Int64)

    a = promote_type(gn)

    sum = 0
    while(x != 0)
        sum = sum + a*a
        sum = sum%N
        x = x - 1
    end

    return Gn(sum)
end

function group_size(gn::Type{Gn{}})
    
    it = 0
    while gn(it).x == it
        it = it + 1
    end

    return it
end

struct Gn{T} 
        x::T
        Gn(x::T) = check_condition(x) == 0 ? error("Can not convert!") : new(x%N)
        *(x::Gn{Int64}, y::Gn{Int64}) = Gn{Int64}((x.x*y.x)%N)
        convert(::Type{Gn{Int64}}, z::Int64) = Gn{Int64}(z)
        convert(::Int64, z::Gn{Int64}) = z.x
        promote_type(x::Gn{Int64}) = promote_type(x.x)
end


