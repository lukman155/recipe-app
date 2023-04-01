class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[show edit update destroy]

  # GET /recipe_foods or /recipe_foods.json
  def index
    @recipe_foods = RecipeFood.all
  end

  # GET /recipe_foods/1 or /recipe_foods/1.json
  def show; end

  # GET /recipe_foods/new
  def new
    @recipe_food = RecipeFood.new
    @recipes = Recipe.all
    @foods = Food.all
    @recipe_food.recipe_id = params[:recipe_id]
  end

  # GET /recipe_foods/1/edit
  def edit; end

  def general_shopping_lists
    @recipe_foods = RecipeFood.includes(:food)
    @food_count = RecipeFood.select(:food_id).distinct.count
  end

  # POST /recipe_foods or /recipe_foods.json
  def create
    @recipe_food = RecipeFood.new(recipe_food_params.merge(user_id: current_user.id))

    # Check for duplicates
    existing_record = RecipeFood.find_by(recipe_id: @recipe_food.recipe_id, food_id: @recipe_food.food_id)
    if existing_record.present?
      respond_to do |format|
        format.html { redirect_to existing_record, notice: 'Recipe food already exists.' }
        format.json { render json: { error: 'Recipe food already exists.' }, status: :unprocessable_entity }
      end
      return
    end

    # Create new record if no duplicates found
    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to @recipe_food, notice: 'Recipe food was successfully created.' }
        format.json { render :show, status: :created, location: @recipe_food }
      else
        format.html { render :new }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipe_foods/1 or /recipe_foods/1.json
  def update
    respond_to do |format|
      if @recipe_food.update(recipe_food_params.merge(user_id: current_user.id, recipe_id: params[:recipe_id]))
        format.html { redirect_to recipe_food_url(@recipe_food), notice: 'Recipe food was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_foods/1 or /recipe_foods/1.json
  def destroy
    @recipe_food.destroy

    respond_to do |format|
      format.html { redirect_to recipe_foods_url, notice: 'Recipe food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id, :user_id)
  end
end
