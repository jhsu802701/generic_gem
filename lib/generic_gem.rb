require 'generic_gem/version'
require 'string_in_file'
require 'replace_quotes'
require 'line_containing'

#
module GenericGem
  def self.create(gem_name, your_name, your_email)
    puts '**********************'
    puts 'Welcome to Generic Gem'
    puts "GEM NAME: #{gem_name}"
    puts "YOUR NAME: #{your_name}"
    puts "YOUR EMAIL: #{your_email}"
    ENV['DIR_MAIN'] = File.expand_path('../../', __FILE__)

    bundle_config
    bundle_gem(gem_name)
    update_version(gem_name)
    add_name(gem_name, your_name)
    update_gemspec(gem_name, your_email)
    add_gem_dep(gem_name, 'rubocop')
    add_gem_dep(gem_name, 'sandi_meter')
    add_gem_dep(gem_name, 'bundler-audit')
    add_gem_dep(gem_name, 'gemsurance')
    add_gem_dep(gem_name, 'ruby-graphviz')
    add_gem_dep(gem_name, 'simplecov')
    update_spec_helper(gem_name)
    update_tests(gem_name)
    update_bin_scripts(gem_name)
    add_rakefile(gem_name)
    add_readme_todo(gem_name)
    add_bash_scripts(gem_name)
    update_gitignore(gem_name)
    update_readme(gem_name)
    update_main_module(gem_name)
    add_rubocop_yml(gem_name)
    reset_git(gem_name)
  end

  def self.bundle_config
    puts '----------------------------------------'
    puts "Setting up #{ENV['HOME']}/.bundle/config"
    puts 'Includes the Code of Conduct (CODE_OF_CONDUCT.md file) and MIT license (LICENSE.txt file)'
    puts 'Using rspec testing'
    system("mkdir -p #{ENV['HOME']}/.bundle")
    system("cp #{ENV['DIR_MAIN']}/lib/files_to_add/config #{ENV['HOME']}/.bundle/config")
  end

  def self.bundle_gem(gem_name)
    t1 = Thread.new do
      puts '--------------------'
      puts 'Creating the new gem'
      puts "bundle gem #{gem_name}"
      system("bundle gem #{gem_name}")
    end
    t1.join
  end

  def self.update_version(gem_name)
    puts '----------------------'
    puts 'Initial version: 0.0.0'
    StringInFile.replace('0.1.0', '0.0.0', "#{gem_name}/lib/#{gem_name}/version.rb")
    ReplaceQuotes.update("#{gem_name}/lib/#{gem_name}/version.rb")
    StringInFile.replace('module', "#\nmodule", "#{gem_name}/lib/#{gem_name}/version.rb")
    StringInFile.replace("'0.0.0'", "'0.0.0'.freeze", "#{gem_name}/lib/#{gem_name}/version.rb")
  end

  def self.add_name(gem_name, your_name)
    puts '-----------------------------------------------------------'
    puts "Filling in your name in LICENSE.txt and #{gem_name}.gemspec"
    puts "Your name: #{your_name}"
    StringInFile.replace('TODO: Write your name', your_name, "#{gem_name}/LICENSE.txt")
    StringInFile.replace('TODO: Write your name', your_name, "#{gem_name}/#{gem_name}.gemspec")
  end

  def self.update_gemspec(gem_name, your_email)
    puts '----------------------------------------------------'
    puts "Filling in your email address in #{gem_name}.gemspec"
    StringInFile.replace('TODO: Write your email address', your_email, "#{gem_name}/#{gem_name}.gemspec")

    puts '-----------------------------------------------------'
    puts "Filling in the gem description in #{gem_name}.gemspec"
    StringInFile.replace('TODO: Write a longer description or delete this line.', 'GENERIC DESCRIPTION', "#{gem_name}/#{gem_name}.gemspec")
    StringInFile.replace('%q{GENERIC DESCRIPTION}', "'GENERIC DESCRIPTION'", "#{gem_name}/#{gem_name}.gemspec")

    puts '-------------------------------------------------'
    puts "Filling in the gem summary in #{gem_name}.gemspec"
    StringInFile.replace('TODO: Write a short summary, because Rubygems requires one.', 'GENERIC SUMMARY', "#{gem_name}/#{gem_name}.gemspec")
    StringInFile.replace('%q{GENERIC SUMMARY}', "'GENERIC SUMMARY'", "#{gem_name}/#{gem_name}.gemspec")

    puts '---------------------------------------------------'
    puts "Updating #{gem_name}.gemspec for RuboCop compliance"
    ReplaceQuotes.update("#{gem_name}/#{gem_name}.gemspec")
    StringInFile.replace("'\\x0'", '"\\x0"', "#{gem_name}/#{gem_name}.gemspec")

    puts '----------------------------------------------------'
    puts "Updating #{gem_name}.gemspec to remove excess spaces"
    while StringInFile.present('  =', "#{gem_name}/#{gem_name}.gemspec")
      StringInFile.replace('  =', ' =', "#{gem_name}/#{gem_name}.gemspec")
    end
    # puts '--------------------------------------------------------------'
    # puts "Replace 'raise' in #{gem_name}/#{gem_name}.gemspec with 'fail'"
    # StringInFile.replace("raise 'RubyGems", "fail 'RubyGems", "#{gem_name}/#{gem_name}.gemspec")
  end

  def self.add_gem_dep(gem_name, gem_dep)
    puts '----------------------------------------'
    puts "Adding #{gem_dep} development dependency"
    str1 = "spec.add_development_dependency 'rspec'"
    str2 = "\n  spec.add_development_dependency '#{gem_dep}'"
    LineContaining.add_after(str1, str2, "#{gem_name}/#{gem_name}.gemspec")
  end

  def self.update_spec_helper(gem_name)
    puts '----------------------------'
    puts 'Updating spec/spec_helper.rb'
    file_new = "#{gem_name}/spec/spec_helper_new.rb"
    file_old = "#{gem_name}/spec/spec_helper.rb"
    open(file_new, 'a') do |f|
      f << "require 'simplecov'\n"
      f << "SimpleCov.start\n\n"
      f << File.read(file_old)
    end
    system("mv #{file_new} #{file_old}")
    ReplaceQuotes.update(file_old)
  end

  def self.update_tests(gem_name)
    puts '--------------------------------'
    puts 'Revising the initial rspec tests'
    StringInFile.replace('expect(false).to eq(true)', 'expect(true).to eq(true)', "#{gem_name}/spec/#{gem_name}_spec.rb")
    puts '----------------------------------------'
    puts 'Convering double quotes to single quotes'
    ReplaceQuotes.update("#{gem_name}/spec/#{gem_name}_spec.rb")
  end

  def self.update_bin_scripts(gem_name)
    puts '----------------------------------'
    puts 'Updating bin/console and bin/setup'
    ReplaceQuotes.update("#{gem_name}/bin/console")
    system("chmod +x #{gem_name}/bin/*")
  end

  def self.add_rakefile(gem_name)
    puts '-------------------'
    puts 'Adding the Rakefile'
    system("cp #{ENV['DIR_MAIN']}/lib/files_to_add/Rakefile #{gem_name}")
  end

  def self.add_readme_todo(gem_name)
    puts '--------------------------------'
    puts 'Adding the README-to_do.txt file'
    system("cp #{ENV['DIR_MAIN']}/lib/files_to_add/README-to_do.txt #{gem_name}")
  end

  def self.add_bash_scripts(gem_name)
    puts '-------------------'
    puts 'Adding Bash scripts'
    system("cp #{ENV['DIR_MAIN']}/lib/files_to_add/*.sh #{gem_name}")

    puts '----------------------------------------------'
    puts "Adding 'gem uninstall' command to Bash scripts"
    str_old = '# uninstall'
    str_new = "gem uninstall #{gem_name}"
    StringInFile.replace(str_old, str_new, "#{gem_name}/code_test.sh")
    StringInFile.replace(str_old, str_new, "#{gem_name}/gem_test.sh")
    StringInFile.replace(str_old, str_new, "#{gem_name}/gem_install.sh")
    StringInFile.replace(str_old, str_new, "#{gem_name}/gem_console.sh")
  end

  def self.update_gitignore(gem_name)
    puts '----------------------------'
    puts 'Updating the .gitignore file'
    puts 'Adding tmp* and .DS_Store'
    open("#{gem_name}/.gitignore", 'a') do |f|
      f << "\nlog/"
      f << "\ntmp*"
      f << "\n.DS_Store"
      f << "\n*.gem"
    end
  end

  def self.update_readme(gem_name)
    puts '---------------------------'
    puts 'Updating the README.md file'
    t1 = Thread.new do
      file_w = open("#{gem_name}/README.md", 'a')
      file_w.write("## Bash Scripts\n")
      file_w.write("### Testing this gem\n")
      file_w.write("After you download this source code, enter `sh gem_test.sh` to set up and test this gem.\n\n")
      file_w.write("### Testing this gem's source code\n")
      file_w.write("Enter `sh code_test.sh` to test the quality of this gem's source code.\n")
      file_w.write("### Running this gem in irb\n")
      file_w.write("Enter `sh gem_console.sh`.\n\n")
      file_w.write("### Installing this gem\n")
      file_w.write("Enter `sh gem_install.sh`.\n")
      file_w.write("### Testing the gem, source code, and installation process\n")
      file_w.write("Enter `sh all.sh` to run the gem_test.sh, code_test.sh, and gem_install.sh scripts.\n")
      file_w.close
    end
    t1.join
  end

  def self.update_main_module(gem_name)
    puts '--------------------------------------------------------------'
    puts "Updating #{gem_name}/lib/#{gem_name}.rb to comply with RuboCop"
    ReplaceQuotes.update("#{gem_name}/lib/#{gem_name}.rb")
    StringInFile.replace('module', "#\nmodule", "#{gem_name}/lib/#{gem_name}.rb")

    puts '-------------------------------------------------------------------------------'
    puts "Adding the suggestion of using a class or module to the lib/#{gem_name}.rb file"
    open("#{gem_name}/lib/#{gem_name}.rb", 'a') do |f|
      f << "# Your new gem is a module by default.  You may wish to use a class instead.\n"
    end
  end

  def self.add_rubocop_yml(gem_name)
    puts '-------------------'
    puts 'Adding .rubocop.yml'
    system("cp #{ENV['DIR_MAIN']}/lib/files_to_add/rubocop.yml #{gem_name}/.rubocop.yml")
    StringInFile.replace('gemspec_file', "#{gem_name}.gemspec", "#{gem_name}/.rubocop.yml")
  end

  def self.reset_git(gem_name)
    puts '---------'
    puts 'Reset Git'
    system("cd #{gem_name} && git init")
    system("cd #{gem_name} && git add .")
    system("cd #{gem_name} && git commit -m 'Initial commit'")
  end
end
