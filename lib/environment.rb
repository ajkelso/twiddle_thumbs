require_relative "./twiddle_thumbs/version"
require_relative "./twiddle_thumbs/cli"
require_relative "./twiddle_thumbs/api"
require_relative "./twiddle_thumbs/Suggestion"


require "colorize"
require "pry"
require 'net/http'
require 'open-uri'
require 'json'


module TwiddleThumbs
  class Error < StandardError; end
end
