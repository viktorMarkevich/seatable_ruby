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
    # required body_params are -> [:sql, :convert_keys]
    # more info -> https://api.seatable.io/reference/list-rows-with-sql

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
    # required query_params is -> [:table_name]
    # all query_params => [:table_name, :view_name, :convert_link_id, :order_by, :direction, :start, :limit]
    # more info -> https://api.seatable.io/reference/list-rows

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
    # required body_params are -> [:table_name,row: { row data }]
    # more info -> https://api.seatable.io/reference/add-row

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
    # required body_params are -> [:table_name,row: { row data }]
    # all body_params are -> [:table_name, :anchor_row_id, :row_insert_position, row: { row data }]
    # more info -> https://api.seatable.io/reference/add-row

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
    # required body_params are -> [:table_name, :row_id, row: { row data }]
    # more info -> https://api.seatable.io/reference/update-row
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

    # # POST
    # # Query Row Link List
    # def query_row_link_list(query = {})
    #   # example of query body
    #   # https://api.seatable.io/#186e5166-6d9e-4aef-890e-a1dd8a8b2ee0
    #   url = URI("https://cloud.seatable.io/dtable-db/api/v1/linked-records/#{dtable_uuid}")
    #
    #   https = Net::HTTP.new(url.host, url.port)
    #   https.use_ssl = true
    #
    #   request = Net::HTTP::Post.new(url)
    #   request["Authorization"] = "Token #{access_token}"
    #   request.body = query
    #
    #   response = https.request(request)
    #   SeatableRuby.parse(response.read_body)
    # end
    #
    # # GET
    # # Get Row's Details with Row ID
    # def row_details
    #   url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/#{params['row_id']}/")
    #   url.query = URI.encode_www_form(params.except('row_id'))
    #
    #   https = Net::HTTP.new(url.host, url.port)
    #   https.use_ssl = true
    #
    #   request = Net::HTTP::Get.new(url)
    #   request["Authorization"] = "Token #{access_token}"
    #
    #   response = https.request(request)
    #   SeatableRuby.parse(response.read_body)
    # end
    #
    # # POST
    # # Batch Append Rows
    # def batch_append_rows(batch_rows_data)
    #   url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/batch-append-rows/")
    #
    #   https = Net::HTTP.new(url.host, url.port)
    #   https.use_ssl = true
    #
    #   request = Net::HTTP::Post.new(url)
    #   request["Authorization"] = "Token #{access_token}"
    #   request["Content-Type"] = "application/json"
    #   request.body = JSON.dump(batch_rows_data)
    #
    #   response = https.request(request)
    #   SeatableRuby.parse(response.read_body)
    # end
    #
    # # PUT
    # # Batch Update Rows
    # def batch_update_rows(rows_data)
    #   url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/batch-update-rows/")
    #
    #   https = Net::HTTP.new(url.host, url.port)
    #   https.use_ssl = true
    #
    #   request = Net::HTTP::Put.new(url)
    #   request["Authorization"] = "Token #{access_token}"
    #   request["Accept"] = "application/json"
    #   request["Content-Type"] = "application/json"
    #   request.body = JSON.dump(rows_data)
    #
    #   response = https.request(request)
    #   SeatableRuby.parse(response.read_body)
    # end
    #
    # # DELETE
    # # Delete Row
    # def delete_row(row_data)
    #   url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/rows/")
    #
    #   https = Net::HTTP.new(url.host, url.port)
    #   https.use_ssl = true
    #
    #   request = Net::HTTP::Delete.new(url)
    #   request["Authorization"] = "Token #{access_token}"
    #   request["Accept"] = "application/json"
    #   request["Content-type"] = "application/json"
    #   request.body = JSON.dump(row_data)
    #
    #   response = https.request(request)
    #   SeatableRuby.parse(response.read_body)
    # end
    #
    # # DELETE
    # # Batch Delete Rows
    # def batch_delete_rows(rows_data)
    #   url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/batch-delete-rows/")
    #
    #   https = Net::HTTP.new(url.host, url.port)
    #   https.use_ssl = true
    #
    #   request = Net::HTTP::Delete.new(url)
    #   request["Authorization"] = "Token #{access_token}"
    #   request["Accept"] = "application/json"
    #   request["Content-type"] = "application/json"
    #   request.body = JSON.dump(rows_data)
    #
    #   response = https.request(request)
    #   SeatableRuby.parse(response.read_body)
    # end
    #
    # # GET
    # # List Deleted Rows
    # def list_deleted_rows
    #   url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/deleted-rows/")
    #
    #   https = Net::HTTP.new(url.host, url.port)
    #   https.use_ssl = true
    #
    #   request = Net::HTTP::Get.new(url)
    #   request["Authorization"] = "Token #{access_token}"
    #
    #   response = https.request(request)
    #   SeatableRuby.parse(response.read_body)
    # end
    #
    # # PUT
    # # Lock Rows
    # def lock_rows(rows_data)
    #   url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/lock-rows/")
    #
    #   https = Net::HTTP.new(url.host, url.port)
    #   https.use_ssl = true
    #
    #   request = Net::HTTP::Put.new(url)
    #   request["Authorization"] = "Token #{access_token}"
    #   request["Content-Type"] = "application/json"
    #   request.body = JSON.dump(rows_data)
    #
    #   response = https.request(request)
    #   SeatableRuby.parse(response.read_body)
    # end
    #
    # # PUT
    # # Unlock Rows
    # def unlock_rows(rows_data)
    #   url = URI("https://cloud.seatable.io/dtable-server/api/v1/dtables/#{dtable_uuid}/unlock-rows/")
    #
    #   https = Net::HTTP.new(url.host, url.port)
    #   https.use_ssl = true
    #
    #   request = Net::HTTP::Put.new(url)
    #   request["Authorization"] = "Token #{access_token}"
    #   request["Content-Type"] = "application/json"
    #   request.body = JSON.dump(rows_data)
    #
    #   response = https.request(request)
    #   SeatableRuby.parse(response.read_body)
    # end
  end
end