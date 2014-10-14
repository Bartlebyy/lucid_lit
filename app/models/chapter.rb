class Chapter < ActiveRecord::Base
  belongs_to :book
  has_many :annotations
  validates_presence_of :name, :body, :chapter_order
end
