class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.integer :user_id
      t.integer :chapter_id
      t.integer :offset
      t.integer :length
      t.string :original_word
      t.string :note, limit: 200

      t.timestamps
    end
  end
end
