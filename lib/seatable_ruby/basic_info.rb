require "uri"
require "net/http"

module SeatableRuby
  class BasicInfo
    attr_accessor :dtable_uuid, :access_token

    def initialize
      @dtable_uuid = client.dtable_uuid
      @access_token = client.access_token
    end

    def client
      @client ||= Client.new
    end
    

    def basic_infos
      url = URI("https://cloud.seatable.io/dtable-server/dtables/#{dtable_uuid}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)

      return_response(https, request)
    end

    def basic_metadata
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/metadata/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Accept"] = "application/json; charset=utf-8; indent=4"

      return_response(https, request)
    end

    def basic_big_data_status
      url = URI("https://cloud.seatable.io/dtable-db/api/v1/base-info/#{dtable_uuid}/")

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