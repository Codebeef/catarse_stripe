# -*- encoding: utf-8 -*-
# stub: catarse_stripe 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "catarse_stripe"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Matt Hall", "Ant\u{f4}nio Roberto Silva", "Diogo Biazus", "Josemar Davi Luedke"]
  s.date = "2015-03-16"
  s.description = "Stripe integration with Catarse crowdfunding platform"
  s.email = ["matt@codebeef.com", "forevertonny@gmail.com", "diogob@gmail.com", "josemarluedke@gmail.com"]
  s.files = ["MIT-LICENSE", "README.rdoc", "Rakefile", "app/assets", "app/assets/images", "app/assets/images/catarse_stripe", "app/assets/images/catarse_stripe/auth", "app/assets/images/catarse_stripe/auth/stripe-outline.png", "app/assets/images/catarse_stripe/auth/stripe_blue-2x.png", "app/assets/images/catarse_stripe/auth/stripe_blue.png", "app/assets/javascripts", "app/assets/javascripts/catarse_stripe", "app/assets/javascripts/catarse_stripe.js", "app/assets/javascripts/catarse_stripe/stripe_form.js", "app/assets/javascripts/catarse_stripe/user_document.js", "app/controllers", "app/controllers/catarse_stripe", "app/controllers/catarse_stripe/stripe_controller.rb", "app/observers", "app/observers/catarse_stripe", "app/observers/catarse_stripe/contribution_observer.rb", "app/observers/catarse_stripe/project_observer.rb", "app/views", "app/views/catarse_stripe", "app/views/catarse_stripe/stripe", "app/views/catarse_stripe/stripe/auth.html.erb", "app/views/catarse_stripe/stripe/charge.html.erb", "app/views/catarse_stripe/stripe/review.html.slim", "app/workers", "app/workers/catarse_stripe", "app/workers/catarse_stripe/payment_receiver_worker.rb", "app/workers/catarse_stripe/refund_worker.rb", "config/initializers", "config/initializers/register.rb", "config/initializers/stripe.rb", "config/locales", "config/locales/cy.yml", "config/locales/en.yml", "config/routes.rb", "db/migrate", "db/migrate/20140731103558_add_stripe_fields_to_contributors.rb", "lib/catarse_stripe", "lib/catarse_stripe.rb", "lib/catarse_stripe/engine.rb", "lib/catarse_stripe/payment_engine.rb", "lib/catarse_stripe/request", "lib/catarse_stripe/request/base.rb", "lib/catarse_stripe/request/payment.rb", "lib/catarse_stripe/request/refund.rb", "lib/catarse_stripe/request/settle.rb", "lib/catarse_stripe/service", "lib/catarse_stripe/service/contributor", "lib/catarse_stripe/service/contributor/base.rb", "lib/catarse_stripe/service/contributor/pay.rb", "lib/catarse_stripe/service/contributor/refund.rb", "lib/catarse_stripe/service/base.rb", "lib/catarse_stripe/version.rb"]
  s.homepage = "http://github.com/Codebeef/catarse_stripe"
  s.rubygems_version = "2.4.5"
  s.summary = "Stripe integration with Catarse"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 4.0"])
      s.add_runtime_dependency(%q<slim-rails>, [">= 0"])
      s.add_runtime_dependency(%q<stripe>, [">= 0"])
      s.add_development_dependency(%q<pg>, [">= 0"])
      s.add_development_dependency(%q<catarse>, [">= 0"])
      s.add_development_dependency(%q<spree_core>, ["~> 2.3"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.14.0"])
      s.add_development_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 4.0"])
      s.add_dependency(%q<slim-rails>, [">= 0"])
      s.add_dependency(%q<stripe>, [">= 0"])
      s.add_dependency(%q<pg>, [">= 0"])
      s.add_dependency(%q<catarse>, [">= 0"])
      s.add_dependency(%q<spree_core>, ["~> 2.3"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.14.0"])
      s.add_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 4.0"])
    s.add_dependency(%q<slim-rails>, [">= 0"])
    s.add_dependency(%q<stripe>, [">= 0"])
    s.add_dependency(%q<pg>, [">= 0"])
    s.add_dependency(%q<catarse>, [">= 0"])
    s.add_dependency(%q<spree_core>, ["~> 2.3"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.14.0"])
    s.add_dependency(%q<factory_girl_rails>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
  end
end
