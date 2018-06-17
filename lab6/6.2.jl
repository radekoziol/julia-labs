# Napisać program, w którym działają następujące zadania:
# Zadanie producenta, który wyszukuje pliki (wszystkie lub 
# z określonym rozszerzeniem) w zadanym drzewie katalogów i wpisuje
#  ich nazwy do kanału.
# Kilka zadań konsumentów, którzy obliczają liczbę linii w danym pliku 
# (pobierając jego nazwę z kanału).
# Na końcu program powinien wypisywać całkowitą liczbę linii we 
# wszystkich plikach.





function producent(c::Channel)
  
    dir = "../lab4/"
    searchdir(path,key) = filter(x->contains(x,key), readdir(path))
    files = searchdir(dir, "jl")

    println("start!")

    for file in files
        println("Adding ", string(dir, file))
        put!(c, string(dir , file))
        yield()
    end

    close(s)

end

function konsument(c::Channel)
  
    l_num = 0

    println("start!")

    for file in c
        println("Catching ", file)
        open(file) do f
            for i in enumerate(eachline(f))
                l_num += 1
            end
        end
        yield()
        println("Read so far ", l_num, " lines")
    end


end


@sync begin
  c=Channel(32)

  @async konsument(c)
  @async producent(c)
end
