class ChickensController < ApplicationController
  before_action :require_user
  before_action :set_chicken, only: %i[ show edit update destroy ]

  # GET /chickens
  def index
    @chickens = current_user.chickens.order(created_at: :desc)
  end

  # GET /chickens/1
  def show
  end

  # GET /chickens/new
  def new
    @chicken = current_user.chickens.build
  end

  # GET /chickens/1/edit
  def edit
  end

  # POST /chickens
  def create
    @chicken = current_user.chickens.build(chicken_params)

    if @chicken.save
      redirect_to chickens_path, notice: "Rooster '#{@chicken.name}' successfully registered to your barn!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chickens/1
  def update
    if @chicken.update(chicken_params)
      redirect_to chickens_path, notice: "Rooster stats updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /chickens/1
  def destroy
    @chicken.destroy
    redirect_to chickens_path, status: :see_other, notice: "Rooster removed from your roster."
  end

  private

  def set_chicken
    # Ensures users can only access their own chickens
    @chicken = current_user.chickens.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to chickens_path, alert: "Chicken not found in your barn."
  end

  def chicken_params
    params.require(:chicken).permit(:name, :weight, :weight_class, :status)
  end
end
