class ColorsController < ApplicationController
  before_action :get_bookmark

  def index
  end

  def create
    @color = Color.new(color_params)
    @color.bookmark = @bookmark
    @color.save
    render partial: "color", locals: {color: @color}, formats: ["html"]
  end

  def destroy
    @color = Color.find(params[:id])
    @color.destroy
    render nothing: true
  end

  private

  def get_bookmark
    @bookmark = Bookmark.find(params[:bookmark_id])
  end

  def color_params
    params.require(:color).permit(:alpha, :blue, :bookmark_id, :green, :red, :x, :y)
  end
end
