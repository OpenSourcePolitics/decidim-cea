# frozen_string_literal: true

Devise.setup do |config|
  # Disable fast signup
  config.allow_unconfirmed_access_for = 0.days
end
