class OCPM
  class Repo
    class Yum
      attr_accessor :path

      # @param [String] the path to this Yum repositories package directory
      def initialize(p)
        @path = p
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
        updated_repo = false
        current_package_filenames = get_package_files
        future_package_filenames = Array.new
        packages.each do |pkg_name, pkg_objs|
          pkg_objs.each do |pkg|
            pkg_filename = File.basename(pkg.path)
            future_package_filenames << pkg_filename 
            # If the package file does not exist, link it
            unless current_package_filenames.include?(pkg_filename)
              updated_repo = true
              File.link(pkg.path, File.join(@path, pkg_filename))
            end
          end
        end

        to_del = current_package_filenames - future_package_filenames
        to_del.each do |file|
          updated_repo = true
          File.unlink(File.join(@path, file))
        end
       
        OCPM.command("createrepo #{@path}")
        true 
      end

    end
  end
end

