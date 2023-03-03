require "uri"
require "net/http"

module SeatableRuby
  class Row
    # attr_accessor :base_token, :table_name
    # attr_writer :api_token

    def initialize
      # @api_token = api_token
      # @access_token
    end

    # def access_token
    #   @access_token ||= access_data['access_token']
    # end
    #
    # def table_uuid
    #   @table_uuid ||= access_data['dtable_uuid']
    # end

    def get_table_rows(table_name = 'Terminierungsliste')
      token_data = Client.new.access_data
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{token_data['dtable_uuid']}/rows/?table_name=#{table_name}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{token_data['access_token']}"
      response = https.request(request)
      data = JSON.parse(response.read_body)
      p data
      data
    end
  end
end