class TransportationExpensesController < ApplicationController
  before_action :set_transportation_expense, only: [:show, :edit, :update, :destroy]

  # GET /transportation_expenses
  # GET /transportation_expenses.json
  def index
    @transportation_expense = TransportationExpense.new(use_date: Date.today)
    @transportation_expenses = TransportationExpense.all
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
end
