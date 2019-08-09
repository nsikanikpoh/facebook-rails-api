
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.text :content
      t.references :user, type: :uuid, foreign_key: true
      t.string :image
      t.datetime :image_updated_at
      t.timestamps
    end
  end
end
