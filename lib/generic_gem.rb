require "generic_gem/version"
require "string_in_file"

module GenericGem
  def self.create (gem_name)
    dir_main = File.expand_path("../../", __FILE__)
    subdir_main = gem_name
    
    puts
    puts "*************************************************"
    puts "Setting up #{ENV['HOME']}/.bundle/config"
    puts "Includes the Code of Conduct (CODE_OF_CONDUCT.md file) and MIT license (LICENSE.txt file)"
    puts "Using rspec testing"
    system("cp #{dir_main}/lib/files_to_add/config #{ENV['HOME']}/.bundle/config")
      
    t1 = Thread.new {  
      puts "********************"
      puts "Creating the new gem"
      puts "bundle gem #{gem_name}"
      system("bundle gem #{gem_name}")  
      }
    t1.join
    
    puts "**********************"
    puts "Initial version: 0.0.0"
    StringInFile.replace("0.1.0", "0.0.0", "#{subdir_main}/lib/#{gem_name}/version.rb")
    
  end
end
