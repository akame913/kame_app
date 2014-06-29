class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.text :comment
      t.string :name
      t.string :content_type
      t.binary :data

      t.timestamps
    end
  end
end
