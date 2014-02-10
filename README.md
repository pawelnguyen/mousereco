# Mousereco

Mousereco is a mouse recording Rails engine with a web interface used to replay user visits

## Installation

Add this line to your application's Gemfile:

    gem 'mousereco'

Execute:

    $ bundle

And then run install generator:

    $ rails generate mousereco:install

It will:
 - add a tracker js code to your application.js file
 - mount Mousereco at ```/mousereco``` route
 - install and run migrations needed for Mousereco

## Usage

By default Mousereco engine will be mounted at ```/mousereco``` path in your application. You can replay your recordings there

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
