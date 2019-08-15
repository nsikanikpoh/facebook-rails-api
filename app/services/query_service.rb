class QueryService
  def self.run_query(model_object, query, target_object)
    model_object.where(query, target_object)
  end
end
