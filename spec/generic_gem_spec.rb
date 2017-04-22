require 'spec_helper'
require 'generic_gem'
require 'string_in_file'

describe GenericGem do
  it 'has a version number' do
    expect(GenericGem::VERSION).not_to be nil
  end

  it 'true == true' do
    expect(true).to eq(true)
  end

  describe 'process' do
    dir_parent = File.expand_path('..', Dir.pwd)
    dir_tmp = "#{dir_parent}/tmp"
    system("rm -rf #{dir_tmp}")
    Dir.chdir(dir_parent) do
      GenericGem.create('tmp')
    end
    it 'Bundler has the proper configuration settings' do
      expect(StringInFile.present('BUNDLE_GEM__COC: true', "#{ENV['HOME']}/.bundle/config")).to eq(true)
      expect(StringInFile.present('BUNDLE_GEM__MIT: true', "#{ENV['HOME']}/.bundle/config")).to eq(true)
      expect(StringInFile.present('BUNDLE_GEM__TEST', "#{ENV['HOME']}/.bundle/config")).to eq(true)
    end

    it 'The new gem has the initial version number 0.0.0' do
      expect(StringInFile.present('0.0.0', "#{dir_tmp}/lib/tmp/version.rb")).to eq(true)
    end

    it 'The Code of Conduct is present' do
      expect(StringInFile.present('Code of Conduct', "#{dir_tmp}/CODE_OF_CONDUCT.md")).to eq(true)
    end

    it 'The credentials.sh script is present' do
      expect(StringInFile.present('git config --global user.email', "#{dir_tmp}/credentials.sh")).to eq(true)
      expect(StringInFile.present('git config --global user.name', "#{dir_tmp}/credentials.sh")).to eq(true)
    end

    it 'A generic gem description should replace the default description in the gemspec file' do
      expect(StringInFile.present('TODO: Write a longer description', "#{dir_tmp}/tmp.gemspec")).to eq(false)
      expect(StringInFile.present('GENERIC DESCRIPTION', "#{dir_tmp}/tmp.gemspec")).to eq(true)
    end

    it 'A generic gem summary should replace the default summary in the gemspec file' do
      expect(StringInFile.present('TODO: Write a short summary', "#{dir_tmp}/tmp.gemspec")).to eq(false)
      expect(StringInFile.present('GENERIC SUMMARY', "#{dir_tmp}/tmp.gemspec")).to eq(true)
    end

    it 'gemspec file includes additional gem dependencies' do
      expect(StringInFile.present("spec.add_development_dependency 'rubocop'", "#{dir_tmp}/tmp.gemspec")).to eq(true)
      expect(StringInFile.present("spec.add_development_dependency 'sandi_meter'", "#{dir_tmp}/tmp.gemspec")).to eq(true)
      expect(StringInFile.present("spec.add_development_dependency 'bundler-audit'", "#{dir_tmp}/tmp.gemspec")).to eq(true)
      expect(StringInFile.present("spec.add_development_dependency 'gemsurance'", "#{dir_tmp}/tmp.gemspec")).to eq(true)
      expect(StringInFile.present("spec.add_development_dependency 'ruby-graphviz'", "#{dir_tmp}/tmp.gemspec")).to eq(true)
      expect(StringInFile.present("spec.add_development_dependency 'simplecov'", "#{dir_tmp}/tmp.gemspec")).to eq(true)
    end

    it 'spec_helper.rb includes simplecov' do
      expect(StringInFile.present("require 'simplecov'", "#{dir_tmp}/spec/spec_helper.rb")).to eq(true)
      expect(StringInFile.present('SimpleCov.start', "#{dir_tmp}/spec/spec_helper.rb")).to eq(true)
    end

    it 'The initial rspec tests are present and expect true == true' do
      expect(StringInFile.present('expect(false).to eq(true)', "#{dir_tmp}/spec/tmp_spec.rb")).to eq(false)
      expect(StringInFile.present('expect(true).to eq(true)', "#{dir_tmp}/spec/tmp_spec.rb")).to eq(true)
    end

    it 'The bin/console file and bin/setup files are executable' do
      expect(File.executable?("#{dir_tmp}/bin/console")).to eq(true)
      expect(File.executable?("#{dir_tmp}/bin/setup")).to eq(true)
    end

    it 'The gem_test.sh script is provided' do
      expect(StringInFile.present('bin/setup', "#{dir_tmp}/gem_test.sh")).to eq(true)
      expect(StringInFile.present('rake', "#{dir_tmp}/gem_test.sh")).to eq(true)
      expect(StringInFile.present('gem uninstall tmp', "#{dir_tmp}/gem_test.sh")).to eq(true)
    end

    it 'The gem_install.sh script is provided' do
      expect(StringInFile.present('bin/setup', "#{dir_tmp}/gem_install.sh")).to eq(true)
      expect(StringInFile.present('rake install', "#{dir_tmp}/gem_install.sh")).to eq(true)
      expect(StringInFile.present('gem uninstall tmp', "#{dir_tmp}/gem_install.sh")).to eq(true)
    end

    it 'The gem_console.sh script is provided' do
      expect(StringInFile.present('bin/setup', "#{dir_tmp}/gem_console.sh")).to eq(true)
      expect(StringInFile.present('bin/console', "#{dir_tmp}/gem_console.sh")).to eq(true)
      expect(StringInFile.present('gem uninstall tmp', "#{dir_tmp}/gem_console.sh")).to eq(true)
    end

    it 'The code_test.sh script is provided' do
      expect(StringInFile.present('bin/setup', "#{dir_tmp}/code_test.sh")).to eq(true)
      expect(StringInFile.present('rubocop', "#{dir_tmp}/code_test.sh")).to eq(true)
      expect(StringInFile.present('gemsurance', "#{dir_tmp}/code_test.sh")).to eq(true)
      expect(StringInFile.present('bundle viz', "#{dir_tmp}/code_test.sh")).to eq(true)
    end

    it 'The all.sh script is provided' do
      expect(StringInFile.present('sh gem_test.sh', "#{dir_tmp}/all.sh")).to eq(true)
      expect(StringInFile.present('sh code_test.sh', "#{dir_tmp}/all.sh")).to eq(true)
      expect(StringInFile.present('sh gem_install.sh', "#{dir_tmp}/all.sh")).to eq(true)
    end

    it 'The Rakefile is provided' do
      expect(StringInFile.present("require 'bundler/gem_tasks'", "#{dir_tmp}/Rakefile")).to eq(true)
      expect(StringInFile.present("require 'rspec/core/rake_task'", "#{dir_tmp}/Rakefile")).to eq(true)
      expect(StringInFile.present('RSpec::Core::RakeTask.new', "#{dir_tmp}/Rakefile")).to eq(true)
      expect(StringInFile.present('task default: :spec', "#{dir_tmp}/Rakefile")).to eq(true)
      expect(StringInFile.present('task test: :spec', "#{dir_tmp}/Rakefile")).to eq(true)
    end

    it 'The README-to_do.txt file is provided' do
      expect(StringInFile.present('http://badge.fury.io/', "#{dir_tmp}/README-to_do.txt")).to eq(true)
      expect(StringInFile.present('https://gemnasium.com/', "#{dir_tmp}/README-to_do.txt")).to eq(true)
      expect(StringInFile.present('https://travis-ci.org/', "#{dir_tmp}/README-to_do.txt")).to eq(true)
      expect(StringInFile.present('https://codeclimate.com/', "#{dir_tmp}/README-to_do.txt")).to eq(true)
      expect(StringInFile.present('https://hakiri.io/', "#{dir_tmp}/README-to_do.txt")).to eq(true)
    end

    it 'The .gitignore file includes tmp, tmp*, and ,DS_Store' do
      expect(StringInFile.present('tmp', "#{dir_tmp}/.gitignore")).to eq(true)
      expect(StringInFile.present('tmp*', "#{dir_tmp}/.gitignore")).to eq(true)
      expect(StringInFile.present('.DS_Store', "#{dir_tmp}/.gitignore")).to eq(true)
    end

    it 'The .gemspec file includes rspec as a development dependency' do
      expect(StringInFile.present("spec.add_development_dependency 'rspec'", "#{dir_tmp}/tmp.gemspec")).to eq(true)
    end

    it 'Added instructions on gem_test.sh and gem_console.sh to README.md' do
      expect(StringInFile.present('gem_test.sh', "#{dir_tmp}/README.md")).to eq(true)
      expect(StringInFile.present('gem_console.sh', "#{dir_tmp}/README.md")).to eq(true)
      expect(StringInFile.present('## Contributing', "#{dir_tmp}/README.md")).to eq(true)
      expect(StringInFile.present('## Development', "#{dir_tmp}/README.md")).to eq(true)
      expect(StringInFile.present('### Testing this gem', "#{dir_tmp}/README.md")).to eq(true)
      expect(StringInFile.present('### Running this gem in irb', "#{dir_tmp}/README.md")).to eq(true)
      expect(StringInFile.present('### Installing this gem', "#{dir_tmp}/README.md")).to eq(true)
    end

    it 'Adds mention of class in main lib file' do
      expect(StringInFile.present('class', "#{dir_tmp}/lib/tmp.rb")).to eq(true)
    end
  end
end
