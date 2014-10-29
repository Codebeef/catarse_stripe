module CatarseStripe
  module Service
    module Backer

      class Refund
        attr_reader :backer

        def initialize(backer)
          @backer = backer
        end

        def refund_transaction
          CatarseStripe::Request::Refund.new({
            id: backer.id
          })
        end

        def perform
          refund_transaction.result
        end
      end

    end
  end
end
