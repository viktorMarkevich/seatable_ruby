require "uri"
require "net/http"

module SeatableRuby
  class Row
    attr_accessor :dtable_uuid, :access_token

    def initialize(params = {})
      client = Client.new
      @dtable_uuid = client.dtable_uuid
      @access_token = client.access_token
    end

    # POST
    # List Rows(with SQL)
    # required body_params are -> { sql: '...', convert_keys: true|false }
    #
    # for more info -> https://seatable.readme.io/reference/querysql

    def list_rows_with_sql(body_params)
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}/sql")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # GET
    # List Rows
    # required query_params is -> { table_name: '...' }
    # all query_params => { table_name: '...', view_name: '...', convert_link_id: '..boolean..', order_by: '...', direction: '...', start: '...', limit: '...' }
    # for more info -> https://seatable.readme.io/reference/listrows
    #
    # NOTE: The response returns only up to 1.000 rows, even if limit is set to more than 1.000.
    # This request can not return rows from the big data backend. User the request List Rows (with SQL) instead.

    def list_rows(query_params)
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}/rows/")
      url.query = URI.encode_www_form(query_params)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Token #{access_token}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # POST
    # Append Row(s)
    # required body_params are -> { table_name: '...', rows: [{ row data }, {}, ...] }
    # for more info -> https://seatable.readme.io/reference/appendrows

    def append_rows(body_params)
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}/rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # PUT
    # Update Row(s)
    # required body_params are -> { table_name: '...', updates: [ row_id: '...', row: { "Name":"Max", "Age":"21" } ] }
    # for more info -> https://seatable.readme.io/reference/updaterow

    def update_rows(body_params)
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}/rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Accept"] = "application/json"
      request["Content-type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # GET
    # Get Row
    # required path_params is -> { row_id: '...' }
    # required query_params is -> { table_name: '...' }
    # all query_params are -> { table_name: '...', convert: true|false }
    # for more info -> https://seatable.readme.io/reference/getrow

    def get_row(path_params, query_params)
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}/rows/#{path_params[:row_id]}/")
      url.query = URI.encode_www_form(query_params)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = "Token #{access_token}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # DELETE
    # Delete Row(s)
    # required body_params are -> { table_name: '...', row_ids: ['..', '..'] }
    # for more info -> https://seatable.readme.io/reference/deleterow

    # FYI: !!! the api doc has an error. There is `row_id` as required attr
    # but after double checking there is only `row_ids` working

    def delete_rows(body_params)
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}/rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Delete.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Accept"] = "application/json"
      request["Content-type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # PUT
    # Lock Rows
    # required body_params are -> { table_name: '...', row_ids: [ '..', '..' ] }
    #
    # NOTE: Lock rows is an advanced feature in SeaTable and only available for enterprise subscriptions.
    # for more info -> https://seatable.readme.io/reference/lockrows

    def lock_rows(body_params)
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}/lock-rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # PUT
    # Unlock Rows
    # required body_params are -> { table_name: '...', row_ids: [ '..', '..' ] }
    #
    # for more info -> https://seatable.readme.io/reference/unlockrows

    def unlock_rows(body_params)
      url = URI("https://cloud.seatable.io/api-gateway/api/v2/dtables/#{dtable_uuid}/unlock-rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end
  end
end