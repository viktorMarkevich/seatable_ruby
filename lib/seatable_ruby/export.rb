require "uri"
require "net/http"

module SeatableRuby
  class Export
    attr_accessor :dtable_uuid, :access_token, :account_token

    def initialize
      client = Client.new
      @dtable_uuid = client.dtable_uuid
      @access_token = client.access_token
      @account_token = Account.new.account_token
    end

    def export_base(path_params, query_params)
      url = URI("https://cloud.seatable.io/api/v2.1/workspace/#{path_params[:workspace_id]}/synchronous-export/export-dtable/")
      url.query = URI.encode_www_form(query_params)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Bearer #{account_token}"

      response = http.request(request)
      # SeatableRuby.parse(response.read_body)
      puts response.read_body
    end

    # GET
    # Export Table
    def export_table(path_params, query_params)
      url = URI("https://cloud.seatable.io/api/v2.1/workspace/#{path_params[:workspace_id]}/synchronous-export/export-table-to-excel/")

      url.query = URI.encode_www_form(query_params)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Bearer #{account_token}"

      response = http.request(request)
      # SeatableRuby.parse(response.read_body)
      puts response.read_body
    end

    # GET
    # Export View
    # EXAMPLE PARAMS => { table_id: "The id of the table. The id of a table is unique inside a base and is often used
    #                               to identify a table. Important: the table_id is not the table_name.",
    #                     table_name: 'The name of the table.',
    #                     dtable_name: 'name of your base',
    #                     view_id: 'id of view, string',
    #                     view_name: 'name of view, required, string. Default value is "Default View" '}

    # REQUIRED PATH PARAMS => [:workspace_id]

    # REQUIRED QUERY PARAMS => [table_id, :table_name, :base_name, :view_id, :view_name]
    #
    # the response example here https://api.seatable.io/reference/export-view
    def export_view(path_params, query_params)
      url = URI("https://cloud.seatable.io/api/v2.1/workspace/#{path_params[:workspace_id]}/synchronous-export/export-view-to-excel/")
      # tt =  { table_id: '0000', table_name: 'xxx', dtable_name: 'viktor_base_name', view_id: '0000', view_name: 'Default View' }
      # tt = { table_name: 'Vorlagen', view_name: 'Default', table_id: 'xd68', view_id: '0000', workspace_id: 32175, dtable_name: 'Delphi' }
      url.query = URI.encode_www_form(query_params)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Bearer #{account_token}"

      response = http.request(request)
      # SeatableRuby.parse(response.read_body)
      puts response.read_body
    end
  end
end