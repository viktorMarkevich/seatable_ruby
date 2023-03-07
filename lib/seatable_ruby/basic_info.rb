require "uri"
require "net/http"

module SeatableRuby
  class BasicInfo
    attr_accessor :access_data

    def initialize
      @access_data = Client.new.access_data
    end

    def basic_infos
      url = URI("https://cloud.seatable.io/dtable-server/dtables/#{access_data['dtable_uuid']}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)

      return_response(https, request)
    end

    def basic_metadata
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{access_data['dtable_uuid']}/metadata/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Accept"] = "application/json; charset=utf-8; indent=4"

      return_response(https, request)
    end

    def basic_big_data_status
      url = URI("https://cloud.seatable.io/dtable-db/api/v1/base-info/#{access_data['dtable_uuid']}/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)

      return_response(https, request)
    end

    private

    def return_response(https, request)
      request["Authorization"] = "Token #{access_data['access_token']}"

      response = https.request(request)
      data = SeatableRuby.parse(response.read_body)
      p data
      data
    end
  end
end