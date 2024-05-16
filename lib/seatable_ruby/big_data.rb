require "uri"
require "net/http"

module SeatableRuby
  class BigData
    attr_accessor :dtable_uuid, :access_token

    def initialize
      client = Client.new
      @dtable_uuid = client.dtable_uuid
      @access_token = client.access_token
    end

    # GET
    # Get Big Data Status
    # for more info -> https://seatable.readme.io/reference/getbigdatastatusdeprecated

    def get_big_data_status
      url = URI("https://cloud.seatable.io/dtable-db/api/v1/base-info/#{dtable_uuid}/")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Token #{access_token}"

      response = http.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # TODO: add the next endpoints:
    #   https://seatable.readme.io/reference/addbigdatarows
    #   https://seatable.readme.io/reference/moverowstobigdata
    #   https://seatable.readme.io/reference/moverowstonormalbackend
  end
end