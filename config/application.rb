require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module RailsIntegrate
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.{rb,yml}"]
    config.autoload_paths += Dir["#{config.root}/app/models/**/"]

    Dir.glob("config/routes/*").each do |route|
      config.paths["config/routes.rb"] << Rails.root.join(route)
    end

    config.autoload_paths << Rails.root.join("lib")
  end
end
