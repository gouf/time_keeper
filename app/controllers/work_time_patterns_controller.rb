class WorkTimePatternsController < ApplicationController
  before_action :set_work_time_pattern, only: [:show, :edit, :update, :destroy]

  # GET /work_time_patterns
  # GET /work_time_patterns.json
  def index
    @work_time_patterns = WorkTimePattern.all
  end

  # GET /work_time_patterns/1
  # GET /work_time_patterns/1.json
  def show
  end

  # GET /work_time_patterns/new
  def new
    @work_time_pattern = WorkTimePattern.new
  end

  # GET /work_time_patterns/1/edit
  def edit
  end

  # POST /work_time_patterns
  # POST /work_time_patterns.json
  def create
    @work_time_pattern = WorkTimePattern.new(work_time_pattern_params)

    respond_to do |format|
      if @work_time_pattern.save
        format.html { redirect_to @work_time_pattern, notice: 'Work pattern was successfully created.' }
        format.json { render :show, status: :created, location: @work_time_pattern }
      else
        format.html { render :new }
        format.json { render json: @work_time_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_time_patterns/1
  # PATCH/PUT /work_time_patterns/1.json
  def update
    respond_to do |format|
      if @work_time_pattern.update(work_time_pattern_params)
        format.html { redirect_to @work_time_pattern, notice: 'Work pattern was successfully updated.' }
        format.json { render :show, status: :ok, location: @work_time_pattern }
      else
        format.html { render :edit }
        format.json { render json: @work_time_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_time_patterns/1
  # DELETE /work_time_patterns/1.json
  def destroy
    @work_time_pattern.destroy
    respond_to do |format|
      format.html { redirect_to work_time_patterns_url, notice: 'Work pattern was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_time_pattern
      @work_time_pattern = WorkTimePattern.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_time_pattern_params
      params.require(:work_time_pattern).permit(:name, :work_started_at, :work_ended_at)
    end
end
