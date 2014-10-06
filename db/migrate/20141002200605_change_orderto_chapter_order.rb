class ChangeOrdertoChapterOrder < ActiveRecord::Migration
  def change
    rename_column :chapters, :order, :chapter_order
  end
end
