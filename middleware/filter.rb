class Filter

  attr_reader :status, :body

  VALID_URL = '/time'

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if request.path != VALID_URL
      # отдаем ошибку - неизвестный URL
      @status = 404
      @body = ["Page not found: #{request.path}. Please use: #{VALID_URL}"]
      return [status, headers, body]
    end

    unless request.params['format']
      # отдаем ошибку - формат не передан
      @status = 400
      @body = ["Time format not found. Get time format like this: /time?format=year,month,day"]
      return [status, headers, body]
    end

    @app.call(env)
  end

  def headers
    { 'Content-type' => 'text/plain' }
  end

end
