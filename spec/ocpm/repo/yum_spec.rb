require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

require 'ocpm/repo/yum'

describe "OCPM::Repo::Yum" do
  before(:all) do
    @repo_path = File.join(SPEC_SCRATCH, 'centos-6.0-i386-os-devel')
    @r = OCPM::Repo::Yum.new(File.join(SPEC_SCRATCH, 'centos-6.0-i386-os-devel'))
    OCPM.command("mkdir -p #{@repo_path}")
  end

  it "has a path" do
    @r.path.should == File.join(SPEC_SCRATCH, 'centos-6.0-i386-os-devel')
  end

  describe "update" do
    before(:all) do
      @u = OCPM::Upstream.new("centos-6.0-i386-os", File.join(SPEC_DATA, "upstream/centos/6.0/os/i386/Packages"), :yum)
      @packages = @u.packages
    end

    it "creates links to new packages" do
      @r.update(@packages)
      File.exists?(File.join(@repo_path, "basesystem-10.0-4.el6.noarch.rpm")).should == true
      File.exists?(File.join(@repo_path, "bitmap-fonts-compat-0.3-15.el6.noarch.rpm")).should == true
    end

    it "removes packages from the repository that should no longer exist" do
      p = @packages.clone
      p.delete("basesystem")
      @r.update(p)
      File.exists?(File.join(@repo_path, "basesystem-10.0-4.el6.noarch.rpm")).should == false
      File.exists?(File.join(@repo_path, "bitmap-fonts-compat-0.3-15.el6.noarch.rpm")).should == true
    end

    it "adds packages from the repository in addition to what already exists" do
      @r.update(@packages)
      File.exists?(File.join(@repo_path, "basesystem-10.0-4.el6.noarch.rpm")).should == true
      File.exists?(File.join(@repo_path, "bitmap-fonts-compat-0.3-15.el6.noarch.rpm")).should == true
    end

    it "creates the repository metadata" do
      @r.update(@packages)
      File.exists?(File.join(@repo_path, "repodata", "filelists.xml.gz")).should == true
      File.exists?(File.join(@repo_path, "repodata", "other.xml.gz")).should == true
      File.exists?(File.join(@repo_path, "repodata", "primary.xml.gz")).should == true
      File.exists?(File.join(@repo_path, "repodata", "repomd.xml")).should == true
    end

  end
end

