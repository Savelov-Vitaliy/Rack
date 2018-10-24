class App

  AVAILABLE_FORMAT = {year: '%Y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%S'}

  def call(env)
    url = env['PATH_INFO']
    query_string = env['QUERY_STRING'].split('=')[1]

    if query_string
      query_format = {}
      query_string.split('%2C').map(&:to_sym).map {|k| query_format[k] = AVAILABLE_FORMAT[k]}

      unknown_format = query_format.keys - AVAILABLE_FORMAT.keys

      if url != '/time'
          @body = ["Page not found: #{url}. Use: /time"]
          @status = 404
      else if unknown_format.empty?
          @body = [Time.now.strftime(query_format.values.join('-'))]
          @status = 200
        else
          @body = ["Unknown time format [#{unknown_format.join(', ')}]", "Available time formats: #{AVAILABLE_FORMAT.keys.inspect}"]
          @status = 400
        end
      end

    else
          @body = ["Time format not found. Get time format like this: /time?format=year%2Cmonth%2Cday"]
          @status = 400
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
