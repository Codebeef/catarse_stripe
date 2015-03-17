module CatarseStripe
  module Service
    module Contribution

      class Base < CatarseStripe::Service::Base
        attr_reader :project

        def self.perform(*opts)
          new(*opts).perform
        end

        def initialize(project)
          @project = project
        end

        def contributions
          @project.contributions.where(state: 'confirmed')
        end

        def each_contribution(&block)
          contributions.find_in_batches do |batch|
            batch.each do |contribution|
              yield contribution
            end
          end
        end
      end

    end
  end
end
