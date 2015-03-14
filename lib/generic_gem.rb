require "generic_gem/version"
require "string_in_file"

module GenericGem
  def self.create (gem_name, your_name, your_email)
    puts "**********************"
    puts "Welcome to Generic Gem"
    puts "GEM NAME: #{gem_name}"
    puts "YOUR NAME: #{your_name}"
    puts "YOUR EMAIL: #{your_email}"
    dir_main = File.expand_path("../../", __FILE__)
    subdir_main = gem_name
    
    puts
    puts "*************************************************"
    puts "Setting up #{ENV['HOME']}/.bundle/config"
    puts "Includes the Code of Conduct (CODE_OF_CONDUCT.md file) and MIT license (LICENSE.txt file)"
    puts "Using rspec testing"
    system("mkdir -p #{ENV['HOME']}/.bundle")
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
    puts "Filling in your name in LICENSE.txt and #{gem_name}.gemspec"
    puts "Your name: #{your_name}"
    StringInFile.replace("TODO: Write your name", your_name, "#{subdir_main}/LICENSE.txt")
    StringInFile.replace("TODO: Write your name", your_name, "#{subdir_main}/#{gem_name}.gemspec")
    
    puts "****************************************************"
    puts "Filling in your email address in #{gem_name}.gemspec"
    StringInFile.replace("TODO: Write your email address", your_email, "#{subdir_main}/#{gem_name}.gemspec")
    
    puts "*****************************************************"
    puts "Filling in the gem description in #{gem_name}.gemspec"
    StringInFile.replace("TODO: Write a longer description or delete this line.", "GENERIC DESCRIPTION", "#{subdir_main}/#{gem_name}.gemspec")
    
    puts "*************************************************"
    puts "Filling in the gem summary in #{gem_name}.gemspec"
    StringInFile.replace("TODO: Write a short summary, because Rubygems requires one.", "GENERIC SUMMARY", "#{subdir_main}/#{gem_name}.gemspec")

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
    
    puts "***************************"
    puts "Updating the README.md file"
    t1 = Thread.new {  
      path_old = "#{subdir_main}/README.md"
      path_new = "#{subdir_main}/README-new.md"
      file_w = open(path_new, 'w')
      section_devel = false
      File.readlines(path_old).each do |line|
        if line.include? '## Contributing'
          section_devel = false
          file_w.write(line)
        elsif line.include? '## Development'
          section_devel = true
          file_w.write(line)
          file_w.write("\n")
          str_test = "Testing this gem: Enter `sh gem_test.sh`.  "
          str_test += "This should work in a fresh Ruby on Rails installation."
          str_test += "\n"
          file_w.write(str_test)
          str_console = "Running this gem in irb: Enter `sh gem_console.sh`.\n\n"
          file_w.write(str_console)
        elsif section_devel == true
          # Do NOT include in new README file
        else
          file_w.write(line)
        end
      end
      file_w.close
      system("rm #{path_old}")
      system("mv #{path_new} #{path_old}")
      }
    t1.join
    
    puts "*******************************************************************************"
    puts "Adding the suggestion of using a class or module to the lib/#{gem_name}.rb file"
    open("#{subdir_main}/lib/#{gem_name}.rb", 'a') { |f|
      f << "# Your new gem is a module by default.  You may wish to use a class instead."
    }
    
  end
end
