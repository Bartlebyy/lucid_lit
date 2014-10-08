class Book < ActiveRecord::Base
  has_many :chapters
  has many :annotations, through: :chapters
  validates_presence_of :title, :author
end
