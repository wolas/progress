require File.dirname(__FILE__) + '/../../spec_helper'

describe "/event/edit.haml" do
  before do
    @event = mock_model(Event)
    @event.stub!(:name).and_return("MyString")
    @event.stub!(:start_date).and_return(Time.now)
    @event.stub!(:end_date).and_return(Time.now)
    @event.stub!(:project_id).and_return("1")
    @event.stub!(:description).and_return("MyText")
    assigns[:event] = @event
  end

  it "should render edit form" do
    render "/events/edit.haml"
    
    response.should have_tag("form[action=#{event_path(@event)}][method=post]") do
      with_tag('input#event_name[name=?]', "event[name]")
      with_tag('textarea#event_description[name=?]', "event[description]")
    end
  end
end
