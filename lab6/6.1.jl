
function print_one()
    for n=1:5
        println("1")
        notify(cond_1)
        wait(cond_3)
    end
end
function print_two()
    for n=1:5
        wait(cond_1)
        println("2")
        notify(cond_2)
    end
end
function print_three()
    for n=1:5
        wait(cond_2)
        println("3")
        notify(cond_3)
    end
end

cond_1 = Condition()
cond_2 = Condition()
cond_3 = Condition()

one = @task print_one();
two = @task print_two();
three = @task print_three();

schedule(two)
schedule(three)
schedule(one)

wait(three)
