module TransportationExpensesHelper
  def is_round_trip(transportation_expense)
    return nil if transportation_expense.cost.blank?
    transportation_expense.is_round_trip ? '往復' : '片道'
  end
end
