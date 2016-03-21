class ChangeExpirationColumnInApiKeys < ActiveRecord::Migration
  def change
    rename_column :api_keys, :expiration, :expires_at
  end
end
