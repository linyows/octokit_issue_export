require 'octokit/client/issue_export'

module Octokit
  class Client
    include Octokit::Client::IssueExport
  end
end
