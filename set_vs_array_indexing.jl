
#
# Set indexing is 1000 faster compared to array indexing.
#

function test_array()
    N = 100000
    array = collect(1:N)
    
    tic()
    for i in 1:N
        !in(i, array) && println("unicorn!")
    end
    toc()
end

test_array()
# elapsed time: 2.926556552 seconds

function test_set()
    N = 100000
    set = Set(collect(1:N))
    
    tic()
    for i in 1:N
        !in(i, set) && println("unicorn!")
    end
    toc()
end

test_set()
# elapsed time: 0.002808054 seconds
