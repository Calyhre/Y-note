require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module YNote
  class Application < Rails::Application
    config.i18n.default_locale = :fr
    config.i18n.enforce_available_locales = true
    I18n.config.enforce_available_locales = true

    config.site_host = ENV['SITE_HOST'] || '0.0.0.0'
    config.root_host = ENV['ROOT_HOST']

    if ENV['HTTP_AUTH']
      config.middleware.use '::Rack::Auth::Basic' do |u, p|
        [u, p] == ENV['HTTP_AUTH'].split('::')
      end
    end
  end

  def self.config
    Application.config
  end
end
