# frozen_string_literal: true

module Uroman
  module Util
    extend self

    def timer(method)
      proc do |*args|
        start_time = Time.now
        puts "Calling: #{method.name}(#{args})"
        puts "Start time: #{start_time.strftime('%A, %B %d, %Y at %H:%M')}"
        result = method.call(*args)
        end_time = Time.now
        duration = end_time - start_time
        puts "End time: #{end_time.strftime('%A, %B %d, %Y at %H:%M')}"
        puts "Duration: #{duration} seconds"
        result
      end
    end

    def slot_value_in_double_colon_del_list(line, slot, default = nil)
      match = line.match(/(?:.*\s)?::#{slot}(|\s+\S.*?)(?:\s+::\S.*|\s*)$/)
      match ? match[1].strip : default
    end

    def has_value_in_double_colon_del_list(line, slot)
      !slot_value_in_double_colon_del_list(line, slot).nil?
    end

    def dequote_string(str)
      str.match(/^\s*(['\"“])(.*)(['\"”])\s*$/) { |m| m[2] } || str
    end

    def last_chr(str)
      str[-1] || ''
    end

    def ud_numeric(char)
      Unicode.numeric?(char) ? Unicode.numeric(char) : nil
    rescue StandardError
      nil
    end

    def robust_str_to_num(num_s, filename = nil, line_number = nil, silent = false)
      return num_s if num_s.is_a?(Numeric)

      begin
        num_s.include?('.') ? BigDecimal(num_s).to_f : Integer(num_s)
      rescue ArgumentError
        unless silent
          warn "Cannot convert \"#{num_s}\" to a number" \
                 + (line_number ? " line: #{line_number}" : "") \
                 + (filename ? " file: #{filename}" : "")
        end
        nil
      end
    end

    def first_non_none(*args)
      args.find { |arg| !arg.nil? }
    end

    def any_not_none?(*args)
      args.any? { |arg| !arg.nil? }
    end

    def add_non_none_to_hash(hash, key, value)
      hash[key] = value unless value.nil?
    end
  end
end
