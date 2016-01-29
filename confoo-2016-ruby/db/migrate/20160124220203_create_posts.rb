class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.string :slug, null: false
      t.string :title, null: false
      t.text :body, limit: 16.megabytes, null: false

      t.timestamps null: false
    end
  end
end
