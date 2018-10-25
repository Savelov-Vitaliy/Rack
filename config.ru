require_relative 'middleware/filter'
require_relative 'app'

use Filter
run App.new
