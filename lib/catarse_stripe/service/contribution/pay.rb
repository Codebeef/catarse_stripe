module CatarseStripe
  module Service
    module Contribution

      class Pay < Base
        attr_reader :failed_contributions

        def initialize(project)
          super(project)
          @failed_contributions = []
        end

        def auth_card(contribution)
          CatarseStripe::Request::Payment.new({
            id: contribution.id
          }).result
        end

        def settle_contribution(contribution)
          CatarseStripe::Request::Settle.new({
            id: contribution.id
          }).result
        end

        def refund_contribution(contribution)
          CatarseStripe::Request::Refund.new({
            id: contribution.id
          }).result
        end

        def perform
          each_contribution do |contribution|
            begin
              next unless contribution.payment_method == 'Stripe'
              next unless contribution.payment_id.blank?

              if auth_card(contribution)
                puts "**** [Stripe] contribution #{contribution.id} paid."
              else
                puts "**** [Stripe] contribution #{contribution.id} failed"
                contribution.cancel!
                @failed_contributions << contribution
              end
            end
          end

          succesful = failed_contributions.empty?

          if succesful
            # Now we have the full amount, we should capture the transactions
            each_contribution do |contribution|
              next if contribution.payment_id.nil?
              settle_contribution(contribution)
            end
          else
            # Refund all authed payments
            each_contribution do |contribution|
              next if contribution.payment_id.nil?
              refund_contribution(contribution)
            end
          end

          succesful
        end
      end

    end
  end
end
