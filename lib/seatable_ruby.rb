# frozen_string_literal: true

require_relative "seatable_ruby/version"

module SeatableRuby
  class Error < StandardError; end

  class << self
    attr_accessor :api_token

    def config
      yield self
    end
  end
end
