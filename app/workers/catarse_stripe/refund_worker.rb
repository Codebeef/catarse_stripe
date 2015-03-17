module CatarseStripe
  class RefundWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(contribution_id)
      contribution = contribution.find(contribution_id)
      CatarseStripe::Service::Contribution::Refund.perform(contribution)
    end
  end
end
