
class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.uuid :requester_id
      t.uuid :requestee_id
      t.boolean :accepted, default: false
      t.timestamps
    end
    add_index :requests, :requester_id
    add_index :requests, :requestee_id 
    add_foreign_key :requests, :users, column: :requestee_id
    add_foreign_key :requests, :users, column: :requester_id
  end
end
