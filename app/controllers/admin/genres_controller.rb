class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end


  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_item_path(@item)
    else
      flash[:notice] = "入力にエラーがありました。"
      redirect_to new_admin_item_path
    end
  end


  def edit
    @genre = Genre.find(params[:id])
  end


  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "情報を更新しました。"
      redirect_to admin_genres_path(@genre)
    else
      render :edit
    end
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
