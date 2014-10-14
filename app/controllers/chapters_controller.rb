class ChaptersController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_filter :set_book_by_chapter, except: [:new]

  def show
    @chapter = Chapter.find(params[:id])
    @next_chapter = Chapter.find_by(chapter_order: @chapter.chapter_order+1)
    @annotations = @chapter.annotations
    respond_to do |format|
      format.html
      format.json { render json: @annotations }
    end
  end

  def new
    set_book_by_param
    @chapter = Chapter.new
    @chapter_order = set_next_chapter_order

  end

  def create
    @chapter = @book.chapters.new(chapter_params)
    if @chapter.save
      redirect_to book_chapter_path(@book, @chapter)
      flash[:success] = "Chapter successfully created!"
    else
      render('new')
      flash[:danger] = "Please fill in all fields."
    end
  end

  def edit
    @chapter = @book.chapters.find(params[:id])
  end

  def update
    @chapter = @book.chapters.find(params[:id])
    if @chapter.update(chapter_params)
      flash[:success] = "Chapter successfully updated!"
    else
      flash[:danger] = "We're sorry, your information could not be updated. Name and description are required fields."
    end
    redirect_to chapter_path(@chapter)
  end

  private
  def chapter_params
    params.require(:chapter).permit(:book_id, :name, :body, :chapter_order)
  end

  def set_book_by_chapter
    @book = Chapter.find(params[:id]).book_id
    # @book = Book.find(params[:book_id])
  end

  def set_book_by_param
    # @book = Chapter.find(params[:id]).book_id
    @book = Book.find(params[:book_id])
  end

  def set_next_chapter_order
    biggest_order = 0
    @book.chapters.each do |chapter|
      if chapter.chapter_order > biggest_order
        biggest_order << chapter.chapter_order
      end
    biggest_order
    end

  end
end
