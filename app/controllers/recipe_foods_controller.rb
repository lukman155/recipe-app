class RecipeFoodsController < ApplicationController
  before_action :set_recipe, only: [:new, :create]

  # GET /recipe_foods or /recipe_foods.json
  def index
    @recipe_foods = RecipeFood.all
  end

  # GET /recipe_foods/1 or /recipe_foods/1.json
  def show
    @recipe_food = RecipeFood.find(params[:id])
  end

  # GET /recipe_foods/new
  def new
    @foods = Food.all
    @recipe_food = RecipeFood.new(recipe_id: @recipe.id)
  end

  # GET /recipe_foods/1/edit
  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  # POST /recipe_foods or /recipe_foods.json
  def create
    @recipe_food = RecipeFood.new(recipe_food_params.merge(user_id: current_user.id))
    if @recipe_food.save
      flash[:success] = 'Food added to recipe successfully'
      redirect_to @recipe
    else
      flash[:error] = 'Failed to add food to recipe'
      render :new
    end
  end

  # PATCH/PUT /recipe_foods/1 or /recipe_foods/1.json
  def update
    @recipe_food = RecipeFood.find(params[:id])

    respond_to do |format|
      if @recipe_food.update(recipe_food_params)
        format.html { redirect_to @recipe_food, notice: 'Recipe food was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_foods/1 or /recipe_foods/1.json
  def destroy
    @target_recipe_food = RecipeFood.find(params[:id])

    return unless @target_recipe_food.destroy

    flash[:success] = 'The food has been deleted successfully'
    redirect_to recipe_path(@target_recipe_food.recipe_id)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :name, :value, :recipe_id)
  end
end