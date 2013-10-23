class Teaser < ActiveRecord::Base
  mount_uploader :image, TeaserImageUploader
  belongs_to :user
  belongs_to :advertisement_campaign

  # validates :text, presence: true
  # FIXME: разобраться, кто делает client_side_validation, так, что я не могу сделать update
  validates :text, :image, :advertisement_campaign_id, presence: true
  validates :text, length: { maximum: configus.teaser.max_text_length }
end
