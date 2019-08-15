
class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.uuid :requester_id, index: true, foreign_key: true
      t.uuid :requestee_id, index: true, foreign_key: true
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
