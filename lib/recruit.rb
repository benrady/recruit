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
  attr_reader :scope

  attr_accessor :template

  def find_user_data(github_user_name)
    user = User.find(github_user_name)

    @scope = {
      :name => user.name,
      :email => user.email,
      :blog_url => user.blog
    }
  end

  def generate_resume
    Engine.new(@template).render(@scope)
  end

end
