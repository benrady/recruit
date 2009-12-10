require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Recruit" do

  before( :each ) do
    @recruit = Recruit.new()
  end

  describe "creates a resume from your github account" do

    before( :each ) do
      user = Octopi::User.new
      user.name = "Ben Rady"
      user.email = "benrady@gmail.com"
      user.blog = "benrady.com"
      Octopi::User.should_receive(:find).and_return(user)

      @recruit.find_user_data("benrady")
      @resume_data = @recruit.scope
    end

    it "with your name" do
      @resume_data.name.should == "Ben Rady"
    end

    it "with your email" do
      @resume_data.email.should == "benrady@gmail.com"
    end

    it "with your blog url" do
      @resume_data.blog_url.should == "benrady.com"
    end

  end

  describe "uses HAML templates" do

    it "to create a resume" do
      @recruit.template = "%p= name"
      resume_markup = "<p>Name</p>"
      haml_engine = mock("HamlEngine")

      Haml::Engine.should_receive(:new).with(@recruit.template).and_return(haml_engine)
      haml_engine.should_receive(:render).with(@recruit.scope).and_return(resume_markup)

      @recruit.generate_resume().should be resume_markup
    end

  end
end
