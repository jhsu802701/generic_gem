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
    GenericGem.create("tmp")
    #system("rm $HOME/.bundle/config")
    # Create new gem in tmp directory
    # Make the changes central to this generic_gem Ruby gem
    # Check $HOME/.bundle/config settings
    it "Bundler has the proper configuration settings" do
      puts "#{ENV['HOME']}/.bundle/config"
      expect(StringInFile.present("BUNDLE_GEM__COC: true", "#{ENV['HOME']}/.bundle/config")).to eq(true)
      expect(StringInFile.present("BUNDLE_GEM__MIT: true", "#{ENV['HOME']}/.bundle/config")).to eq(true)
      expect(StringInFile.present("BUNDLE_GEM__TEST", "#{ENV['HOME']}/.bundle/config")).to eq(true)
    end
    # Check for code of conduct
    # Check for MIT license
    # Check for initial rspec tests
    # Check that initial version number is 0.0.0
    # Check that bin/setup and bin/console are executable
    # Check the gem_test.sh script
    # Check the gem_console.sh script
    # Check the *_spec.rb file
    # Check .gitignore for tmp, tmp*, and .DS_Store
    
  end
  
end
