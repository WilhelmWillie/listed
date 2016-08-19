class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.belongs_to :user, index: true

      t.string :title
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
  end
end