class Idea < ActiveRecord::Base
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :like_user, through: :likes, source: :user

  has_many :members, dependent: :destroy
  has_many :user_members, through: :members, source: :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: {scope: :body}
  validates :body, presence:true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


  def is_liked_by (user)
    likes.find_by_user_id user
  end

  def has_member (user)
    members.find_by_user_id user
  end

end
