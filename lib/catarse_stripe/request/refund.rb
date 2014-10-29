module CatarseStripe
  module Request

    class Refund < Base
      def transaction
        @transaction ||= ::Stripe::Charge.retrieve(contribution.payment_id, contribution.project.stripe_access_token)
      end

      def void_transaction
        transaction.refunds.create
      end

      def result
        puts "[Stripe] Refunding #{transaction.id}"

        void_transaction
        contribution.update_attributes({
          payment_id: nil
        })

        transaction
      rescue
        puts "Could not refund #{transaction.id}"
        false
      end
    end

  end
end
