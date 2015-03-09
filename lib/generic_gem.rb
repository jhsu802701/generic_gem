require "generic_gem/version"

module GenericGem
  def self.create (gem_name)
    dir_main = File.expand_path("../../", __FILE__)
    
    t1 = Thread.new {
      puts
      puts "*************************************************"
      puts "Setting up #{ENV['HOME']}/.bundle/config"
      puts "Includes the Code of Conduct (CODE_OF_CONDUCT.md file) and MIT license (LICENSE.txt file)"
      puts "Using rspec testing"
      system ("cp #{dir_main}/lib/files_to_add/config #{ENV['HOME']}/.bundle/config")
      
      puts "*************************************************"
      puts "bundle gem #{gem_name}"
      system ("bundle gem #{gem_name}")
      
      }
    t1.join
  end
end
