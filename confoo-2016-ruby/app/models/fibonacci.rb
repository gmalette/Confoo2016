module Fibonacci
  def self.fib(n)
    return 0 if n == 0
    return 1 if n == 1 || n == 2

    fib(n-1) + fib(n-2)
  end

  def self.fib2(n, cache={})
    return 0 if n == 0
    return 1 if n == 1 || n == 2

    cache[n] ||= fib2(n-1, cache) + fib2(n-2, cache)
  end

  def self.fib3(n)
    return 0 if n == 0
    return 1 if n <= 2

    a, b = 1, 1
    3.upto(n) do
      a, b = b, a+b
    end
    b
  end
end
