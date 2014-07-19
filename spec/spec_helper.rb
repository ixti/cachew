require "simplecov"
require "coveralls"
require "timecop"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter "/spec/"
end

Timecop.safe_mode = true

require "cachew"

RSpec.configure do |config|
  config.disable_monkey_patching!
end
