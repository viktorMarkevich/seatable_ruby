require "uri"
require "net/http"

module SeatableRuby
  class Row
    attr_accessor :params, :dtable_uuid, :access_token

    def initialize(params = {})
      @dtable_uuid = client.dtable_uuid
      @access_token = client.access_token
      @params = params
    end

    def client
      @client ||= Client.new
    end

    # GET
    # List Rows
    def list_rows
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows")
      url.query = URI.encode_www_form(params)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{access_token}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
      # ALLOWED_PARAMS => [:table_name, :view_name, :convert_link_id, :order_by, :direction, :start, :limit]
      # the response example here https://api.seatable.io/#528ae603-6dcc-4dc3-846f-a38974a4795d
    end

    # POST
    # Query with SQL
    def query_with_sql(query = {})
      url = URI("https://cloud.seatable.io/dtable-db/api/v1/query/#{dtable_uuid}/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(query)
      # ALLOWED_QUERY => { "sql": "select Name from Table1", "convert_keys": true }
      # https://api.seatable.io/#333f80ba-1c61-4a74-a0a9-fa806185d850

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # POST
    # Query Row Link List
    def query_row_link_list(query = {})
      # example of query body
      # https://api.seatable.io/#186e5166-6d9e-4aef-890e-a1dd8a8b2ee0
      url = URI("https://cloud.seatable.io/dtable-db/api/v1/linked-records/#{dtable_uuid}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_token}"
      request.body = query

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # GET
    # Get Row's Details with Row ID
    def row_details
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/#{params['row_id']}/")
      url.query = URI.encode_www_form(params.except('row_id'))

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{access_token}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # POST
    # Append Row
    def append_row(row_data)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(row_data)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # POST
    # Insert Row
    def insert_row(row_data)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Accept"] = "application/json"
      request["Content-type"] = "application/json"
      request.body = JSON.dump(row_data)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # POST
    # Batch Append Rows
    def batch_append_rows(batch_rows_data)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/batch-append-rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(batch_rows_data)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # PUT
    # Update Row
    def update_row(row_data)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Accept"] = "application/json"
      request["Content-type"] = "application/json"
      request.body = JSON.dump(row_data)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # PUT
    # Batch Update Rows
    def batch_update_rows(rows_data)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/batch-update-rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Accept"] = "application/json"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(rows_data)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # DELETE
    # Delete Row
    def delete_row(row_data)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Delete.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Accept"] = "application/json"
      request["Content-type"] = "application/json"
      request.body = JSON.dump(row_data)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # DELETE
    # Batch Delete Rows
    def batch_delete_rows(rows_data)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/batch-delete-rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Delete.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Accept"] = "application/json"
      request["Content-type"] = "application/json"
      request.body = JSON.dump(rows_data)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # GET
    # List Deleted Rows
    def list_deleted_rows
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/deleted-rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Token #{access_token}"

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # PUT
    # Lock Rows
    def lock_rows(rows_data)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/lock-rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(rows_data)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end

    # PUT
    # Unlock Rows
    def unlock_rows(rows_data)
      url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/unlock-rows/")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(url)
      request["Authorization"] = "Token #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump(rows_data)

      response = https.request(request)
      SeatableRuby.parse(response.read_body)
    end
  end
end