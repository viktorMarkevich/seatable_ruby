require "uri"
require "net/http"

module SeatableRuby
  class Account
    attr_accessor :account_data

    def initialize(form_data = {})
      @account_data = choose_priority(form_data)
      # account_data can receive { 'token' => 'token_data' } OR { 'some_error_key' => ['message'] }
    end

    private

    def choose_priority(form_data)
      return request_account_token(form_data) if form_data.present?

      return request_account_token(SeatableRuby.account_credentials) if SeatableRuby.account_credentials.present?

      return { 'token' => SeatableRuby.account_token } if SeatableRuby.account_token.present?

      request_account_token({}) # to return an error message
    end

    # POST
    # required form_data params -> { username: 'email address', password: 'passsword' }
    # There are 3 options to get account token(the number of an options it's number of priority):
    #
    # 1. SeatableRuby::Account.new({ username: 'email address', password: 'passsword' }) =>
    #
    # => < SeatableRuby::Account:###### @account_data={ 'token' => tokenString' }>
    #
    # ******************************************************************************************************************
    # 2. SeatableRuby::Account.new =>
    #
    # => < SeatableRuby::Account:###### @account_data={ 'token' => tokenString' } >
    #
    # by using seatable an account credentials DEFINED IN RAILS APP as config hash data:
    #
    # c.account_credentials = {
    #   username: ENV['SEATABLE_USERNAME'],
    #   password: ENV['SEATABLE_PASSWORD']
    # }
    #
    # ******************************************************************************************************************
    #
    # 2. SeatableRuby::Account.new =>
    #
    # => < SeatableRuby::Account:###### @account_data={ 'token' => tokenString' } >
    #
    # by using seatable account_token that was DEFINED IN RAILS APP as the `c.account_token= ENV['SEATABLE_ACCOUNT_TOKEN']`
    # it used IF the c.account_credentials = { } was not defined at all
    #*******************************************************************************************************************
    #
    # for more info -> https://api.seatable.io/reference/get-account-token

    def request_account_token(credentials)
      url = URI("https://cloud.seatable.io/api2/auth-token/")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["accept"] = 'application/json'
      request["content-type"] = 'application/x-www-form-urlencoded'
      request.body = credentials&.to_query

      response = http.request(request)
      SeatableRuby.parse(response.read_body)
    end
  end
end