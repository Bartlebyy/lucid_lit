class BooksController < ApplicationController
  def index
    @books = Book.all.order(title: :asc)
  end

  def show
    @book = Book.find(params[:id])
    @chapters = Chapter.where book_id: @book.id
  end
end
