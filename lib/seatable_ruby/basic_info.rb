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
    # for more info -> https://seatable.readme.io/reference/getbaseinfo

    def basic_info
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'

      return_response(http, request)
    end

    # GET
    # Get Metadata
    # for more info -> https://seatable.readme.io/reference/getmetadata

    def basic_metadata
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}/metadata/")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Accept"] = "application/json; charset=utf-8; indent=4"

      return_response(http, request)
    end

    # GET
    # List Collaborators
    # for more info -> https://seatable.readme.io/reference/listcollaborators

    def list_collaborators
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}/related-users/")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'

      return_response(http, request)
    end

    private

    def return_response(http, request)
      request["Authorization"] = "Token #{access_token}"

      response = http.request(request)
      SeatableRuby.parse(response.read_body)
    end
  end
end