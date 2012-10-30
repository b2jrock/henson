require "henson/source/generic"

require "henson/source/path"

module Henson
  class InvalidSourceError < StandardError; end

  module Source
    def self.infer_from_opts(opts = {})
      raise Henson::InvalidSourceError unless opts.any?

      if path = opts.delete(:path)
        Henson::Source::Path.new path
      end
    end
  end
end