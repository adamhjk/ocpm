class OCPM
  class Repo
    class Yum
      attr_accessor :path

      # @param [String] the path to this Yum repositories package directory
      def initialize(p)
        @path = p
        OCPM.command("mkdir -p #{@path}")
      end
  
      # @return [Array] the paths to each RPM in this repository
      def get_package_files
        # A bit of a code-smell - this is duplicate code form
        # OCPM::Upstream::Yum, because the format here is identical to the
        # upstream - not so for debian new-style repositories, sadly.
        #
        # There is *one* difference, which is that this reports the basename.
        packages = []
        Dir[File.join(@path, "*.rpm")].each do |rpm|
          packages << File.basename(File.expand_path(rpm))
        end
        packages
      end

      # Takes a package list hash and links them in to the repository, deletes
      # any packages that are in the repository but not in the package list,
      # and then runs 'createrepo' to populate the Yum metadata.
      #
      # @param [Hash] a list of packages, likely from OCPM::Upstream#packages
      #   or similar.
      # @return [True]
      def update(packages)
        OCPM.command("createrepo #{@path}")
        true 
      end

    end
  end
end

