class Taxonomy < ActiveRecord::Base
  has_ancestry
  validates :title, :position, presence: true
end
