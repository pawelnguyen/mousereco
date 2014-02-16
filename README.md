# Mousereco

Mousereco is a mouse recording Rails engine with a web interface used to replay user visits

## Installation

#### 1. Add this line to your application's Gemfile:

    gem 'mousereco'

#### 2. Execute:

    $ bundle

#### 3. And then run install generator:

    $ rails generate mousereco:install

It will:
 - add ```initializers/mousereco.rb``` file
 - add a tracker js code to your application.js file
 - mount Mousereco at ```/mousereco``` route
 - install and run migrations needed for Mousereco

#### 4. Change your http basic authentication password:

Edit ```initializers/mousereco.rb``` file:

```
config.http_auth_password = 'your_secret_password'
```

## Usage

By default Mousereco engine will be mounted at ```/mousereco``` path in your application. You can replay your recordings there

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
