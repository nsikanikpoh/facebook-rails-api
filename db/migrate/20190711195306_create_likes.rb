
class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :post, type: :uuid, foreign_key: true
      t.timestamps

    end
    add_index :likes, [:user_id, :post_id], unique: true
  end
end
