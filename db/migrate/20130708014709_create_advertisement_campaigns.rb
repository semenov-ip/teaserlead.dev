class CreateAdvertisementCampaigns < ActiveRecord::Migration
  def change
    create_table :advertisement_campaigns do |t|
      t.string :name
      t.string :url
      t.references :category, index: true

      t.timestamps
    end
  end
end
