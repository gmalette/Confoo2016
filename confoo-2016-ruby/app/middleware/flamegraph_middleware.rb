class FlamegraphMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    results = nil
    Flamegraph.generate(Rails.root.join("flamegraph.html")) do
      results = @app.call(env)
    end
    results
  end
end
