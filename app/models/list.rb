class List < ActiveRecord::Base
  belongs_to :user

  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_initialize :init

  # For pagination, only 5 lists are listed per page
  self.per_page = 5

  def init
    # Sets the likes and comments count to 0 automatically unless something is already there
    self.likes_count ||= 0
    self.comments_count ||= 0 
  end
end
