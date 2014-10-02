class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.text :body
      t.integer :order

      t.timestamps
    end
  end
end
