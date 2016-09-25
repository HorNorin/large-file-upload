class CreateUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :uploads do |t|
      t.string :filename
      t.string :path
      t.integer :uploaded_size, default: 0

      t.timestamps
    end
  end
end
