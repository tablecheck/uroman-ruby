# frozen_string_literal: true

module Uroman
  class Edge
    # This class defines edges that span part of a sentence with a specific romanization.
    # There might be multiple edges for a given span. The edges in turn are part of the
    # romanization lattice.

    attr_accessor :start, :end, :txt, :type

    def initialize(start, end_pos, txt, annotation = nil)
      @start = start
      @end = end_pos
      @txt = txt
      @type = annotation
    end

    def to_s
      "[#{@start}-#{@end}] #{@txt} (#{@type})"
    end

    def inspect
      to_s
    end

    def to_json(*_args)
      [@start, @end, @txt, @type].to_json
    end

    def self.json_str(rom_result)
      return rom_result if rom_result.is_a?(String)

      "[#{rom_result.map { |edge| edge.is_a?(Edge) ? edge.to_json : edge.to_s }.join}]"
    end
  end
end
