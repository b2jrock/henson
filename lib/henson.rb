require "henson/api_client"
require "henson/installer"
require "henson/puppet_module"
require "henson/settings"
require "henson/version"

module Henson
  def self.settings
    @settings ||= Settings.new
  end

  def self.ui=(new_ui)
    @ui = new_ui
  end

  def self.ui
    @ui
  end

  def self.api_client
    @api_client ||= Henson::APIClient.new "api.github.com",
      :access_token => ENV["GITHUB_API_TOKEN"]
  end

  ########
  # Errors
  ########

  class Error < StandardError
    def self.exit_code(i)
      define_method(:exit_code) { i }
    end
  end

  class PuppetfileError         < Error; exit_code(14); end
  class PuppetfileNotFound      < Error; exit_code(16); end
  class ModulefileError         < Error; exit_code(14); end
  class ModulefileNotFound      < Error; exit_code(16); end
  class ModuleNotFound          < Error; exit_code(18); end

  class VersionMissingError     < Error; exit_code(22); end
  class RequirementNotSatisfied < Error; exit_code(20); end

  class GitNotInstalled         < Error; exit_code(30); end
  class GitRefNotFound          < Error; exit_code(32); end
  class GitInvalidRef           < Error; exit_code(34); end

  class GitHubTarballNotFound   < Error; exit_code(40); end
  class GitHubAPIError          < Error; exit_code(42); end
  class GitHubDownloadError     < Error; exit_code(44); end
end
