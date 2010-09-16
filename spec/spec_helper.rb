require 'dm-core/spec/lib/adapter_helpers'
require 'dm-core/spec/lib/pending_helpers'

Spec::Runner.configure do |config|
  config.extend( DataMapper::Spec::Adapters::Helpers)
  config.include(DataMapper::Spec::PendingHelpers)
end
