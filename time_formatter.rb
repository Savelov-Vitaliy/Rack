class TimeFormatter

  VALID_FORMATS = {year: '%Y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%S'}

  def initialize(params)
    @query_formats = params.split(',').map(&:to_sym).each.with_object({}) {|key, hash| hash[key] = VALID_FORMATS[key]}
    @unknown_formats = @query_formats.keys - VALID_FORMATS.keys
  end

  def success?
    @unknown_formats.empty?
  end

  def formatted_time
    Time.now.strftime(@query_formats.values.join('-')) if success?
  end

  def unknown_formats
    @unknown_formats.join(', ')
  end

  def valid_formats
    VALID_FORMATS.keys.inspect
  end

end
