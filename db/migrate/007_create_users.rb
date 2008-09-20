class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :ip_address
      t.timestamps
    end

    add_index :users, :ip_address, :unique => true
  end

  def self.down
    drop_table :users
  end
end
