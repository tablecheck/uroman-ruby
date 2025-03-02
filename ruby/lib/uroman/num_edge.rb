# frozen_string_literal: true

module Uroman
  class NumEdge < Edge
    attr_accessor :orig_txt,
                  :txt,
                  :value,
                  :fraction,
                  :num_base,
                  :base_multiplier,
                  :type,
                  :script,
                  :is_large_power,
                  :active,
                  :n_decimals,
                  :value_s

    def initialize(start, end_pos, s, uroman, active: false)
      # For NumEdge, the s argument is in original language (not yet romanized).
      super(start, end_pos, s)

      @orig_txt = @txt = s
      @value = @fraction = @num_base = @base_multiplier = nil
      @type = @script = nil
      @is_large_power = false
      @active = active
      @n_decimals = nil
      @value_s = nil

      if start + 1 == end_pos
        char = s[0]
        if (d = uroman.num_props[char])
          @active = true
          @value = d['value']
          fraction_list = d['fraction']
          @fraction = fraction_list ? Rational(fraction_list[0], fraction_list[1]) : nil
          @num_base = d['base']
          @base_multiplier = d['mult']
          @type = d['type']
          @script = d['script']
          @is_large_power = d['is-large-power']
          update
        end
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
      @value = first_non_nil(value, @value)
      @value_s = first_non_nil(value_s, @value_s)
      @fraction = first_non_nil(fraction, @fraction)
      @n_decimals = first_non_nil(n_decimals, @n_decimals)
      @num_base = first_non_nil(num_base, @num_base)
      @base_multiplier = first_non_nil(base_multiplier, @base_multiplier)
      @script = first_non_nil(script, @script)
      @type = first_non_nil(e_type, @type)
      @orig_txt = first_non_nil(orig_txt, @orig_txt)

      if @value_s
        value_s = @value_s
      elsif @value.nil?
        value_s = ""
      elsif @value.is_a?(Float) && @n_decimals
        value_s = format("%.#{@n_decimals}f", @value)
      else
        value_s = @value.to_s
      end

      fraction_s = @fraction ? "#{@fraction.numerator}/#{@fraction.denominator}" : ''
      delimiter_s = value_s.empty? || fraction_s.empty? ? '' : ' '

      @txt = value_s + delimiter_s + fraction_s
      @txt = @orig_txt if @txt.empty?

      @txt
    end

    def to_s
      b_clause = if @num_base
                   @base_multiplier ? "#{@base_multiplier}*#{@num_base}" : @num_base.to_s
                 end

      out = "#{@active ? '' : ' *'}[#{@start}-#{@end}] #{@orig_txt} R:#{@txt} T:#{@type}"
      out << " LP" if @is_large_power
      out << " B:#{b_clause}" if b_clause
      out << " V:#{@value}" if @value&.to_s&.!=(@txt)
      out << " VS:#{@value_s}" if @value_s&.!=(@txt)
      out << " F:.#{@n_decimals}f" if @n_decimals
      out << " S:#{@script}" if @script
      out
    end

    private

    def first_non_nil(*args)
      args.compact.first
    end
  end
end
