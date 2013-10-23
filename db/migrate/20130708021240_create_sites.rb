class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.references :category, index: true
      t.string :title, null: false
      t.string :url, null:false
      t.text :description

      t.timestamps
    end
  end
end
