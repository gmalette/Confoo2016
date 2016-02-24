require 'benchmark'

desc "Benchmark for Fibonacci"
task :fib_benchmark do
  Benchmark.bm do |x|
    x.report { Fibonacci.fib(35) }
    # x.report { Fibonacci.fib2(35) }
    # x.report { Fibonacci.fib3(35) }
  end
end
