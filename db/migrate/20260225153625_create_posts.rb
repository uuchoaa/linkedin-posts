class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.integer :external_id
      t.integer :category
      t.string :title
      t.string :skill_level
      t.text :hook
      t.text :content_summary
      t.text :senior_insight
      t.text :cta
      t.string :hashtags, array: true, default: []
      t.text :body
      t.integer :status

      t.timestamps
    end
    add_index :posts, :external_id, unique: true
  end
end
