class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, limit: 140

      t.timestamps null: false

      t.index [:email], unique: true
    end
  end
end
