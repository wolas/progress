require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/index.haml" do
  before do
    event_98 = mock_model(Event)
    event_98.should_receive(:name).and_return("MyString")
    event_98.should_receive(:start_date).and_return(Time.now)
    event_98.should_receive(:end_date).and_return(Time.now)
    event_98.should_receive(:project_id).and_return("1")
    event_98.should_receive(:description).and_return("MyText")
    event_99 = mock_model(Event)
    event_99.should_receive(:name).and_return("MyString")
    event_99.should_receive(:start_date).and_return(Time.now)
    event_99.should_receive(:end_date).and_return(Time.now)
    event_99.should_receive(:project_id).and_return("1")
    event_99.should_receive(:description).and_return("MyText")

    assigns[:events] = [event_98, event_99]
  end

  it "should render list of events" do
    render "/events/index.haml"
  end
end
