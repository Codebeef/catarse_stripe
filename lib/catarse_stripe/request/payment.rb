module CatarseStripe
  module Request

    class Payment < Base
      def transaction
        @transaction ||= Stripe::Charge.create({
          customer: contribution.payment_token,
          amount: contribution.price_in_cents,
          currency: 'gbp',
          description: I18n.t('stripe_description', scope: SCOPE, project_name: contribution.project.name, value: contribution.display_value),
          capture: false,
          application_fee: (contribution.price_in_cents * ::Configuration['catarse_fee'].to_f).to_i
          },
          contribution.project.stripe_access_token
        )
      end

      def result
        puts "[Stripe] Paying #{contribution.id}"
        begin
          transaction
          puts "[Stripe] Paid with Tx #{transaction.id}"
          contribution.update_attributes({
            payment_id: transaction.id
          })

          transaction
        rescue
          puts "[Stripe] Could not create charge"
          false
        end
      end
    end

  end
end
