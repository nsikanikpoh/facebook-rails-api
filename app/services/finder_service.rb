class FinderService
  def self.find_resource(model_object, target_object)
    model_object.find(target_object)
  end
end
