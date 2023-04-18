# frozen_string_literal: true

require_relative "seatable_ruby/version"
require_relative "seatable_ruby/account"
require_relative "seatable_ruby/client"
require_relative "seatable_ruby/row"
require_relative "seatable_ruby/basic_info"
require_relative "seatable_ruby/column"
require_relative "seatable_ruby/view"
require_relative "seatable_ruby/export"

module SeatableRuby
  class Error < StandardError; end

  class << self
    attr_accessor :api_token, :account_credentials, :account_token

    def config
      yield self
    end

    def parse(body)
      JSON.parse(body)
    rescue JSON::ParserError
      nil
    end
  end
end
