require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

require 'ocpm/package'

describe "OCPM::Package" do
  describe "self.from_deb" do
    before(:all) do
      @p = OCPM::Package.from_deb(File.join(SPEC_DATA, "libxcb-property1_0.3.6-1build1_amd64.deb"))
    end

    it "builds an OCPM::Package from an rpm file" do
      @p.should be_a_kind_of(OCPM::Package)
    end

    it "is a deb" do
      @p.type.should == :deb
    end

    it "has a name" do
      @p.name.should == "libxcb-property1"
    end

    it "has a version" do
      @p.version.should == "0.3.6"
    end

    it "has an iteration" do
      @p.iteration.should == "1build1"
    end

    it "has an architecture" do
      @p.arch.should == "amd64"
    end

    it "has a maintainer" do
      @p.maintainer.should == "Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>"
    end
  end

  describe "self.from_rpm" do
    before(:all) do
      @p = OCPM::Package.from_rpm(File.join(SPEC_DATA, "at-3.1.10-42.el6.i686.rpm"))
    end

    it "builds an OCPM::Package from an rpm file" do
      @p.should be_a_kind_of(OCPM::Package)
    end

    it "is an rpm" do
      @p.type.should == :rpm
    end

    it "has a name" do
      @p.name.should == "at"
    end

    it "has a version" do
      @p.version.should == "3.1.10"
    end

    it "has an iteration" do
      @p.iteration.should == "42.el6"
    end

    it "has an architecture" do
      @p.arch.should == "i686"
    end

    it "has a maintainer" do
      @p.maintainer.should == "CentOS BuildSystem <http://bugs.centos.org>"
    end
  end
end
