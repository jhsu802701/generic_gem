require "generic_gem/version"
require "string_in_file"

module GenericGem
  def self.create (gem_name, your_name)
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

    puts "*****************************************************************"
    puts "Filling in your name as the owner of the copyright in LICENSE.txt"
    puts "Your name: #{your_name}"
    StringInFile.replace("TODO: Write your name", your_name, "#{subdir_main}/LICENSE.txt")

    puts "********************************"
    puts "Revising the initial rspec tests"
    StringInFile.replace("expect(false).to eq(true)", "expect(true).to eq(true)", "#{subdir_main}/spec/#{gem_name}_spec.rb")

    puts "*****************************************************"
    puts "Making the bin/console and bin/setup files executable"
    system("chmod +x #{subdir_main}/bin/*")

    puts "*****************************"
    puts "Adding the gem_test.sh script"
    system("cp #{dir_main}/lib/files_to_add/gem_test.sh #{subdir_main}")

    puts "********************************"
    puts "Adding the gem_console.sh script"
    system("cp #{dir_main}/lib/files_to_add/gem_console.sh #{subdir_main}")

    puts "*******************"
    puts "Adding the Rakefile"
    system("cp #{dir_main}/lib/files_to_add/Rakefile #{subdir_main}")

    puts "******************************"
    puts "Completing the .gitignore file"
    puts "Adding tmp* and .DS_Store"
    open("#{subdir_main}/.gitignore", 'a') { |f|
      f << "tmp*"
      f << ".DS_Store"
    }
    
    puts "*********************************"
    puts "Adding rspec to the .gemspec file"
    t1 = Thread.new {  
      path_old = "#{subdir_main}/#{gem_name}.gemspec"
      path_new = "#{subdir_main}/#{gem_name}_new.gemspec"
      file_w = open(path_new, 'w')
      File.readlines(path_old).each do |line|
        if line.include? 'spec.add_development_dependency "rake"'
          file_w.write(line)
          file_w.write('  spec.add_development_dependency "rspec"')
          file_w.write("\n")
        else
          file_w.write(line)
        end
      end
      file_w.close
      system("rm #{path_old}")
      system("mv #{path_new} #{path_old}")
      }
    t1.join
  end
end
