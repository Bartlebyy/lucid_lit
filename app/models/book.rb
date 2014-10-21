class Book < ActiveRecord::Base
  has_many :chapters
  has_many :annotations, through: :chapters
  validates_presence_of :title, :author

  def first_chapter
    chapters.where(chapter_order: 1).first
  end

end
