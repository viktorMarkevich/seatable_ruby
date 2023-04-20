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
    # for more info -> https://api.seatable.io/reference/list-rows-with-sql

    def list_rows_with_sql(body_params)
      url = URI("https://cloud.seatable.io/dtable-db/api/v1/query/#{dtable_uuid}/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # GET
    # List Rows
    # required query_params is -> { table_name: '...' }
    # all query_params => { table_name: '...', view_name: '...', convert_link_id: '...', order_by: '...', direction: '...', start: '...', limit: '...' }
    # for more info -> https://api.seatable.io/reference/list-rows
    #
    # NOTE: The response returns only up to 1.000 rows, even if limit is set to more than 1.000.
    # This request can not return rows from the big data backend. User the request List Rows (with SQL) instead.

    def list_rows(query_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows")
      url.query = URI.encode_www_form(query_params)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{access_token}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # POST
    # Append Row
    # required body_params are -> { table_name: '...', row: { row data } }
    # for more info -> https://api.seatable.io/reference/add-row

    def append_row(body_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # POST
    # Insert Row
    # required body_params are -> { table_name: '...', row: { row data } }
    # all body_params are -> { table_name: '...', anchor_row_id: '...', row_insert_position: '...', row: { row data } }
    # for more info -> https://api.seatable.io/reference/add-row

    def insert_row(body_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Accept"] = "application/json"
      request["Content-type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # PUT
    # Update Row
    # required body_params are -> { table_name: '...', row_id: '...', row: { row data }]
    # for more info -> https://api.seatable.io/reference/update-row
    def update_row(body_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/")

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

    # DELETE
    # Delete Row
    # required body_params are -> { table_name: '...', row_id: '...' }
    # for more info -> https://api.seatable.io/reference/delete-row
    def delete_row(body_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/")

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

    # GET
    # Get Row
    # required path_params is -> { row_id: '...' }
    # required query_params is -> { table_name: '...' }
    # all query_params are -> { table_name: '...', convert: true|false }
    # for more info -> https://api.seatable.io/reference/get-row

    def get_row(path_params, query_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/#{path_params[:row_id]}/")
      url.query = URI.encode_www_form(query_params)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{access_token}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # POST
    # Batch Append Rows
    # required body_params are -> { table_name: '..', rows: [...] }
    # for more info -> https://api.seatable.io/reference/append-rows

    def append_rows(body_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/batch-append-rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # PUT
    # Batch Update Rows
    # required body_params are -> { table_name: '...', updates: [ row_id: '...', row: { "Name":"Max", "Age":"21" } ] }
    # for more info -> https://api.seatable.io/reference/update-rows

    def update_rows(body_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/batch-update-rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Accept"] = "application/json"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(body_params)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # DELETE
    # Batch Delete Rows
    # required body_params are -> { table_name: '...', row_ids: ['..', '..'] }
    # for more info -> https://api.seatable.io/reference/delete-rows

    def delete_rows(body_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/batch-delete-rows/")

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
    # for more info -> https://api.seatable.io/reference/lock-rows

    def lock_rows(body_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/lock-rows/")

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
    # for more info -> https://api.seatable.io/reference/unlock-rows

    def unlock_rows(body_params)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/unlock-rows/")

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