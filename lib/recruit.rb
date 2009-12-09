require "rubygems"
require "octopi"

class Recruit
  include Octopi

  attr_reader :name
  attr_reader :email
  attr_reader :blog

  def initialize(github_user_name)
    user = User.find(github_user_name)

    # DEBT There must be a better way
    @name = user.name
    @email = user.email
    @blog = user.blog
  end
end
