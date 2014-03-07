def system_call(cmd)
  result = system(cmd)
  raise SystemExit, "Command '#{cmd}' not found." if result.eql? nil
  raise ScriptError, "Error in command '#{cmd}'." if result.eql? false
  result
end

require 'minitest/spec'
require 'minitest/autorun'

describe "A 'system' method that raises exceptions when execution results in error" do
  it "treats a non-existing command with SystemExit" do
    lambda { system_call('') }.must_raise SystemExit
    lambda { system_call('foo') }.must_raise SystemExit
  end

  it "treats an ill-formed command as ScriptError" do
    lambda { system_call('ls | grep') }.must_raise ScriptError
  end

  it "defaults to original method on successfully executed command" do
    lambda { system_call('ls') }.call.must_equal true
  end
end
