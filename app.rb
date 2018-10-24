class App
  require_relative 'time_formatter'

  def call(env)
    request = Rack::Request.new(env)

    unless request.params['format']
      # отдаем ошибку - формат не передан
      @body = ["Time format not found. Get time format like this: /time?format=year,month,day"]
      @status = 400
    else
      formatter = TimeFormatter.new(request.params['format'].split(','))
      if formatter.success?
        # отдаем успшный ответ
        @body = [Time.now.strftime(formatter.get_formats)]
        @status = 200
      else
        # отдаем ошибку - неизвестный формат
        @body = ["Unknown time format [#{formatter.get_formats}]. Available time formats: #{TimeFormatter::VALID_FORMATS.keys.inspect}"]
        @status = 400
      end
    end

    [status, headers, body]
  end

  private

  def status
    @status
  end

  def headers
    { 'Content-type' => 'text/plain' }
  end

  def body
    @body
  end

end
