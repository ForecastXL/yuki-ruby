$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'yuki_api_wrapper'

RSpec.configure do |config|
  config.mock_with :rspec
end