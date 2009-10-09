# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_loader update_div
    s =  "var so = new SWFObject(\"/flash/loading.swf\", \"home\", \"50\", \"50\", \"9\");"
    s += "so.addParam(\"wmode\", \"transparent\");"
    s += "so.write(\"#{update_div.to_s}\");"
  end
end
