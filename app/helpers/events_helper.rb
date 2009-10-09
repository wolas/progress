module EventsHelper
  def arrange_date params
    params.stringify_keys!
    if params[:date].empty?
      params[:'date(1i)'] = ""
      params[:'date(2i)'] = ""
      params[:'date(3i)'] = ""
      params[:'date(4i)'] = ""
      params[:'date(5i)'] = ""
    else
      date = params[:date].to_date
      params[:'date(1i)'] = date.year.to_s
      params[:'date(2i)'] = date.month.to_s
      params[:'date(3i)'] = date.day.to_s
    end
  end
end