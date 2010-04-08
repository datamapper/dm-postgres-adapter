require 'spec_helper'

require 'dm-migrations/adapters/dm-postgres-adapter'
require 'dm-postgres-adapter'

require 'dm-core/spec/adapter_shared_spec'
require 'dm-do-adapter/spec/shared_spec'

describe DataMapper::Adapters::PostgresAdapter do

  before :all do
    @adapter    = DataMapper.setup(:default, 'postgres://localhost/dm_core_test')
    @repository = DataMapper.repository(@adapter.name)
  end
  
  it_should_behave_like "An Adapter"
  it_should_behave_like "A DataObjects Adapter"

end
