require "uri"
require "net/http"

module SeatableRuby
  class View
    attr_accessor :dtable_uuid, :access_token

    def initialize
      client = Client.new
      @dtable_uuid = client.dtable_uuid
      @access_token = client.access_token
    end

    # GET
    # List Views
    # required query_params is -> { table_name: '...' }
    #
    # for mor info -> https://api.seatable.io/reference/list-views

    def list_views(query_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/views/")

      url.query = URI.encode_www_form(query_params)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Bearer #{access_token}"

      response = http.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # POST
    # Create view
    # required query_params is -> { table_name: '..' }
    # required body_params is -> { name: '..', type: table|archive }
    # ALL body_params is -> { name: '..', type: table|archive, is_locked: true|false }
    #
    # for mor info -> https://api.seatable.io/reference/create-view
    def create_view(query_params, body_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/views/")

      url.query = URI.encode_www_form(query_params)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["accept"] = 'application/json'
      request["content-type"] = 'application/json'
      request["Authorization"] = "Bearer #{access_token}"
      request.body = JSON.dump(body_params)

      response = http.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # GET
    # Get View
    # required path_params is -> { view_name: '...' }
    # required query_params is -> { table_name: '...' }
    #
    # for mor info -> https://api.seatable.io/reference/get-view

    def get_view(path_params, query_params)
      view_name = (path_params[:view_name] || 'Default View').gsub(/[\s*]/, '%20')
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/views/#{view_name}/")

      url.query = URI.encode_www_form(query_params)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Bearer #{access_token}"

      response = http.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # PUT
    # Update View
    # for mor info -> https://api.seatable.io/reference/update-view
    #
    def update_view(query = {})
      p 'The Update View does not ready yet'
    end

    # DELETE
    # Delete View
    # for mor info -> https://api.seatable.io/reference/delete-view
    def delete_view(query = {})
      p 'The Delete View does not ready yet'
    end
  end
end