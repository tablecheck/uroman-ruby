# frozen_string_literal: true

# Original Python by Ulf Hermjakob, USC/ISI, 2024. Ruby port by Johnny Shields, 2025.
# uroman is a universal romanizer. It converts text in any script to the Latin alphabet.
# This script is a Ruby reimplementation of the Python uroman script.
# The tool has been tested on 250 languages, with 100 or more sentences each.
# This script is still under development and large-scale testing. Feedback welcome.
# This script provides token-size caching (for faster runtimes).
#
# Output formats include:
# - (1) best romanization string
# - (2) best romanization edges ("best path"; incl. start and end positions with respect to the original string)
# - (3) best romanization with alternatives (as applicable for ambiguous romanization)
# - (4) best romanization full lattice (all edges, including superseded sub-edges)

require 'date'
require 'json'
require 'set'
require 'unicode'
require 'optparse'
require 'bigdecimal'
require 'bigdecimal/util' # TODO: really?

require 'uroman/util'
require 'uroman/dict'
require 'uroman/edge'
require 'uroman/num_edge'
require 'uroman/lattice'
require 'uroman/data'
require 'uroman/cli'

module Uroman
end
