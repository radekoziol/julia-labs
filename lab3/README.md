# code optimization 
 
## optimization

### Removing constants

``` julia 
    @time A = generate_random_graph(800)
```
``` shell
radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  1.028805 seconds (1.99 M allocations: 77.121 MiB, 17.19% gc time)w
radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  0.330716 seconds (164.08 k allocations: 12.141 MiB)
radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  0.320446 seconds (73.63 k allocations: 8.957 MiB)  //after removing both K,N
```

### Introducting types

``` julia
    @time nodes = generate_random_nodes(800)
```
``` shell
radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  0.020462 seconds (12.03 k allocations: 648.174 KiB)
radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  0.017444 seconds (8.47 k allocations: 483.912 KiB)
```

### Using arrays{}() i fill()


``` julia
    A = generate_random_graph(800,10000)
    nodes = generate_random_nodes(800)
    @time convert_to_graph(A, nodes)
```
``` shell
radekkoziol@HP-RK:~/Projects/Julia/lab3$ julia graphs.jl
  0.017472 seconds (8.47 k allocations: 484.193 KiB)

  0.082104 seconds (46.87 k allocations: 2.658 MiB)
```

### ??
<!-- with opt. -->
```julia
A = generate_random_graph(800,10000)
nodes = generate_random_nodes(800)
graph = convert_to_graph(A, nodes)
```
``` shell
@time println(check_euler())
  0.778981 seconds (219.04 k allocations: 12.407 MiB, 7.44% gc time)
```

### Graph array type changed to BitArray
``` shell
  0.556613 seconds (220.91 k allocations: 12.517 MiB)
```

### Avoiding string interpolation for I/O
``` shell
  0.510869 seconds (219.05 k allocations: 12.414 MiB)
```
