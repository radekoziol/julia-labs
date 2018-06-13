using Gadfly
using DataFrames
using DifferentialEquations

Gadfly.push_theme(:default)
set_default_plot_size(20cm, 7.5cm)


# dx/dt = Ax - Bxy
# dy/dt = -Cy + Dxt
LV_sol = @ode_def LV begin
    dx = A*x - B*x*y
    dy = -C*y + D*x*y
end A B C D

# 
function lv(A,B,C,D,x0,y0)
    # input point
    u0= [x0,y0]
    in_vector=[A,B,C,D]
    # shall be float
    tspan = (0.0 , 8.0)

    prob = ODEProblem(LV_sol,u0,tspan,in_vector)
    # docs -> For medium accuracy calculations, RK4 is a good choice.
    sol = solve(prob,RK4(),dt=0.01 )
    # Preparing data
    fieldnames(sol)
    title = string("in: A=",string(A),",B=",string(B),",C=",string(C),",D=",string(D))
    # Creating 3 columns and filling values
    df1=DataFrame(t=sol.t, xy =sol.u, exp = title)
    df2=hcat(df1, collect(1:size(df1,1)))
    df2[:x1] = map((x,y) -> y[2] - x[1], df2[:xy] , df2[:xy])
    rename!(df2,:x1,:diff)

    df3=hcat(df2, collect(1:size(df2,1)))
    rename!(df3,:x1, :y)
    df3[:y] = map((x) ->  x[2], df3[:xy])
    df3[:xy] = map((x) ->  x[1], df3[:xy])
    rename!(df3,:xy, :x)
    # Creating csv
    writetable(string(title,".csv"), df3)

    # Printing stats
    pred= df3[:y]
    prey= df3[:x]
    print("Min prey num= ",minimum(prey),"\n")
    print("Max prey num= ",maximum(prey),"\n")
    print("Mean prey num= ",mean(prey),"\n")
    print("Min pred num= ",minimum(pred),"\n")
    print("Max pred num= ",maximum(pred),"\n")
    print("Mean pred num= ",mean(pred),"\n")
    df3
end

example_eq = Array{DataFrame}(4)

example_eq[1] = lv(0.1 , 1.2 , 3.1 , 1.1 , 8.0 , 4.0)
example_eq[2] = lv(10,10,10,10.0, 8.0,3.0)
example_eq[3] = lv(123.1,12,222,12.5, 65.0 ,43.0)
example_eq[4] = lv(0.51,0.1,0.01,2.01,0.2,0.5)

dfArr = example_eq[1]
for i = 2:4
    dfArr=[dfArr; lvdf[i]]
end