module TasksHelper
  def partition_on_state tasks, exclude_completed
    completed, open  = tasks.partition {|task| task.completed? }
    late, upcoming = open.partition {|task| task.late? }

    standby = late.select{|task| task.standby? }
    late -= standby
    standby += upcoming.select{|task| task.standby? }
    upcoming -= standby


    task_list = [[:late, late], [:upcoming, upcoming]]
    task_list << [:completed, completed] unless exclude_completed
    return task_list, standby
  end
end