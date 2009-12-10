require "rubygems"
require "octopi"
require "haml"

# Follows the builder pattern
class Recruit
  include Octopi
  include Haml 

  attr_reader :name
  attr_reader :email
  attr_reader :blog

  attr_accessor :template

  def initialize(github_user_name)
    user = User.find(github_user_name)

    # DEBT There must be a better way
    @name = user.name
    @email = user.email
    @blog = user.blog
  end

  def generate_resume
    Engine.new(@template).render(self)
  end

end
