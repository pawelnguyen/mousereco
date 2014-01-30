module Mousereco
  class Engine < ::Rails::Engine
    isolate_namespace Mousereco

    initializer "mousereco.assets.precompile" do |app|
      app.config.assets.precompile += %w(mousereco/mousereco.js mousereco/mousereco.css)
    end
  end
end
