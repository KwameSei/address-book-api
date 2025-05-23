class RequestLogger
  def initialize(app)
    @app = app
  end

  def call(env)
    start = Time.now
    status, headers, response = @app.call(env)
    duration = ((Time.now - start) * 1000).round(2)

    method = env["REQUEST_METHOD"]
    path = env["PATH_INFO"]
    puts "[#{Time.now}] #{method} #{path} - #{status} (#{duration}ms)"

    [status, headers, response]
  end
end