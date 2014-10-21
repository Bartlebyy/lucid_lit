class AnnotationsController < ApplicationController
  before_filter :set_chapter
  def create
    @annotation = @chapter.annotations.new(annotation_params)
    if @annotation.save
      flash[:success] = "Annotation successfully created!"
      # render :js => 'window.location.reload()'
    else
      render('new')
      flash[:danger] = "Please fill in all fields."
    end
  end

  private
  def annotation_params
    params.require(:annotation).permit(:chapter_id, :user_id, :note, :original_word, :offset, :length)
  end

  def set_chapter
    @chapter = Chapter.find(params[:chapter_id])
  end
end
