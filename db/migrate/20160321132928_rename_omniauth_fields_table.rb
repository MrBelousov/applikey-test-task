class RenameOmniauthFieldsTable < ActiveRecord::Migration
  def change
    rename_table :omniauth_fields, :providers
  end
end
