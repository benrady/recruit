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

  def self.create_resume(*args)
    APICache.store=APICache::MemoryStore.new
    recruit = Recruit.new
    recruit.find_user_data(args[0])
    recruit.load_template
    recruit.generate_resume
  end

  def find_user_data(github_user_name)
    user = User.find(github_user_name)

    @scope = {
      :name => user.name,
      :email => user.email,
      :blog_url => user.blog
    }
  end

  def load_template
      @template = File.open(File.join(File.dirname(__FILE__), 'templates', 'default.haml')).read
  end

  def generate_resume
    Engine.new(@template).render(@scope)
  end

end
