module CatarseStripe
  module Service
    module Contributor

      class Pay < Base
        attr_reader :failed_contributors

        def initialize(project)
          super(project)
          @failed_contributors = []
        end

        def auth_card(contributor)
          CatarseStripe::Request::Payment.new({
            id: contributor.id
          }).result
        end

        def settle_contributor(contributor)
          CatarseStripe::Request::Settle.new({
            id: contributor.id
          }).result
        end

        def refund_contributor(contributor)
          CatarseStripe::Request::Refund.new({
            id: contributor.id
          }).result
        end

        def perform
          each_contributor do |contributor|
            begin
              next unless contributor.payment_method == 'Stripe'
              next unless contributor.payment_id.blank?

              if auth_card(contributor)
                puts "**** [Stripe] contributor #{contributor.id} paid."
              else
                puts "**** [Stripe] contributor #{contributor.id} failed"
                contributor.cancel!
                @failed_contributors << contributor
              end
            end
          end

          succesful = failed_contributors.empty?

          if succesful
            # Now we have the full amount, we should capture the transactions
            each_contributor do |contributor|
              next if contributor.payment_id.nil?
              settle_contributor(contributor)
            end
          else
            # Refund all authed payments
            each_contributor do |contributor|
              next if contributor.payment_id.nil?
              refund_contributor(contributor)
            end
          end

          succesful
        end
      end

    end
  end
end
