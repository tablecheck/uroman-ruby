# frozen_string_literal: true

module Uroman
  # Base class for simple dictionary-like objects
  class Dict
    def initialize(**kwargs)
      # Store all keyword arguments as instance variables
      kwargs.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def inspect
      instance_variables.map { |var| "#{var}=#{instance_variable_get(var)}" }.join(" ")
    end

    def [](key, default = nil)
      instance_variable_defined?("@#{key}") ? instance_variable_get("@#{key}") : default
    end

    def empty?
      instance_variables.empty?
    end
  end

  # Romanization rule with source and target strings
  class RomRule < Dict
    attr_accessor :source, :target, :type, :context, :lcode

    def initialize(**kwargs)
      super
      @type ||= nil
      @context ||= nil
      @lcode ||= nil
    end
  end

  # Script metadata
  class Script < Dict
    attr_accessor :name, :default_vowel, :abugida

    def initialize(**kwargs)
      super
      @default_vowel ||= nil
      @abugida ||= false
    end
  end
end 
