class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, index: true, unique: true
      t.string :display_name
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
