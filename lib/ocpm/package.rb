
class OCPM
  class Package

    attr_accessor :name, :version, :iteration, :arch, :maintainer, :url, :description, :upstream, :dependencies, :type, :path

    def self.from_file(file)
      if file =~ /rpm$/
        OCPM::Package.from_rpm(file)
      elsif file =~ /deb$/
        OCPM::Package.from_deb(file)
      end
    end

    # Creates an OCPM::Package from an RPM
    #
    # @param [String] the rpm file to create the object from
    # @return [OCPM::Package]
    def self.from_rpm(file)
      p = OCPM::Package.new
      p.type = :rpm
      p.path = file
      OCPM.command_per_line('rpm -qp --queryformat \'name: %{NAME}\nversion: %{VERSION}\niteration: %{RELEASE}\narch: %{ARCH}\nmaintainer: %{PACKAGER}\ndescription: %{SUMMARY}\nurl: %{URL}\n\' ' + file) do |item|
        item =~ /^(.+?): (.+)$/
        p.send("#{$1}=".to_sym, $2)
      end
      p
    end

    # Creates an OCPM::Package from a dpkg
    #
    # @param [String] the deb file to create the object from
    # @return [OCPM::Package]
    def self.from_deb(file)
      p = OCPM::Package.new
      p.type = :deb
      p.path = file
      OCPM.command_per_line('dpkg-deb --show --showformat \'name: ${Package}\nversion: ${Version}\narch: ${Architecture}\nmaintainer: ${Maintainer}\ndescription: ${Description}\nurl: ${Homepage}\n\' ' + file) do |item|
        next if item =~ /^ / # Skip extraneous lines from dpkg
        item =~ /^(.+): (.+)$/
        accessor = $1
        value = $2
        if accessor == 'version'
          value =~ /^(.+)-(.+)$/
          version = $1
          iteration = $2
          p.send("version=".to_sym, version)
          p.send("iteration=".to_sym, iteration)
        else
          p.send("#{accessor}=".to_sym, value)
        end
      end
      p
    end

  end
end
