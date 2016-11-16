class TransportationExpensePatternsController < ApplicationController
  def index
    # TODO : 入力フォームに複数(増減可変)のTransportationExpense モデルへの入力を受け付ける機能を追加する
    @transportation_expense_models = [TransportationExpense.new]
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
