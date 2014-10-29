module CatarseStripe
  module Request

    class Base
      SCOPE = 'projects.backers.checkout'

      attr_reader :options

      def initialize(options = {})
        @options = options.with_indifferent_access
      end

      def result
        raise 'Needs overriding'
      end

      def success?
        result != false
      end

      def contribution
        @contribution ||= ::PaymentEngines.find_payment(id: options[:id])
      end
    end

  end
end
