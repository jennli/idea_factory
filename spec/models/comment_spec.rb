require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    it "doesn't allow creating a comment with no body" do
      c = Comment.new
      comment_valid = c.valid?
      expect(comment_valid).to eq(false)
    end
  end
end
