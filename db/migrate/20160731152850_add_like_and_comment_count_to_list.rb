class AddLikeAndCommentCountToList < ActiveRecord::Migration
  def change
    add_column :lists, :like_count, :integer
    add_column :lists, :comment_count, :integer
  end
end
