# SeatableRuby

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/seatable_ruby`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add seatable_ruby

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install seatable_ruby

## Usage
### Config 
- create a file with any name (whatever you like) in the `initializers` folder.
- add the following lines to this file:
    ```
    require 'seatable_ruby'

    SeatableRuby.config do |c|
        c.api_token = ENV['SEATABLE_API_TOKEN']
        ....
        c.account_token = ENV['SEATABLE_ACCOUNT_TOKEN'] # If you know your account_token.
          
          OR/AND
  
        c.account_credentials = {                       # To get an account_token
          username: ENV['SEATABLE_USERNAME'],
          password: ENV['SEATABLE_PASSWORD']
        ....
  
        # If setup the account_credentials and account_token data,
        # then gem will works with account_credentials only.
        # More info about priorities in the `Account` section.  
         
        }
    end    
    ```
__NOTE:__ Put your seatable data into `ENV['SEATABLE_...']`. You can do it by using the [dotenv-rails gem](https://github.com/bkeepers/dotenv) **OR** use `master.key` and `credentials.yml.enc` if you rails version is `5.0 +`.
### Endpoints
#### Account: `SeatableRuby::Account.new`

- __Account token:__
  - Method - [POST]
  - There are 3 options to get account_token. If all of them defined, then gem will works in the next priorities:
    - [1]: pass seatable account credentials => `SeatableRuby::Account.new({ username: 'email address', password: 'passsword' }).account_token` => `token_string`
    - [2]: set seatable `account_credentials` into `/config/initializers/seatable.rb` (take a look Config section) => `SeatableRuby::Account.new.account_token` => `token_string` 
    - [3]: set seatable `account_token` into `/config/initializers/seatable.rb` (take a look Config section) => `SeatableRuby::Account.new.account_token` => `token_string`
  - More api info [here](https://api.seatable.io/reference/get-account-token)

#### BasicInfo: `SeatableRuby::BasicInfo.new`
- __Get Base Info:__
  - Method - [GET]
  - Instance method - `basic_info`
  - More api info [here](https://api.seatable.io/reference/get-base-info)


- __Get Metadata:__
  - Method - [GET]
  - Instance method - `basic_metadata`
  - More api info [here](https://api.seatable.io/reference/get-metadata)


- __Get Big Data Status:__
  - Method - [GET]
  - Instance method - `basic_big_data_status`
  - More api info [here](https://api.seatable.io/reference/get-big-data-status)

#### Columns: `SeatableRuby::Column.new`
- __Get Big Data Status:__
  - Method - [GET]
  - Instance method - `list_columns(query_params)`
    - Required `query_params` is `{ table_name: '...' }`
    - All `query_params` are `{ table_name: '...', view_name: '...' }`
  - More api info [here](https://api.seatable.io/reference/list-columns)


#### Export: `SeatableRuby::Export.new`
- __Export Base:__
  - Method - [GET]
  - Instance method - `export_base(path_params, query_params)`
    - Required `path_params` is `{ workspace_id: '..' }`
    - Required `query_params` is `{ dtable_name: 'base name' }`
  - **NOTE:** in the api they show us the `:base_name` key for some reason, but work version is the `:dtable_name` key  
  - More api info [here](https://api.seatable.io/reference/export-base)


- __Export Table:__
  - Method - [GET]
  - Instance method - `export_table(path_params, query_params)`
    - Required `path_params` is `{ workspace_id: '..' }`
    - Required `query_params` is `{ table_id: 'xxxx', table_name: '', dtable_name: '...'] }`
  - **NOTE:** in the api they show us the `:base_name` key for some reason, but work version is the `:dtable_name` key
  - More api info [here](https://api.seatable.io/reference/export-table)


- __Export View:__
  - Method - [GET]
  - Instance method - `export_view(path_params, query_params)`
    - Required `path_params` is `{ workspace_id: '..' }`
    - Required `query_params` is `{ table_id: "xxxx", table_name: '...', dtable_name: 'name of your base', view_id: '', view_name: 'name of view' }`
  - **NOTE:** in the api they show us the `:base_name` key for some reason, but work version is the `:dtable_name` key
  - More api info [here](https://api.seatable.io/reference/export-view)

  
#### Rows: `SeatableRuby::Row.new`
- __List Rows(with SQL):__
  - Method - [POST]
  - Instance method - `list_rows_with_sql(body_params)` 
    - Required `body_params` are `{ sql: '...', convert_keys: boolean }`
  - More api info [here](https://api.seatable.io/reference/list-rows-with-sql)
  

- __List Rows:__  
  - Method - [GET]
  - Instance method - `list_rows(query_params)`
    - Required `query_params` is `{ table_name: '...' }`
    - All `query_params` are `{ table_name: '...', view_name: '...', convert_link_id: '...', order_by: '...', direction: '...', start: '...', limit: '...' }`
  - **NOTE:** The response returns only up to 1.000 rows, even if limit is set to more than 1.000. This request can not return rows from the big data backend. User the request List Rows (with SQL) instead.
  - More api info [here](https://api.seatable.io/reference/list-rows)
  
  
- __Append Row:__
  - Method - [POST]
  - Instance method - `append_row(body_params)`
    - Required `body_params` are `{ table_name: '...', row: { row data } }`
  - More api info [here](https://api.seatable.io/reference/add-row)


- __Insert Row:__
  - Method - [POST]
  - Instance method - `insert_row(body_params)`
    - Required `body_params` are `{ table_name: '...', row: { row data } }`
    - All params: `body_params` are `{ table_name: '...', anchor_row_id: '...', row_insert_position: '...', row: { row data } }`
  - More api info [here](https://api.seatable.io/reference/add-row)


- __Update Row:__
  - Method - [PUT]
  - Instance method - `update_row(body_params)`
    - Required `body_params` are `{ table_name: '...', row_id: '...', row: { row data }] }`
  - More api info [here](https://api.seatable.io/reference/update-row)


- __Delete Row:__
  - Method - [DELETE]
  - Instance method - `delete_row(body_params)`
    - Required `body_params` are `{ table_name: '...', row_id: '...' }`
  - More api info [here](https://api.seatable.io/reference/delete-row)


- __Get Row:__
  - Method - [GET]
  - Instance method - `get_row(path_params, query_params)`
    - Required `path_params` is `{ row_id: '...' }`
    - Required `query_params` is `{ table_name: '...' }`
    - All `query_params` are `{ table_name: '...', convert: boolean }`
  - More api info [here](https://api.seatable.io/reference/get-row)
  

- __Batch Append Rows:__
  - Method - [POST]
  - Instance method - `append_rows(body_params)`
    - Required `body_params` are `{ table_name: '..', rows: [...] }`
  - More api info [here](https://api.seatable.io/reference/append-rows)

- __Batch Update Rows:__
  - Method - [PUT]
  - Instance method - `update_rows(body_params)`
    - Required `body_params` are `{ table_name: '...', updates: [ row_id: '...', row: { "Name":"Max", "Age":"21" } ] }`
  - More api info [here](https://api.seatable.io/reference/update-rows)
  

- __Batch Delete Rows:__
  - Method - [DELETE]
  - Instance method - `delete_rows(body_params)`
    - Required `body_params` are `{ table_name: '...', row_ids: ['..', '..'] }`
  - More api info [here](https://api.seatable.io/reference/delete-rows)
  

- __Lock Rows:__
  - Method - [PUT]
  - Instance method - `lock_rows(body_params)`
    - Required `body_params` are `{ table_name: '...', row_ids: [ '..', '..' ] }`
    - **NOTE:** Lock rows is an advanced feature in SeaTable and only available for `enterprise` subscriptions.
  - More api info [here](https://api.seatable.io/reference/lock-rows)


- __Unlock Rows:__
  - Method - [PUT]
  - Instance method - `unlock_rows(body_params)`
    - Required `body_params` are `{ table_name: '...', row_ids: [ '..', '..' ] }`
  - More api info [here](https://api.seatable.io/reference/unlock-rows)


#### Views: `SeatableRuby::View.new`
- __List Views:__
  - Method - [GET]
  - Instance method - `list_views(query_params)`
    - Required `query_params` is `{ table_name: '...' }`
  - More api info [here](https://api.seatable.io/reference/list-views)


- __Create View:__
  - Method - [POST]
  - Instance method - `create_view(query_params, body_params)`
    - Required `query_params` is `{ table_name: '...' }`
    - Required `body_params` are `{ name: '...', type: 'table|archive' }`
    - All `body_params` are `{ name: '...', type: 'table|archive', is_locked: boolean }`
  - More api info [here](https://api.seatable.io/reference/create-view)
  

- __Get View:__
  - Method - [GET]
  - Instance method - `get_view(path_params, query_params)`
    - Required `path_params` is `{ view_name: '...' }`
    - Required `query_params` is `{ table_name: '...' }`
  - More api info [here](https://api.seatable.io/reference/get-view)
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/viktorMarkevich/seatable_ruby.
