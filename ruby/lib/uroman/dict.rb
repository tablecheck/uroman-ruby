# frozen_string_literal: true

module Uroman
  class Dict
    def initialize(**kwargs)
      @data = {}
      kwargs.each do |key, value|
        next if value.nil? || value == [] || value == false

        key = key.to_s.tr('_', '-')
        @data[key] = value
      end
    end

    def [](key)
      @data[key]
    end

    def to_s
      @data.to_s
    end

    def empty?
      @data.empty?
    end
  end

  class RomRule < Dict
  end

  class Script < Dict
  end
end
