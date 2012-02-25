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
      @rp.update(packages)
    end

  end
end
