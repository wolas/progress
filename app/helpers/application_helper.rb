# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_loader update_div
    s =  "var so = new SWFObject(\"/flash/loading.swf\", \"home\", \"50\", \"50\", \"9\");"
    s += "so.addParam(\"wmode\", \"transparent\");"
    s += "so.write(\"#{update_div.to_s}\");"
  end
  
  def sort_options options, alt
    options[:style] ||= "padding-left: 5px; padding-right: 5px;"
    options[:width] ||= 30
    options[:alt] ||= alt
    options[:title] ||= options[:alt]
    options
  end
  
  def users_icon options = {}    
    image_tag "icons/users.png", sort_options( options, "Users" )
  end
  
  def edit_user_icon options = {}    
    image_tag "icons/edit_user.png", sort_options( options, "Edit" )
  end
  
  def delete_user_icon options = {}    
    image_tag "icons/delete_user.png", sort_options( options, "Delete" )
  end
  
  def open_icon options = {}    
    image_tag "icons/open.png", sort_options( options, "Open" )
  end
  
  
  
  def close_icon options = {}    
    image_tag "icons/close.png", sort_options( options, "Close" )
  end
  
  def cancel_icon options = {}
    options[:width] ||= 20    
    image_tag "cross.png", sort_options( options, "Cancel" )
  end
  
  
  
  def task_icon options = {}    
    image_tag "icons/task.png", sort_options( options, "Tasks" )
  end
  
  def edit_task_icon options = {}    
    image_tag "icons/edit_task.png", sort_options( options, "Edit" )
  end
  
  def destroy_task_icon options = {}    
    image_tag "icons/delete_task.png", sort_options( options, "Delete" )
  end
  
  def new_task_icon options = {}    
    image_tag "icons/new_task.png", sort_options( options, "New Task" )
  end
  
  
  
  def project_icon options = {}    
    image_tag "icons/project.png", sort_options( options, "Projects" )
  end
  
  def edit_project_icon options = {}    
    image_tag "icons/edit_project.png", sort_options( options, "Edit" )
  end
  
  def destroy_project_icon options = {}    
    image_tag "icons/delete_project.png", sort_options( options, "Delete" )
  end
  
  def new_project_icon options = {}    
    image_tag "icons/new_project.png", sort_options( options, "New Project" )
  end
  
  
  
  def event_icon options = {}    
    image_tag "icons/event.png", sort_options( options, "Events" )
  end
  
  def edit_event_icon options = {}    
    image_tag "icons/edit_event.png", sort_options( options, "Edit" )
  end
  
  def destroy_event_icon options = {}    
    image_tag "icons/delete_event.png", sort_options( options, "Delete" )
  end
  
  def new_event_icon options = {}    
    image_tag "icons/new_event.png", sort_options( options, "New Event" )
  end
  
  
  
  def client_icon options = {}    
    image_tag "icons/client.png", sort_options( options, "Clients" )
  end
  
  def edit_client_icon options = {}    
    image_tag "icons/edit_client.png", sort_options( options, "Edit" )
  end
  
  def destroy_client_icon options = {}    
    image_tag "icons/delete_client.png", sort_options( options, "Delete" )
  end
  
  def new_client_icon options = {}    
    image_tag "icons/new_client.png", sort_options( options, "New Client" )
  end
end
