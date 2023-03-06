require "uri"
require "net/http"

module SeatableRuby
  class Row
    attr_accessor :params, :access_data

    def initialize(params = {})
      @access_data = Client.new.access_data
      @params = params
    end

    def list_rows
      # TODO: add check for allowed params
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{access_data['dtable_uuid']}/rows")
      url.query = URI.encode_www_form(params)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{access_data['access_token']}"
      response = https.request(request)
      SeatableRuby.parse(response.read_body)
      # ALLOWED_PARAMS => [:table_name, :view_name, :convert_link_id, :order_by, :direction, :start, :limit
      # the response example here https://api.seatable.io/#528ae603-6dcc-4dc3-846f-a38974a4795d
    end

    def query_with_sql(query)
      url = URI("https://cloud.seatable.io/dtable-db/api/v1/query/#{access_data['dtable_uuid']}/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_data['access_token']}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(query)
      # ALLOWED_QUERY => { "sql": "select Name from Table1", "convert_keys": true }
      # https://api.seatable.io/#333f80ba-1c61-4a74-a0a9-fa806185d850

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end
  end
end