$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'yuki'

RSpec.configure do |config|
  config.mock_with :rspec
end
