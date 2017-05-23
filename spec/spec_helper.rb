require "pry"
require "rspec"

require_relative "../lib/adventure"

RSpec.configure do |config|
  #To enable stubbing
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  #Disables test output to terminal
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = File.open(File::NULL, "w")
    $stdout = File.open(File::NULL, "w")
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end
end
