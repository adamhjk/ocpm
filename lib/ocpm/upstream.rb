require 'ocpm/upstream/yum'
require 'ocpm/upstream/dir'

class OCPM
  class Upstream
    attr_accessor :name, :path, :type

    # Create a new OCPM::Upstream.
    #
    # @param [String] the name of this upstream
    # @param [String] the path to this upstream on disk
    # @param [Symbol] the type of upstream, one of :yum, :apt or :dir
    def initialize(n, p, t)
      @name = n
      @path = p
      @type = t
      @up = case @type
            when :yum
              OCPM::Upstream::Yum.new(@path)
            when :apt
              OCPM::Upstream::Apt.new(@path)
            when :dir
              OCPM::Upstream::Dir.new(@path)
            end
    end

    # Returns a hash of OCPM::Package objects that are currently in this
    # upstream.
    #
    # @return [Hash] A hash, with the keys as package names, and the value an
    #   array of OCPM::Package objects.
    def packages
      packages = {}
      @up.get_package_files.each do |file|
        pkg = OCPM::Package.from_file(file)
        pkg.upstream = @name
        if packages.has_key?(pkg.name)
          packages[pkg.name] << pkg
        elsif
          packages[pkg.name] = [ pkg ]
        end
      end
      packages
    end

  end
end
