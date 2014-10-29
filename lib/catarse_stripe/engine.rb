module CatarseStripe
  class Engine < ::Rails::Engine
    isolate_namespace CatarseStripe

    config.before_initialize do
      puts 'Adding Stripe observers'
      config.active_record.observers << 'CatarseStripe::ProjectObserver'
      config.active_record.observers << 'CatarseStripe::BackerObserver'
    end
  end
end
