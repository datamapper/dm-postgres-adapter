require 'do_postgres'

module DataMapper
  class Query
    module Conditions
      class ILikeComparison < AbstractComparison
        slug :ilike

        private

        # Overloads the +expected+ method in AbstractComparison
        #
        # Return a regular expression suitable for matching against the
        # records value.
        #
        # @return [Regexp]
        #
        # @see AbtractComparison#expected
        #
        # @api semipublic
        def expected
          Regexp.new('\A' << super.gsub('%', '.*').tr('_', '.') << '\z', 'i')
        end

        # @return [String]
        #
        # @see AbstractComparison#to_s
        #
        # @api private
        def comparator_string
          'ILIKE'
        end
      end # class ILikeComparison
    end
  end
end
