require "uri"
require "net/http"

module SeatableRuby
  class BasicInfo
    attr_accessor :dtable_uuid, :access_token

    def initialize
      client = Client.new
      @dtable_uuid = client.dtable_uuid
      @access_token = client.access_token
    end

    # GET
    # Get Base Info
    # for more info -> https://api.seatable.io/reference/get-base-info

    def basic_info
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)

      return_response(https, request)
    end

    # GET
    # Get Metadata
    # for more info -> https://api.seatable.io/reference/get-metadata

    def basic_metadata
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/dtables/#{dtable_uuid}/metadata/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Accept"] = "application/json; charset=utf-8; indent=4"

      return_response(https, request)
    end

    # GET
    # Get Big Data Status
    # for more info -> https://api.seatable.io/reference/get-big-data-status

    def basic_big_data_status
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/base-info/#{dtable_uuid}/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)

      return_response(https, request)
    end

    private

    def return_response(https, request)
      request["Authorization"] = "Token #{access_token}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end
  end
end