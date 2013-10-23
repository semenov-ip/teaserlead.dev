class CreateTeaserBlocks < ActiveRecord::Migration
  def change
    create_table :teaser_blocks do |t|
      t.string :topic
      t.string :text_color
      t.string :text_encoding
      t.string :text_position
      t.string :font
      t.integer :block_size
      t.string :block_bg_color
      t.string :block_border_color
      t.integer :block_margin
      t.string :block_position
      t.integer :teaser_count
      t.references :site

      t.timestamps
    end
  end
end
