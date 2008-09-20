class CreateLabels < ActiveRecord::Migration
  def self.up
    create_table :labels do |t|
      t.string :name

      t.datetime :created_at
    end

    create_table(:labels_shirts, :id => false) do |t|
      t.integer :label_id, :shirt_id
    end
  end

  def self.down
    drop_table :labels_shirts
    drop_table :labels
  end
end
