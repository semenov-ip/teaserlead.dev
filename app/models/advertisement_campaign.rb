class AdvertisementCampaign < ActiveRecord::Base
  belongs_to  :category
  has_many    :teasers
  accepts_nested_attributes_for :teasers, :reject_if => :all_blank, :allow_destroy => true
end
