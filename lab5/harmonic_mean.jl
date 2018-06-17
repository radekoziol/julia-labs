@generated function harmonic_mean(I::Integer...)

    l = length(I)

    ex = :($0)

    for i = l : -1 : 1
        ex = :(1/I[$i] + $ex)
    end
    
    return :(length(I)/$ex)
end

