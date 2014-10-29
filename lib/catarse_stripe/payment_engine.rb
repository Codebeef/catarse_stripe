module CatarseStripe
  class PaymentEngine

    def name
      'Stripe'
    end

    def review_path(contribution)
      CatarseStripe::Engine.routes.url_helpers.review_stripe_path(contribution)
    end

    def can_do_refund?
      true
    end

    def direct_refund contribution
      CatarseStripe::Request::Refund.new({
        id: contribution.payment_id
      })
    end

    def locale
      'en'
    end

  end
end
