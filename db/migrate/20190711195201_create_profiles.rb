
class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.string :location
      t.date :birthday
      t.string :gender
      t.text :bio
      t.string :avatar
      t.datetime :avatar_updated_at
      t.string :cover
      t.integer :cover_file_size
      t.datetime :cover_updated_at
      t.timestamps
    end
  end
end
