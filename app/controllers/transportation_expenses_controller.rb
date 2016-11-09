class TransportationExpensesController < ApplicationController
  before_action :set_transportation_expense, only: [:show, :edit, :update, :destroy]

  # GET /transportation_expenses
  # GET /transportation_expenses.json
  def index
    @transportation_expenses = map_transportation_expenses_to_calender(month: @month, year: @year)
    @transportation_expense = TransportationExpense.find_by_use_date(params[:use_date] || Date.today)

    @cost = calculate_transportation_expense(@transportation_expenses)
  end

  # GET /transportation_expenses/1
  # GET /transportation_expenses/1.json
  def show
  end

  # GET /transportation_expenses/new
  def new
    @transportation_expense = TransportationExpense.new
  end

  # GET /transportation_expenses/1/edit
  def edit
  end

  # POST /transportation_expenses
  # POST /transportation_expenses.json
  def create
    @transportation_expense = TransportationExpense.new(transportation_expense_params)

    respond_to do |format|
      if @transportation_expense.save
        format.html { redirect_to @transportation_expense, notice: 'Transportation expense was successfully created.' }
        format.json { render :show, status: :created, location: @transportation_expense }
      else
        format.html { render :new }
        format.json { render json: @transportation_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transportation_expenses/1
  # PATCH/PUT /transportation_expenses/1.json
  def update
    respond_to do |format|
      if @transportation_expense.update(transportation_expense_params)
        format.html { redirect_to @transportation_expense, notice: 'Transportation expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @transportation_expense }
      else
        format.html { render :edit }
        format.json { render json: @transportation_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transportation_expenses/1
  # DELETE /transportation_expenses/1.json
  def destroy
    @transportation_expense.destroy
    respond_to do |format|
      format.html { redirect_to transportation_expenses_url, notice: 'Transportation expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transportation_expense
    @transportation_expense = TransportationExpense.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def transportation_expense_params
    params.require(:transportation_expense).permit(
      :use_date,
      :destination,
      :route,
      :destination_from,
      :destination_to,
      :is_round_trip,
      :cost
    )
  end

  def calculate_transportation_expense(transportation_expenses)
    # TODO : 当月の交通費の合計を算出する
  end

  def map_transportation_expenses_to_calender(month:, year:)
    # 当月の日付分、TransportationExpense オブジェクトを用意する
    # * 当月の日が何日あるかを調べる
    # * 全レコードから当該日付にマッピングする
    # @transportation_expense_records に代入する

    # 当月の日付分、TransportationExpense オブジェクトを用意する
    # * 当月の日が何日あるかを調べる
    days_in_month = Time.days_in_month(month, year)

    # すでに指定年月のレコードが作成されていれば
    # SQL クエリから結果を返す
    query_result = TransportationExpense.find_by_use_date_in_month_year(month, year).order(:use_date)
    result_size = query_result.count('*')
    return query_result if result_size.eql?(days_in_month)

    # 1日目から月末まで
    # カレンダーの日付にマッピングしていく
    1.step(days_in_month).map do |day|
      date = Date.new(year, month, day)
      # model association の設定で外部ID 入力必須のため
      # バリデーション回避オプションを有効化
      if transportation_expense_record = TransportationExpense.find_by_use_date(date)
        transportation_expense_record
      else
        transportation_expense_record = TransportationExpense.new(use_date: date)
        transportation_expense_record.save(validate: false)
        transportation_expense_record
      end
    end
  end
end
