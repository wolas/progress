require File.dirname(__FILE__) + '/../spec_helper'

describe Event do
  before(:each) do
    @event = Event.new :date => Date.tomorrow, :name => 'text_event', :description => 'test', :project => new_project(:end_date => Date.today + 10)
    @event.should be_valid
  end

  describe 'when valid, should' do

    before(:each) { @event.should be_valid }
    after(:each)  { @event.should_not be_valid }

    it 'have a date in the future' do
      @event.date = Date.yesterday
    end

    it 'have an date past the project end date' do
      @event.date = @event.project.end_date + 1
    end

    it 'have a name' do
      @event.name = nil
    end
  end


  it 'should be late if the end date has already passed' do
    @event.date = Date.yesterday
    @event.should be_late
  end

  it 'should not be late if the end date has not passed' do
    @event.date = Date.tomorrow
    @event.should_not be_late
  end

  it 'should allow to check if it happens in a given day' do
    @event.happens_in(Date.today).should be_true
  end

  describe 'when rendered as xml, should include the' do

    before(:each) { @xml = @event.to_xml }
    after(:each)  { @xml.should include(@result)}

    it 'date formatted as "weekday, day month year time timezone"' do
      @result = @event.date.strftime "%a, %d %b %Y %H:%M:%S %Z"
    end

    it('project colour') { @result = @event.project.colour }
    it('project name') { @result = @event.project.name }
    it('name') { @result = @event.name }
    it('description') { @result = @event.description }
  end
end
