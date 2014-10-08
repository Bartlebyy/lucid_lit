class Annotation < ActiveRecord::Base
  belongs_to :chapter
  has_and_belongs_to_many :users
  validates_presence_of :original_word, :note, :offset, :length
end
