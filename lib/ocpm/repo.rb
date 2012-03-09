require 'ocpm/repo/yum'

class OCPM
  class Repo
 
    attr_accessor :name, :path, :type

    def initialize(name, path, type)
      @name = name
      @path = path
      @type = type
      @rp = case @type
            when :yum
              OCPM::Repo::Yum.new(@path)
            when :dir
              OCPM::Repo::Dir.new(@path)
            end
    end

    # Given a list of packages, makes sure this repository
    # has all the latest packaging goodness.
    #
    # @param [Hash] a hash with package names as keys, and values that are
    #   arrays of OCPM::Package objects, such as those created by
    #   OCPM::Upsteam#packages, or the OCPM::Repo#packages method, most
    #   likely.
    def update(packages)
      updated_repo = false
      current_package_filenames = @rp.get_package_files
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
      @rp.update(packages)
    end

  end
end
