
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.text :content
      t.references :user, type: :uuid, foreign_key: true
      t.references :post, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
