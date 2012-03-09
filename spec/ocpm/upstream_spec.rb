require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

require 'ocpm/upstream'
require 'ocpm/upstream/yum'
require 'ocpm/package'

describe "OCPM::Upstream" do
  upstreams = {
    "yum" => [ "centos-6.0-i386-os", File.join(SPEC_DATA, "upstream/centos/6.0/os/i386/Packages"), :yum ],
    "dir" => [ "debian-random", File.join(SPEC_DATA, "upstream/directory"), :dir ]
  }

  upstreams.each do |name, args|
    describe "type #{name}" do
      before(:all) do
        @u = OCPM::Upstream.new(args[0], args[1], args[2])
      end

      it "has a name" do
        @u.name.should == args[0] 
      end

      it "has a path" do
        @u.path.should == args[1]
      end

      it "has a type" do
        @u.type.should == args[2] 
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
        end

        it "sets the upstream on each package object" do
          @packages.values.each do |pl|
            pl.each do |i| 
              i.upstream.should == @u.name
            end
          end
        end
      end
    end
  end
end
