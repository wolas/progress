require File.dirname(__FILE__) + '/../spec_helper'

describe Project do

  before(:each) do
    @project = new_project
    @project.should be_valid
  end

  describe 'people are:' do

    before(:each) { @project.save }

    it 'managers of the project' do
      @project.managers.create user_params
      @project.managers.first.class.should eql(User)
    end

    it 'users involved through tasks' do
      task_user = new_user
      @project.tasks << Task.new( task_params(:users => [task_user]) )
      @project.users.should include(task_user)
    end

    it 'users involved through events' do
      event_user = new_user
      @project.events << Event.new( event_params(:users => [event_user]) )
      @project.users.should include(event_user)
    end
  end

  it 'should show the number of days remaining' do
    @project.end_date = Date.today + 6
    @project.days_remaining.should eql(6)
  end

  it 'should be late if the end date has already passed' do
    @project.end_date = Date.yesterday
    @project.should be_late
  end

  it 'should not be late if the end date has not passed' do
    @project.end_date = Date.tomorrow
    @project.should_not be_late
  end

  describe 'completed percentage' do

    after(:each) { @project.percentage_complete.should eql(@result) }

    it 'should be 100 if there are no tasks open' do
      @project.tasks.completed.size.should eql(0)
      @result = 100
    end

    it 'should be 100 if all tasks are completed' do
      @project.tasks << new_task(:completed => true)
      @result = 100
    end

    it 'should be 50 if halve tasks are completed' do
      @project.save!
      @project.tasks.create! task_params(:completed => true)
      @project.tasks.create! task_params(:completed => false)
      @result = 50
    end

    it 'should be 0 if all tasks are completed' do
      @project.save!
      @project.tasks.create! task_params(:completed => false)
      @project.tasks.create! task_params(:completed => false)
      @result = 0
    end

  end

  describe 'when valid, should' do

    before(:each) { @project.should be_valid }
    after(:each)  { @project.should_not be_valid }

    it 'have an end date in the future' do
      @project.end_date = Date.yesterday
    end

    it 'end date' do
      @project.end_date = nil
    end

    it 'have a name' do
      @project.name = nil
    end

    it 'have a colour' do
      @project.colour = nil
    end
  end

end
