
# Napisać funkcję, która bierze typ i wypisuje jego graf dziedziczenia np. w formie "Any-->Number-->Real-->AbstractFloat-->Float16" (3pkt)
function type_graf(t)
    queue = [t]
    it  = supertype(t)
    while supertype(it) != t
        push!(queue, supertype(it))
        t = it
        it = supertype(it)
    end
    for i in queue
        print(i)
        print("->")
    end
    print("\n")
end

# type_graf(Float16)
