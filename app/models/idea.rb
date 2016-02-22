class Idea < ActiveRecord::Base
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :like_user, through: :likes, source: :user

  has_many :members, dependent: :destroy
  has_many :user_members, through: :members, source: :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: {scope: :body}
  validates :body, presence:true


  def is_liked_by (user)
    likes.find_by_user_id user
  end

  def has_member (user)
    members.find_by_user_id user
  end

end
