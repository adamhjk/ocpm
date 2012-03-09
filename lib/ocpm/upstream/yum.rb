class OCPM
  class Upstream
    class Yum
      attr_accessor :path

      # @param [String] the path to this Yum repositories package directory
      def initialize(p)
        @path = p
      end
   
      # @return [Array] the paths to each RPM in this repository
      def get_package_files
        packages = []
        ::Dir[File.join(@path, "*.rpm")].each do |rpm|
          packages << File.expand_path(rpm)
        end
        packages
      end

    end
  end
end
