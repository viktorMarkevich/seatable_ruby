# SeatableRuby

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/seatable_ruby`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add seatable_ruby

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install seatable_ruby

## Usage
 
- create a file with any name (whatever you like) in the `initializers` folder.
- add the following lines to this file:
    ```
    require 'seatable_ruby'

    SeatableRuby.config do |c|
        c.api_token = ENV['SEATABLE_API_TOKEN']
        ....
        c.account_token = ENV['SEATABLE_ACCOUNT_TOKEN'] # If you know your account_tocken. This has a higher priority than the lines below.
          
          OR/AND
  
        c.account_credentials = { # to get an account token
          username: ENV['SEATABLE_USERNAME'],
          password: ENV['SEATABLE_PASSWORD']
        ....
        }
    end    
    ```
__NOTE:__ Put your seatable data into `ENV['SEATABLE_...']`. You can do it by using the [dotenv-rails gem](https://github.com/bkeepers/dotenv) **OR** use `master.key` and `credentials.yml.enc` if you rails version is `5.0 +`.
### Endpoints
#### Rows
- List Rows:  
  - Method - [GET]
  - Action - `list_rows`
  - Available params [here](https://api.seatable.io/#528ae603-6dcc-4dc3-846f-a38974a4795d)

- Query with SQL:
  - Method - [POST]
  - Action - `query_with_sql(query = {})`
  - Body request example [here](https://api.seatable.io/#333f80ba-1c61-4a74-a0a9-fa806185d850)

- Query Row Link List:
  - Method - [POST]
  - Action - `query_row_link_list(query = {})`
  - Body request example [here](https://api.seatable.io/#186e5166-6d9e-4aef-890e-a1dd8a8b2ee0)

- Get Row's Details with Row ID:
  - Method - [GET]
  - Action - `row_details`
  - Available params [here](https://api.seatable.io/#9d893840-90b2-4d43-a3bc-493799eef278)

- Append Row:
  - Method - [POST]
  - Action - `append_row(row_data)`
  - Body request example [here](https://api.seatable.io/#46fc953a-0928-49ec-ae21-d652294d15b1)

- Insert Row:
  - Method - [POST]
  - Action - `insert_row(row_data)`
  - Body request example [here](https://api.seatable.io/#14141025-e963-4826-a8e7-710a3cf563ba)

- Batch Append Rows:
  - Method - [POST]
  - Action - `batch_append_rows(batch_rows_data)`
  - Body request example [here](https://api.seatable.io/#d34eb1ec-6692-4f5f-9182-94eff2efeaae)

- Update Row:
  - Method - [PUT]
  - Action - `update_row(row_data)`
  - Body request example [here](https://api.seatable.io/#25735354-2eac-42fc-bd2e-903a68e10c52)

- Batch Update Rows:
  - Method - [PUT]
  - Action - `batch_update_rows(rows_data)`
  - Body request example [here](https://api.seatable.io/#81ade8f6-13ff-4140-96a9-bc3c7fad3e0b)

- Delete Row:
  - Method - [DELETE]
  - Action - `delete_row(row_data)`
  - Body request example [here](https://api.seatable.io/#6a840773-693f-42a4-9121-c8a074312f99)

- Batch Delete Rows:
  - Method - [DELETE]
  - Action - `batch_delete_rows(rows_data)`
  - Body request example [here](https://api.seatable.io/#522785d7-c771-4597-a71f-9fb713ad8bc6)

- List Deleted Rows:
  - Method - [GET]
  - Action - `list_deleted_rows`
  - Example [here](https://api.seatable.io/#b9338a36-add8-4c80-9770-f265fb75ada2)

- Lock Rows:
  - Method - [PUT]
  - Action - `lock_rows(rows_data)`
  - Body request example [here](https://api.seatable.io/#39e0b4c9-aa7e-4efa-86ff-05f37cb972d9)

- Unlock Rows:
  - Method - [PUT]
  - Action - `unlock_rows(rows_data)`
  - Body request example [here](https://api.seatable.io/#dac3fea7-ee02-43a6-97ec-2ae6d49602ec)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/viktorMarkevich/seatable_ruby.
