
function has_shared_divisors(x,y)

    # Starting from 2
    it = 2
    while(it != min(x,y))
        if x%it == y%it == 0
            return true
        end
        it=it+1
    end

    return false

end


