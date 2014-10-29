module CatarseStripe
  module Request

    class Settle < Base
      def transaction
        @transaction ||= ::Stripe::Charge.retrieve(contribution.payment_id, contribution.project.stripe_access_token)
      end

      def settle_transaction
        transaction.capture
      end

      def result
        puts "[Stripe] Settling #{transaction.id}"
        settle_transaction
        transaction
      rescue
        puts "[Stripe] Could not capture #{transaction.id}"
        false
      end
    end

  end
end
