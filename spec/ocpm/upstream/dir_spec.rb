require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

require 'ocpm/upstream/dir'

describe "OCPM::Upstream::Dir" do
  before(:all) do
    @up = OCPM::Upstream::Dir.new(File.join(SPEC_DATA, "upstream/directory"))
  end

  describe "get_package_files" do
    it "returns a list of package files" do
      path = File.join(SPEC_DATA, "upstream/directory")
      @up.get_package_files.should == [ 
        File.join(path, "libxcb-property1_0.3.6-1build1_amd64.deb"),
      ]
    end
  end

end

