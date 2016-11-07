class TimeRecordsController < ApplicationController
  before_action :set_time_record, only: [:show, :edit, :update, :destroy]
  before_action :set_year_month_instance_variable, only: [:index]

  # GET /time_records
  # GET /time_records.json
  def index
    @time_records = map_time_records_to_calender(month: @month, year: @year)
    @time_record = TimeRecord.find_by_work_date(params[:work_date] || Date.today)

    @work_time = calculate_work_time(@time_records)
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
        format.html { redirect_to time_records_path, notice: 'Time record was successfully updated.' }
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
      :work_time_pattern_id,
      :rest_time,
      :work_started_at,
      :work_ended_at,
      :description
    )
  end

  def set_year_month_instance_variable
    # params[:year], params[:month] 情報から年月の表示を移動する
    # 次点 session[:year], session[:month] から取り出し
    # なければ現在の年・月から値を設定
    @year, @month =
      [
        params[:year].nil? ? nil : params[:year].to_i,
        params[:month].nil? ? nil : params[:month].to_i
      ]

    @year ||= session[:year]
    @month ||= session[:month]

    @year ||= Date.today.year
    @month ||= Date.today.month

    # 月がその範囲を踏み切ったときに年を移動する
    @month, @year = [12, @year - 1] if @month < 1
    @month, @year = [1, @year + 1] if @month > 12

    # 値をセッションに保存して再利用する
    # レコード 編集後のページ遷移に対応する
    session[:year] = @year
    session[:month] = @month
  end

  def map_time_records_to_calender(month:, year:)
    # 当月の日付分、TimeRecord オブジェクトを用意する
    # * 当月の日が何日あるかを調べる
    # * 全レコードから当該日付にマッピングする
    # @time_records に代入する

    # 当月の日付分、TimeRecord オブジェクトを用意する
    # * 当月の日が何日あるかを調べる
    days_in_month = Time.days_in_month(month, year)

    # すでに指定年月のレコードが作成されていれば
    # SQL クエリから結果を返す
    query_result = TimeRecord.find_by_work_date_in_month_year(month, year).order(:work_date)
    result_size = query_result.count('*')
    return query_result if result_size.eql?(days_in_month)

    # 1日目から月末まで
    # カレンダーの日付にマッピングしていく
    1.step(days_in_month).map do |day|
      date = Date.new(year, month, day)
      # model association の設定で外部ID 入力必須のため
      # バリデーション回避オプションを有効化
      if time_record = TimeRecord.find_by_work_date(date)
        time_record
      else
        time_record = TimeRecord.new(work_date: date)
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
