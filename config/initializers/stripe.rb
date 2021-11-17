Rails.configuration.stripe = {
  :publishable_key        => ENV['PUBLISHABLE_KEY'],
  :secret_key             => ENV['SECRET_KEY'],
  :stripe_endpoint_secret => ENV['STRIPE_ENDPOINT_SECRET']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]