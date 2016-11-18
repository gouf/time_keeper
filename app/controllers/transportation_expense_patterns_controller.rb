class TransportationExpensePatternsController < ApplicationController
  def index
    # TODO : 入力フォームに複数(増減可変)のTransportationExpense モデルへの入力を受け付ける機能を追加する

    # * transportation expense pattern
    # パターン名を登録・保持し、それをもとに transportation expenses を読み出す
    # * transportation expenses
    # view に表示する交通費一覧
    # ここからさらに、各レコードの編集画面へ遷移する
    #
    # * transportation expense
    # 交通費の新規登録
    # 交通費パターン名に関連付けられた、交通費レコードを作成する
    @transportation_expenses = []
    @transportation_expense = TransportationExpense.new
    @transportation_expense_pattern = TransportationExpensePattern.new
    # パターンとして1レコードずつ登録していく
    # 登録されたレコードは、パターンとの関連付けにより一覧表示される
  end

  def new
  end

  def create
    if TransportationExpensePattern.create(transportation_expense_pattern_params)
      redirect_to transportation_expense_patterns_path
    else
      # TODO : flash によるエラーメッセージの表示
      redirect_to transportation_expense_patterns_path
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def transportation_expense_pattern_params
    params.require(:transportation_expense_pattern).permit(
      :name
    )
  end
end
