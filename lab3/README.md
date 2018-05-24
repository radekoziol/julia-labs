# code optimization 
 
## 

### Pozbycie sie stałych 

``` shell
``` julia 
    @time A = generate_random_graph(800)
```

radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  1.028805 seconds (1.99 M allocations: 77.121 MiB, 17.19% gc time)w
radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  0.330716 seconds (164.08 k allocations: 12.141 MiB)
radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  0.320446 seconds (73.63 k allocations: 8.957 MiB)  //after removing both K,N
```

### Okreslenie typow zmiennych
``` shell
``` julia
    @time nodes = generate_random_nodes(800)
```
radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  0.020462 seconds (12.03 k allocations: 648.174 KiB)
radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  0.017444 seconds (8.47 k allocations: 483.912 KiB)
```

### Używanie arrays{}() i fill()

``` shell
<!-- with opt. -->
``` julia
    A = generate_random_graph(800,10000)
    nodes = generate_random_nodes(800)
    @time convert_to_graph(A, nodes)
```

radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  0.017472 seconds (8.47 k allocations: 484.193 KiB)

  0.082104 seconds (46.87 k allocations: 2.658 MiB)
```
###

``` shell
<!-- with opt. -->
```julia
A = generate_random_graph(800,10000)
nodes = generate_random_nodes(800)
graph = convert_to_graph(A, nodes)
```
@time println(check_euler())
  0.778981 seconds (219.04 k allocations: 12.407 MiB, 7.44% gc time)
```

### Changing graph edges' array to be bitArray