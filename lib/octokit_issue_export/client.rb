require 'octokit/client/issue_export'

module Octokit
  class Client
    include Octokit::Client::IssueExport
    alias :original_request :request

    def _request_stopper
      return if last_response.nil?
      return unless Octokit.rate_limit.remaining.zero?

      minutes = (rate_limit.resets_in + 5)/60
      puts "=> Rate limit! Please wait #{minutes} minutes(#{rate_limit.resets_at})..."
      sleep minutes
    end

    def request(method, path, data, options = {})
      _request_stopper
      original_request(method, path, data, options = {})
    end
  end
end
