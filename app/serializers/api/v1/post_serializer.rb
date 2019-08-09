class Api::V1::PostSerializer < Api::V1::ApplicationSerializer
  attributes :content, :image, :user_id

  def comments
    ActiveModel::SerializableResource.new(object.comments,  each_serializer: Api::V1::CommentSerializer)
  end
end
