require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dkeeper
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end

    # Mailer
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default :charset => "utf-8"
    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: Figaro.env.gmail_domain,
      authentication: "plain",
      enable_starttls_auto: true,
      user_name: Figaro.env.gmail_username,
      password: Figaro.env.gmail_password
    }
    binding.pry
  end
end
