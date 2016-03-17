class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :token, index: true
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
