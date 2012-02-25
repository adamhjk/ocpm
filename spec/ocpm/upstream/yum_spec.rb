require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

require 'ocpm/upstream/yum'

describe "OCPM::Upstream::Yum" do
  before(:all) do
    @up = OCPM::Upstream::Yum.new(File.join(SPEC_DATA, "upstream/centos/6.0/os/i386/Packages"))
  end

  describe "get_package_files" do
    it "returns a list of package files" do
      path = File.join(SPEC_DATA, "upstream/centos/6.0/os/i386/Packages")
      @up.get_package_files.should == [ 
        File.join(path, "bitmap-fonts-compat-0.3-15.el6.noarch.rpm"),
        File.join(path, "basesystem-10.0-4.el6.noarch.rpm"),
      ]
    end
  end

end
