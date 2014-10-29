module CatarseStripe
  class RefundWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(backer_id)
      backer = Backer.find(backer_id)
      CatarseStripe::Service::Backer::Refund.perform(backer)
    end
  end
end
