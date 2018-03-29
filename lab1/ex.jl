
# Sorting fun
# function sort(arr)
#     for i = 1:length(arr)
#         for j = i:length(arr)
#             if arr[i] < arr[j]
#                 tmp = arr[i]
#                 arr[i] = arr[j]
#                 arr[j] = tmp
#             end
#         end
#     end
#     return arr
# end


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


print(sort([1,3,1,4,5,6,2,1]))
print("\n")
type_graf(Float16)