module CatarseStripe
  module Service
    module Contributor

      class Refund
        attr_reader :contributor

        def initialize(contributor)
          @contributor = contributor
        end

        def refund_transaction
          CatarseStripe::Request::Refund.new({
            id: contributor.id
          })
        end

        def perform
          refund_transaction.result
        end
      end

    end
  end
end
