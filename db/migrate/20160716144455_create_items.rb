class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :list, index: true

      t.string :name
      t.text :description
      t.integer :order

      t.timestamps null: false
    end
  end
end
