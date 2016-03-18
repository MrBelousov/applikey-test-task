class CreateOmniauthFields < ActiveRecord::Migration
  def change
    create_table :omniauth_fields do |t|
      t.string   :provider
      t.integer  :user_id, index: true
      t.string   :uid
      t.string   :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps null: false
    end
  end
end
