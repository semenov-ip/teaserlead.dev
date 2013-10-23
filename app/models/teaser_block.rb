class TeaserBlock < ActiveRecord::Base
  belongs_to :site

  validates :site_id, presence:true
end
