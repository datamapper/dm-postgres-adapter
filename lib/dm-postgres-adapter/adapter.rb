require 'do_postgres'
require 'dm-do-adapter'

module DataMapper
  module Adapters

    class PostgresAdapter < DataObjectsAdapter

      module SQL #:nodoc:
        private

        # @api private
        def supports_returning?
          true
        end
        
        def comparison_operator(comparison)
          subject = comparison.subject
          value   = comparison.value

          case comparison.slug
            when :ilike   then ilike_operator(value)
            else super
          end
        end
        
        # @api private
        def ilike_operator(operand)
          'ILIKE'
        end
      end

      include SQL

    end

    const_added(:PostgresAdapter)

  end
end
