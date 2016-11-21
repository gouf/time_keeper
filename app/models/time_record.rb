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
end
