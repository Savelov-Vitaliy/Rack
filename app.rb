require_relative 'time_formatter'

class App

  attr_reader :status, :body

  def call(env)
    request = Rack::Request.new(env)
    formatter = TimeFormatter.new(request.params['format'])

    if formatter.success?
      # отдаем успешный ответ
      @body = [formatter.formatted_time]
      @status = 200
    else
      # отдаем ошибку - неизвестный формат
      @body = ["Unknown time format [#{formatter.unknown_formats}]. Available time formats: #{formatter.valid_formats}"]
      @status = 400
    end

    [status, headers, body]
  end

  private

  def headers
    { 'Content-type' => 'text/plain' }
  end

end
