# Property Service

### Built With

* Ruby 3.0.0
* Ruby On Rails 6.1.4
* Puma 5.0
* PostgresSQL

### Important Gems used
* activerecord-postgres-earthdistance
* has_scope
* rspec-rails

##### 1. Check out the repository

```bash
git clone git@github.com:Ashour15/property_service.git
```

##### 2. Create database.yml file

Copy the sample database.yml file and edit the database configuration as required.

```bash
cp config/database.yml.sample config/database.yml
```

##### 3. Create and setup the database

Run the following commands to create the database and import the dump data.

```ruby
bundle exec rake db:create
psql -U{{username}} {{database name}} < properties.sql 
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

### To run test suites

You can start the rails server using the command given below.

```ruby
bundle exec rspec spec/models/property_spec.rb
bundle exec rspec spec/requests/properties_spec.rb
```

## Example

### Request

`GET /properties/`

    curl -i -H 'Accept: application/json' -d 'lng=13.4236807&lat=52.5342963&property_type=apartment&marketing_type=sell' http://localhost:3000/properties

### Response

    HTTP/1.1 200 OK
    Status: 200 OK
    Connection: close
    Content-Type: application/json

 ```
[
  {

    house_number: "31", 
    street: "Marienburger Straße", 
    city: "Berlin", 
    zip_code: "10405
    state: "Berlin",
    lat: '13.4211476',
    lng: '52.534993',
    price: '350000'

  },
  {

    house_number: "16", 
    street: "Winsstraße", 
    city: "Berlin", 
    zip_code: "10405"
    state: "Berlin",
    lat: '52.533533',
    lng: '13.425226',
    price: '320400'

  }
...]
```
