module CalendarHelper
  def get_month(today = Date.today)
    month = []
    first = today.beginning_of_month
    last = today.end_of_month

    end_last_month = last.last_month
    middle_last_month = end_last_month - (first.wday - 1)

    middle_last_month.upto(last) { |date| month << date }

    begining_next_month = first.next_month
    middle_next_month = begining_next_month + (42 - month.size - 1)

    begining_next_month.upto(middle_next_month) { |date| month << date }

    month = month.in_groups_of(7)
  end
end
