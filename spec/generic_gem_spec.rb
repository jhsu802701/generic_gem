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
    GenericGem.create("tmp", "James Bond")
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

    # Check for MIT license
    it "The MIT license is present and includes your name in the copyright" do
      expect(StringInFile.present("James Bond", "tmp/LICENSE.txt")).to eq(true)
      expect(StringInFile.present("TODO: Write your name", "tmp/LICENSE.txt")).to eq(false)
    end
    # Check for initial rspec tests
    # Check that initial version number is 0.0.0
    # Check that bin/setup and bin/console are executable
    # Check the gem_test.sh script
    # Check the gem_console.sh script
    # Check the *_spec.rb file
    # Check .gitignore for tmp, tmp*, and .DS_Store
    
  end
  
end
