require "uri"
require "net/http"

module SeatableRuby
  class Row
    attr_accessor :options, :access_data

    def initialize(options = {})
      @access_data = Client.new.access_data
      @options = options.merge(@access_data)
    end

    def get_table_rows
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{access_data['dtable_uuid']}/rows/?table_name=#{options[:table_name]}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{access_data['access_token']}"
      response = https.request(request)
      SeatableRuby.parse(response.read_body)
      # the response example here https://api.seatable.io/#528ae603-6dcc-4dc3-846f-a38974a4795d
    end
  end
end