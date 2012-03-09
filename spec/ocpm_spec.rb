require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "OCPM" do
  describe "self.command" do
    it "runs a command and returns stdout and stderr" do
      o, e = OCPM.command("echo foo")
      o.should == "foo\n"

      o, e = OCPM.command("bash -c 'echo foo 1>&2'")
      e.should == "foo\n"
    end

    it "should raise a RuntimeError on command failure" do
      lambda { OCPM.command("bash -c 'exit 1'") }.should raise_error(RuntimeError)
    end
  end

  describe "self.command_per_line" do
    it "should yield a block for each line of output" do
      seen = Hash.new
      OCPM.command_per_line("cat #{File.join(SPEC_DATA, 'command_per_line')}") do |line|
        seen[line] = true
      end
      seen.has_key?("one").should == true
      seen.has_key?("two").should == true
      seen.has_key?("three").should == true
      seen.keys.length.should == 3
    end
  end
end
