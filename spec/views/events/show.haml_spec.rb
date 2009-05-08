require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/show.haml" do
  before do
    @event = mock_model(Event)
    @event.stub!(:name).and_return("MyString")
    @event.stub!(:start_date).and_return(Time.now)
    @event.stub!(:end_date).and_return(Time.now)
    @event.stub!(:project_id).and_return("1")
    @event.stub!(:description).and_return("MyText")

    assigns[:event] = @event
  end

  it "should render attributes in <p>" do
    render "/events/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

