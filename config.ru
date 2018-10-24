require_relative 'middleware/url_filter'
require_relative 'app'

use URLFilter
run App.new
