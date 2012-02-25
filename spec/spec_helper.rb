$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'ocpm'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

SPEC_DATA = File.expand_path(File.join(File.dirname(__FILE__), 'data'))
SPEC_SCRATCH = File.expand_path(File.join(File.dirname(__FILE__), 'scratch'))

system("rm -rf #{SPEC_SCRATCH}")
system("mkdir -p #{SPEC_SCRATCH}")

RSpec.configure do |config|
  
end
