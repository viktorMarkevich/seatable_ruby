require "uri"
require "net/http"

module SeatableRuby
  class Client
    attr_reader :api_token
    attr_accessor :access_token, :dtable_uuid

    def initialize
      @api_token = SeatableRuby.api_token
      @access_token ||= access_data['access_token']
      @dtable_uuid ||= access_data['dtable_uuid']
    end

    def access_data
      @access_data ||= access_object
    end

    # for more info -> https://api.seatable.io/reference/get-base-token-with-api-token

    def access_object
      url = URI("https://cloud.seatable.io/api/v2.1/dtable/app-access-token/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Accept"] = "application/json; charset=utf-8; indent=4"
      request["Authorization"] = "Token #{api_token}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end
  end
end