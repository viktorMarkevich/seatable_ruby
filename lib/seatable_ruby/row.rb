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
      # ALLOWED_PARAMS => [:table_name, :view_name, :convert_link_id, :order_by, :direction, :start, :limit]
      # the response example here https://api.seatable.io/#528ae603-6dcc-4dc3-846f-a38974a4795d
    end

    def query_with_sql(query = {})
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

    def query_row_link_list(query = {})
      # example of query body
      # https://api.seatable.io/#186e5166-6d9e-4aef-890e-a1dd8a8b2ee0
      url = URI("https://cloud.seatable.io/dtable-db/api/v1/linked-records/#{access_data['dtable_uuid']}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_data['access_token']}"
      request.body = query

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    def row_details
      # url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/650d8a0d-7e27-46a8-8b18-6cc6f3dbvh46/rows/Qtf7xPmoRaiFyQPO1aENTjb/?table_id=0000&convert=true")
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{access_data['dtable_uuid']}/rows/#{params['row_id']}/")
      url.query = URI.encode_www_form(params.except('row_id'))

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{access_data['access_token']}"

      response = https.request(request)

      SeatableRuby.parse(response.read_body)
    end
  end
end