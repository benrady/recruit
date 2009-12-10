require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Recruit" do

  before( :each ) do
    user = Octopi::User.new
    user.name = "Ben Rady"
    user.email = "benrady@gmail.com"
    user.blog = "benrady.com"
    Octopi::User.should_receive(:find).and_return(user)
    @recruit = Recruit.new("benrady")
  end

  describe "creates a resume from your github account" do

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

  describe "uses HAML templates" do
    it "to create a resume" do
      @recruit.template = "%p= name"
      haml_engine = mock("HamlEngine")

      haml_engine.should_receive(:render).with(@recruit)
      Haml::Engine.should_receive(:new).with(@recruit.template).and_return(haml_engine)

      @recruit.generate_resume()
    end

  end
end
