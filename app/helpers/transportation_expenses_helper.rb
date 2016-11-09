module TransportationExpensesHelper
  def year_month_display
    # 矢印リンク付きの年月を表示
    # ←年→←月→
    content_tag(
      :h2,
      content_tag(
        :a,
        '←',
        href: "#{transportation_expenses_path}?year=#{@year - 1}&month=#{@month}"
      ) +
      content_tag(:span, "#{@year}年") +
      content_tag(
        :a,
        '→',
        href: "#{transportation_expenses_path}?year=#{@year + 1}&month=#{@month}"
      ) +
      content_tag(
        :a,
        '←',
        href: "#{transportation_expenses_path}?year=#{@year}&month=#{@month - 1}"
      ) +
      content_tag(:span, "#{@month}月") +
      content_tag(
        :a,
        '→',
        href: "#{transportation_expenses_path}?year=#{@year}&month=#{@month + 1}"
      ),
      class: 'text-center'
    )
  end

  def is_round_trip(transportation_expense)
    return nil if transportation_expense.cost.blank?
    transportation_expense.is_round_trip ? '往復' : '片道'
  end
end
