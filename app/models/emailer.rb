class Emailer < ActionMailer::Base

  def task_completed recipients, task, user
    @subject = "Completed - #{task.name}"
    @recipients = Array.new(recipients).map(&:email)
    @from = 'no-reply@it.yr.com'
    @sent_on = Time.now
    @body['task'] = task
    @body['user'] = user
    @headers = {}
  end

  def task_assigned recipients, task, user
    @subject = "Assigned - #{task.name}"
    @recipients = Array.new(recipients).map(&:email)
    @from = 'no-reply@it.yr.com'
    @sent_on = Time.now
    @body['task'] = task
    @body['user'] = user
    @headers = {}
  end


  def project_created recipients, project
    @subject = "Project - #{project.name} created."
    @recipients = Array.new(recipients).map(&:email)
    @from = 'no-reply@yr.progress.com'
    @sent_on = Time.now
    @body['project'] = project
    @headers = {}
  end
end
