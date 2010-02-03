require 'do_postgres'
require 'data_objects_adapter'

dir = Pathname(__FILE__).dirname.expand_path / 'postgres_adapter'

require dir / 'adapter'
