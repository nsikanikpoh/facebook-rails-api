class FinderService
  def self.find_resource(model_object, target_object)
    return model_object.find(target_object) rescue nil
  end
end
