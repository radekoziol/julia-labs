using Gadfly
using DataFrames
using DifferentialEquations

Pkg.status("DataFrames")
Pkg.status("DifferentialEquations")
Gadfly.push_theme(:default)
set_default_plot_size(20cm, 7.5cm)

a = 0.0
b = 8.0
c = 4.0
d = 5

function lorenz(du,u,p,t)
    du[1] = u[1]*(a - b*u[2])
    du[2] = u[2]*(a*u[1] - b)
end

u0 = [0.0;1.0]
tspan = (0.0,5.0)
prob = ODEProblem(lorenz,u0,tspan)
sol = solve(prob)

# fieldnames(sol)

# df1=DataFrame(t=sol.t, u=sol.u, lambda=λ)


plot(sol,vars=(1,2))
