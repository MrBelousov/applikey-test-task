class AddTypeColumnToProvidersTable < ActiveRecord::Migration
  def change
    add_column :providers, :type, :integer
  end
end
