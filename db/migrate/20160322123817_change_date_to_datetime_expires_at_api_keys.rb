class ChangeDateToDatetimeExpiresAtApiKeys < ActiveRecord::Migration
  def self.up
    change_table :api_keys do |t|
      t.change :expires_at, :datetime
    end
  end
  def self.down
    change_table :api_keys do |t|
      t.change :expires_at, :date
    end
  end
end
