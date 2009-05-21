require File.dirname(__FILE__) + '/../spec_helper'

describe Task do
  before(:each) do
    @task = new_task
    @task.should be_valid
  end

  describe 'when valid, should' do

    before(:each) { @task.should be_valid }
    after(:each)  { @task.should_not be_valid }

    it 'have an end date in the future' do
      @task.end_date = Date.yesterday
    end

    it 'have a start date in the future' do
      @task.start_date = Date.yesterday
    end

    it 'have the end date past the start date' do
      @task.start_date = @task.end_date + 1
    end

    it 'have an end date past the project end date' do
      @task.end_date = @task.project.end_date + 1
    end

    it 'have a name' do
      @task.name = nil
    end
  end


  it 'should be late if the end date has already passed' do
    @task.end_date = Date.yesterday
    @task.should be_late
  end

  it 'should not be late if the end date has not passed' do
    @task.end_date = Date.tomorrow
    @task.should_not be_late
  end

  it 'should show the number of days remaining' do
    @task.end_date = Date.today + 6
    @task.days_remaining.should eql(6)
  end

  it 'should allow to check if it happens in a given day' do
    @task.start_date = Date.yesterday
    @task.end_date = Date.tomorrow

    @task.happens_in(Date.today).should be_true
  end

  describe 'when rendered as xml, should include the' do

    before(:each) { @xml = @task.to_xml }
    after(:each)  { @xml.should include(@result)}

    it 'date formatted as "weekday, day month year time timezone"' do
      @result = @task.end_date.strftime "%a, %d %b %Y %H:%M:%S %Z"
    end

    it('project colour') { @result = @task.project.colour }
    it('project name') { @result = @task.project.name }
    it('name') { @result = @task.name }
    it('description') { @result = @task.description }
  end

end
