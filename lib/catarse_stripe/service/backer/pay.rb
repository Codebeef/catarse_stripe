module CatarseStripe
  module Service
    module Backer

      class Pay < Base
        attr_reader :failed_backers

        def initialize(project)
          super(project)
          @failed_backers = []
        end

        def auth_card(backer)
          CatarseStripe::Request::Payment.new({
            id: backer.id
          }).result
        end

        def settle_backer(backer)
          CatarseStripe::Request::Settle.new({
            id: backer.id
          }).result
        end

        def refund_backer(backer)
          CatarseStripe::Request::Refund.new({
            id: backer.id
          }).result
        end

        def perform
          each_backer do |backer|
            begin
              next unless backer.payment_method == 'Stripe'
              next unless backer.payment_id.blank?

              if auth_card(backer)
                puts "**** [Stripe] Backer #{backer.id} paid."
              else
                puts "**** [Stripe] Backer #{backer.id} failed"
                backer.cancel!
                @failed_backers << backer
              end
            end
          end

          succesful = failed_backers.empty?

          if succesful
            # Now we have the full amount, we should capture the transactions
            each_backer do |backer|
              next if backer.payment_id.nil?
              settle_backer(backer)
            end
          else
            # Refund all authed payments
            each_backer do |backer|
              next if backer.payment_id.nil?
              refund_backer(backer)
            end
          end

          succesful
        end
      end

    end
  end
end
