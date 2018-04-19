# Napisać prosty program i przetestować na nim działanie profilera. (5pkt)
# Program powinien wywoływać przez jakiś czas (np. 500 razy) na przemian dwie funkcje,
#  które wykonują w pętli różną liczbę instrukcji. Np. funkcja1 alokuje 100000 stringów, a funkcja2 10000 stringów.
# W efekcie funkcja1 powinna zajmować 10 razy więcej czasu wykonania programu niż funkcja2.
# Prześledzić działanie programu, używając narzędzi do generowania raportów (Profile.print 
# oraz ProfileView.view()).
# Sprawdzić, jak zmieniają się wyniki profilowania dla różnych wartości delay profilera.
#  Kiedy proporcje ilości czasu spędzonego w każdej z funkcji przestają odpowiadać rzeczywistości?

function allocate_strings(N::Int64)
    fill!(Array{String}(N),"xd")
end



# Profile.init() # returns the current settings
# Profile.init(n = 10^7, delay = 0.01)
allocate_strings(1)

Profile.clear()  # usuń dane z poprzedniego profilowania
i = 1
while(i!=500)
    @ profile allocate_strings(2000000)
    i = i + 1
end
j = 1
while(j!=500)
    @ profile allocate_strings(2000000)
    j = j + 1
end

Profile.print(format=:flat)

# using ProfileView
# ProfileView.view()
