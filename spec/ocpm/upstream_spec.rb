require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

require 'ocpm/upstream'

describe "OCPM::Upstream" do
  before(:all) do
    @u = OCPM::Upstream.new("centos-6.0-i386-os", File.join(SPEC_DATA, "upstream/centos/6.0/os/i386/Packages"), :yum)
  end

  it "has a name" do
    @u.name.should == "centos-6.0-i386-os"
  end

  it "has a path" do
    @u.path.should == File.join(SPEC_DATA, "upstream/centos/6.0/os/i386/Packages")
  end

  it "has a type" do
    @u.type.should == :yum
  end

  describe "packages" do
    before(:all) do
      @packages = @u.packages
    end

    it "returns a hash of OCPM::Package objects" do
      @packages.should be_a_kind_of(Hash)
    end

    it "has an array of packages for each package name" do
      @packages.each do |k,v|
        k.should be_a_kind_of(String)
        v.should be_a_kind_of(Array)
      end
    end

    it "has an OCPM::Package for each member of the array" do
      seen = Array.new
      @packages.values.each do |pl|
        pl.each do |i| 
          i.should be_a_kind_of(OCPM::Package)
          seen << i.name
        end
      end
      seen.include?("basesystem").should == true
      seen.include?("bitmap-fonts-compat").should == true
    end

    it "sets the upstream on each package object" do
      @packages.values.each do |pl|
        pl.each do |i| 
          i.upstream.should == 'centos-6.0-i386-os'
        end
      end
    end
  end
end
