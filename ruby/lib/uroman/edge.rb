# frozen_string_literal: true

require 'json'

module Uroman
  # This class defines edges that span part of a sentence with a specific romanization.
  # There might be multiple edges for a given span. The edges in turn are part of the
  # romanization lattice.
  class Edge
    attr_accessor :start, :finish, :txt, :type

    def initialize(start, finish, s, annotation = nil)
      @start = start
      @finish = finish
      @txt = s
      @type = annotation
    end

    def to_s
      "[#{@start}-#{@finish}] #{@txt} (#{@type})"
    end

    def inspect
      to_s
    end

    def to_json(*_args)
      JSON.generate([@start, @finish, @txt, @type])
    end

    def self.json_str(rom_result)
      if rom_result.is_a?(String)
        rom_result
      else
        result = +'['
        rom_result.each do |edge|
          if edge.is_a?(Edge)
            result += edge.to_json
          else
            result += edge.to_s
          end
          result += ','
        end
        result.chomp!(',')
        result + ']'
      end
    end
  end
end 
