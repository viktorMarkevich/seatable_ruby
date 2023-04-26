require "uri"
require "net/http"

module SeatableRuby
  class Column
    attr_accessor :dtable_uuid, :access_token

    def initialize
      client = Client.new
      @dtable_uuid = client.dtable_uuid
      @access_token = client.access_token
    end

    # GET
    # List Columns
    # required query params -> { table_name: '...' }
    # all query params -> { table_name: '...', view_name: '...' }
    #
    # for more info -> https://api.seatable.io/reference/list-columns

    def list_columns(query_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/columns")

      url.query = URI.encode_www_form(query_params) # For example: it returns "?table_name=Table1&view_name=Default View"
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{access_token}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end
  end
end