begin
  route_proc = ->(contribution) do
    CatarseStripe::Engine.routes.url_helpers.review_stripe_path(contribution)
  end

  PaymentEngines.register({
    name: 'stripe',
    review_path: route_proc,
    locale: 'en'
  })
rescue Exception => e
  puts "Error while registering payment engine: #{e}"
end
