class URLFilter

  VALID_URL = '/time'

  def initialize(app)
    @app = app
  end

  def call(env)

    if env['PATH_INFO'] == VALID_URL
      status, headers, body = @app.call(env)
    else
      status = 404
      headers = { 'Content-type' => 'text/plain' }
      body = ["Page not found: #{env['PATH_INFO']}. Please use: #{VALID_URL}"]
    end

    [status, headers, body]
  end

end