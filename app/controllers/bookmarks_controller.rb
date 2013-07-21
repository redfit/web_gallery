class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy, :send_mail]

  def index
    if params[:tag]
      @bookmarks = Bookmark.tagged_with(params[:tag]).order('updated_at desc')
    else
      @bookmarks = Bookmark.order('updated_at desc')
    end
    @bookmarks = @bookmarks.page(params[:page]).per(6)
  end

  def show
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.save

    respond_to do |format|

      format.html { redirect_to bookmarks_path }
      format.json { render nothing: true }
    end
  end

  def update
    @bookmark.update(bookmark_params)
    render nothing: true
  end

  def destroy
    @bookmark.destroy
    render nothing: true
  end

  def send_mail
    @mail = Notifier.send_mail(@bookmark, params[:email]).deliver
    render nothing: true
  end


  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :title, :screenshot, :tag_list)
  end
end
