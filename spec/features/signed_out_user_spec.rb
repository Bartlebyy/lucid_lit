require 'rails_helper'

feature 'signed out user' do
  let!(:book1) { FactoryGirl.create(:book) }
  let!(:book2) { FactoryGirl.create(:book) }
  let!(:chapter1) { FactoryGirl.create(:chapter) }
  let!(:chapter2) { FactoryGirl.create(:chapter) }
  before(:each) do
    book1.chapters << chapter1
    book1.chapters << chapter2
  end

  scenario "visits book index from home" do
    visit root_path
    click_on "Our Books"
    page.has_content?(book1.title)
    page.has_content?(book2.title)
  end

  scenario "visits book show from book index" do
    visit books_path
    click_on book1.title
    page.has_content?(book1.title)
    page.has_content?(chapter1.name)
    page.has_content?(chapter2.name)
  end

  scenario "visits chapter page from book show" do
    visit book_path(book1.id)
    click_on chapter1.name
    page.has_content?(chapter1.name)
    page.has_content?(chapter1.body)
    page.has_content?("Next Chapter")
  end

  scenario "switches between chapter pages" do
    visit chapter_path(chapter1.id)
    click_on ("Next Chapter")
    page.has_content?(chapter2.name)
    page.has_content?(chapter2.body)
    page.has_content?("Complete!")
  end

  scenario "completes chapter and redirects to book show" do
    visit chapter_path(chapter2.id)
    click_on ("Complete!")
    page.has_content?(book1.title)
    page.has_content?(chapter1.name)
    page.has_content?(chapter2.name)
  end

end
