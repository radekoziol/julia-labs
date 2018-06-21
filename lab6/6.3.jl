using Plots
Plots.gr()


function generate_julia(z; c=2, maxiter=200)
    for i=1:maxiter
        if abs(z) > 2
            return i-1
        end
        z = z^2 + c
    end
    maxiter
end

# function calc_julia!(julia_set, xrange, 
#     yrange; maxiter=200, height_start=0, height_end=0, width_start=0, width_end=0)
#    for x=width_start:width_end
#         for y=height_start:height_end
#             z = xrange[x] + 1im*yrange[y]
#             julia_set[x, y] = generate_julia(z, c=-0.70176-0.3842im, maxiter=maxiter)
#         end
#     end
# end

function calc_julia!(julia_set, xrange, yrange; maxiter=200, height=400, width_start=1, width_end=400)
    for x=width_start:width_end
         for y=1:height
             z = xrange[x] + 1im*yrange[y]
             julia_set[x, y] = generate_julia(z, c=-0.70176-0.3842im, maxiter=maxiter)
         end
     end
 end

function calc_julia_main(h,w)
   xmin, xmax = -2,2
   ymin, ymax = -1,1
   xrange = linspace(xmin, xmax, w)
   yrange = linspace(ymin, ymax, h)
	println(xrange[100],yrange[101])
   julia_set = Array(Int64, (w, h))
#    th_num = 4

   @time calc_julia!(julia_set, xrange, yrange, height=h, width_end=w)

#    @sync @parallel for i=1:th_num
    # @time calc_julia!(julia_set, xrange, yrange, 
                    #   ((i-1)*h)/th_num),(i*h)/th_num), ((i-1)*h)/th_num),(i*h)/th_num))  
#    end

   Plots.heatmap(xrange, yrange, julia_set)
   png("julia")
end


calc_julia_main(2000,2000)