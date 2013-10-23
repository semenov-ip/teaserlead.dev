class CreateTeasers < ActiveRecord::Migration
  def change
    create_table :teasers do |t|
      t.string :text, null: false
      t.string :image, null: false
      t.string :url, null: false, default: ""
      t.references :advertisement_campaign, null: false
      t.references :user
      t.timestamps
    end
  end
end
