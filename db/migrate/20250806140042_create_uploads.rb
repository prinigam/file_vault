class CreateUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :uploads do |t|
      t.string :title
      t.text :description
      t.string :file_type
      t.integer :file_size
      t.string :url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
