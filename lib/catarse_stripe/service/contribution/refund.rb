module CatarseStripe
  module Service
    module Contribution

      class Refund
        attr_reader :contribution

        def initialize(contribution)
          @contribution = contribution
        end

        def refund_transaction
          CatarseStripe::Request::Refund.new({
            id: contribution.id
          })
        end

        def perform
          refund_transaction.result
        end
      end

    end
  end
end
