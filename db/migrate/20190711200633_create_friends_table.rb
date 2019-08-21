
class CreateFriendsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :friends, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.uuid :otheruser_id
      t.timestamps
    end
  end
end
