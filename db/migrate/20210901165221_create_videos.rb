class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :small_cover_url
      t.string :large_cover_url
      t.string :cover_image_url
      t.text :description
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
