class CuisinesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :verify_admin, only: %i[new create edit update]

  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = @cuisine.recipes
    flash.now[:failure] = 'Não há receitas dessa cozinha.'
  end
  
  def new
    @cuisine = Cuisine.new
  end
  
  def create
    @cuisine = Cuisine.create(params.require(:cuisine).permit(:name))
    if @cuisine.save
      redirect_to @cuisine
    else
      flash[:alert] = 'Você deve informar um nome único'
      render :new
    end
  end

  private

  def verify_admin
    redirect_to root_path unless current_user.admin?
  end
end