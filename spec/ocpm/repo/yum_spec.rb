require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

require 'ocpm/upstream'
require 'ocpm/upstream/yum'
require 'ocpm/package'
require 'ocpm/repo/yum'

describe "OCPM::Repo::Yum" do
  before(:all) do
    @repo_path = File.join(SPEC_SCRATCH, 'centos-6.0-i386-os-devel')
    @r = OCPM::Repo::Yum.new(File.join(SPEC_SCRATCH, 'centos-6.0-i386-os-devel'))
  end

  it "has a path" do
    @r.path.should == File.join(SPEC_SCRATCH, 'centos-6.0-i386-os-devel')
  end

  describe "update" do
    before(:all) do
      @u = OCPM::Upstream.new("centos-6.0-i386-os", File.join(SPEC_DATA, "upstream/centos/6.0/os/i386/Packages"), :yum)
      @packages = @u.packages
    end

    it "creates the repository metadata" do
      @r.update(@packages)
#      File.exists?(File.join(@repo_path, "repodata", "filelists.xml.gz")).should == true
#      File.exists?(File.join(@repo_path, "repodata", "other.xml.gz")).should == true
#      File.exists?(File.join(@repo_path, "repodata", "primary.xml.gz")).should == true
      File.exists?(File.join(@repo_path, "repodata", "repomd.xml")).should == true
    end

  end
end

