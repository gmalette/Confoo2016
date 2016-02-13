Rails.application.routes.draw do
  get "fib/:n", to: "fibonacci#show"
end
