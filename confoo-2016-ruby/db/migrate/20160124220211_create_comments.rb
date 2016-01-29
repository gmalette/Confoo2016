class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, null: false
      t.references :user, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
