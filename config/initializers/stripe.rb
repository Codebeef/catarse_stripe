Rails.configuration.stripe = {
  :publishable_key => (ENV['STRIPE_PUB_KEY']),
  :secret_key      => (ENV['STRIPE_SEC_KEY']),
  :stripe_client_id => (ENV['STRIPE_CLIENT_ID'])
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]
STRIPE_CLIENT_ID = Rails.configuration.stripe[:stripe_client_id]
