
# Sorting fun
function sort(arr)
    for i = 1:length(arr)
        for j = i:length(arr)
            if arr[i] < arr[j]
                tmp = arr[i]
                arr[i] = arr[j]
                arr[j] = tmp
            end
        end
    end
    return arr
end


print(sort([1,3,1,4,5,6,2,1]))
print("\n")
