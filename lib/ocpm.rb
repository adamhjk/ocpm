require 'systemu'
require 'ocpm/config'
require 'ocpm/log'

class OCPM
  class << self
    def command(cmd)
      OCPM::Log.debug("Running command: #{cmd}")
      status, stdout, stderr = systemu(cmd)
      unless status.success?
        OCPM::Log.fatal("Command #{cmd} failed with status code #{status.exitstatus}")
        OCPM::Log.fatal("---STDOUT---")
        OCPM::Log.fatal(stdout)
        OCPM::Log.fatal("---STDERR---")
        OCPM::Log.fatal(stderr)
        raise RuntimeError, "Command #{cmd} failed with status code #{status.exitstatus}"
      end
      OCPM::Log.debug("---STDOUT---")
      OCPM::Log.debug(stdout)
      OCPM::Log.debug("---STDERR---")
      OCPM::Log.debug(stderr)
      return stdout, stderr
    end

    def command_per_line(cmd, &block)
      o, e = command(cmd)
      o.split("\n").each do |line|
        block.call(line)
      end
    end
  end
end
