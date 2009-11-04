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

  def task_assigned recipient, task, role
    @subject = "You are a #{role.humanize.singularize} for task \"#{task.name}\""
    @recipients = recipient.email
    @from = recipient.email
    @sent_on = Time.now
    @body['task'] = task
    @body['role'] = role
    @headers = {}
  end

  def project_assigned recipient, project, role
    @subject = "You are the new #{role.humanize.singularize} for project \"#{project.name}\""
    @recipients = recipient.email
    @from = recipient.email
    @sent_on = Time.now
    @body['project'] = project
    @body['role'] = role
    @headers = {}
  end
end
