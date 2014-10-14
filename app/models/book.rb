class Book < ActiveRecord::Base
  has_many :chapters
  has_many :annotations, through: :chapters
  validates_presence_of :title, :author
end
