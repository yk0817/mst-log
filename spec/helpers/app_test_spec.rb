require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#link_to_event" do
    it "displays the title, and formatted date" do
      event = Event.new("Ruby Kaigi", Date.new(2010, 8, 27))
      # expect(helper.link_to_event).to match /Ruby Kaigi, 27 Aug, 2010/
    end
  end
end