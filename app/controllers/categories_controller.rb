class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to action: :show, id: @category.id
    else
      redirect_to action: :edit
    end
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to action: :show, id: @category.id
    else
      redirect_to action: :new
    end
  end

  def destroy
    @category = Category.find(params[:id])

    if @category.destroy
      redirect_to action: :index
    else
      redirect_to action: :show, id: @category.id
    end
  end

  def category_params
    params.require(:category).permit(:name, :status)
  end
end
