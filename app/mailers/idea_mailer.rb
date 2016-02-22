class IdeaMailer < ApplicationMailer
  def notify_idea_owner(like)
    @liker = like.user
    @idea = like.idea
    @owner = @idea.user
    mail(to: @owner.email, subject: "You got a like!")
  end
end
