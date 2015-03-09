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

    it "The MIT license is present and includes your name in the copyright" do
      expect(StringInFile.present("James Bond", "tmp/LICENSE.txt")).to eq(true)
      expect(StringInFile.present("TODO: Write your name", "tmp/LICENSE.txt")).to eq(false)
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
    end
    # Check the gem_console.sh script
    # Check the *_spec.rb file
    # Check .gitignore for tmp, tmp*, and .DS_Store
    
  end
  
end
