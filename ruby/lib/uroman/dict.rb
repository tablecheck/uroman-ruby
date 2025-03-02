# frozen_string_literal: true

module Uroman
  # Base class for simple dictionary-like objects
  class Dict
    def initialize(**kw_args)
      @data = {}

      kw_args.each do |key, value|
        key2 = key.to_s.tr('_', '-')
        @data[key2] = value unless value.nil? || value == [] || value == false
      end
    end

    def inspect
      @data.map { |k, v| "#{k}=#{v}" }.join(' ')
    end

    def [](key)
      @data[key.to_s]
    end

    def empty?
      @data.empty?
    end

    def to_h
      @data
    end
  end

  # Romanization rule with source and target strings
  # key: source string
  # typical attributes: s (source), t (target), prov (provenance), lcodes (language codes)
  # t_alts=t_alts (target alternatives), use_only_at_start_of_word, dont_use_at_start_of_word,
  # use_only_at_end_of_word, dont_use_at_end_of_word, use_only_for_whole_word
  class RomRule < Dict
  end

  # Script metadata
  # key: lower case script_name
  # typical attributes: script_name, direction, abugida_default_vowels, alt_script_names, languages
  class Script < Dict
  end
end 
