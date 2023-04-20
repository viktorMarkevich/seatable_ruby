require "uri"
require "net/http"

module SeatableRuby
  class Export
    attr_accessor :dtable_uuid, :access_token, :account_token

    def initialize
      client = Client.new
      @dtable_uuid = client.dtable_uuid
      @access_token = client.access_token
      @account_token = Account.new.account_data['token']
    end

    # GET
    # Export Base
    # REQUIRED PATH PARAMS => { workspace_id: '..' }
    # REQUIRED QUERY PARAMS => { dtable_name: 'base name' } # NOTE! - in the api they show us the 'base_name' for some reason,
    #                                           but work version is :dtable_name
    #
    # for more info ->  https://api.seatable.io/reference/export-base

    def export_base(path_params, query_params)
      url = URI("https://cloud.seatable.io/api/v2.1/workspace/#{path_params[:workspace_id]}/synchronous-export/export-dtable/")

      make_query(url, query_params)
    end

    # GET
    # Export Table
    # REQUIRED PATH PARAMS => { workspace_id: '' }
    # REQUIRED QUERY PARAMS => { table_id: 'fdf', table_name: '', dtable_name: '...']
    # NOTE! - in the api they show us the 'base_name' for some reason, but work version is :dtable_name
    #
    # for more info -> https://api.seatable.io/reference/export-table

    def export_table(path_params, query_params)
      url = URI("https://cloud.seatable.io/api/v2.1/workspace/#{path_params[:workspace_id]}/synchronous-export/export-table-to-excel/")

      make_query(url, query_params)
    end

    # GET
    # Export View
    # REQUIRED PATH PARAMS => [:workspace_id]
    # REQUIRED QUERY PARAMS => { table_id: "The id of the table. The id of a table is unique inside a base and is often used
    #                                   to identify a table. Important: the table_id is not the table_name.",
    #                            table_name: 'The name of the table.',
    #                            dtable_name: 'name of your base',
    #                            view_id: 'id of view, string',
    #                            view_name: 'name of view, required, string.'}
    #
    # NOTE! - in the api they show us the 'base_name' for some reason,
    #                                                       but work version is :dtable_name
    #
    # for more info -> https://api.seatable.io/reference/export-view

    def export_view(path_params, query_params)
      url = URI("https://cloud.seatable.io/api/v2.1/workspace/#{path_params[:workspace_id]}/synchronous-export/export-view-to-excel/")

      make_query(url, query_params)
    end

    private

    def make_query(url, query_params)
      url.query = URI.encode_www_form(query_params)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Bearer #{account_token}"

      response = http.request(request)
      response.read_body
    end
  end
end