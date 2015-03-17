module CatarseStripe
  module Service
    module Contributor

      class Base < CatarseStripe::Service::Base
        attr_reader :project

        def self.perform(*opts)
          new(*opts).perform
        end

        def initialize(project)
          @project = project
        end

        def contributors
          @project.contributors.where(state: 'confirmed')
        end

        def each_contributor(&block)
          contributors.find_in_batches do |batch|
            batch.each do |contributor|
              yield contributor
            end
          end
        end
      end

    end
  end
end
