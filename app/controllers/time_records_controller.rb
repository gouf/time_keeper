class TimeRecordsController < ApplicationController
  before_action :set_time_record, only: [:show, :edit, :update, :destroy]

  # GET /time_records
  # GET /time_records.json
  def index
    @time_record = TimeRecord.new
    # 当月の日付分、TimeRecord オブジェクトを用意する
    # * 当月の日が何日あるかを調べる
    # * 全レコードから当該日付にマッピングする
    # @time_records に代入する
    map_time_records_to_calender =
      proc do
        # 当月の日付分、TimeRecord オブジェクトを用意する
        # * 当月の日が何日あるかを調べる
        today = Date.today
        month = today.month
        year = today.year
        days_in_month = Time.days_in_month(month, year)

        # カレンダーの日付にマッピングしていく
        1.step(days_in_month).map do |day|
          date = Date.new(year, month, day)
          TimeRecord.find_or_create_by(work_date: date)
        end
      end

    @time_records = map_time_records_to_calender.call
  end

  # GET /time_records/1
  # GET /time_records/1.json
  def show
  end

  # GET /time_records/new
  def new
    @time_record = TimeRecord.new
  end

  # GET /time_records/1/edit
  def edit
  end

  # POST /time_records
  # POST /time_records.json
  def create
    @time_record = TimeRecord.new(time_record_params)

    respond_to do |format|
      if @time_record.save
        format.html { redirect_to @time_record, notice: 'Time record was successfully created.' }
        format.json { render :show, status: :created, location: @time_record }
      else
        format.html { render :new }
        format.json { render json: @time_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_records/1
  # PATCH/PUT /time_records/1.json
  def update
    respond_to do |format|
      if @time_record.update(time_record_params)
        format.html { redirect_to @time_record, notice: 'Time record was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_record }
      else
        format.html { render :edit }
        format.json { render json: @time_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_records/1
  # DELETE /time_records/1.json
  def destroy
    @time_record.destroy
    respond_to do |format|
      format.html { redirect_to time_records_url, notice: 'Time record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_record
      @time_record = TimeRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_record_params
      params.require(:time_record).permit(
        :work_date,
        :worktime_pattern_id,
        :rest_time,
        :work_start_at,
        :work_end_at,
        :description
      )
    end
end
