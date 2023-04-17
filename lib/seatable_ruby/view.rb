require "uri"
require "net/http"

module SeatableRuby
  class View
    attr_accessor :params, :access_data

    def initialize(params = {})
      @access_data = Client.new.access_data
      @params = params
    end

    # GET
    # List Rows
    def list_views
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{access_data['dtable_uuid']}/views/")

      url.query = URI.encode_www_form(params)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'

      response = http.request(request)
      SeatableRuby.parse(response.read_body)
      # ALLOWED_PARAMS => [:table_name]
      # the response example here https://api.seatable.io/reference/list-views
    end

    # POST
    # Create view
    def create_view(body = {})

      # ALLOWED_BODY => { name: "Name of the new view.",
      #                   type: "Type of the view, either normal view or a big data view. The default value is table.",
      #                   is_locked: boolean }
      # name: required
      # type: required

      p 'The Get View does not ready yet'
    end

    # GET
    # Get View
    def get_view(query = {})
      p 'The Get View does not ready yet'
    end

    # PUT
    # Update View
    def update_view(query = {})
      p 'The Update View does not ready yet'
    end

    # DELETE
    # Delete View
    def delete_view(query = {})
      p 'The Delete View does not ready yet'
    end
  end
end