class Api::V1::ApplicationSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at
  attributes :errors

  def cache_key(_options = {})
    object.cache_key
  end

  def errors
    object.errors
  end

  def error_messages
    object.errors.full_messages
  end
end
