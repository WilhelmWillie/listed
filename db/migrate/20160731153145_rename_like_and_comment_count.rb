class RenameLikeAndCommentCount < ActiveRecord::Migration
  def change
    rename_column :lists, :like_count, :likes_count
    rename_column :lists, :comment_count, :comments_count
  end
end
