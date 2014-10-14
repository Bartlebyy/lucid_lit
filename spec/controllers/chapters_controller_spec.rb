require 'rails_helper'

RSpec.describe ChaptersController, :type => :controller do
  render_views
  let!(:user) { FactoryGirl.create(:user) }
  let!(:book1) { FactoryGirl.create(:book) }
  let!(:book2) { FactoryGirl.create(:book) }
  let!(:chapter1) { FactoryGirl.create(:chapter) }
  before(:each) do
    book1.chapters << chapter1
  end

  describe "GET 'show'" do
    before(:each) do
      book1.chapters << chapter1
    end
    it "works" do
      get :show, id: chapter1.id, book_id: book1.id
      expect(response).to be_success
    end
  end

  describe "GET 'New'" do
    context "when the user is not logged in" do
      it "redirects" do
        get :new, book_id: book1.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when the user is logged in" do
      it "works" do
        sign_in user
        get :new, book_id: book1.id
        expect(response).to be_success
      end
    end
  end

  # describe "POST 'Create'" do
  #   context "when the user is not logged in" do
  #     it "redirects" do
  #       expect {
  #         post :create, chapter: {name: "Test", description: "Testing description."}
  #       }.to_not change{ Chapter.count }
  #       expect(response).to redirect_to root_path
  #     end
  #   end
  #
  #   context "when the user is logged in" do
  #     it "works" do
  #       sign_in user
  #       expect {
  #         post :create, chapter: {name: "Test", body: "Testing description."}
  #       }.to change{ Chapter.count }.by(1)
  #       expect(Chapter.last.people.first).to eq(user.person)
  #       expect(response).to redirect_to Chapter.last
  #     end
  #   end
  # end
end
