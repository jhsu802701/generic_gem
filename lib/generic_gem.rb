require "generic_gem/version"

module GenericGem
  def self.create (gem_name)
    dir_main = File.expand_path("../../", __FILE__)
    
    t1 = Thread.new {
      puts "*************************************************"
      puts "Setting up #{ENV['HOME']}/.bundle/config"
      system ("cp #{dir_main}/lib/files_to_add/config #{ENV['HOME']}/.bundle/config")
      puts "*************************************************"
      puts "bundle gem #{gem_name}"
      system ("bundle gem #{gem_name}")
      #system("git clone https://github.com/mhartl/sample_app_3rd_edition.git #{subdir_name}")
      #system("cd #{subdir_name} && git checkout remotes/origin/account-activation-password-reset")
      }
    t1.join
  end
end
