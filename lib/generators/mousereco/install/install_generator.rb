module Mousereco
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc 'This generator installs Mousereco'

      def copy_initializer_file
        copy_file 'mousereco.rb', 'config/initializers/mousereco.rb'
      end

      def add_assets
        js_manifest = 'app/assets/javascripts/application.js'

        inject_into_file js_manifest, "//= require mousereco/tracker\n", :before => '//= require_tree .'
      end

      def add_routes
        route "mount Mousereco::Engine, at: \"/mousereco\"\n"
      end

      def run_migrations
        rake 'mousereco:install:migrations'
        rake 'db:migrate'
      end
    end
  end
end
