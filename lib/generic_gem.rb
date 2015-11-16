require 'generic_gem/version'
require 'string_in_file'
require 'replace_quotes'

#
module GenericGem
  def self.create(gem_name, your_name, your_email)
    puts '**********************'
    puts 'Welcome to Generic Gem'
    puts "GEM NAME: #{gem_name}"
    puts "YOUR NAME: #{your_name}"
    puts "YOUR EMAIL: #{your_email}"
    dir_main = File.expand_path('../../', __FILE__)
    subdir_main = gem_name

    puts
    puts '*************************************************'
    puts "Setting up #{ENV['HOME']}/.bundle/config"
    puts 'Includes the Code of Conduct (CODE_OF_CONDUCT.md file) and MIT license (LICENSE.txt file)'
    puts 'Using rspec testing'
    system("mkdir -p #{ENV['HOME']}/.bundle")
    system("cp #{dir_main}/lib/files_to_add/config #{ENV['HOME']}/.bundle/config")

    t1 = Thread.new do
      puts '********************'
      puts 'Creating the new gem'
      puts "bundle gem #{gem_name}"
      system("bundle gem #{gem_name}")
    end
    t1.join

    puts '**********************'
    puts 'Initial version: 0.0.0'
    StringInFile.replace('0.1.0', '0.0.0', "#{subdir_main}/lib/#{gem_name}/version.rb")
    ReplaceQuotes.update("#{subdir_main}/lib/#{gem_name}/version.rb")
    StringInFile.replace('module', "#\nmodule", "#{subdir_main}/lib/#{gem_name}/version.rb")

    puts '*****************************************************************'
    puts "Filling in your name in LICENSE.txt and #{gem_name}.gemspec"
    puts "Your name: #{your_name}"
    StringInFile.replace('TODO: Write your name', your_name, "#{subdir_main}/LICENSE.txt")
    StringInFile.replace('TODO: Write your name', your_name, "#{subdir_main}/#{gem_name}.gemspec")

    puts '****************************************************'
    puts "Filling in your email address in #{gem_name}.gemspec"
    StringInFile.replace('TODO: Write your email address', your_email, "#{subdir_main}/#{gem_name}.gemspec")

    puts '*****************************************************'
    puts "Filling in the gem description in #{gem_name}.gemspec"
    StringInFile.replace('TODO: Write a longer description or delete this line.', 'GENERIC DESCRIPTION', "#{subdir_main}/#{gem_name}.gemspec")

    puts '*************************************************'
    puts "Filling in the gem summary in #{gem_name}.gemspec"
    StringInFile.replace('TODO: Write a short summary, because Rubygems requires one.', 'GENERIC SUMMARY', "#{subdir_main}/#{gem_name}.gemspec")

    puts '********************************'
    puts 'Revising the initial rspec tests'
    StringInFile.replace('expect(false).to eq(true)', 'expect(true).to eq(true)', "#{subdir_main}/spec/#{gem_name}_spec.rb")

    puts '*******************************************'
    puts 'Updating bin/console to comply with Rubocop'
    ReplaceQuotes.update("#{subdir_main}/bin/console")

    puts '*****************************************************'
    puts 'Making the bin/console and bin/setup files executable'
    system("chmod +x #{subdir_main}/bin/*")

    puts '*****************************'
    puts 'Adding the gem_test.sh script'
    system("cp #{dir_main}/lib/files_to_add/gem_test.sh #{subdir_main}")

    puts '*********************************************'
    puts "Adding 'gem uninstall' command to gem_test.sh"
    str_old = '#!/bin/bash'
    str_new = '#!/bin/bash' + "\n\n" + "gem uninstall #{gem_name}"
    StringInFile.replace(str_old, str_new, "#{subdir_main}/gem_test.sh")

    puts '********************************'
    puts 'Adding the gem_install.sh script'
    system("cp #{dir_main}/lib/files_to_add/gem_install.sh #{subdir_main}")

    puts '************************************************'
    puts "Adding 'gem uninstall' command to gem_install.sh"
    str_old = '#!/bin/bash'
    str_new = '#!/bin/bash' + "\n\n" + "gem uninstall #{gem_name}"
    StringInFile.replace(str_old, str_new, "#{subdir_main}/gem_install.sh")

    puts '********************************'
    puts 'Adding the gem_console.sh script'
    system("cp #{dir_main}/lib/files_to_add/gem_console.sh #{subdir_main}")

    puts '************************************************'
    puts "Adding 'gem uninstall' command to gem_console.sh"
    str_old = '#!/bin/bash'
    str_new = '#!/bin/bash' + "\n\n" + "gem uninstall #{gem_name}"
    StringInFile.replace(str_old, str_new, "#{subdir_main}/gem_console.sh")

    puts '*******************'
    puts 'Adding the Rakefile'
    system("cp #{dir_main}/lib/files_to_add/Rakefile #{subdir_main}")

    puts '******************************'
    puts 'Completing the .gitignore file'
    puts 'Adding tmp* and .DS_Store'
    open("#{subdir_main}/.gitignore", 'a') do |f|
      f << '\ntmp*'
      f << '\n.DS_Store'
      f << '\n*.gem'
    end

    puts '***************************'
    puts 'Updating the README.md file'
    t1 = Thread.new do
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
          file_w.write('\n\n')
          str_test = '### Testing this gem\n\n'
          str_test += 'Enter `sh gem_test.sh`.\n\n'
          file_w.write(str_test)

          str_console = '### Running this gem in irb\n\n'
          str_console += 'Enter `sh gem_console.sh`.\n\n'
          file_w.write(str_console)

          str_install = '### Installing this gem\n\n'
          str_install += 'Enter `sh gem_install.sh`.\n\n'
          file_w.write(str_install)
        elsif section_devel == true
          # Do NOT include in new README file
        else
          file_w.write(line)
        end
      end
      file_w.close
      system("rm #{path_old}")
      system("mv #{path_new} #{path_old}")
    end
    t1.join

    puts '*****************************************************************'
    puts "Updating #{subdir_main}/lib/#{gem_name}.rb to comply with RuboCop"
    ReplaceQuotes.update("#{subdir_main}/lib/#{gem_name}.rb")
    StringInFile.replace('module', "#\nmodule", "#{subdir_main}/lib/#{gem_name}.rb")

    puts '*******************************************************************************'
    puts "Adding the suggestion of using a class or module to the lib/#{gem_name}.rb file"
    open("#{subdir_main}/lib/#{gem_name}.rb", 'a') do |f|
      f << "# Your new gem is a module by default.  You may wish to use a class instead.\n"
    end

    puts '*********'
    puts 'Reset Git'
    system("cd #{subdir_main} && git init")
    system("cd #{subdir_main} && git add .")
    system("cd #{subdir_main} && git commit -m 'Initial commit'")
  end
end
