## About This Project

This is the back-end of a hypothetical application to expose API's from the DB. The goal of this project is to get familiar with how to expose data in a standard format for the front-end to consume.

I used the Rails Engine Lite [project](https://backend.turing.edu/module3/projects/rails_engine_lite/) to guide me.

#### Learning Goals of Project

- Expose an API
- Use serializers to format JSON responses 
- Test API exposure 
- Use SQL and AR to gather data

#### Versions

- Ruby 2.7.2

- Rails 5.2.6

#### Important Gems
Testing: [rspec-rails](https://github.com/rspec/rspec-rails), [factory-bot](https://github.com/thoughtbot/factory_bot), [faker](https://github.com/faker-ruby/faker)

API: [jsonapi-serializer](https://github.com/fotinakis/jsonapi-serializers)

## Endpoints 
| Request Type  | URI           |  Description | 
| ------------- | ------------- |  ----------- | 
| GET  |  /api/v1/merchants  | get all merchants
| GET  |  /api/v1/merchants/:id  | get one merchant
| GET  |  /api/v1/merchants/:id/items | get all items for a given merchant ID |
| GET |  /api/v1/items | get all items |
| POST | /api/v1/items/:id | get one item |
| POST | /api/v1/items | create an item |
| POST | /api/v1/items/:id | edit an item | 
| POST | /api/v1/items | delete an item |
| GET | /api/v1/merchants/find?name=iLl | NON-RESTFUL -- find a single merchant matching a search term | 
| GET | /api/v1/items/find_all?name=lAcE | NON-RESTFUL -- find all items matching a search term | 