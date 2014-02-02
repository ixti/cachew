require "simplecov"
require "coveralls"


SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]


SimpleCov.start do
  add_filter "/spec/"
end


require "cachew"


RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
