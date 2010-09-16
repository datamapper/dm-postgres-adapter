class Symbol
  def ilike
    DataMapper::Query::Operator.new(self, :ilike)
  end
end # class Symbol
