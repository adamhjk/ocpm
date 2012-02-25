require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

require 'ocpm/repo'

describe "OCPM::Repo" do
  before(:all) do
    @r = OCPM::Repo.new('centos-6.0-i386-os-devel', File.join(SPEC_SCRATCH, 'centos-6.0-i386-os-devel'), :yum)
  end

  it "has a name" do
    @r.name.should == 'centos-6.0-i386-os-devel'
  end

  it "has a path" do
    @r.path.should == File.join(SPEC_SCRATCH, 'centos-6.0-i386-os-devel')
  end

  it "has a type" do
    @r.type.should == :yum
  end
end
