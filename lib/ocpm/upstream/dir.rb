class OCPM
  class Upstream
    class Dir
      attr_accessor :path

      # @param [String] the path to the directory with package files in it
      def initialize(p)
        @path = p
      end
   
      # @return [Array] the paths to each package in this repository
      def get_package_files
        packages = []
        ::Dir[File.join(@path, "*")].each do |pkg|
          if pkg =~ /\.rpm$/ || pkg =~ /\.deb$/
            packages << File.expand_path(pkg)
          end
        end
        packages
      end

    end
  end
end

