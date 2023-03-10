require "uri"
require "net/http"

module SeatableRuby
  class Column
    attr_accessor :params, :access_data

    def initialize(params = {})
      @access_data = Client.new.access_data
      @params = params
    end

    # GET
    # List Columns in View in Table
    def list_columns_in_view_in_table(params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{access_data['dtable_uuid']}/columns")
      # ?table_name=Table1&view_name=Default View")
      url.query = URI.encode_www_form(params)
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{access_data['access_token']}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end
  end
end