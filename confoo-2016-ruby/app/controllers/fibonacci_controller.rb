class FibonacciController < ApplicationController
  def show
    render text: Fibonacci.fib(params.require(:n).to_i)
  end
end
