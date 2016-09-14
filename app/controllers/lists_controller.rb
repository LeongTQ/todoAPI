class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to lists_path
    else
      redirect_to new_list_path
    end
  end

  def edit
    @list = List.find_by(id: params[:id])
  end

  def update
    @list = List.find_by(id: params[:id])

    if @list.update(list_params)
      redirect_to lists_path(@list)
    else
      redirect_to edit_list_path(@list)
    end
  end

  def destroy
    @list = List.find_by(id: params[:id])
    if @list.destroy
      redirect_to lists_path
    else
      redirect_to lists_path(@list)
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end
end
