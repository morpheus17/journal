class CategoriesController < ApplicationController
  # before_action :set_category, only: %i[ show edit update destroy ]
  before_action :logged_in_user, :set_category


  # GET /categories/new
  def new
    # @category = Category.new
    @category = current_user.categories.new
  end

  # GET /categories or /categories.json
  def index
    @user = User.find_by_id(session[:user_id])
    @categories = @user.categories
    @categories = Array.wrap(@categories)
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, success: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /categories/1/edit
  def edit
    @category = current_user.categories.find(params[:id])
  end
  
  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      @category = current_user.categories.find(params[:id])
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    # @category.destroy
    # respond_to do |format|
    #   format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
    #   format.json { head :no_content }
    # end

    @category = current_user.categories.find(params[:id])
      if @category 
        @category.destroy
        flash[:success] = "Item has been deleted"
      else
        flash[:alert] = "Error"
      end
      redirect_to root_path
  end

  # GET /categories/1 or /categories/1.json
  def show
    @category = Category.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category 
      @categories = Category.find_by_id(session[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description, :color, :user_id)
    end
end
