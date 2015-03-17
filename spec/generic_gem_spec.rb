require 'spec_helper'

describe GenericGem do
  it 'has a version number' do
    expect(GenericGem::VERSION).not_to be nil
  end

  it 'true == true' do
    expect(true).to eq(true)
  end
  
  describe 'process' do
    require 'string_in_file'
    system("rm -rf tmp")
    GenericGem.create("tmp", "James Bond", "jbond@example.com")
    it "Bundler has the proper configuration settings" do
      expect(StringInFile.present("BUNDLE_GEM__COC: true", "#{ENV['HOME']}/.bundle/config")).to eq(true)
      expect(StringInFile.present("BUNDLE_GEM__MIT: true", "#{ENV['HOME']}/.bundle/config")).to eq(true)
      expect(StringInFile.present("BUNDLE_GEM__TEST", "#{ENV['HOME']}/.bundle/config")).to eq(true)
    end
    
    it "The new gem has the initial version number 0.0.0" do
      expect(StringInFile.present("0.0.0", "tmp/lib/tmp/version.rb")).to eq(true)
    end
    
    it "The Code of Conduct is present" do
      expect(StringInFile.present("Contributor Code of Conduct", "tmp/CODE_OF_CONDUCT.md")).to eq(true)
    end

    it "Your name in the LICENSE.txt and gemspec files" do
      expect(StringInFile.present("James Bond", "tmp/LICENSE.txt")).to eq(true)
      expect(StringInFile.present("TODO: Write your name", "tmp/LICENSE.txt")).to eq(false)
      expect(StringInFile.present("TODO: Write your name", "tmp/tmp.gemspec")).to eq(false)
      expect(StringInFile.present("James Bond", "tmp/tmp.gemspec")).to eq(true)
    end
    
    it "Your email address is in the gemspec file" do
      expect(StringInFile.present("jbond@example.com", "tmp/tmp.gemspec")).to eq(true)
    end
    
    it "A generic gem description should replace the default description in the gemspec file" do
      expect(StringInFile.present("TODO: Write a longer description", "tmp/tmp.gemspec")).to eq(false)
      expect(StringInFile.present("GENERIC DESCRIPTION", "tmp/tmp.gemspec")).to eq(true)
    end
    
    it "A generic gem summary should replace the default summary in the gemspec file" do
      expect(StringInFile.present("TODO: Write a short summary", "tmp/tmp.gemspec")).to eq(false)
      expect(StringInFile.present("GENERIC SUMMARY", "tmp/tmp.gemspec")).to eq(true)
    end

    it "The initial rspec tests are present and expect true == true" do
      expect(StringInFile.present("require 'tmp'", "tmp/spec/spec_helper.rb")).to eq(true)
      expect(StringInFile.present("expect(false).to eq(true)", "tmp/spec/tmp_spec.rb")).to eq(false)
      expect(StringInFile.present("expect(true).to eq(true)", "tmp/spec/tmp_spec.rb")).to eq(true)
    end
  
    it "The bin/console file and bin/setup files are executable" do
      expect(File.executable?("tmp/bin/console")).to eq(true)
      expect(File.executable?("tmp/bin/setup")).to eq(true)
    end

    it "The gem_test.sh script is provided" do
      expect(StringInFile.present("bin/setup", "tmp/gem_test.sh")).to eq(true)
      expect(StringInFile.present("rake", "tmp/gem_test.sh")).to eq(true)
      expect(StringInFile.present("gem uninstall tmp", "tmp/gem_test.sh")).to eq(true)
    end
    
    it "The gem_install.sh script is provided" do
      expect(StringInFile.present("bin/setup", "tmp/gem_install.sh")).to eq(true)
      expect(StringInFile.present("rake install", "tmp/gem_install.sh")).to eq(true)
      expect(StringInFile.present("gem uninstall tmp", "tmp/gem_install.sh")).to eq(true)
    end

    it "The gem_console.sh script is provided" do
      expect(StringInFile.present('bin/console', "tmp/gem_console.sh")).to eq(true)
    end

    it "The Rakefile is provided" do
      expect(StringInFile.present('require "bundler/gem_tasks"', "tmp/Rakefile")).to eq(true)
      expect(StringInFile.present('require "rspec/core/rake_task"', "tmp/Rakefile")).to eq(true)
      expect(StringInFile.present('RSpec::Core::RakeTask.new', "tmp/Rakefile")).to eq(true)
      expect(StringInFile.present('task :default => :spec', "tmp/Rakefile")).to eq(true)
      expect(StringInFile.present('task :test => :spec', "tmp/Rakefile")).to eq(true)
    end

    it "The .gitignore file includes tmp, tmp*, and ,DS_Store" do
      expect(StringInFile.present("tmp", "tmp/.gitignore")).to eq(true)
      expect(StringInFile.present("tmp*", "tmp/.gitignore")).to eq(true)
      expect(StringInFile.present(".DS_Store", "tmp/.gitignore")).to eq(true)
    end

    it "The .gemspec file includes rspec as a development dependency" do
      expect(StringInFile.present('spec.add_development_dependency "rspec"', "tmp/tmp.gemspec")).to eq(true)
    end
    
    it "Added instructions on gem_test.sh and gem_console.sh to README.md" do
      expect(StringInFile.present("gem_test.sh", "tmp/README.md")).to eq(true)
      expect(StringInFile.present("gem_console.sh", "tmp/README.md")).to eq(true)
    end
    
    it "Adds mention of class in main lib file" do
      expect(StringInFile.present("class", "tmp/lib/tmp.rb")).to eq(true)
    end
    
  end
  
end
