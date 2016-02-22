require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:idea) {FactoryGirl.create(:idea)}
  let(:comment){FactoryGirl.create(:comment, {user: user, idea: idea})}
  let(:comment_1){FactoryGirl.create(:comment)}

  describe "#create" do
    context "with no signed in user" do

      it "redirects to the sign in page" do
        post :create, idea_id: idea.id,
        comment: FactoryGirl.attributes_for(:comment)
        expect(response).to redirect_to new_session_path
      end
    end

    context "with signed in user" do
      before { request.session[:user_id] = user.id }

      context "with valid params" do
        def send_valid_request
          post :create, idea_id: idea.id,
          comment: FactoryGirl.attributes_for(:comment)
        end

        it "creates a comment in the database associated with the idea" do
          count_before = idea.comments.count
          send_valid_request
          count_after = idea.comments.count
          expect(count_after - count_before).to eq(1)
        end

        it "associates the comment with the logged in user" do
          send_valid_request
          expect(Comment.last.user).to eq(user)
        end

        it "redirects to the idea show page" do
          send_valid_request
          expect(response).to redirect_to(idea)
        end

        it "sets a flash notice messages" do
          send_valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with invalid params" do
        def send_invalid_request
          post :create, idea_id: idea.id,
          comment: {body:{}}
        end

        it "does not create a comment in the database associated with the idea" do
          count_before = idea.comments.count
          send_invalid_request
          count_after = idea.comments.count
          expect(count_after - count_before).to eq(0)
        end

        it "redirects to the idea show page" do
          send_invalid_request
          expect(response).to redirect_to(idea)
        end

        it "sets a flash alert messages" do
          send_invalid_request
          expect(flash[:alert]).to be
        end
      end

    end
  end

  describe "#destroy" do
    context "with no signed in user" do
      it "redirects to the sign in page" do
        delete :destroy, id:comment.id, idea_id: idea.id
        expect(response).to redirect_to new_session_path
      end
    end

    context "with signed in user" do
      before { request.session[:user_id] = user.id  }

      context "with signed in user as the owner of the comment" do
        it "removes the comment from the database" do
          comment
          count_before = Comment.count
          delete :destroy, idea_id: idea.id, id: comment.id
          count_after = Comment.count
          expect(count_before - count_after).to eq(1)
        end

        it "redirects to idea show page" do
          delete :destroy, idea_id: idea.id, id: comment.id
          expect(response).to redirect_to(idea_path(idea))
        end

      end
      context "with signed in user as not the owner of the comment" do
        it "raises an error" do
          expect do
            delete :destroy, idea_id: comment_1.idea_id, id: comment_1.id
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
