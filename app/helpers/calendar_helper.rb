module CalendarHelper
  def get_month(today = Date.today)
    first = today.beginning_of_month
    month = []
    first.wday.times { month << nil }
    first.upto(today.end_of_month) { |date| month << date }
    (42 - month.size).times { month << nil }
    month = month.in_groups_of(7)
  end
end
