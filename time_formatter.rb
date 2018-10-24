class TimeFormatter

  VALID_FORMATS = {year: '%Y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%S'}

  def initialize(params)
    @query_formats = {}
    params.map(&:to_sym).map {|k| @query_formats[k] = VALID_FORMATS[k]}
    @unknown_formats = @query_formats.keys - VALID_FORMATS.keys
  end

  def success?
    @unknown_formats.empty?
  end

  def get_formats
    success? ? @query_formats.values.join('-') : @unknown_formats.join(', ')
  end

end