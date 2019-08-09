
class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :requester_id, index: true
      t.string :requestee_id, index: true
      t.integer :accepted

      t.timestamps
    end
  end
end
