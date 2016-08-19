class RemoveSlugFromLists < ActiveRecord::Migration
  def change
    remove_column :lists, :slug
  end
end
