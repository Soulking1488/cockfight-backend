class MatchResultsController < ApplicationController
  before_action :set_match_result, only: %i[ show edit update destroy ]

  # GET /match_results or /match_results.json
  def index
    @match_results = MatchResult.all
  end

  # GET /match_results/1 or /match_results/1.json
  def show
  end

  # GET /match_results/new
  def new
    @match_result = MatchResult.new
  end

  # GET /match_results/1/edit
  def edit
  end

  # POST /match_results or /match_results.json
  def create
    @match_result = MatchResult.new(match_result_params)

    respond_to do |format|
      if @match_result.save
        format.html { redirect_to @match_result, notice: "Match result was successfully created." }
        format.json { render :show, status: :created, location: @match_result }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @match_result.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /match_results/1 or /match_results/1.json
  def update
    respond_to do |format|
      if @match_result.update(match_result_params)
        format.html { redirect_to @match_result, notice: "Match result was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @match_result }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @match_result.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /match_results/1 or /match_results/1.json
  def destroy
    @match_result.destroy!

    respond_to do |format|
      format.html { redirect_to match_results_path, notice: "Match result was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match_result
      @match_result = MatchResult.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def match_result_params
      params.expect(match_result: [ :match_card_id, :winning_chicken_id, :win_method, :duration_seconds, :admin_notes ])
    end
end
