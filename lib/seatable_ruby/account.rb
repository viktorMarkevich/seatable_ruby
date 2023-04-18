require "uri"
require "net/http"

module SeatableRuby
  class Account
    attr_accessor :account_token

    def initialize
      @account_token = account_token
    end

    def account_token
      url = URI("https://cloud.seatable.io/api2/auth-token/")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["accept"] = 'application/json'
      request["content-type"] = 'application/x-www-form-urlencoded'
      request.body = SeatableRuby.account_credentials&.to_query

      response = http.request(request)
      SeatableRuby.parse(response.read_body)['token']
    end
  end
end