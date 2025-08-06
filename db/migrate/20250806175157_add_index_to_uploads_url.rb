class AddIndexToUploadsUrl < ActiveRecord::Migration[7.1]
  def change
    add_index :uploads, :url, unique: true
  end
end
