# frozen_string_literal: true

require_relative "edge"

module Uroman
  class NumEdge < Edge
    attr_accessor :value,
                  :value_s,
                  :fraction,
                  :n_decimals,
                  :num_base,
                  :base_multiplier,
                  :script,
                  :e_type,
                  :orig_txt,
                  :active

    def initialize(start, finish, s, uroman = nil, active = false)
      super(start, finish, s)
      @active = active
      @value = nil
      @value_s = nil
      @fraction = nil
      @n_decimals = nil
      @num_base = nil
      @base_multiplier = nil
      @script = nil
      @e_type = nil # one of nil, 'num', 'digit', 'multiplier', 'base', 'sign', 'operator', 'decimal pt'
      @orig_txt = nil

      # Deferred initialization via uroman if provided
      if uroman
        n = uroman.num_value(s)
        update(value: n) if n
      end
    end

    def update(value: nil,
               value_s: nil,
               fraction: nil,
               n_decimals: nil,
               num_base: nil,
               base_multiplier: nil,
               script: nil,
               e_type: nil,
               orig_txt: nil)
      @value = value if value
      @value_s = value_s if value_s
      @fraction = fraction if fraction
      @n_decimals = n_decimals if n_decimals
      @num_base = num_base if num_base
      @base_multiplier = base_multiplier if base_multiplier
      @script = script if script
      @e_type = e_type if e_type
      @orig_txt = orig_txt if orig_txt
      
      # Returns processed value string
      value_str = if @e_type == "operator"
                    @txt 
                  elsif @fraction
                    @fraction.to_s
                  elsif @value_s
                    @value_s
                  elsif @value.is_a?(Integer) || @value.is_a?(Float)
                    @value.to_s
                  else
                    @txt
                  end
      
      value_str
    end

    def to_s
      if @active
        "#{super} #{@value} [#{@e_type}] #{@value_s}"
      else
        super
      end
    end
  end
end 
