class Site < ActiveRecord::Base
  belongs_to :category
  has_many :teaser_blocks
end
