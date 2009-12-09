require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Recruit" do
  describe "creates a resume from your github account" do

    before( :each ) do
      user = Octopi::User.new
      user.name = "Ben Rady"
      user.email = "benrady@gmail.com"
      user.blog = "benrady.com"
      Octopi::User.should_receive(:find).and_return(user)
      @recruit = Recruit.new("benrady")
    end

    it "with your name" do
      @recruit.name.should == "Ben Rady"
    end

    it "with your email" do
      @recruit.email.should == "benrady@gmail.com"
    end

    it "with your blog url" do
      @recruit.blog.should == "benrady.com"
    end

  end
end
