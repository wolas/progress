require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/new.haml" do
  before do
    @event = mock_model(Event)
    @event.stub!(:new_record?).and_return(true)
    @event.stub!(:name).and_return("MyString")
    @event.stub!(:start_date).and_return(Time.now)
    @event.stub!(:end_date).and_return(Time.now)
    @event.stub!(:project_id).and_return("1")
    @event.stub!(:description).and_return("MyText")
    assigns[:event] = @event
  end

  it "should render new form" do
    render "/events/new.haml"
    
    response.should have_tag("form[action=?][method=post]", events_path) do
      with_tag("input#event_name[name=?]", "event[name]")
      with_tag("textarea#event_description[name=?]", "event[description]")
    end
  end
end
