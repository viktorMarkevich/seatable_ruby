require "uri"
require "net/http"

module SeatableRuby
  class Client
    attr_reader :api_token, :table_name
    attr_accessor :access_token, :table_uuid

    def initialize(api_token)
      @api_token = api_token
    end


    def access_data
      url = URI("https://cloud.seatable.io/api/v2.1/dtable/app-access-token/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Accept"] = "application/json; charset=utf-8; indent=4"
      request["Authorization"] = "Token #{api_token}"

      response = https.request(request)
      parse(response.read_body)

      # {
      #   "app_name": "KoPAC",
      #   "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2Nzc4NTc4NDgsImR0YWJsZV91dWlkIjoiMWMzOGM3NDMtNTY2Yy00NGJkLWJkZGQtNGI3OWZhMjNmMTFhIiwidXNlcm5hbWUiOiIiLCJwZXJtaXNzaW9uIjoicnciLCJhcHBfbmFtZSI6IktvUEFDIn0.6YHr2ZOa3w-9S8a3xfuNBGel2lnFSEfeDCUhuvM1Kgw",
      #   "dtable_uuid": "1c38c743-566c-44bd-bddd-4b79fa23f11a",
      #   "dtable_server": "https://cloud.seatable.io/dtable-server/",
      #   "dtable_socket": "https://cloud.seatable.io/",
      #   "dtable_db": "https://cloud.seatable.io/dtable-db/",
      #   "workspace_id": 32175,
      #   "dtable_name": "Terminanfrage_BW_09.02.2023_FIX_14.02.2023"
      # }
    end

    def parse(body)
      JSON.parse(body)
    rescue JSON::ParserError
      nil
    end

    def access_token
      @access_token ||= access_data['access_token']
    end

    def table_uuid
      @table_uuid ||= access_data['dtable_uuid']
    end

    # def get_table_rows(table_name = 'Terminierungsliste')
    #   token_data = receive_access_token
    #   url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{token_data['dtable_uuid']}/rows/?table_name=#{table_name}")
    #
    #   https = Net::HTTP.new(url.host, url.port)
    #   https.use_ssl = true
    #
    #   request = Net::HTTP::Get.new(url)
    #   request["Authorization"] = "Token #{token_data['access_token']}"
    #   response = https.request(request)
    #   data = JSON.parse(response.read_body)
    #   p data
    #   data
    # end
  end
end