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

end
