class CreateShirts < ActiveRecord::Migration
  def self.up
    create_table :shirts do |t|
      t.string :name, :product_url
      t.text :description
      t.decimal :min_price, :max_price, :precision => 6, :scale => 2

      t.string :type

      t.timestamps
    end

    add_index :shirts, :product_url
  end

  def self.down
    drop_table :shirts
  end
end
