require 'do_postgres'
require 'dm-do-adapter'

module DataMapper
  module Adapters

    class PostgresAdapter < DataObjectsAdapter

      module SQL #:nodoc:
        IDENTIFIER_MAX_LENGTH = 63

        private

        # @api private
        def supports_returning?
          true
        end
      end

      include SQL

    end

    const_added(:PostgresAdapter)

  end
end
