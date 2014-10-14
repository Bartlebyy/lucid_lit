require 'rails_helper'

RSpec.describe BooksController, :type => :controller do
  render_views

  let!(:book1) { FactoryGirl.create(:book) }
  let!(:book2) { FactoryGirl.create(:book) }
  let!(:chapter1) { FactoryGirl.create(:chapter) }
  before(:each) do
    book1.chapters << chapter1
  end

  describe "GET 'index'" do
    it "works" do
      get :index
      expect(response).to be_success
    end

    it "shows the books" do
      get :index
      expect(response.body).to include(book1.title)
      expect(response.body).to include(book2.title)
    end
  end

  describe "GET 'show'" do
    it "works" do
      get :show, id: book1.id
      expect(response).to be_success
    end
  end

end
