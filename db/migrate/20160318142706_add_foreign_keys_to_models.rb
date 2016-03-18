class AddForeignKeysToModels < ActiveRecord::Migration
  def change
    add_foreign_key :omniauth_fields, :users
    add_foreign_key :posts, :users
    add_foreign_key :comments, :users
    add_foreign_key :api_keys, :users
  end
end
