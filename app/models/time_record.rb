class TimeRecord < ApplicationRecord
  belongs_to :work_time_pattern
  # note: only works on postgres
  scope :find_by_work_date_in_month_year, ->(month, year) { where(%Q(work_date::text like '#{year}-#{month}-%')) }

  # 遅刻
  def late?
    is_there_not_presented_value = [work_time_pattern.work_started_at, work_started_at].compact.size.eql?(2).!
    return false if is_there_not_presented_value
    work_time_pattern.work_started_at < work_started_at
  end

  # 早退
  def leave_work_early?
    is_there_not_presented_value = [work_ended_at, work_time_pattern.work_ended_at].compact.size.eql?(2).!
    return false if is_there_not_presented_value
    work_ended_at < work_time_pattern.work_ended_at
  end

  # 欠勤
  def absent?
    is_work_day = work_time_pattern_id.present?
    is_not_work_today = work_started_at.nil? && work_ended_at.nil?
    is_work_day && is_not_work_today
  end

  # 遅刻・早退・欠勤状態の記録
  def save_attendance_state
    # 勤務日じゃない = 勤務パターンが選択・登録されていない場合
    return if work_time_pattern_id.nil?

    # 遅刻・早退・欠勤条件に合致する/しない場合 当該属性値に true/false を設定
    %w(late leave_work_early absent).each do |method_attribute_name|
      attribute = method_name = method_attribute_name
      method("is_#{attribute}=".to_sym).call(method("#{method_name}?").call)
    end
    save
  end

  # クラスメソッドの定義
  class << self
    # 土日祝祭日を除いた合計勤務日を返す
    # 日曜(振替休日)・平日に祝祭日があれば勤務すべき日数を減算する
    def workdays_of_month(year:, month:)

      first_day_of_month = Date.new(year, month, 1)
      last_day_of_month = (Date.new(year, month + 1, 1) - 1.day) # 月末の算出

      # 祝祭日のハッシュ( 日付 => 祝祭日名 )を得る
      # Note: 動作に不具合が出た場合、このgem のアップデートないし乗り換えを検討する
      holidays = HolidayJapan.between(first_day_of_month, last_day_of_month)

      # 当月の土曜・日曜を除いた日数を得る
      weekdays_count =
        (first_day_of_month..last_day_of_month)
        .find_all { |day| day.on_weekday? }
        .size

      # 祝祭日が
      # * 土曜であれば 0
      # * 日曜であれば振替休日 1
      # * 平日であれば 1
      # として勤務すべき日数からの減算対象として加える
      holidays_count =
        holidays
        .keys
        .map { |date| date.saturday? ? 0 : 1 }
        .inject(:+)

      weekdays_count - holidays_count
    end
  end
end
