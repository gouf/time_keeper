class WorkTimeRecordsController < ApplicationController
  before_action :set_time_record, only: [:show, :edit, :update, :destroy]

  # GET /time_records
  # GET /time_records.json
  def index
    @time_records = map_time_records_to_calender(month: @month, year: @year)
    @time_record = WorkTimeRecord.find_by_work_date(params[:work_date] || Date.today)

    @work_time = calculate_work_time(@time_records)
    @workdays_of_month = WorkTimeRecord.workdays_of_month(month: @month, year: @year)
  end

  # GET /time_records/1
  # GET /time_records/1.json
  def show
  end

  # GET /time_records/new
  def new
    @time_record = WorkTimeRecord.new
  end

  # GET /time_records/1/edit
  def edit
  end

  # POST /time_records
  # POST /time_records.json
  def create
    @time_record = WorkTimeRecord.new(time_record_params)

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
        @time_record.save_attendance_state
        format.html { redirect_to work_time_records_path, notice: 'Time record was successfully updated.' }
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
    @time_record = WorkTimeRecord.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def time_record_params
    params.require(:time_record).permit(
      :work_date,
      :work_time_pattern_id,
      :rest_time,
      :work_started_at,
      :work_ended_at,
      :description
    )
  end

  def map_time_records_to_calender(month:, year:)
    # 当月の日付分、WorkTimeRecord オブジェクトを用意する
    # * 当月の日が何日あるかを調べる
    # * 全レコードから当該日付にマッピングする
    # @time_records に代入する

    # 当月の日付分、WorkTimeRecord オブジェクトを用意する
    # * 当月の日が何日あるかを調べる
    days_in_month = Time.days_in_month(month, year)

    # すでに指定年月のレコードが作成されていれば
    # SQL クエリから結果を返す
    query_result = WorkTimeRecord.find_by_work_date_in_month_year(month, year).order(:work_date)
    result_size = query_result.count('*')
    return query_result if result_size.eql?(days_in_month)

    # 1日目から月末まで
    # カレンダーの日付にマッピングしていく
    1.step(days_in_month).map do |day|
      date = Date.new(year, month, day)
      # model association の設定で外部ID 入力必須のため
      # バリデーション回避オプションを有効化
      if time_record = WorkTimeRecord.find_by_work_date(date)
        time_record
      else
        time_record = WorkTimeRecord.new(work_date: date)
        time_record.save(validate: false)
        time_record
      end
    end
  end

  def calculate_work_time(time_records)
    time_records.map do |time_record|
      rest_time = time_record.rest_time.hour.to_i * 1.hour

      work_time =
        if [time_record&.work_ended_at, time_record&.work_started_at].compact.size.eql?(2) # 両方に値がある場合
          Time.at((time_record.work_ended_at.to_i - time_record.work_started_at.to_i - rest_time).abs).utc
        else
          Time.at(0).utc
        end

      # 8 時間を超えたものを残業時間として計上
      residual_time =
        if (work_time.to_i - 8.hour.to_i) > 0
          # residual_time を計算後にwork_time を更新しないと8時間差し引きの計算が合わない
          _residual_time = Time.at(work_time.to_i - 8.hour.to_i).utc
          work_time = Time.at(8.hour.to_i).utc
          _residual_time
        else
          Time.at(0).utc
        end

      {
        residual_time: residual_time,
        work_time: { work_time: work_time, hour: work_time.hour, min: work_time.min }
      }
    end
  end
end
