module CatarseStripe
  class RefundWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(contributor_id)
      contributor = contributor.find(contributor_id)
      CatarseStripe::Service::Contributor::Refund.perform(contributor)
    end
  end
end
