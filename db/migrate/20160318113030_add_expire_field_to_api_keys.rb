class AddExpireFieldToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :expiration, :date
  end
end
