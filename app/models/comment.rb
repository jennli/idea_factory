class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :body, presence:true, uniqueness: true
end
