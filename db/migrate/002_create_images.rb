class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.column :original_url, :string

      t.column :size,         :integer  # file size in bytes
      t.column :content_type, :string   # mime type, ex: application/mp3
      t.column :filename,     :string   # sanitized filename
      t.column :height,       :integer  # in pixels
      t.column :width,        :integer  # in pixels
      t.column :parent_id,    :integer  # id of parent image (on the same table, a self-referencing foreign-key).
                                        # Only populated if the current object is a thumbnail.
      t.column :thumbnail,    :string   # the 'type' of thumbnail this attachment record describes.

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
