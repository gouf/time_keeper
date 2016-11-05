class WorkPatternsController < ApplicationController
  before_action :set_work_pattern, only: [:show, :edit, :update, :destroy]

  # GET /work_patterns
  # GET /work_patterns.json
  def index
    @work_patterns = WorkPattern.all
  end

  # GET /work_patterns/1
  # GET /work_patterns/1.json
  def show
  end

  # GET /work_patterns/new
  def new
    @work_pattern = WorkPattern.new
  end

  # GET /work_patterns/1/edit
  def edit
  end

  # POST /work_patterns
  # POST /work_patterns.json
  def create
    @work_pattern = WorkPattern.new(work_pattern_params)

    respond_to do |format|
      if @work_pattern.save
        format.html { redirect_to @work_pattern, notice: 'Work pattern was successfully created.' }
        format.json { render :show, status: :created, location: @work_pattern }
      else
        format.html { render :new }
        format.json { render json: @work_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_patterns/1
  # PATCH/PUT /work_patterns/1.json
  def update
    respond_to do |format|
      if @work_pattern.update(work_pattern_params)
        format.html { redirect_to @work_pattern, notice: 'Work pattern was successfully updated.' }
        format.json { render :show, status: :ok, location: @work_pattern }
      else
        format.html { render :edit }
        format.json { render json: @work_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_patterns/1
  # DELETE /work_patterns/1.json
  def destroy
    @work_pattern.destroy
    respond_to do |format|
      format.html { redirect_to work_patterns_url, notice: 'Work pattern was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_pattern
      @work_pattern = WorkPattern.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_pattern_params
      params.require(:work_pattern).permit(:name, :work_started_at, :work_ended_at)
    end
end
